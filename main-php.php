<?php
  session_start();
  ob_start();
  header("Content-type: application/json");
  date_default_timezone_set('UTC');

  $conn = mysqli_connect('127.0.0.1', 'root', '', 'videoapp');
  if (mysqli_connect_errno()) {
    echo '<p>Error: Could not connect to database.<br/>
    Please try again later.</p>';
    exit;
  }

  function get_result( $Statement ) {
    $RESULT = array();
    $Statement->store_result();
    for ( $i = 0; $i < $Statement->num_rows; $i++ ) {
        $Metadata = $Statement->result_metadata();
        $PARAMS = array();
        while ( $Field = $Metadata->fetch_field() ) {
            $PARAMS[] = &$RESULT[ $i ][ $Field->name ];
        }
        call_user_func_array( array( $Statement, 'bind_result' ), $PARAMS );
        $Statement->fetch();
    }
    return $RESULT;
}
  // all actions query data to db
  try {
    switch($_POST["action"]) {
      case 'login':
        $username =  $_POST["username"];

        //get the password of the username from the database
        $sql = "SELECT password FROM UserInfo WHERE username = '$username'";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $stmt->store_result();

        //if there is a row, that means the username exists, return false and an error message if it is 0
        if ($stmt->num_rows != 0) {
          $stmt->bind_result($password);
          $stmt->fetch();

          //check if the actual password matches the user inputted password, return false if they are not
          if ($_POST["password"] != $password) {
            print json_encode([
              'success' => false,
              'error' => "Error: Incorrect username and/or password"
            ]);
          }
          else {
            print json_encode([
              'success' => true
            ]);
          }
        }
        else {
          print json_encode([
            'success' => false,
            'error' => "Error: Incorrect username and/or password"
          ]);
        }

        exit;
      case 'signup':
        //insert new user details into database
        $sql = "INSERT INTO UserInfo (username, password, name, email) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ssss', $_POST["username"], $_POST["password"], $_POST["name"], $_POST["email"]);
        if ($stmt->execute()) {
          print json_encode([
            'success' => true
          ]);
        }
        else {
          print json_encode([
            'success' => false
          ]);
        }

        exit;
      case 'checkusername':
        $username =  $_POST["username"];

        //get the user inputted username from database
        $sql = "SELECT username FROM UserInfo WHERE username = '$username'";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $stmt->store_result();

        //if row count is 0, that means the username is not taken, return true to indicate that the username does not exist in the database
        if ($stmt->num_rows == 0) {
          print json_encode([
            'success' => true
          ]);
        }
        else {
          print json_encode([
            'success' => false
          ]);
        }

        exit;
      case 'checkemail':
        $email =  $_POST["email"];

        //get the user inputted email from database
        $sql = "SELECT email FROM UserInfo WHERE email = '$email'";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $stmt->store_result();

        //if row count is 0, that means the email is not taken, return true to indicate that the email does not exist in the database
        if ($stmt->num_rows == 0) {
          print json_encode([
            'success' => true
          ]);
        }
        else {
          print json_encode([
            'success' => false
          ]);
        }

        exit;
      case 'videoUpload':
        $videoName = isset($_POST['videoName']) ? $_POST['videoName'] : '';
        $fileFullName = isset($_FILES['fileToUpload']['name']) ? $_FILES['fileToUpload']['name'] : '';
        $description = isset($_POST['description']) ? $_POST['description'] : '';
        $currentDate = isset($_POST['currentDate']) ? $_POST['currentDate'] : '';
        $username = isset($_POST['username']) ? $_POST['username'] : '';

        $videoName = strip_tags($videoName);       
        $fileFullName = strip_tags($fileFullName);        
        $description = strip_tags($description);        
        $currentDate = strip_tags($currentDate);
        $username = strip_tags($username);

        //get the video complete file name and the user that uploaded it from the database
        $sql = "SELECT fileFullName, username FROM Videos WHERE fileFullName = '$fileFullName' AND username = '$username'";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $stmt->store_result();

        //if the row count is 0, that means the user has not uploaded the particular video file yet, return an error message if the user did upload the file already
        if ($stmt->num_rows == 0) {
          //insert video and its details into database
          $sql = "INSERT INTO Videos (videoName, fileFullName, description, date, username) VALUES (?, ?, ?, ?, ?)";
          $stmt = $conn->prepare($sql);
          $stmt->bind_param('sssss',$videoName, $fileFullName, $description, $currentDate, $username); // ssss: 4 strings, i: interger
  
          // upload photo to folder
          if ($stmt->execute()) {
            // Move videos from local to server
            $target_dir = "uploads/";
            $target_file = $target_dir . basename($_FILES['fileToUpload']['name']);
            $tmp_name = $_FILES['fileToUpload']['tmp_name'];
  
            //check if file already exists, return true as we'll allow the same videos to be uploaded as long as it is from different users
            if (file_exists($target_file)) {
              print json_encode(array("success"=>true));
            }
            else {
              //check if the move was successful, retun an error message if it wasn't
              if (move_uploaded_file($tmp_name, $target_file)) {
                print json_encode(array("success"=>true));
              }
              else {
                print json_encode(array("error"=>"Error: Could not move file to upload folder."));
              }
            }
          } 
          else {
            print json_encode(array("error"=>"Error: Problem with the database."));
          }        
        }
        else {
          print json_encode(array("error"=>"Error: You have already uploaded this file."));
        }
        
        exit;
      case 'comment':
        //insert comment into database
        $sql = "INSERT INTO Comments (comment, username, date, video_id) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('sssi', $_POST["comment"], $_POST["username"], $_POST["date"], $_POST["id"]);

        if ($stmt->execute()) {
          print json_encode([
            'success' => true
          ]);
        }
        else {
          print json_encode([
            'success' => false, 'error' => error_get_last()
          ]);
        }

        exit;
      case 'getVideoInfo':
        $id =  $_POST["id"];

        //increase the view count by 1 for the video found by the id
        $sql = "UPDATE Videos SET views = views + 1 WHERE id = '$id'";
        $stmt = $conn->prepare($sql);

        if ($stmt->execute()) {
          //get the video info
          $sql = "SELECT * FROM Videos WHERE id = '$id'";
          $stmt = $conn->prepare($sql);
          $stmt->execute();
          $stmt->store_result();
  
          if ($stmt->num_rows != 0) {
            $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $highLight, $views);
            $stmt->fetch();
            
            //return appropriate data
            print json_encode(['success' => true,'videoName' => $videoName, 'fileFullName' => $fileFullName, 'username' => $username,'description' => $description,'date' => $date, 'views' => $views]);
          }
          else {
            print json_encode(['success' => false, "error" => error_get_last()]);
          }
        }
        else {
          print json_encode(['success' => false, "error" => error_get_last()]);
        }
        
        exit;
      case 'getComments':
        $id =  $_POST["id"];

        //get all comments and their details of a video from the video id
        $sql = "SELECT * FROM Comments WHERE video_id = '$id'";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows != 0) {
          $stmt->bind_result($comment, $username, $date, $video_id);
          $result = get_result($stmt);

          print json_encode(['success' => true,'comments' => $result]);
        }
        else {
          print json_encode(['success' => false, "error" => error_get_last()]);
        }
        
        exit;
      case 'getHighLightVideos':
        //get videos and their infomration that are marked as a highlight
        $query = "SELECT id, videoName, fileFullName, description, date, username, views FROM Videos ORDER by hightLight DESC LIMIT 5";
        $stmt = $conn->prepare($query);

        if ($stmt->execute()) {
          $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $views);
          $result = get_result($stmt);
          print json_encode(['success' => true,'videos' => $result]);
        }
        else {
          print json_encode(['success' => false]);
        }
        exit;
      case 'getNewestVideos':
        //get videos that match id, sort from the top since those are the newest uploaded videos
        $query = "SELECT id, videoName, fileFullName, description, date, username, views FROM Videos ORDER by id DESC";
        $stmt = $conn->prepare($query);

        if ($stmt->execute()) {
          $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $views);
          $result = get_result($stmt);
          print json_encode(['success' => true,'videos' => $result]);
        }
        else {
          print json_encode(['success' => false]);
        }
        exit;

      case 'getMostViewVideos':
        //get 7 videos that have the most views
        $query = "SELECT id, videoName, fileFullName, description, date, username, views FROM Videos ORDER by views DESC LIMIT 7";
        $stmt = $conn->prepare($query);

        if ($stmt->execute()) {
          $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $views);
          $result = get_result($stmt);
          print json_encode(['success' => true,'videos' => $result]);
        }
        else {
          print json_encode(['success' => false]);
        }
        exit;
        
      case 'search':
        $usersearch =  $_POST["usersearch"];
        //remove html white space indicator
        $usersearch = str_replace('%20', ' ', $usersearch);

        //get all videos that contain the user search
        $query = "SELECT id, videoName, fileFullName, description, date, username, views FROM Videos WHERE videoName LIKE '%$usersearch%'";
        $stmt = $conn->prepare($query);
        $stmt->execute();
        $stmt->store_result();

        if ($stmt->num_rows != 0) {
          $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $views);
          $result = get_result($stmt);
          print json_encode(['success' => true,'videos' => $result]);
        }
        else {
          print json_encode(['success' => false, 'error' => "Error: Could not find any videos." ]);
        }
        exit;

      case 'getuservideos':
        $username =  $_POST["username"];

        $query = "SELECT id, videoName, fileFullName, description, date, username, views FROM Videos WHERE username = '$username'";
        $stmt = $conn->prepare($query);
        
        if ($stmt->execute()) {
          $stmt->bind_result($id, $videoName, $fileFullName, $description, $date, $username, $views);
          $result = get_result($stmt);
          
          print json_encode(['success' => true, 'videos' => $result]);
        }
        else {
          print json_encode(['success' => false]);
        }
        exit;

      case 'deletevideo':
        $id = $_POST["id"];

        $query = "DELETE FROM Videos WHERE id = '$id'";
        $stmt = $conn->prepare($query);

        if ($stmt->execute()) {
          print json_encode(['success' => true]);
        }
        else {
          print json_encode(['success' => false]);
        }
        exit;
        
     }
  }
  catch (Exception $e) {
    print json_encode([
      'success' => false,
      'error' => $e->getMessage()
    ]);
  }
?>
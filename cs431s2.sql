-- phpMyAdmin SQL Dump
-- version 4.4.15
-- http://www.phpmyadmin.net
--
-- Host: mariadb
-- Generation Time: May 10, 2020 at 12:06 AM
-- Server version: 5.5.60-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs431s2`
--

-- --------------------------------------------------------

--
-- Table structure for table `chatlog`
--

CREATE TABLE IF NOT EXISTS `chatlog` (
  `id` int(11) NOT NULL,
  `username` text,
  `message` text,
  `color` text,
  `joined` tinyint(1) NOT NULL DEFAULT '0',
  `gone` tinyint(1) NOT NULL DEFAULT '0',
  `sent_by` varchar(50) DEFAULT NULL,
  `date_created` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chatlog`
--

INSERT INTO `chatlog` (`id`, `username`, `message`, `color`, `joined`, `gone`, `sent_by`, `date_created`) VALUES
(1, '', '', '', 0, 1, '0uhg1or3fq9lr7pbgalrdun3f4', 1588545039),
(2, 'choktn', '', 'pink', 0, 1, '0uhg1or3fq9lr7pbgalrdun3f4', 1588545072),
(3, 'choktn', '', 'pink', 1, 0, '0uhg1or3fq9lr7pbgalrdun3f4', 1588545080),
(4, 'indanailpail', '', 'purple', 1, 0, 'doerfddtpdo87t211phek47581', 1588545092),
(5, 'indanailpail', 'a', 'purple', 0, 0, 'doerfddtpdo87t211phek47581', 1588545097),
(6, 'choktn', 'a', 'pink', 0, 0, '0uhg1or3fq9lr7pbgalrdun3f4', 1588545105),
(7, 'choktn', '', 'pink', 0, 1, '0uhg1or3fq9lr7pbgalrdun3f4', 1588545110),
(8, 'indanailpail', '', 'purple', 0, 1, 'doerfddtpdo87t211phek47581', 1588545114),
(9, 'choktn', '', 'purple', 1, 0, 'doerfddtpdo87t211phek47581', 1588545224),
(10, 'choktn', '', 'purple', 0, 1, 'doerfddtpdo87t211phek47581', 1588545231),
(11, 'hi', '', 'yellow', 0, 1, 'lasmurs4tgbnjdd7s7td5uhe96', 1588619786),
(12, 'test again', '', 'purple', 0, 1, 'lasmurs4tgbnjdd7s7td5uhe96', 1588619786),
(13, 'IE', '', 'blue', 0, 1, 'sd82nlkcdcppgcdahs8j0un567', 1588619794),
(14, 'jseph', '', 'orange', 0, 1, 'ekcjh6d3tm0h0mbqvqj2boimt2', 1588620118),
(15, 'hjlh', '', 'red', 0, 1, 'ekcjh6d3tm0h0mbqvqj2boimt2', 1588788238),
(16, 'fdhfgh', '', 'yellow', 1, 0, 'ekcjh6d3tm0h0mbqvqj2boimt2', 1588788243),
(17, 'fdhfgh', 'jlk', 'yellow', 0, 0, 'ekcjh6d3tm0h0mbqvqj2boimt2', 1588788246),
(18, '', '', '', 0, 1, 'ingmp8t6u3iph5ikbc0rv0tq11', 1588893043),
(19, '', '', '', 0, 1, 'ingmp8t6u3iph5ikbc0rv0tq11', 1588893125);

-- --------------------------------------------------------

--
-- Table structure for table `Comments`
--

CREATE TABLE IF NOT EXISTS `Comments` (
  `comment` text NOT NULL,
  `username` text NOT NULL,
  `date` text NOT NULL,
  `video_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Comments`
--

INSERT INTO `Comments` (`comment`, `username`, `date`, `video_id`) VALUES
('a', 'choktn', '5/8/2020', 124),
('c', 'choktn', '5/8/2020', 128),
('adfasdf', 'choktn', '5/8/2020', 125),
('casdfasdf', 'indanailpail', '5/8/2020', 124),
('aa', 'indanailpail', '5/8/2020', 128),
('test', 'indanailpail', '5/8/2020', 127),
('n', 'choktn', '5/8/2020', 112),
('test', 'choktn', '5/8/2020', 133),
('test', 'choktn', '5/8/2020', 112),
('comment', 'choktn', '5/8/2020', 128),
('test', 'choktn', '5/8/2020', 138),
('Test', 'choktn', '5/9/2020', 126),
('test', 'choktn', '5/9/2020', 141),
('a', 'choktn', '5/9/2020', 116),
('test 2', 'choktn', '5/9/2020', 133),
('testing order', 'choktn', '5/9/2020', 133),
('test', 'choktn', '5/9/2020', 128),
('a', 'choktn', '5/9/2020', 133),
('test', 'test', '5/9/2020', 111),
('test', 'test', '5/9/2020', 112),
('nice', 'joseph', '5/9/2020', 141),
('nice', 'joseph', '5/9/2020', 141);

-- --------------------------------------------------------

--
-- Table structure for table `Images`
--

CREATE TABLE IF NOT EXISTS `Images` (
  `photoName` varchar(100) NOT NULL,
  `dateTaken` date NOT NULL,
  `photographer` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `fileName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Images`
--

INSERT INTO `Images` (`photoName`, `dateTaken`, `photographer`, `location`, `fileName`) VALUES
('PHOTO', '2002-02-02', 'Mark Hauchwitz', 'BERLIN', 'eye-png-42308.png'),
('2', '1999-05-05', 'P2', 'L2', '2.jpg'),
('test', '2020-05-08', 'Joseph', 'Fullerton', 'smoke.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `UserInfo`
--

CREATE TABLE IF NOT EXISTS `UserInfo` (
  `username` text NOT NULL,
  `password` text NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `UserInfo`
--

INSERT INTO `UserInfo` (`username`, `password`, `name`, `email`) VALUES
('choktn', 'a', 'Tavin Chok', 'choktn@gmail.com'),
('joseph', '123456', 'joseph', 'testing@gmail.com'),
('test', 'test', 'test test', 'test@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `Videos`
--

CREATE TABLE IF NOT EXISTS `Videos` (
  `id` int(11) NOT NULL,
  `videoName` text,
  `fileFullName` text,
  `description` text NOT NULL,
  `date` varchar(10) NOT NULL,
  `username` text NOT NULL,
  `hightLight` int(1) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Videos`
--

INSERT INTO `Videos` (`id`, `videoName`, `fileFullName`, `description`, `date`, `username`, `hightLight`, `views`) VALUES
(110, 'small video', 'small.mp4', 'small Video', '5/6/2020', 'joseph', 1, 18),
(111, 'animal video 23r3', 'small.mp4', 'HL video', '5/7/2020', 'choktn', 1, 22),
(112, 'large video HL', 'small.mp4', 'Large video HL testing', '5/7/2020', 'joseph', 1, 399),
(116, 'sample video 1mb', 'small.mp4', 'sample video 1mb', '5/7/2020', 'indanailpail', 1, 15),
(124, 'c', 'small.mp4', 'c', '5/7/2020', 'indanailpail', NULL, 13),
(125, 'testing', 'small.mp4', 'ssfafsafsdfsdfsdf', '5/8/2020', 'joseph', NULL, 31),
(126, 'testing uploading', 'small.mp4', 'ssfafsafsdfsdfsdf', '5/8/2020', 'joseph', NULL, 12),
(128, 'testing uploading', 'testingvideo.mp4', 'a', '5/8/2020', 'joseph', NULL, 75),
(129, 'b', 'small.mp4', 'a', '5/8/2020', 'choktn', NULL, 25),
(130, 'b', 'small.mp4', 'a', '5/8/2020', 'choktn', NULL, 8),
(131, 'sdgdf', 'small.mp4', 'fdghfdh', '5/8/2020', 'joseph', NULL, 7),
(133, 'cartoon', 'cartoon.mp4', 'cartoon video', '5/8/2020', 'joseph', 2, 46),
(137, 'a', 'small.mp4', 'b', '5/8/2020', 'choktn', NULL, 11),
(139, 'ogv file', 'small.ogv', 'testing ogv file', '5/9/2020', 'choktn', NULL, 6),
(140, 'webm file', 'small.webm', 'testing webm file', '5/9/2020', 'choktn', NULL, 5),
(141, 'm4v file', 'ken-video.m4v', 'test m4v file', '5/9/2020', 'choktn', NULL, 17),
(143, '1 MB file', 'file_example_MP4_480_1_5MG.mp4', 'upload test', '5/9/2020', 'choktn', NULL, 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chatlog`
--
ALTER TABLE `chatlog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Videos`
--
ALTER TABLE `Videos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatlog`
--
ALTER TABLE `chatlog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `Videos`
--
ALTER TABLE `Videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=144;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

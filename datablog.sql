-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 04, 2020 at 06:38 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datablog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` varchar(25) NOT NULL,
  `phone_num` varchar(25) NOT NULL,
  `msg` varchar(900) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'vinay', '8574962341', 'fkllspsdfmadvl  ;fla;efkpaekm fgslfspcva apgopvl lgpra', '2020-07-31', 'vs@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `tag_line` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `writer` varchar(25) NOT NULL,
  `img_file` varchar(25) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tag_line`, `slug`, `content`, `writer`, `img_file`, `date`) VALUES
(1, 'Data science ', 'Its about what is data science and Deep Learning.', 'first_slug', 'Data science is an inter-disciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from many structural and unstructured data. Data science is related to data mining, machine learning and big data.\r\nData science is a \"concept to unify statistics, data analysis, machine learning, domain knowledge and their related methods\" in order to \"understand and analyze actual phenomena\" with data.[3] It uses techniques and theories drawn from many fields within the context of mathematics, statistics, computer science, domain knowledge and information science. Turing award winner Jim Gray imagined data science as a \"fourth paradigm\" of science (empirical, theoretical, computational and now data-driven) and asserted that \"everything about science is changing because of the impact of information technology\" and the data deluge.', 'Vishal Sharma', 'post-bg.jpg', '2020-07-31'),
(2, 'Statistics', 'Its about what is Statistics for Data Science ', 'Second-slug', 'Statistics is the discipline that concerns the collection, organization, analysis, interpretation and presentation of data.In applying statistics to a scientific, industrial, or social problem, it is conventional to begin with a statistical population or a statistical model to be studied. Populations can be diverse groups of people or objects such as \"all people living in a country\" or \"every atom composing a crystal\". Statistics deals with every aspect of data, including the planning of data collection in terms of the design of surveys and experiments.[4] See glossary of probability and statistics.\r\n\r\nWhen census data cannot be collected, statisticians collect data by developing specific experiment designs and survey samples. Representative sampling assures that inferences and conclusions can reasonably extend from the sample to the population as a whole. An experimental study involves taking measurements of the system under study, manipulating the system, and then taking additional measurements using the same procedure to determine if the manipulation has modified the values of the measurements. In contrast, an observational study does not involve experimental manipulation.\r\n\r\nTwo main statistical methods are used in data analysis: descriptive statistics, which summarize data from a sample using indexes such as the mean or standard deviation, and inferential statistics, which draw conclusions from data that are subject to random variation (e.g., observational errors, sampling variation).[5] Descriptive statistics are most often concerned with two sets of properties of a distribution (sample or population): central tendency (or location) seeks to characterize the distribution\'s central or typical value, while dispersion (or variability) characterizes the extent to which members of the distribution depart from its center and each other. Inferences on mathematical statistics are made under the framework of probability theory, which deals with the analysis of random phenomena.\r\n\r\nA standard statistical procedure involves the collection of data leading to test of the relationship between two statistical data sets, or a data set and synthetic data drawn from an idealized model. A hypothesis is proposed for the statistical relationship between the two data sets, and this is compared as an alternative to an idealized null hypothesis of no relationship between two data sets. Rejecting or disproving the null hypothesis is done using statistical tests that quantify the sense in which the null can be proven false, given the data that are used in the test. Working from a null hypothesis, two basic forms of error are recognized: Type I errors (null hypothesis is falsely rejected giving a \"false positive\") and Type II errors (null hypothesis fails to be rejected and an actual relationship between populations is missed giving a \"false negative\").Multiple problems have come to be associated with this framework: ranging from obtaining a sufficient sample size to specifying an adequate null hypothesis.[citation needed] ', 'Vishal Sharma', 'post-bg.jpg', '2020-07-31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

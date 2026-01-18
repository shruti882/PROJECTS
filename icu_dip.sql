-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2023 at 12:20 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `icu_dip`
--

-- --------------------------------------------------------

--
-- Table structure for table `currentdata`
--

CREATE TABLE `currentdata` (
  `kit` int(20) NOT NULL,
  `temp` varchar(200) NOT NULL,
  `pulse` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `currentdata`
--

INSERT INTO `currentdata` (`kit`, `temp`, `pulse`) VALUES
(1, '20.51', '41'),
(2, '44.92', '0');

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `contact` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `specialization` varchar(256) NOT NULL,
  `gender` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `name`, `email`, `contact`, `password`, `specialization`, `gender`) VALUES
(1, 'Gauresh Suryawanshi', 'gauresh@gmail.com', '8600180045', '123456', 'Heart Specialist', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `icuward` varchar(256) NOT NULL,
  `contact` varchar(256) NOT NULL,
  `bedno` varchar(256) NOT NULL,
  `address` varchar(256) NOT NULL,
  `disease` varchar(256) NOT NULL,
  `kit` varchar(256) NOT NULL,
  `gender` varchar(256) NOT NULL,
  `doctor` varchar(256) NOT NULL,
  `blood` varchar(256) NOT NULL,
  `occupation` varchar(256) NOT NULL,
  `adhar` varchar(256) NOT NULL,
  `rname` varchar(256) NOT NULL,
  `rcontact` varchar(256) NOT NULL,
  `rgender` varchar(256) NOT NULL,
  `status` varchar(256) NOT NULL,
  `admitdate` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `name`, `icuward`, `contact`, `bedno`, `address`, `disease`, `kit`, `gender`, `doctor`, `blood`, `occupation`, `adhar`, `rname`, `rcontact`, `rgender`, `status`, `admitdate`) VALUES
(1, 'Gauresh', '1', '8600180045', '1', 'Nashik', 'Yes', '1', 'Male', 'Gauresh Suryawanshi', 'B positive', 'Engineer', '123456789012', 'Sunil Joshi', '8888888888', 'Male', 'Discharge On 17.03.2023', '2023/03/17 14:19:09'),
(2, 'Sunil Joshi', '1', '9860878291', '2', 'Nashik', 'Yes', '2', 'Male', 'Gauresh Suryawanshi', 'O positive', 'Engineer', '123456789013', 'Sunil Joshi', '8888888888', 'Male', 'Admit', '2023/03/18 16:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `sensorlog`
--

CREATE TABLE `sensorlog` (
  `kit` int(20) NOT NULL,
  `temp` varchar(200) NOT NULL,
  `pulse` varchar(200) NOT NULL,
  `datee` varchar(200) NOT NULL,
  `timee` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensorlog`
--

INSERT INTO `sensorlog` (`kit`, `temp`, `pulse`, `datee`, `timee`) VALUES
(1, '37', '69', '17-03-2023', '01:00:00'),
(1, '35', '65', '17-03-2023', '02:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `supervisor`
--

CREATE TABLE `supervisor` (
  `id` int(11) NOT NULL,
  `supervisorname` varchar(256) NOT NULL,
  `email` varchar(256) NOT NULL,
  `contact` varchar(256) NOT NULL,
  `password` varchar(256) NOT NULL,
  `qualification` varchar(256) NOT NULL,
  `shift` varchar(256) NOT NULL,
  `gender` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `supervisor`
--

INSERT INTO `supervisor` (`id`, `supervisorname`, `email`, `contact`, `password`, `qualification`, `shift`, `gender`) VALUES
(1, 'Gauresh Suryawanshi', 'gauresh@gmail.com', '8600180045', '123456', 'BE', '1', 'Male');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supervisor`
--
ALTER TABLE `supervisor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `supervisor`
--
ALTER TABLE `supervisor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

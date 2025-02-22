-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 02, 2025 at 09:38 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `PetHospitalMangementSystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `Appointment`
--

CREATE TABLE `Appointment` (
  `APP_ID` int(11) NOT NULL,
  `P_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` time NOT NULL,
  `Reason` text NOT NULL,
  `Room` varchar(50) NOT NULL,
  `Status` enum('Not Started','In progress','Completed') NOT NULL,
  `Duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Appointment`
--

INSERT INTO `Appointment` (`APP_ID`, `P_ID`, `S_ID`, `Date`, `Time`, `Reason`, `Room`, `Status`, `Duration`) VALUES
(1, 1, 1, '2023-10-01', '10:00:00', 'Routine Checkup', 'Room 101', 'Completed', 30),
(2, 2, 2, '2023-10-02', '11:00:00', 'Skin Allergy', 'Room 102', 'Completed', 45),
(3, 3, 1, '2023-10-03', '09:30:00', 'Vaccination', 'Room 101', 'Completed', 20);

-- --------------------------------------------------------

--
-- Table structure for table `BillingRecord`
--

CREATE TABLE `BillingRecord` (
  `B_ID` int(11) NOT NULL,
  `APP_ID` int(11) NOT NULL,
  `C_ID` int(11) NOT NULL,
  `TotalAmount` decimal(7,2) NOT NULL,
  `PaymentStatus` enum('Paid','Unpaid') NOT NULL,
  `PaymentMethod` enum('Cash','Credit Card','Debit Card') NOT NULL,
  `DueDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `BillingRecord`
--

INSERT INTO `BillingRecord` (`B_ID`, `APP_ID`, `C_ID`, `TotalAmount`, `PaymentStatus`, `PaymentMethod`, `DueDate`) VALUES
(1, 1, 1, 500.00, 'Paid', 'Credit Card', '2023-10-01'),
(2, 2, 1, 750.00, 'Paid', 'Cash', '2023-10-02'),
(3, 3, 2, 900.00, 'Unpaid', 'Debit Card', '2023-10-10');

-- --------------------------------------------------------

--
-- Table structure for table `Client`
--

CREATE TABLE `Client` (
  `C_ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Address` text NOT NULL,
  `Email` varchar(255) NOT NULL,
  `RegistrationDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Client`
--

INSERT INTO `Client` (`C_ID`, `Name`, `PhoneNumber`, `Address`, `Email`, `RegistrationDate`) VALUES
(1, 'Nourhan Hamdy', '01010216416', '14th May Bridge St.', 'nourhanhamdy1711@gmail.com', '2023-01-15'),
(2, 'Mariam Alaa', '01101011865', 'Fatma EL-Zahraa St.', 'mariam.alaafathy@gmail.com', '2023-02-10'),
(3, 'Youmna Yasser', '01020550027', 'Transport & Engineering St.', 'youmnayasser2003@gmail.com', '2023-03-05');

-- --------------------------------------------------------

--
-- Table structure for table `Pet`
--

CREATE TABLE `Pet` (
  `P_ID` int(11) NOT NULL,
  `C_ID` int(11) NOT NULL,
  `Pname` varchar(255) NOT NULL,
  `Species` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` enum('Male','Female') NOT NULL,
  `Weight` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Pet`
--

INSERT INTO `Pet` (`P_ID`, `C_ID`, `Pname`, `Species`, `DOB`, `Gender`, `Weight`) VALUES
(1, 1, 'Kookie', 'Cat', '2020-05-10', 'Male', 4.50),
(2, 1, 'Joy', 'Cat', '2019-07-20', 'Female', 3.20),
(3, 2, 'Possie', 'Rabbit', '2021-03-15', 'Female', 3.00);

-- --------------------------------------------------------

--
-- Table structure for table `StaffMember`
--

CREATE TABLE `StaffMember` (
  `S_ID` int(11) NOT NULL,
  `Sname` varchar(255) NOT NULL,
  `Role` varchar(100) NOT NULL,
  `Specialization` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(15) NOT NULL,
  `Address` text NOT NULL,
  `Email` varchar(255) NOT NULL,
  `HireDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `StaffMember`
--

INSERT INTO `StaffMember` (`S_ID`, `Sname`, `Role`, `Specialization`, `PhoneNumber`, `Address`, `Email`, `HireDate`) VALUES
(1, 'Dr. Alice Johnson', 'Veterinarian', 'Surgery', '1112223333', '789 Pine Street', 'alice@example.com', '2022-08-01'),
(2, 'Dr. Bob Williams', 'Veterinarian', 'Dermatology', '4445556666', '321 Cedar Road', 'bob@example.com', '2021-05-15'),
(3, 'Ms. Julia Robert', 'Secretary', NULL, '2336777123', '105 Walker St.', 'julia@example.com', '2019-04-05');

-- --------------------------------------------------------

--
-- Table structure for table `TreatmentRecord`
--

CREATE TABLE `TreatmentRecord` (
  `TR_ID` int(11) NOT NULL,
  `APP_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  `TreatmentDate` date NOT NULL,
  `Details` text NOT NULL,
  `Diagnosis` text DEFAULT NULL,
  `Medications` text DEFAULT NULL,
  `Cost` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `TreatmentRecord`
--

INSERT INTO `TreatmentRecord` (`TR_ID`, `APP_ID`, `S_ID`, `TreatmentDate`, `Details`, `Diagnosis`, `Medications`, `Cost`) VALUES
(1, 1, 1, '2023-10-01', 'Routine physical examination', 'Healthy', NULL, 500.00),
(2, 2, 2, '2023-10-02', 'Treated for skin allergy', 'Allergic dermatitis', 'Antihistamines', 750.00),
(3, 3, 1, '2023-10-03', 'Administered rabies vaccine', NULL, 'Rabies Vaccine', 900.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Appointment`
--
ALTER TABLE `Appointment`
  ADD PRIMARY KEY (`APP_ID`),
  ADD KEY `P_ID` (`P_ID`),
  ADD KEY `S_ID` (`S_ID`);

--
-- Indexes for table `BillingRecord`
--
ALTER TABLE `BillingRecord`
  ADD PRIMARY KEY (`B_ID`),
  ADD KEY `APP_ID` (`APP_ID`),
  ADD KEY `C_ID` (`C_ID`);

--
-- Indexes for table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`C_ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Pet`
--
ALTER TABLE `Pet`
  ADD PRIMARY KEY (`P_ID`),
  ADD KEY `C_ID` (`C_ID`);

--
-- Indexes for table `StaffMember`
--
ALTER TABLE `StaffMember`
  ADD PRIMARY KEY (`S_ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `TreatmentRecord`
--
ALTER TABLE `TreatmentRecord`
  ADD PRIMARY KEY (`TR_ID`),
  ADD KEY `APP_ID` (`APP_ID`),
  ADD KEY `S_ID` (`S_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Appointment`
--
ALTER TABLE `Appointment`
  MODIFY `APP_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `BillingRecord`
--
ALTER TABLE `BillingRecord`
  MODIFY `B_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Client`
--
ALTER TABLE `Client`
  MODIFY `C_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Pet`
--
ALTER TABLE `Pet`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `StaffMember`
--
ALTER TABLE `StaffMember`
  MODIFY `S_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `TreatmentRecord`
--
ALTER TABLE `TreatmentRecord`
  MODIFY `TR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Appointment`
--
ALTER TABLE `Appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`P_ID`) REFERENCES `Pet` (`P_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`S_ID`) REFERENCES `StaffMember` (`S_ID`) ON DELETE CASCADE;

--
-- Constraints for table `BillingRecord`
--
ALTER TABLE `BillingRecord`
  ADD CONSTRAINT `billingrecord_ibfk_1` FOREIGN KEY (`APP_ID`) REFERENCES `Appointment` (`APP_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `billingrecord_ibfk_2` FOREIGN KEY (`C_ID`) REFERENCES `Client` (`C_ID`) ON DELETE CASCADE;

--
-- Constraints for table `Pet`
--
ALTER TABLE `Pet`
  ADD CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `Client` (`C_ID`) ON DELETE CASCADE;

--
-- Constraints for table `TreatmentRecord`
--
ALTER TABLE `TreatmentRecord`
  ADD CONSTRAINT `treatmentrecord_ibfk_1` FOREIGN KEY (`APP_ID`) REFERENCES `Appointment` (`APP_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `treatmentrecord_ibfk_2` FOREIGN KEY (`S_ID`) REFERENCES `StaffMember` (`S_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2023 at 01:51 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `id` int(5) NOT NULL,
  `userName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_by` int(5) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(5) NOT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isActive` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`id`, `userName`, `password`, `created_by`, `created_on`, `updated_by`, `updated_on`, `isActive`) VALUES
(1, 'admin@gmail.com', 'admin@1234', 0, '2023-02-09 09:19:38', 0, '2023-02-09 09:21:09', 1);

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_token_id` int(11) NOT NULL,
  `appointment_time` time NOT NULL,
  `appointment_date` date NOT NULL,
  `isAdmit` tinyint(4) NOT NULL DEFAULT 0,
  `isbedAllotment` tinyint(4) NOT NULL DEFAULT 0,
  `bed_number` int(11) NOT NULL DEFAULT 0,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `patient_id`, `department_id`, `doctor_id`, `patient_token_id`, `appointment_time`, `appointment_date`, `isAdmit`, `isbedAllotment`, `bed_number`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(20, 13, 28, 16, 1, '08:00:00', '2023-02-24', 0, 0, 0, '2023-02-24 11:29:33', 1, '2023-02-24 11:29:33', NULL),
(21, 12, 9, 3, 1, '08:00:00', '2023-02-24', 1, 1, 2, '2023-02-24 11:29:42', 1, '2023-02-24 11:29:42', NULL),
(22, 10, 9, 3, 1, '08:00:00', '2023-02-27', 1, 1, 4, '2023-02-24 12:34:13', 1, '2023-02-24 12:34:13', NULL),
(23, 9, 5, 4, 1, '08:00:00', '2023-02-24', 0, 0, 0, '2023-02-24 12:34:22', 1, '2023-02-24 12:34:22', NULL),
(24, 8, 9, 3, 2, '08:15:00', '2023-02-24', 1, 1, 3, '2023-02-24 12:34:31', 1, '2023-02-24 12:34:31', NULL),
(26, 14, 27, 16, 1, '08:00:00', '2023-03-01', 0, 0, 0, '2023-03-01 04:54:39', 1, '2023-03-01 04:54:39', NULL),
(27, 13, 9, 3, 1, '08:00:00', '2023-03-01', 0, 0, 0, '2023-03-01 09:07:38', 1, '2023-03-01 09:07:38', NULL),
(28, 14, 9, 3, 2, '08:15:00', '2023-03-01', 0, 0, 0, '2023-03-01 11:26:34', 1, '2023-03-01 11:26:34', NULL),
(29, 15, 9, 3, 3, '08:30:00', '2023-03-01', 1, 1, 5, '2023-03-01 11:26:43', 1, '2023-03-01 11:26:43', NULL),
(30, 9, 9, 3, 1, '08:00:00', '2023-03-02', 0, 0, 0, '2023-03-02 10:26:18', 1, '2023-03-02 10:26:18', NULL),
(31, 14, 11, 20, 1, '08:00:00', '2023-03-02', 0, 0, 0, '2023-03-02 10:26:31', 1, '2023-03-02 10:26:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bed_allotment`
--

CREATE TABLE `bed_allotment` (
  `id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `bed_number` int(11) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blood_bank`
--

CREATE TABLE `blood_bank` (
  `id` int(11) NOT NULL,
  `candidate_name` varchar(255) NOT NULL,
  `candidate_type` varchar(255) NOT NULL,
  `mobile_number` varchar(255) NOT NULL,
  `aadhar_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `blood_group_id` varchar(255) NOT NULL,
  `dob` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `blood_unit` int(11) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blood_bank`
--

INSERT INTO `blood_bank` (`id`, `candidate_name`, `candidate_type`, `mobile_number`, `aadhar_number`, `address`, `email`, `blood_group_id`, `dob`, `gender`, `blood_unit`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(2, 'khushi gfh', 'Receiver', '9799914470', '123456789111', 'Sardarpura, Jodhpur,Raj', 'rohitdg@gmail.com', '2', '2023-03-01', 'Male', 3, '2023-03-02 13:14:11', 1, '2023-03-03 05:11:21', 1);

-- --------------------------------------------------------

--
-- Table structure for table `blood_group`
--

CREATE TABLE `blood_group` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blood_group`
--

INSERT INTO `blood_group` (`id`, `name`, `created_by`, `created_on`, `updated_by`, `updated_on`) VALUES
(1, 'A+', 1, '2023-02-15 07:36:50', 1, '2023-02-15 07:36:50'),
(2, 'A-', 1, '2023-02-15 07:36:50', 1, '2023-02-15 07:36:50'),
(3, 'B+', 1, '2023-02-15 07:37:08', 1, '2023-02-15 07:37:08'),
(4, 'B-', 1, '2023-02-15 07:37:08', 1, '2023-02-15 07:37:08'),
(5, 'O+', 1, '2023-02-15 07:37:22', 1, '2023-02-15 07:37:22'),
(6, 'O-', 1, '2023-02-15 07:37:22', 1, '2023-02-15 07:37:22'),
(7, 'AB+', 1, '2023-02-15 07:37:38', 1, '2023-02-15 07:37:38'),
(8, 'AB-', 1, '2023-02-15 07:37:38', 1, '2023-02-15 07:37:38');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `department_details` longtext NOT NULL,
  `department_bed_total` int(11) NOT NULL,
  `department_available_bed` int(11) NOT NULL DEFAULT 0,
  `department_reserved_bed` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isActive` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `department_name`, `department_details`, `department_bed_total`, `department_available_bed`, `department_reserved_bed`, `created_by`, `created_on`, `updated_by`, `updated_on`, `isActive`) VALUES
(3, 'Gynaecology', 'Gynaecology department deals with investigation, treatment and prevention of female reproductive system and urinary tract problems. Some of the common problems which are investigated and treated are infertility, incontinence, endometritis etc.', 10, 0, 0, 0, '2023-02-13 08:24:13', 1, '2023-03-02 06:41:31', 1),
(4, 'Haematology', 'Haematology department deals with investigation, treatment and prevention of blood diseases. This department closely work with the hospital laboratory.', 20, 0, 0, 0, '2023-02-13 08:24:13', 0, '2023-02-28 12:38:08', 1),
(5, 'Neurology', 'Neurology department deals with the investigation, treatment and prevention of the human nervous system.', 20, 0, 0, 0, '2023-02-13 08:24:13', 0, '2023-03-01 10:37:04', 0),
(6, 'Orthopaedic', 'This department deals with problems and treatments of the musculoskeletal system. Services include bone setting, repair of damaged bone, ligaments, tendons and replacements of bones. This department provides both inpatient and outpatient services. Outpatient services include fracture treatment, dislocated joints, musculoskeletal injuries.', 20, 0, 0, 0, '2023-02-13 08:24:13', 0, '2023-02-28 11:37:15', 0),
(9, 'ENT ', 'ENT department deals with investigation and treatment of ear, nose and throat disorders. ENT department deals with various disorders such as:\r\n   - General ear, nose and throat diseases\r\n   - Cancers of the neck and head region\r\n   - Neck lumps\r\n   - ENT allergy problems\r\n   - Balance and hearing disorders\r\n   - Salivary gland diseases\r\n   - Voice disorders\r\n   - Surgical procedures of ENT', 20, 16, 4, 0, '2023-02-13 08:24:13', 0, '2023-03-01 12:29:41', 1),
(10, 'Paediatrics', 'The paediatrics department deals with infants, children and adolescents. This department deals with some significant diseases such as infectious diseases, congenital diseases, mental disorders and childhood cancer. In this department health care personnel are specialized and also procedures and practices are different based on the child\'s age group.', 20, 0, 0, 0, '2023-02-13 08:24:13', 0, '2023-02-28 11:37:19', 0),
(11, 'Psychiatry', 'This department deals with diagnosis, treatment and prevention of mental illness and disorders. Some of the services include:\r\n   - Investigation, diagnosis and treatment of psychiatric illness\r\n   - Providing psychological counselling\r\n   - De-addiction services\r\n   - Conducting IQ tests.', 20, 0, 0, 0, '2023-02-13 08:24:13', 0, '2023-02-28 11:28:12', 1),
(25, 'Anesthetics', 'Doctors in this department give anesthetic for operations and procedures. An anesthetic is a drug or agent that produces a complete or partial loss of feeling. There are three kinds of anesthetic: general, regional and local.', 10, 0, 0, 1, '2023-02-16 09:39:52', 1, '2023-02-28 11:27:43', 1),
(26, 'Dentistry', 'The branch of medical science concerned with the diagnosis and treatment of diseases and disorders of the teeth and gums.', 20, 0, 0, 1, '2023-02-16 09:45:25', NULL, '2023-02-28 11:27:46', 1),
(27, 'Dermatology & Cosmetic', 'Cosmetic dermatology is a specialised field of dermatology that focuses on procedures that improve appearance of the skin, particularly on the face and neck. It is also known as aesthetic dermatology or aesthetic medicine.', 20, 20, 0, 1, '2023-02-16 09:46:40', NULL, '2023-03-01 12:27:03', 1),
(28, 'Gastroenterology', 'A gastroenterologist is a specialist with expertise in the disorders and diseases that affect the digestive system — which includes the gastrointestinal tract (esophagus, stomach, small intestine, large intestine, rectum and anus) as well as the pancreas, liver, bile ducts and gallbladder.', 20, 0, 0, 1, '2023-02-16 09:47:23', NULL, '2023-03-01 10:36:58', 1);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `doctor_image` varchar(255) NOT NULL,
  `doctor_fees` varchar(255) NOT NULL,
  `doctor_mobile` varchar(255) NOT NULL,
  `doctor_email` varchar(255) NOT NULL,
  `doctor_address` varchar(255) NOT NULL,
  `doctor_password` varchar(255) NOT NULL,
  `doctor_education` varchar(255) NOT NULL,
  `doctor_dob` date NOT NULL,
  `doctor_department_id` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `doctor_name`, `doctor_image`, `doctor_fees`, `doctor_mobile`, `doctor_email`, `doctor_address`, `doctor_password`, `doctor_education`, `doctor_dob`, `doctor_department_id`, `isActive`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(3, 'Dr. Rohan Kalla', 'download_1q2de4hauj573.jpeg', '500', '9744458620', 'rohan@gmail.com', 'MG Road , jodhpur', '$2a$12$7M9iRbkE3xJnCfOwqehLo.057uRzC10hjU91WCGYpi2taTYFhL59e', 'MS', '2023-03-01', 9, 1, '2023-02-15 07:47:04', 1, '2023-03-01 04:44:31', 1),
(4, 'Dr. Ankit Sain', 'kpail.jpg', '500', '9766613385', 'ankit@gmail.com', 'Raja park Jaipur raj', '$2a$12$M0IU79F5NueXnwRalpwe4u5d5sEO/AOqrIFtkFqxG9W4HSXCYIeWm', 'MD', '2023-02-04', 5, 1, '2023-02-15 07:56:04', 1, '2023-02-28 11:55:57', NULL),
(16, 'Dr. Twinkle Purohit', 'images_1sqlvugzbs32s.jpeg', '300', '9799914487', 'twinkle@gmail.com', 'Raja park Jaipur raj', '$2a$12$w/HKK.uY08nPLXkT.CZBi.TpP.j7kDjrzAaVWXdhCok8PfKdXzNTW', 'MBBS', '2023-03-01', 27, 1, '2023-02-16 09:51:23', 1, '2023-03-01 04:44:43', 1),
(20, 'Dr. Nikhil Mishra', 'imagesuser_1hta81psohl2c.png', '500', '9733345960', 'nikhil@gmail.com', 'Near Goyal Hospital Jodhpur', '$2a$12$6rcsQvFWFUb5F825ducL9uahGNnvlAqqUm3fm.giPpOzFvyhJVPWy', 'MBBS ', '1987-02-05', 11, 1, '2023-03-01 04:44:12', 1, '2023-03-01 04:44:12', NULL),
(21, 'Dr. Irfan Khan', 'user1_1peaq06uipiju.jpg', '300', '8991445669', 'irfan@gmail.com', 'Suraj Pohl Jalore', '$2a$12$aFm21p2U5HaJsT2d2gG/GuPVS3zaxJEsq.vdV74b7QTvGw/3BKq8m', 'MBBS', '1960-11-12', 26, 1, '2023-03-01 04:46:13', 1, '2023-03-01 04:46:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `id` int(11) NOT NULL,
  `nurse_name` varchar(255) NOT NULL,
  `nurse_image` varchar(255) NOT NULL,
  `nurse_mobile` varchar(255) NOT NULL,
  `nurse_email` varchar(255) NOT NULL,
  `nurse_address` varchar(255) NOT NULL,
  `nurse_password` varchar(255) NOT NULL,
  `nurse_education` varchar(255) NOT NULL,
  `nurse_dob` date NOT NULL,
  `nurse_department_id` int(11) NOT NULL,
  `isActive` tinyint(4) NOT NULL DEFAULT 1,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nurse`
--

INSERT INTO `nurse` (`id`, `nurse_name`, `nurse_image`, `nurse_mobile`, `nurse_email`, `nurse_address`, `nurse_password`, `nurse_education`, `nurse_dob`, `nurse_department_id`, `isActive`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(3, 'Gunjan Bohra', 'userr_espczeydcnj4_5kjvscewjmaf.jpg', '9566614487', 'gunjan@gmail.com', 'Sector G , Shastri nagar , Jodhpur', '$2a$12$KsJMpnthVbe4TfwO5EeAg.O1tqfICnIXcsiDC13NM2L.qHPBdhUPG', 'BSc ', '2023-03-02', 4, 1, '2023-03-02 06:52:49', 1, '2023-03-02 07:21:22', 1),
(4, 'siddika jain', 'small_flower_n73pxgclxd8q.jpg', '9755561125', 'siddikaJain@1996', 'Jalori Gate , Jodhpur', '$2a$12$xJWpvyTcHVyigyrB.j7PuetTUWYJ.icE8OGCE1LGFnQ/JouCGJ5tq', 'BSE Nursing', '2023-02-27', 26, 1, '2023-03-02 07:19:40', 1, '2023-03-02 07:21:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `id` int(11) NOT NULL,
  `patient_name` varchar(255) NOT NULL,
  `patient_mobile` varchar(255) NOT NULL,
  `patient_email` varchar(255) NOT NULL,
  `patient_gender` varchar(255) NOT NULL,
  `patient_aadhar_no` varchar(255) NOT NULL,
  `patient_password` varchar(255) NOT NULL,
  `patient_address` varchar(255) NOT NULL,
  `patient_blood_group_id` varchar(255) NOT NULL,
  `patient_dob` varchar(255) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`id`, `patient_name`, `patient_mobile`, `patient_email`, `patient_gender`, `patient_aadhar_no`, `patient_password`, `patient_address`, `patient_blood_group_id`, `patient_dob`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(8, 'John Jain', '9799914455', 'john1996@gmail.com', 'Male', '999999999999', '$2a$12$D197mo1owMyYG0PtBCNdYep5gbncc9T4n9wnZRdZU8994cKq4Q7BW', 'Ram Puri Kota', '3', '2023-02-03', '2023-02-22 06:29:16', 1, '2023-02-22 06:29:16', NULL),
(9, 'Kamlesh Singh', '7888145729', 'kamlesh@gmail.com', 'Male', '123456789456', '$2a$12$v7R5Rv5v1fWA2BjlbvFi.e2.Kijbhpla/Z5VCLFhz5J1vG.yywY5e', 'khnjk7b6 gn 5', '4', '2023-02-04', '2023-02-22 06:29:49', 1, '2023-02-22 06:30:07', 1),
(10, 'Yogesh Kalla', '3283278342', 'yogesh@gmail.com', 'Male', '456564564566', '$2a$12$uqxtBHqpyeTH8bScMSr7R.l3ctpIh4atj/7Qq.btCqBGwtb7.rAMm', 'Ram Puri Kota', '7', '2023-02-10', '2023-02-22 10:31:25', 1, '2023-02-22 10:31:25', NULL),
(11, 'Prasoon', '7894561230', 'prasoon@gmail.com', 'Male', '545454448484', '$2a$12$YlXM1nKZwon7XeGt2tjAKeZnq45/7R02O0fAgPZqzbj1kHYUe8mRu', 'khnjk7b6 gn 5', '4', '2023-01-30', '2023-02-23 05:07:07', 1, '2023-02-23 05:07:07', NULL),
(12, 'Kalpesh Purohit', '8974561238', 'kaplesh@gmail.com', 'Male', '128892608799', '$2a$12$9diVFKGuy9T2V1O0OtkWgOxTY42EXobX2T4EPgJMWusgkbf5/HX9a', 'Near Taj Hotel , Jodhpur', '8', '2023-02-17', '2023-02-23 06:34:03', 1, '2023-02-23 06:34:03', NULL),
(13, 'Rahul Sharma', '7895462139', 'rahul@gmail.com', 'Male', '321654789852', '$2a$12$sY4buy7OEEloU/4VzWmrze02J4OeMqQvuXoD8waF1VJDG0aOIsRaW', 'Vashiali Nagar , Kota', '7', '2023-02-23', '2023-02-23 06:34:53', 1, '2023-02-23 06:34:53', NULL),
(14, 'Abhi Jain', '8999445633', 'abhi@gmail.com', 'Male', '444646464646', '$2a$12$Cb.vz2NQDzHVObsMPqgmHeY8wHp16RKoMDaUSPjFH5frKdFiSYu7.', 'Shastri nagar jodhpur', '4', '2023-02-23', '2023-02-23 06:35:50', 1, '2023-02-23 12:35:55', 1),
(15, 'Sunil Sharma', '9994445596', 'sunil@gmail.com', 'Male', '123488898700', '$2a$12$CaF565Wvzt3H.cUKHbCPzeQ/lBwQZmj094fcTYfOUTGZp47MZQ.DS', 'B road sardarpura , Jodhpur', '4', '2023-01-31', '2023-02-28 10:48:55', 1, '2023-02-28 10:48:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy`
--

CREATE TABLE `pharmacy` (
  `id` int(11) NOT NULL,
  `medicine_name` varchar(255) NOT NULL,
  `medicine_company` varchar(255) NOT NULL,
  `medicine_quantity` varchar(255) NOT NULL,
  `medicine_description` varchar(255) NOT NULL,
  `medicine_maufacturing_date` date NOT NULL,
  `medicine_expiry_date` date NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pharmacy`
--

INSERT INTO `pharmacy` (`id`, `medicine_name`, `medicine_company`, `medicine_quantity`, `medicine_description`, `medicine_maufacturing_date`, `medicine_expiry_date`, `created_on`, `created_by`, `updated_on`, `updated_by`) VALUES
(3, 'yyyyy', 'iiiiiii', '9', 'fghgfhfhjkj', '2023-03-14', '2023-03-24', '2023-03-03 12:31:02', 1, '2023-03-03 12:40:28', 1),
(4, 'dsfdfg', 'dsfds', '90', 'fghgfhfhjkj', '2023-03-14', '2023-04-01', '2023-03-03 12:48:27', 1, '2023-03-03 12:48:27', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bed_allotment`
--
ALTER TABLE `bed_allotment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blood_bank`
--
ALTER TABLE `blood_bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blood_group`
--
ALTER TABLE `blood_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `doctor_email` (`doctor_email`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pharmacy`
--
ALTER TABLE `pharmacy`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `bed_allotment`
--
ALTER TABLE `bed_allotment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_bank`
--
ALTER TABLE `blood_bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blood_group`
--
ALTER TABLE `blood_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pharmacy`
--
ALTER TABLE `pharmacy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

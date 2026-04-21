-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 19, 2025 at 02:48 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP DATABASE drais_school;
CREATE DATABASE drais_school;
use drais_school;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drais_school`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_years`
--

CREATE TABLE `academic_years` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `id` bigint(20) NOT NULL,
  `actor_user_id` bigint(20) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(100) NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `changes_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`changes_json`)),
  `ip` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `curriculum_id` int(11) DEFAULT NULL,
  `class_level` int(11) DEFAULT NULL,
  `head_teacher_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `school_id`, `name`, `curriculum_id`, `class_level`, `head_teacher_id`) VALUES
(2, 1, 'BABY CLASS', 1, 1, 1),
(3, 1, 'MIDDLE CLASS', 1, 1, 2),
(4, 1, 'TOP CLASS', 1, 1, 3),
(5, 1, 'PRIMARY ONE', 1, NULL, NULL),
(6, 1, 'PRIMARY TWO', 1, NULL, NULL),
(7, 1, 'PRIMARY THREE', 1, NULL, NULL),
(8, 1, 'PRIMARY FOUR', 1, NULL, NULL),
(9, 1, 'PRIMARY FIVE', 1, NULL, 5),
(10, 1, 'PRIMARY SIX', 1, NULL, NULL),
(11, 1, 'PRIMARY SEVEN', 1, NULL, NULL),
(13, 1, 'TAHFIZ', 2, NULL, NULL),
(14, 1, 'BABY CLASS', 1, 1, 1),
(15, 1, 'MIDDLE CLASS', 1, 2, 2),
(16, 1, 'TOP CLASS', 1, 3, 3),
(18, 1, 'PRIMARY ONE', 1, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `class_results`
--

CREATE TABLE `class_results` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `result_type_id` bigint(20) NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `contact_type` varchar(30) NOT NULL,
  `occupation` varchar(120) DEFAULT NULL,
  `alive_status` varchar(20) DEFAULT NULL,
  `date_of_death` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `school_id`, `person_id`, `contact_type`, `occupation`, `alive_status`, `date_of_death`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 103, 'father', NULL, NULL, NULL, '2025-08-18 10:10:26', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `counties`
--

CREATE TABLE `counties` (
  `id` bigint(20) NOT NULL,
  `district_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `curriculums`
--

CREATE TABLE `curriculums` (
  `id` tinyint(4) NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `curriculums`
--

INSERT INTO `curriculums` (`id`, `code`, `name`) VALUES
(1, 'secular', 'Secular Curriculum'),
(2, 'theology', 'Theology Curriculum');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `head_staff_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department_workplans`
--

CREATE TABLE `department_workplans` (
  `id` bigint(20) NOT NULL,
  `department_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `owner_type` varchar(30) NOT NULL,
  `owner_id` bigint(20) NOT NULL,
  `document_type_id` bigint(20) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `file_url` varchar(255) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `issued_by` varchar(150) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `uploaded_by` bigint(20) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` bigint(20) NOT NULL,
  `code` varchar(60) NOT NULL,
  `label` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `code`, `label`) VALUES
(1, 'national_id', 'National ID'),
(2, 'passport_photo', 'Passport Photo'),
(3, 'full_photo', 'Full Photo'),
(4, 'imam_priest_letter', 'Letter from Imam/Priest'),
(5, 'county_kadhi_reverend_letter', 'Letter from County Kadhi/Reverend'),
(6, 'lci_letter', 'Letter from LCI'),
(7, 'gso_letter', 'Letter from GISO/GSO'),
(8, 'birth_certificate', 'Birth Certificate'),
(9, 'transfer_letter', 'Transfer Letter'),
(10, 'other', 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `class_id` bigint(20) DEFAULT NULL,
  `theology_class_id` bigint(20) DEFAULT NULL,
  `stream_id` bigint(20) DEFAULT NULL,
  `academic_year_id` bigint(20) DEFAULT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`id`, `student_id`, `class_id`, `theology_class_id`, `stream_id`, `academic_year_id`, `term_id`, `status`) VALUES
(1, 457, 9, NULL, NULL, NULL, NULL, 'active'),
(2, 458, 9, NULL, NULL, NULL, NULL, 'active'),
(3, 459, 9, NULL, NULL, NULL, NULL, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `start_datetime` datetime NOT NULL,
  `end_datetime` datetime NOT NULL,
  `location` varchar(120) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'upcoming',
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `body` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `status` varchar(20) DEFAULT 'scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fee_payments`
--

CREATE TABLE `fee_payments` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `wallet_id` bigint(20) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `method` varchar(30) DEFAULT NULL,
  `paid_by` varchar(150) DEFAULT NULL,
  `payer_contact` varchar(50) DEFAULT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `receipt_no` varchar(40) DEFAULT NULL,
  `ledger_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fee_structures`
--

CREATE TABLE `fee_structures` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `item` varchar(120) NOT NULL,
  `amount` decimal(14,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_categories`
--

CREATE TABLE `finance_categories` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ledger`
--

CREATE TABLE `ledger` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `wallet_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `tx_type` varchar(10) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `student_id` bigint(20) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `living_statuses`
--

CREATE TABLE `living_statuses` (
  `id` tinyint(4) NOT NULL,
  `code` varchar(20) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `living_statuses`
--

INSERT INTO `living_statuses` (`id`, `code`, `label`) VALUES
(1, 'alive', 'Alive'),
(2, 'deceased', 'Deceased');

-- --------------------------------------------------------

--
-- Table structure for table `nationalities`
--

CREATE TABLE `nationalities` (
  `id` int(11) NOT NULL,
  `code` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nationalities`
--

INSERT INTO `nationalities` (`id`, `code`, `name`) VALUES
(1, 'UGA', 'Uganda');

-- --------------------------------------------------------

--
-- Table structure for table `orphan_statuses`
--

CREATE TABLE `orphan_statuses` (
  `id` tinyint(4) NOT NULL,
  `code` varchar(20) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orphan_statuses`
--

INSERT INTO `orphan_statuses` (`id`, `code`, `label`) VALUES
(1, 'orphan', 'Orphan'),
(2, 'non_orphan', 'Non-Orphan');

-- --------------------------------------------------------

--
-- Table structure for table `parishes`
--

CREATE TABLE `parishes` (
  `id` bigint(20) NOT NULL,
  `subcounty_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll_definitions`
--

CREATE TABLE `payroll_definitions` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

CREATE TABLE `people` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `other_name` varchar(100) DEFAULT NULL,
  `gender` varchar(15) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `people`
--

INSERT INTO `people` (`id`, `school_id`, `first_name`, `last_name`, `other_name`, `gender`, `date_of_birth`, `phone`, `email`, `address`, `photo_url`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'kalungi', 'hamuza', NULL, 'M', '2025-08-14', NULL, NULL, NULL, NULL, '2025-08-18 07:43:48', NULL, NULL),
(2, 1, 'NAIRAH', 'MUHAMMAD', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 07:11:19', NULL, NULL),
(3, 1, 'NANYANGE', 'YUSURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:47:12', NULL, NULL),
(4, 1, 'NAIGAGA', 'JALIA NKENGA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:48:28', NULL, NULL),
(5, 1, 'NAMULI', 'ZIYADA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:58:21', NULL, NULL),
(6, 1, 'NAJJUKO', 'MADINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:59:18', NULL, NULL),
(7, 1, 'KISUYI', 'MUSWAB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:00:15', NULL, NULL),
(8, 1, 'NAKIMULI', 'AISHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:00:51', NULL, NULL),
(9, 1, 'NAMBEEDHA', 'NUSULA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:02:19', NULL, NULL),
(10, 1, 'RUKAYYA ISA', 'SEMPIJJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:03:40', NULL, NULL),
(11, 1, 'DIDI', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:04:22', NULL, NULL),
(12, 1, 'TUMUSIME', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:05:38', NULL, NULL),
(13, 1, 'KANENE', 'UTHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:06:20', NULL, NULL),
(14, 1, 'MPAULO', 'ZAITUNA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:07:08', NULL, NULL),
(15, 1, 'ASIMWE', 'RAZAK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:07:52', NULL, NULL),
(16, 1, 'RASHMA', 'BINT RAMATHAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:08:46', NULL, NULL),
(17, 1, 'NKIZZI', 'MARIAM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:09:54', NULL, NULL),
(18, 1, 'RANI', 'BARAKAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:10:35', NULL, NULL),
(19, 1, 'MUWAYI', 'HISHAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:11:24', NULL, NULL),
(20, 1, 'IBRAHIM', 'ODOGO', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:12:05', NULL, NULL),
(21, 1, 'KAKEREWE', 'MEDDIE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:13:04', NULL, NULL),
(22, 1, 'MUSWAB', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:13:53', NULL, NULL),
(23, 1, 'ISABIRYE', 'UMARU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:14:37', NULL, NULL),
(24, 1, 'BABUZA', 'MUHAMMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:11', NULL, NULL),
(25, 1, 'ZZIWA', 'RAYHAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:52', NULL, NULL),
(26, 1, 'NTAMBI', 'FAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:16:32', NULL, NULL),
(27, 1, 'KILIBA', 'UMAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:17:21', NULL, NULL),
(28, 1, 'SSENYANGE', 'DALDAE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:18:03', NULL, NULL),
(29, 1, 'MUZAALE', 'SALIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:18:41', NULL, NULL),
(30, 1, 'KAWUMA', 'NIJAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:19:28', NULL, NULL),
(31, 1, 'BALUKA', 'KHADIJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:20:36', NULL, NULL),
(32, 1, 'KYEYAGO', 'NASIF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:21:42', NULL, NULL),
(33, 1, 'NSUBUGA', 'ZAKIYYU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:22:27', NULL, NULL),
(34, 1, 'NAZIIFA', 'NAIGAGA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:23:12', NULL, NULL),
(35, 1, 'RUKAYYA', 'SIRINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:24:45', NULL, NULL),
(36, 1, 'TIKUSITWA', 'AMAL', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:25:23', NULL, NULL),
(37, 1, 'NAMUKOBE', 'ZAHIRA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:26:03', NULL, NULL),
(38, 1, 'KIKOBWAKO', 'GIFT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:26:40', NULL, NULL),
(39, 1, 'NANJURA B', 'DESIRE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:27:34', NULL, NULL),
(40, 1, 'MUKISA', 'JEMIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:28:12', NULL, NULL),
(41, 1, 'NAMIYINGO', 'THUWAIBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:28:57', NULL, NULL),
(42, 1, 'NANDUBU', 'JACOB', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:30:13', NULL, NULL),
(43, 1, 'MUTESI', 'SHARIFAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:31:47', NULL, NULL),
(44, 1, 'NTUUYO', 'IMRAN  HASIM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:33:44', NULL, NULL),
(45, 1, 'MENYA', 'ABDL-RAHIIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:34:44', NULL, NULL),
(46, 1, 'NABUTANDA', 'RANIA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:35:32', NULL, NULL),
(47, 1, 'NAMUWAYA', 'SHATURA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:40:22', NULL, NULL),
(48, 1, 'NAKIRANDA', 'RAHIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:27:59', NULL, NULL),
(49, 1, 'SHAMSHA  MUBIRU', 'YUSUF', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:28:56', NULL, NULL),
(50, 1, 'MUHSIN', 'ABDULLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:30:13', NULL, NULL),
(51, 1, 'MUWANGUZI', 'RAFIK', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:31:44', NULL, NULL),
(52, 1, 'MULINDA', 'AZED', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:33:20', NULL, NULL),
(53, 1, 'NABANAKULYA', 'HADIJJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:34:14', NULL, NULL),
(54, 1, 'MUNURO', 'AFRINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:35:08', NULL, NULL),
(55, 1, 'WESIGE', 'ALEYA  RAMADHAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:36:15', NULL, NULL),
(56, 1, 'ASUMAN', 'ATANAZIRABA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:37:11', NULL, NULL),
(57, 1, 'TENYWA', 'ALI MANSI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:26:51', NULL, NULL),
(58, 1, 'HAFIIZU', 'WAISWA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:28:18', NULL, NULL),
(59, 1, 'SSEMAZI', 'SHAMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:29:02', NULL, NULL),
(60, 1, 'NABOSA', 'RAYHAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:29:56', NULL, NULL),
(61, 1, 'NAMAGEMBE', 'SHAZIMINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:30:45', NULL, NULL),
(62, 1, 'NAMWABALA', 'KAUTHAR', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:31:34', NULL, NULL),
(63, 1, 'DIDI', 'RAYHAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:32:11', NULL, NULL),
(64, 1, 'LUGWIRE', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:32:58', NULL, NULL),
(65, 1, 'ADEN', 'UTHUMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:33:58', NULL, NULL),
(66, 1, 'AALYAH', 'HAMZA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:34:36', NULL, NULL),
(67, 1, 'HAMZA MUHAMMAD', 'MWASE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:36:31', NULL, NULL),
(68, 1, 'MUKISA', 'RASHIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:37:12', NULL, NULL),
(69, 1, 'DUMBA', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:37:46', NULL, NULL),
(70, 1, 'MATENDE', 'SHURAIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:42:28', NULL, NULL),
(71, 1, 'KIBIRIGE', 'AKRAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:43:05', NULL, NULL),
(72, 1, 'NAMUWAYA', 'SUMAYA UMAR', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:44:23', NULL, NULL),
(73, 1, 'MUYIIMA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:45:53', NULL, NULL),
(74, 1, 'NAMUWAYA', 'ASHIYA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:46:32', NULL, NULL),
(75, 1, 'ISABIRYE', 'HUZAIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:47:11', NULL, NULL),
(76, 1, 'MULINDA', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:47:48', NULL, NULL),
(77, 1, 'MAGUMBA', 'AKIRAM JOWAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:48:38', NULL, NULL),
(78, 1, 'BIDI', 'SAIDA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:49:12', NULL, NULL),
(79, 1, 'ZIWA', 'RAUSHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:49:53', NULL, NULL),
(80, 1, 'SSALI', 'RASHID MUBARAKA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:50:41', NULL, NULL),
(81, 1, 'DHAKABA', 'SHABAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:51:25', NULL, NULL),
(82, 1, 'KASADHA', 'HUSINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:52:08', NULL, NULL),
(83, 1, 'YAHAYA', 'ISA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:53:39', NULL, NULL),
(84, 1, 'KATENDE', 'YASIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:54:11', NULL, NULL),
(85, 1, 'BAMWAGALE', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:54:59', NULL, NULL),
(86, 1, 'SHURAIM', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:55:31', NULL, NULL),
(87, 1, 'LWANTALE', 'SHUMI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:56:11', NULL, NULL),
(88, 1, 'ABDUL-RAHMAN', 'RAMADHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:56:54', NULL, NULL),
(89, 1, 'MUBARA', 'ABDUL-SWABUR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:58:00', NULL, NULL),
(90, 1, 'KINTU', 'SAD JUNIOR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:58:36', NULL, NULL),
(91, 1, 'AYEBALE', 'ASHLYN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:59:22', NULL, NULL),
(92, 1, 'MAYANJA', 'IDRIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:00:21', NULL, NULL),
(93, 1, 'NAMUJUZI H', 'TASNEEM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:02:20', NULL, NULL),
(94, 1, 'KIRANDA', 'AZAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:03:02', NULL, NULL),
(95, 1, 'KAGOYA', 'RAHUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:03:49', NULL, NULL),
(96, 1, 'NAKAMANYA', 'LUKAIYA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:04:49', NULL, NULL),
(97, 1, 'SHURAYM', 'ZAID', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:05:36', NULL, NULL),
(98, 1, 'KAWUMA', 'SHATRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:06:20', NULL, NULL),
(99, 1, 'MAYANJA', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:07:19', NULL, NULL),
(100, 1, 'NANGOBI', 'AZIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:07:56', NULL, NULL),
(101, 1, 'NAMUGONZA', 'KHADIJJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:09:11', NULL, NULL),
(102, 1, 'SDWALLAHUDIN', 'BUN UMAR MENYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:10:26', NULL, NULL),
(103, 1, 'UMAR', 'MENYA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:10:26', NULL, NULL),
(104, 1, 'NAMUGABO', 'HAIRAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:11', NULL, NULL),
(105, 1, 'MUGABO', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:50', NULL, NULL),
(106, 1, 'RAYAN', 'TAIKA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:16:26', NULL, NULL),
(107, 1, 'KATABA', 'TASHIL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:17:19', NULL, NULL),
(108, 1, 'GULUBE', 'HADAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:18:20', NULL, NULL),
(109, 1, 'BABIRYE', 'SHAUFA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:22:40', NULL, NULL),
(110, 1, 'NAKUEIRA', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:24:13', NULL, NULL),
(111, 1, 'KIBUTTO', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:25:27', NULL, NULL),
(112, 1, 'MUNUULO AFRAH', 'NANKYA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:26:19', NULL, NULL),
(113, 1, 'GASSEMBA', 'BASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:27:14', NULL, NULL),
(114, 1, 'SHAMIRAH', 'ABDALLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:28:01', NULL, NULL),
(115, 1, 'FAUZAN', 'KASAKYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:29:04', NULL, NULL),
(116, 1, 'NAMPALA', 'MUSA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:30:04', NULL, NULL),
(117, 1, 'NANJIYA', 'TAIBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:30:40', NULL, NULL),
(118, 1, 'NDYEKU', 'J', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:31:35', NULL, NULL),
(119, 1, 'NAKISIGE', 'MWAJJUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:32:34', NULL, NULL),
(120, 1, 'NAMUGAYA', 'SHAMIRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:33:27', NULL, NULL),
(121, 1, 'MAGUMBA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:34:03', NULL, NULL),
(122, 1, 'UTMMAN', 'BASIL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:34:39', NULL, NULL),
(123, 1, 'NAQIYYAH', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:36:01', NULL, NULL),
(124, 1, 'MUZALE', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:36:44', NULL, NULL),
(125, 1, 'HIBA', 'MUHAMMAD', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:37:37', NULL, NULL),
(126, 1, 'GULOOBA', 'JAMAL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:38:55', NULL, NULL),
(127, 1, 'NAFULA', 'PATIENCE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:39:30', NULL, NULL),
(128, 1, 'MAGOOLA', 'BASHIRI', NULL, 'M', NULL, NULL, NULL, 'IGANGA', NULL, '2025-08-18 10:42:23', NULL, NULL),
(129, 1, 'ZAHARA ABDALLAH', 'NAKIBUULE', NULL, 'F', NULL, NULL, NULL, 'KAMPALA', NULL, '2025-08-18 10:46:15', NULL, NULL),
(130, 1, 'ZAINAB ABDALLAH', 'NAMUGENYI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:47:38', NULL, NULL),
(131, 1, 'JUMBA', 'ABDALLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:48:22', NULL, NULL),
(132, 1, 'RAYAN', 'RAMADHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:49:08', NULL, NULL),
(133, 1, 'ARAFAT', 'KIGENYI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:49:53', NULL, NULL),
(134, 1, 'RUKINDU', 'ASHIRAF MUSA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:50:40', NULL, NULL),
(135, 1, 'BUWEMBO', 'MUDATHIR', NULL, 'M', NULL, NULL, NULL, 'MUKONO', NULL, '2025-08-18 10:52:10', NULL, NULL),
(136, 1, 'NSUBUGA', 'ABDUL-AZIZI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:53:02', NULL, NULL),
(137, 1, 'KASEKENDE', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:54:40', NULL, NULL),
(138, 1, 'LUSWATA', 'MUHAMMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:55:58', NULL, NULL),
(139, 1, 'BWANIKA', 'RIDHIWANI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:56:49', NULL, NULL),
(140, 1, 'ABUBAKAR', 'SWIDIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:58:47', NULL, NULL),
(141, 1, 'KIRUNDA', 'ISMAEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:59:32', NULL, NULL),
(142, 1, 'NYANJA', 'NOORDEEN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:00:24', NULL, NULL),
(143, 1, 'MUHAMMAD ALI', 'SSERUBOGO', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:01:29', NULL, NULL),
(144, 1, 'NYANZI', 'ABDUL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:02:18', NULL, NULL),
(145, 1, 'KATEGA', 'AYUB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:03:24', NULL, NULL),
(146, 1, 'SONKO', 'SHARAF KIGANDA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:04:24', NULL, NULL),
(147, 1, 'KATUSIIME', 'FAHIIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:05:18', NULL, NULL),
(148, 1, 'SEGUJJA', 'HUSSEIN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:06:56', NULL, NULL),
(149, 1, 'SSEMWANGA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:07:53', NULL, NULL),
(150, 1, 'MUKOSE', 'TWAHIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:09:10', NULL, NULL),
(151, 1, 'ABDUL SHAKUR', 'SWALEH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:10:03', NULL, NULL),
(152, 1, 'MULANGIRA', 'ABDL RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:11:04', NULL, NULL),
(153, 1, 'WANDERA', 'MUSTAPHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:12:37', NULL, NULL),
(154, 1, 'NABABENGA', 'HABIBAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:14:20', NULL, NULL),
(155, 1, 'ATWA-U', 'MWASE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:15:12', NULL, NULL),
(156, 1, 'WAWAYANGA', 'ABDUL HAIRI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:16:14', NULL, NULL),
(157, 1, 'KALEMA', 'FADHIL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:17:04', NULL, NULL),
(158, 1, 'MUYOMBA', 'ANWAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:18:59', NULL, NULL),
(159, 1, 'BALE', 'ABDL-SHAKUR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:20:23', NULL, NULL),
(160, 1, 'BYARUHANGA', 'NASIIB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:21:20', NULL, NULL),
(161, 1, 'MUBIRU', 'AZHAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:22:09', NULL, NULL),
(162, 1, 'LUQMAN', 'KAYONDO', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:22:54', NULL, NULL),
(163, 1, 'SSEMAKULA', 'SHUKRAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:23:41', NULL, NULL),
(164, 1, 'SSENOGA', 'MAHAWISH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:24:37', NULL, NULL),
(165, 1, 'WALUGEMBE', 'HAITHAM ABDUL KARIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:25:58', NULL, NULL),
(166, 1, 'SHADIAH', 'BINTI ZAIDI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:26:56', NULL, NULL),
(167, 1, 'KALUNGI', 'UKASHA UMAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:27:50', NULL, NULL),
(168, 1, 'ASIMWE', 'RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:28:51', NULL, NULL),
(169, 1, 'HASSAN', 'QASSIMJ WASSWA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:29:49', NULL, NULL),
(170, 1, 'SSEKADU', 'HAMAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:30:40', NULL, NULL),
(171, 1, 'BUKENYA', 'ABDUL GHAFAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:32:55', NULL, NULL),
(172, 1, 'LUKWAGO', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:33:53', NULL, NULL),
(173, 1, 'KANAKULYA', 'RAJAB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:34:44', NULL, NULL),
(174, 1, 'NAIGAGA', 'HAJARA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:35:24', NULL, NULL),
(175, 1, 'LWANGA', 'UKASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:36:13', NULL, NULL),
(176, 1, 'TAUFIC', 'LUKOMWA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:37:20', NULL, NULL),
(177, 1, 'ABDUL AZIZI', 'SAIF LA WAYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:38:41', NULL, NULL),
(178, 1, 'NANGOBI', 'SUMMAYAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:39:39', NULL, NULL),
(179, 1, 'WASOKO', 'EDRISA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:40:36', NULL, NULL),
(180, 1, 'HAMIDAH', 'QASSIM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:41:40', NULL, NULL),
(181, 1, 'ABDUL AZIZ', 'MUYIIMA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:42:29', NULL, NULL),
(182, 1, 'UMAR', 'MUSA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:43:10', NULL, NULL),
(183, 1, 'THURAYYA', 'MBAZIIRA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:44:09', NULL, NULL),
(184, 1, 'RAYAN', 'KAGABA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:44:45', NULL, NULL),
(185, 1, 'MUBIRU', 'MUSTAFA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:48:43', NULL, NULL),
(186, 1, 'MISBAHU', 'ASHIRAF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:49:26', NULL, NULL),
(187, 1, 'ABDUL NASWIR MUHAMMAD', 'NGOBI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:50:19', NULL, NULL),
(188, 1, 'ABDUL MALIK', 'MUHAMMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:51:29', NULL, NULL),
(189, 1, 'FADHIL', 'HUZAIFAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:52:12', NULL, NULL),
(190, 1, 'FADHIL', 'HUBAIBU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:52:54', NULL, NULL),
(191, 1, 'FADHIL', 'UWAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:53:41', NULL, NULL),
(192, 1, 'ABDURAHMAN HASSAN', 'WASSWA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:54:47', NULL, NULL),
(193, 1, 'KANYIKE', 'MUHAMMAD YASIN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:55:38', NULL, NULL),
(194, 1, 'NAKATE', 'AFUWA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:56:25', NULL, NULL),
(195, 1, 'ZAITUNI', 'NAISAMULA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:58:37', NULL, NULL),
(196, 1, 'MUYOMBA', 'UMAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:59:24', NULL, NULL),
(197, 1, 'KAWOOYA', 'UMAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:00:15', NULL, NULL),
(198, 1, 'ABDUL RAHMAN SHURAIM', 'WAFULA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:01:05', NULL, NULL),
(199, 1, 'KAZIBWE', 'ISMAEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:01:45', NULL, NULL),
(200, 1, 'BASHIRA', 'ABDUL KARIM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:02:32', NULL, NULL),
(201, 1, 'IQLAS MOHAMED', 'MUHAMMUD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:03:46', NULL, NULL),
(202, 1, 'IDRIS', 'MOHAMED MUHAMMUD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:04:33', NULL, NULL),
(203, 1, 'HIBATULLAH', 'ABAS', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:05:35', NULL, NULL),
(204, 1, 'HAIRAT', 'NASSUNA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:06:19', NULL, NULL),
(205, 1, 'NSIMBI', 'NAJIB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:06:54', NULL, NULL),
(206, 1, 'TIMUNTU', 'ABDUL-RAZAK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:07:37', NULL, NULL),
(207, 1, 'ABDUL-AZIZI', 'ZIZINGA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:08:47', NULL, NULL),
(208, 1, 'WILDAN', 'TWAIB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:09:31', NULL, NULL),
(209, 1, 'MUGUNDA', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:10:10', NULL, NULL),
(210, 1, 'HASNAT', 'UTHUMAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:11:10', NULL, NULL),
(211, 1, 'SHAKIB', 'MUGANGA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:11:58', NULL, NULL),
(212, 1, 'MUSOBYA', 'SHAFICK ABUABAKR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:13:02', NULL, NULL),
(213, 1, 'NAKANTU', 'HAFIDHWA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:13:53', NULL, NULL),
(214, 1, 'NAKANTU', 'HUNAISA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:14:37', NULL, NULL),
(215, 1, 'JAMILA', 'JUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:15:50', NULL, NULL),
(216, 1, 'RAHMA', 'FADHIL', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:16:38', NULL, NULL),
(217, 1, 'KIIRA', 'MUHAAMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:17:22', NULL, NULL),
(218, 1, 'AAYAT', 'UTHMAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:18:03', NULL, NULL),
(219, 1, 'QAYIM', 'UTHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:18:50', NULL, NULL),
(220, 1, 'ZAMZAM', 'NAKALEMBE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:19:37', NULL, NULL),
(221, 1, 'BASHIR', 'ABDUL HAFIDHU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:20:29', NULL, NULL),
(222, 1, 'ABDUL RAHMAN', 'DAMUZUNGU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:19:57', NULL, NULL),
(223, 1, 'MUKISA', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:21:02', NULL, NULL),
(224, 1, 'RAHIYYAH', 'ZAID', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:22:33', NULL, NULL),
(225, 1, 'SULTAN', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:23:25', NULL, NULL),
(226, 1, 'NAMWENA', 'RAHMA NAMYALO', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:17:55', NULL, NULL),
(227, 1, 'MPAULO', 'SWALIC', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:18:42', NULL, NULL),
(228, 1, 'ERIASI', 'KAWUKA SUDAISI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:19:37', NULL, NULL),
(229, 1, 'KYOTAITE', 'RAJAB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:20:23', NULL, NULL),
(230, 1, 'UTHUMAN', 'RAJAB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:21:05', NULL, NULL),
(231, 1, 'USAM', 'FARID', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:21:44', NULL, NULL),
(232, 1, 'ZIRABA', 'JUMA GASEMBA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:22:32', NULL, NULL),
(233, 1, 'SEBACHWA', 'SHARIF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:23:23', NULL, NULL),
(234, 1, 'KAGOYA', 'SHUKRAN ALI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:24:16', NULL, NULL),
(235, 1, 'BIDI', 'HADIJJAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:24:58', NULL, NULL),
(236, 1, 'NTALO', 'JAWUHALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:25:42', NULL, NULL),
(237, 1, 'ARIAN', 'MUHAMOOD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:26:19', NULL, NULL),
(238, 1, 'SSERUGOJI', 'MUHAMMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:27:35', NULL, NULL),
(239, 1, 'NAKIYINJI', 'RAHUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:28:17', NULL, NULL),
(240, 1, 'NAIGAGA', 'BUSHIRA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:29:06', NULL, NULL),
(241, 1, 'NAMUYANGU', 'SHUKRUT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:29:53', NULL, NULL),
(242, 1, 'KAMPI', 'ANISHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:30:30', NULL, NULL),
(243, 1, 'NAMUSUSWA', 'RASHIMAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:31:31', NULL, NULL),
(244, 1, 'KALEMBE', 'NUSULA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:35:26', NULL, NULL),
(245, 1, 'NAMATENDE', 'SHATURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:17:55', NULL, NULL),
(246, 1, 'MENYA', 'HASHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:18:49', NULL, NULL),
(247, 1, 'NAM', 'NOEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:19:41', NULL, NULL),
(248, 1, 'KAKAIRE', 'BUKARI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:20:26', NULL, NULL),
(249, 1, 'NAIGAGA', 'SHUNURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:21:23', NULL, NULL),
(250, 1, 'MUKUBYA', 'HISHAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:22:12', NULL, NULL),
(251, 1, 'JIBRIL', 'HILAL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:23:03', NULL, NULL),
(252, 1, 'AZEDI .A.', 'GANIYU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:24:27', NULL, NULL),
(253, 1, 'KISIGE', 'SHADI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:26:07', NULL, NULL),
(254, 1, 'NTUUYO', 'HANIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:26:56', NULL, NULL),
(255, 1, 'NAMPEERA', 'WALDA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:27:53', NULL, NULL),
(256, 1, 'SHAFIE', 'SIRAJ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:28:38', NULL, NULL),
(257, 1, 'MUGOOWA', 'TAHIA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:29:23', NULL, NULL),
(258, 1, 'NDADA', 'MUHAMMAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:30:16', NULL, NULL),
(259, 1, 'NAMWASE', 'SHUKRUT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:31:08', NULL, NULL),
(260, 1, 'KANTONO', 'MARIAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:31:49', NULL, NULL),
(261, 1, 'AKIMA BWANA', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:32:31', NULL, NULL),
(262, 1, 'ISIKO', 'DAUDA HYTHAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:33:35', NULL, NULL),
(263, 1, 'SIRAJ', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:34:24', NULL, NULL),
(264, 1, 'NAKATO', 'SHIFRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:35:04', NULL, NULL),
(265, 1, 'SARAH MUHAMMAD', 'NAMWAMI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:36:01', NULL, NULL),
(266, 1, 'NAQIYYU', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:36:43', NULL, NULL),
(267, 1, 'NGOBI', 'SHAMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:37:21', NULL, NULL),
(268, 1, 'BABIRYE', 'HAIRAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:38:00', NULL, NULL),
(269, 1, 'BASEKE', 'ABDUL-MAJID', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:38:45', NULL, NULL),
(270, 1, 'MUHAMMAD', 'SHARIF MPINDI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:39:43', NULL, NULL),
(271, 1, 'BUTHAINA', 'BASEF', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:40:25', NULL, NULL),
(272, 1, 'BIYINZIKA', 'PIOUS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:41:11', NULL, NULL),
(273, 1, 'ZZIWA', 'RABIBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:42:42', NULL, NULL),
(274, 1, 'KASADHA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:44:44', NULL, NULL),
(275, 1, 'KAGUBIRU', 'ABDUL WARITH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:45:26', NULL, NULL),
(276, 1, 'WANDERA', 'ABDUL RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:46:10', NULL, NULL),
(277, 1, 'MENYA', 'ISMA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:46:51', NULL, NULL),
(278, 1, 'NANYANZI', 'LAILA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:47:34', NULL, NULL),
(279, 1, 'ABDUL', 'BAAR ISA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:48:14', NULL, NULL),
(280, 1, 'SEWANYANA', 'ABDUL RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:49:01', NULL, NULL),
(281, 1, 'KIZZA', 'SWALEH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:49:42', NULL, NULL),
(282, 1, 'TAQIYUDIN', 'HASSAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:50:25', NULL, NULL),
(283, 1, 'NABAGALA', 'SHARIFAH ABUBAR', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:51:27', NULL, NULL),
(284, 1, 'NASEJJE', 'SWALIHAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:52:38', NULL, NULL),
(285, 1, 'MUWAYI', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:53:30', NULL, NULL),
(286, 1, 'APOLOTI', 'BARIAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:54:15', NULL, NULL),
(287, 1, 'WAIGONGOLO', 'UTHUMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:55:17', NULL, NULL),
(288, 1, 'ASHURAH', 'FAHIMU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:56:04', NULL, NULL),
(289, 1, 'ABDUL-QAWIYU', 'WAKO', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:56:48', NULL, NULL),
(290, 1, 'NURIAT', 'NANSAMBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:57:49', NULL, NULL),
(291, 1, 'ABDALLAH', 'HABIBI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:58:44', NULL, NULL),
(292, 1, 'NAKAGOLO', 'SHTURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:59:36', NULL, NULL),
(293, 1, 'KIWANUKA', 'IBRAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:00:23', NULL, NULL),
(294, 1, 'NABUKERA', 'RAUF', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:01:07', NULL, NULL),
(295, 1, 'WASWA', 'AQAMAL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:01:50', NULL, NULL),
(296, 1, 'SENGOYE', 'KATO', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:02:28', NULL, NULL),
(297, 1, 'MUSENZE', 'HANANI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:03:09', NULL, NULL),
(298, 1, 'WAFULA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:04:08', NULL, NULL),
(299, 1, 'NALUBEGA', 'ATIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:05:01', NULL, NULL),
(300, 1, 'MANGOOLE', 'HATIMU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:05:47', NULL, NULL),
(301, 1, 'OTHIENO', 'JOHNSTEVEN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:06:44', NULL, NULL),
(302, 1, 'KATIIKI', 'RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:07:21', NULL, NULL),
(303, 1, 'OBO', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:21:28', NULL, NULL),
(304, 1, 'ABDUL-SHAKUR', 'MALINZI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:23:01', NULL, NULL),
(305, 1, 'DAKHABA', 'BURUHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:24:15', NULL, NULL),
(306, 1, 'BALELE', 'ABDUL-MAJID', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:25:04', NULL, NULL),
(307, 1, 'MUWAYA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:26:09', NULL, NULL),
(308, 1, 'MUGEYA', 'HASHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:27:06', NULL, NULL),
(309, 1, 'MUTYABA', 'AWATH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:27:55', NULL, NULL),
(310, 1, 'OTUMA', 'JANAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:28:47', NULL, NULL),
(311, 1, 'ZIYAD', 'KASAKYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:30:54', NULL, NULL),
(312, 1, 'MUTAGOBWA', 'AHMED JUMA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:31:47', NULL, NULL),
(313, 1, 'HUNAISA', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:32:33', NULL, NULL),
(314, 1, 'MULINYA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:33:35', NULL, NULL),
(315, 1, 'KISIGE', 'SHURAIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:34:19', NULL, NULL),
(316, 1, 'GAALI', 'ARAFAT', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:35:10', NULL, NULL),
(317, 1, 'NANGOBI', 'ALIYAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:36:01', NULL, NULL),
(318, 1, 'KALUNGI', 'RAYD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:38:35', NULL, NULL),
(319, 1, 'MUGOWA', 'FAHAD', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:39:57', NULL, NULL),
(320, 1, 'HUSINA', 'MINSHAWI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:41:02', NULL, NULL),
(321, 1, 'NAMULEME', 'THUWAIBAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:42:07', NULL, NULL),
(322, 1, 'SSENYONJO', 'TAUFIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:43:19', NULL, NULL),
(323, 1, 'SHARIFA', 'ABDUL-HAMIDU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:44:29', NULL, NULL),
(324, 1, 'KASADHA', 'YASIN YAKUB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:45:56', NULL, NULL),
(325, 1, 'NAMAGANDA', 'FITRA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:47:09', NULL, NULL),
(326, 1, 'NAMBI', 'HAWA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:48:05', NULL, NULL),
(327, 1, 'ABDUL-KARIM', 'ABDALLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:49:00', NULL, NULL),
(328, 1, 'NABANDA', 'HADIJJAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:50:00', NULL, NULL),
(329, 1, 'MAGUMBA', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:50:50', NULL, NULL),
(330, 1, 'KYOLABA', 'FATUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:51:30', NULL, NULL),
(331, 1, 'KANSIIME', 'YASMINE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:53:00', NULL, NULL),
(332, 1, 'MUNURO', 'SHABAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:53:39', NULL, NULL),
(333, 1, 'KATERAGA', 'MUGAGA ISMAEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:54:43', NULL, NULL),
(334, 1, 'MUKISA', 'ABDUL-RAZAK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:55:29', NULL, NULL),
(335, 1, 'OLANYA', 'HAMZA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:56:16', NULL, NULL),
(336, 1, 'NAMATENDE', 'AISHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:57:56', NULL, NULL),
(337, 1, 'AMIRAH', 'HUSSNAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:59:00', NULL, NULL),
(338, 1, 'MUTESI', 'RASHMAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:59:57', NULL, NULL),
(339, 1, 'NANGOBI', 'FARIHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:02:10', NULL, NULL),
(340, 1, 'KATENDE', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:03:08', NULL, NULL),
(341, 1, 'WAISWA', 'HASSAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:04:37', NULL, NULL),
(342, 1, 'KATO', 'HUSSEIN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:05:51', NULL, NULL),
(343, 1, 'KINTU', 'MEDI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:06:48', NULL, NULL),
(344, 1, 'KAKAIRE', 'UKASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:07:59', NULL, NULL),
(345, 1, 'AHMED', 'MUDATHIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:09:34', NULL, NULL),
(346, 1, 'MUTUBA', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:10:30', NULL, NULL),
(347, 1, 'KONERA', 'HUSNAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:11:30', NULL, NULL),
(348, 1, 'KISUYI', 'HUZAIRU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:12:37', NULL, NULL),
(349, 1, 'YAHAYA', 'MUCHAINA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:20:40', NULL, NULL),
(350, 1, 'MPAULO', 'SHABAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:21:34', NULL, NULL),
(351, 1, 'SEBUGANDA', 'SHURAIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:22:43', NULL, NULL),
(352, 1, 'HANIHP', 'QURAISH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:23:45', NULL, NULL),
(353, 1, 'MUSASIZI', 'AQIEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:24:59', NULL, NULL),
(354, 1, 'ASIMA', 'FATIHA  FARID', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:26:11', NULL, NULL),
(355, 1, 'KAKOOZA', 'HUZAIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:27:06', NULL, NULL),
(356, 1, 'GASEMBA', 'AZED', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:27:55', NULL, NULL),
(357, 1, 'NAKISUYI  FAHMAT', 'FAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:29:03', NULL, NULL),
(358, 1, 'ANISHA', 'MUTESI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:30:03', NULL, NULL),
(359, 1, 'BAMULANZEKI', 'SALIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:30:59', NULL, NULL),
(360, 1, 'RAHMA', 'NAKAGOLO', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:31:51', NULL, NULL),
(361, 1, 'WANGUBO', 'RAYAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:32:47', NULL, NULL),
(362, 1, 'NAMPALA', 'RAHMA  MINJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:34:06', NULL, NULL),
(363, 1, 'NAMUWAYA', 'RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:34:58', NULL, NULL),
(364, 1, 'NALUWAGULU', 'NOOR', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:35:59', NULL, NULL),
(365, 1, 'SOOMA', 'ASHIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:36:59', NULL, NULL),
(366, 1, 'NANJIRA', 'AYAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:38:15', NULL, NULL),
(367, 1, 'TIBAGA', 'NUSUFA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:39:32', NULL, NULL),
(368, 1, 'NAMPALA', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:41:17', NULL, NULL),
(369, 1, 'KYEYUNE', 'HALIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:46:21', NULL, NULL),
(370, 1, 'KIGUNDU', 'SHAFIK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:47:32', NULL, NULL),
(371, 1, 'BINT YUSUF', 'ASHJIBA  NANTABO', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:48:37', NULL, NULL),
(372, 1, 'NASSALI', 'FARIHYA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:50:10', NULL, NULL),
(373, 1, 'ABUBAKALI', 'SWIDIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:51:37', NULL, NULL),
(374, 1, 'MUSTAFA', 'PAVEZ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:52:21', NULL, NULL),
(375, 1, 'SUDAIS', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:53:09', NULL, NULL),
(376, 1, 'BAMULANZEKI', 'RAMADHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:54:10', NULL, NULL),
(377, 1, 'ASIIMWE', 'FAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:54:49', NULL, NULL),
(378, 1, 'NAKIBINGE', 'IBRA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:55:59', NULL, NULL),
(379, 1, 'UTHMAN', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:56:50', NULL, NULL),
(380, 1, 'BIKADHO', 'ADAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:58:32', NULL, NULL),
(381, 1, 'MWASE', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:59:21', NULL, NULL),
(382, 1, 'MONDO', 'HASSAN  RAHUL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:00:17', NULL, NULL),
(383, 1, 'MUHSIN', 'ABDUL-KARIM  NSAMBA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:01:37', NULL, NULL),
(384, 1, 'ASHAR', 'NAKIMULI', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:02:33', NULL, NULL),
(385, 1, 'NAMAGANDA', 'RAUDHAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:03:27', NULL, NULL),
(386, 1, 'WAIRA', 'MUSWABU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:04:22', NULL, NULL),
(387, 1, 'EMETAYI', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:06:56', NULL, NULL),
(388, 1, 'BAKAKI', 'SWABAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:07:43', NULL, NULL),
(389, 1, 'GOOBI', 'ABASI  HANAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:08:43', NULL, NULL),
(390, 1, 'NAMULONDO', 'ZAINAB  RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:09:31', NULL, NULL),
(391, 1, 'HASSANAT', 'KANSIIME', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:10:13', NULL, NULL),
(392, 1, 'MATENDE', 'ABDUL-RAUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:11:28', NULL, NULL),
(393, 1, 'BUKENYA', 'HASSAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:13:16', NULL, NULL),
(394, 1, 'MUHAMMAD', 'ISA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:17:35', NULL, NULL),
(395, 1, 'MUDATHIR', 'IBRAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:18:21', NULL, NULL),
(396, 1, 'KAKAIRE', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:19:18', NULL, NULL),
(397, 1, 'BALELE', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:20:32', NULL, NULL),
(398, 1, 'MUNOBWA', 'ABDUL-SWABAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:21:31', NULL, NULL),
(399, 1, 'MULONDO', 'ISHAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:22:23', NULL, NULL),
(400, 1, 'SULAIMAN', 'SAIF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:23:11', NULL, NULL),
(401, 1, 'BABIRYE', 'HABIBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:24:17', NULL, NULL),
(402, 1, 'NAKIYEMBA', 'SHIFRA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:25:07', NULL, NULL),
(403, 1, 'WAVAMUNO', 'ATWIB', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:26:07', NULL, NULL),
(404, 1, 'NAMUSUUBO', 'SHAHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:27:53', NULL, NULL),
(405, 1, 'TIBWABYA', 'RASHIDAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:29:06', NULL, NULL),
(406, 1, 'LUWANGULA', 'JUMA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:32:03', NULL, NULL),
(407, 1, 'NABIRYO', 'FAQIHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:33:08', NULL, NULL),
(408, 1, 'NAMPALA', 'SHURYM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:34:01', NULL, NULL),
(409, 1, 'WALUSANSA', 'ISA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:34:49', NULL, NULL),
(410, 1, 'MUSIS', 'RAMISH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:35:36', NULL, NULL),
(411, 1, 'HINDU', 'ABDULLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:36:20', NULL, NULL),
(412, 1, 'ZAINAB', 'ABDULLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:38:18', NULL, NULL),
(413, 1, 'MUKOSE', 'AHMED', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:40:34', NULL, NULL),
(414, 1, 'KYONJO', 'MUSA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:41:41', NULL, NULL),
(415, 1, 'KIYIMBA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:42:29', NULL, NULL),
(416, 1, 'KULUTUBI', 'GAMUSI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:43:37', NULL, NULL),
(417, 1, 'NAKIDOODO', 'SULTANA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:44:52', NULL, NULL),
(418, 1, 'SADALA', 'ISA  GASEMBA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:45:56', NULL, NULL),
(419, 1, 'DIDI', 'HUSSEIN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:46:58', NULL, NULL),
(420, 1, 'NOWAL', 'ABDULLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:47:47', NULL, NULL),
(421, 1, 'NANDEGHO', 'RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:48:39', NULL, NULL),
(422, 1, 'KIBUYE', 'ABUTHAARI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:49:40', NULL, NULL),
(423, 1, 'SIKYAGATEMA', 'KAUTHARA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:50:37', NULL, NULL),
(424, 1, 'ISMAEL', 'AZED', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:51:23', NULL, NULL),
(425, 1, 'HAMISI', 'MUGOYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:52:13', NULL, NULL),
(426, 1, 'MUGOYA', 'ABDULLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:53:04', NULL, NULL),
(427, 1, 'TAGEJJA', 'TAKIYYU', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:54:07', NULL, NULL),
(428, 1, 'SEMAKULU', 'RAJASHI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:55:04', NULL, NULL),
(429, 1, 'SSENYOGA', 'ABDALLAH  RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:56:06', NULL, NULL),
(430, 1, 'KISUYI', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:56:55', NULL, NULL),
(431, 1, 'SSENOGA', 'MUNFIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:58:07', NULL, NULL),
(432, 1, 'BIWEMBA', 'RAJAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:59:07', NULL, NULL),
(433, 1, 'JALIRUDEEN', 'ASIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:00:05', NULL, NULL),
(434, 1, 'RAUDHAH', 'ZZIWA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:00:47', NULL, NULL),
(435, 1, 'IHLAM', 'ISMAEL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:01:44', NULL, NULL),
(436, 1, 'NAMATA', 'MUNTAHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:02:39', NULL, NULL),
(437, 1, 'NAKIMBUGWE', 'HANIFA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:03:39', NULL, NULL),
(438, 1, 'NAMBOGWE', 'AISHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:04:42', NULL, NULL),
(439, 1, 'MWOGEZA', 'ASHRAF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:05:29', NULL, NULL),
(440, 1, 'MASTULA', 'MARIAM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:06:25', NULL, NULL),
(441, 1, 'AMASE', 'NUSFAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:07:18', NULL, NULL),
(442, 1, 'MAGEZI', 'SHAFIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:08:07', NULL, NULL),
(443, 1, 'NATABI', 'RAHMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:08:58', NULL, NULL),
(444, 1, 'NAKINYANZI', 'MARIAM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:10:04', NULL, NULL),
(445, 1, 'MATSAD', 'HAITHAM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:11:12', NULL, NULL),
(446, 1, 'NGOOBI', 'HAARITH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:11:58', NULL, NULL),
(447, 1, 'MUSINGO', 'FIRDAUS', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:12:46', NULL, NULL),
(448, 1, 'UKASHA', 'RAMADHAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:13:29', NULL, NULL),
(449, 1, 'KAMBA', 'NASSER  DUMBA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:14:25', NULL, NULL),
(450, 1, 'KHAIRAT', 'ABDALLAH  NANKISA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:15:14', NULL, NULL),
(451, 1, 'NABILYE', 'ZAINAB', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:15:59', NULL, NULL),
(452, 1, 'ZULFA', 'ABDALLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:16:50', NULL, NULL),
(453, 1, 'MUKISA', 'RASHID', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:17:39', NULL, NULL),
(454, 1, 'KIZITO', 'UKASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:18:25', NULL, NULL),
(458, NULL, 'NAMWASE', 'SWALIHAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:24:52', NULL, NULL),
(459, NULL, 'NAMWASE', 'SWALIHAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:25:35', NULL, NULL),
(460, NULL, 'HASSAN', 'ABDALLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:42:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) NOT NULL,
  `code` varchar(120) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_cards`
--

CREATE TABLE `report_cards` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `overall_grade` varchar(10) DEFAULT NULL,
  `class_teacher_comment` text DEFAULT NULL,
  `headteacher_comment` text DEFAULT NULL,
  `dos_comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_card_metrics`
--

CREATE TABLE `report_card_metrics` (
  `report_card_id` bigint(20) NOT NULL,
  `total_score` decimal(7,2) DEFAULT NULL,
  `average_score` decimal(5,2) DEFAULT NULL,
  `min_score` decimal(5,2) DEFAULT NULL,
  `max_score` decimal(5,2) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `promoted` tinyint(1) DEFAULT 0,
  `promotion_class_id` bigint(20) DEFAULT NULL,
  `computed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report_card_subjects`
--

CREATE TABLE `report_card_subjects` (
  `id` bigint(20) NOT NULL,
  `report_card_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `total_score` decimal(5,2) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `position` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requirements_master`
--

CREATE TABLE `requirements_master` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` bigint(20) NOT NULL,
  `exam_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `score` decimal(5,2) DEFAULT NULL,
  `grade` varchar(5) DEFAULT NULL,
  `remarks` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `result_types`
--

CREATE TABLE `result_types` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `code` varchar(60) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(80) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salary_payments`
--

CREATE TABLE `salary_payments` (
  `id` bigint(20) NOT NULL,
  `staff_id` bigint(20) NOT NULL,
  `wallet_id` bigint(20) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `method` varchar(30) DEFAULT NULL,
  `reference` varchar(120) DEFAULT NULL,
  `ledger_id` bigint(20) DEFAULT NULL,
  `paid_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE `schools` (
  `id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `legal_name` varchar(200) DEFAULT NULL,
  `short_code` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `currency` varchar(10) DEFAULT 'UGX',
  `address` text DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `school_settings`
--

CREATE TABLE `school_settings` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `key_name` varchar(120) NOT NULL,
  `value_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `staff_no` varchar(50) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_attendance`
--

CREATE TABLE `staff_attendance` (
  `id` bigint(20) NOT NULL,
  `staff_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(20) DEFAULT 'present',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff_salaries`
--

CREATE TABLE `staff_salaries` (
  `id` bigint(20) NOT NULL,
  `staff_id` bigint(20) NOT NULL,
  `month` year(4) DEFAULT NULL,
  `period_month` tinyint(4) DEFAULT NULL,
  `definition_id` bigint(20) NOT NULL,
  `amount` decimal(14,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `streams`
--

CREATE TABLE `streams` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) DEFAULT NULL,
  `person_id` bigint(20) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `theology_class_id` int(11) DEFAULT NULL,
  `admission_no` varchar(50) DEFAULT NULL,
  `village_id` bigint(20) DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `school_id`, `person_id`, `class_id`, `theology_class_id`, `admission_no`, `village_id`, `admission_date`, `status`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, NULL, NULL, '2025/0001', NULL, '2025-08-18', 'active', NULL, '2025-08-18 07:43:48', NULL, NULL),
(2, 1, 2, NULL, NULL, '2025/0002', NULL, '2025-08-18', 'active', NULL, '2025-08-18 07:11:19', NULL, NULL),
(3, 1, 3, NULL, NULL, '2025/0003', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:47:12', NULL, NULL),
(4, 1, 4, NULL, NULL, '2025/0004', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:48:28', NULL, NULL),
(5, 1, 5, NULL, NULL, '2025/0005', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:58:21', NULL, NULL),
(6, 1, 6, NULL, NULL, '2025/0006', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:59:18', NULL, NULL),
(7, 1, 7, NULL, NULL, '2025/0007', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:00:15', NULL, NULL),
(8, 1, 8, NULL, NULL, '2025/0008', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:00:51', NULL, NULL),
(9, 1, 9, NULL, NULL, '2025/0009', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:02:19', NULL, NULL),
(10, 1, 10, NULL, NULL, '2025/0010', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:03:40', NULL, NULL),
(11, 1, 11, NULL, NULL, '2025/0011', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:04:22', NULL, NULL),
(12, 1, 12, NULL, NULL, '2025/0012', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:05:38', NULL, NULL),
(13, 1, 13, NULL, NULL, '2025/0013', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:06:20', NULL, NULL),
(14, 1, 14, NULL, NULL, '2025/0014', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:07:08', NULL, NULL),
(15, 1, 15, NULL, NULL, '2025/0015', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:07:52', NULL, NULL),
(16, 1, 16, NULL, NULL, '2025/0016', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:08:46', NULL, NULL),
(17, 1, 17, NULL, NULL, '2025/0017', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:09:54', NULL, NULL),
(18, 1, 18, NULL, NULL, '2025/0018', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:10:35', NULL, NULL),
(19, 1, 19, NULL, NULL, '2025/0019', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:11:25', NULL, NULL),
(20, 1, 20, NULL, NULL, '2025/0020', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:12:05', NULL, NULL),
(21, 1, 21, NULL, NULL, '2025/0021', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:13:04', NULL, NULL),
(22, 1, 22, NULL, NULL, '2025/0022', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:13:53', NULL, NULL),
(23, 1, 23, NULL, NULL, '2025/0023', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:14:37', NULL, NULL),
(24, 1, 24, NULL, NULL, '2025/0024', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:11', NULL, NULL),
(25, 1, 25, NULL, NULL, '2025/0025', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:52', NULL, NULL),
(26, 1, 26, NULL, NULL, '2025/0026', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:16:32', NULL, NULL),
(27, 1, 27, NULL, NULL, '2025/0027', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:17:21', NULL, NULL),
(28, 1, 28, NULL, NULL, '2025/0028', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:18:03', NULL, NULL),
(29, 1, 29, NULL, NULL, '2025/0029', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:18:41', NULL, NULL),
(30, 1, 30, NULL, NULL, '2025/0030', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:19:28', NULL, NULL),
(31, 1, 31, NULL, NULL, '2025/0031', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:20:36', NULL, NULL),
(32, 1, 32, NULL, NULL, '2025/0032', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:21:42', NULL, NULL),
(33, 1, 33, NULL, NULL, '2025/0033', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:22:27', NULL, NULL),
(34, 1, 34, NULL, NULL, '2025/0034', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:23:12', NULL, NULL),
(35, 1, 35, NULL, NULL, '2025/0035', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:24:45', NULL, NULL),
(36, 1, 36, NULL, NULL, '2025/0036', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:25:23', NULL, NULL),
(37, 1, 37, NULL, NULL, '2025/0037', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:26:03', NULL, NULL),
(38, 1, 38, NULL, NULL, '2025/0038', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:26:40', NULL, NULL),
(39, 1, 39, NULL, NULL, '2025/0039', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:27:34', NULL, NULL),
(40, 1, 40, NULL, NULL, '2025/0040', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:28:12', NULL, NULL),
(41, 1, 41, NULL, NULL, '2025/0041', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:28:57', NULL, NULL),
(42, 1, 42, NULL, NULL, '2025/0042', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:30:13', NULL, NULL),
(43, 1, 43, NULL, NULL, '2025/0043', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:31:47', NULL, NULL),
(44, 1, 44, NULL, NULL, '2025/0044', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:33:44', NULL, NULL),
(45, 1, 45, NULL, NULL, '2025/0045', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:34:44', NULL, NULL),
(46, 1, 46, NULL, NULL, '2025/0046', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:35:32', NULL, NULL),
(47, 1, 47, NULL, NULL, '2025/0047', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:40:22', NULL, NULL),
(48, 1, 48, NULL, NULL, '2025/0048', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:27:59', NULL, NULL),
(49, 1, 49, NULL, NULL, '2025/0049', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:28:56', NULL, NULL),
(50, 1, 50, NULL, NULL, '2025/0050', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:30:13', NULL, NULL),
(51, 1, 51, NULL, NULL, '2025/0051', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:31:44', NULL, NULL),
(52, 1, 52, NULL, NULL, '2025/0052', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:33:20', NULL, NULL),
(53, 1, 53, NULL, NULL, '2025/0053', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:34:14', NULL, NULL),
(54, 1, 54, NULL, NULL, '2025/0054', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:35:08', NULL, NULL),
(55, 1, 55, NULL, NULL, '2025/0055', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:36:15', NULL, NULL),
(56, 1, 56, NULL, NULL, '2025/0056', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:37:11', NULL, NULL),
(57, 1, 57, NULL, NULL, '2025/0057', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:26:51', NULL, NULL),
(58, 1, 58, NULL, NULL, '2025/0058', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:28:18', NULL, NULL),
(59, 1, 59, NULL, NULL, '2025/0059', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:29:02', NULL, NULL),
(60, 1, 60, NULL, NULL, '2025/0060', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:29:56', NULL, NULL),
(61, 1, 61, NULL, NULL, '2025/0061', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:30:45', NULL, NULL),
(62, 1, 62, NULL, NULL, '2025/0062', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:31:34', NULL, NULL),
(63, 1, 63, NULL, NULL, '2025/0063', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:32:11', NULL, NULL),
(64, 1, 64, NULL, NULL, '2025/0064', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:32:58', NULL, NULL),
(65, 1, 65, NULL, NULL, '2025/0065', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:33:58', NULL, NULL),
(66, 1, 66, NULL, NULL, '2025/0066', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:34:36', NULL, NULL),
(67, 1, 67, NULL, NULL, '2025/0067', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:36:31', NULL, NULL),
(68, 1, 68, NULL, NULL, '2025/0068', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:37:12', NULL, NULL),
(69, 1, 69, NULL, NULL, '2025/0069', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:37:47', NULL, NULL),
(70, 1, 70, NULL, NULL, '2025/0070', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:42:28', NULL, NULL),
(71, 1, 71, NULL, NULL, '2025/0071', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:43:05', NULL, NULL),
(72, 1, 72, NULL, NULL, '2025/0072', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:44:23', NULL, NULL),
(73, 1, 73, NULL, NULL, '2025/0073', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:45:53', NULL, NULL),
(74, 1, 74, NULL, NULL, '2025/0074', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:46:32', NULL, NULL),
(75, 1, 75, NULL, NULL, '2025/0075', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:47:11', NULL, NULL),
(76, 1, 76, NULL, NULL, '2025/0076', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:47:48', NULL, NULL),
(77, 1, 77, NULL, NULL, '2025/0077', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:48:38', NULL, NULL),
(78, 1, 78, NULL, NULL, '2025/0078', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:49:12', NULL, NULL),
(79, 1, 79, NULL, NULL, '2025/0079', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:49:53', NULL, NULL),
(80, 1, 80, NULL, NULL, '2025/0080', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:50:41', NULL, NULL),
(81, 1, 81, NULL, NULL, '2025/0081', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:51:26', NULL, NULL),
(82, 1, 82, NULL, NULL, '2025/0082', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:52:08', NULL, NULL),
(83, 1, 83, NULL, NULL, '2025/0083', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:53:39', NULL, NULL),
(84, 1, 84, NULL, NULL, '2025/0084', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:54:11', NULL, NULL),
(85, 1, 85, NULL, NULL, '2025/0085', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:54:59', NULL, NULL),
(86, 1, 86, NULL, NULL, '2025/0086', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:55:31', NULL, NULL),
(87, 1, 87, NULL, NULL, '2025/0087', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:56:11', NULL, NULL),
(88, 1, 88, NULL, NULL, '2025/0088', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:56:54', NULL, NULL),
(89, 1, 89, NULL, NULL, '2025/0089', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:58:00', NULL, NULL),
(90, 1, 90, NULL, NULL, '2025/0090', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:58:36', NULL, NULL),
(91, 1, 91, NULL, NULL, '2025/0091', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:59:22', NULL, NULL),
(92, 1, 92, NULL, NULL, '2025/0092', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:00:21', NULL, NULL),
(93, 1, 93, NULL, NULL, '2025/0093', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:02:20', NULL, NULL),
(94, 1, 94, NULL, NULL, '2025/0094', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:03:02', NULL, NULL),
(95, 1, 95, NULL, NULL, '2025/0095', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:03:49', NULL, NULL),
(96, 1, 96, NULL, NULL, '2025/0096', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:04:49', NULL, NULL),
(97, 1, 97, NULL, NULL, '2025/0097', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:05:36', NULL, NULL),
(98, 1, 98, NULL, NULL, '2025/0098', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:06:20', NULL, NULL),
(99, 1, 99, NULL, NULL, '2025/0099', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:07:19', NULL, NULL),
(100, 1, 100, NULL, NULL, '2025/0100', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:07:56', NULL, NULL),
(101, 1, 101, NULL, NULL, '2025/0101', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:09:11', NULL, NULL),
(102, 1, 102, NULL, NULL, '2025/0102', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:10:26', NULL, NULL),
(103, 1, 104, NULL, NULL, '2025/0103', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:11', NULL, NULL),
(104, 1, 105, NULL, NULL, '2025/0104', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:50', NULL, NULL),
(105, 1, 106, NULL, NULL, '2025/0105', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:16:26', NULL, NULL),
(106, 1, 107, NULL, NULL, '2025/0106', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:17:19', NULL, NULL),
(107, 1, 108, NULL, NULL, '2025/0107', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:18:20', NULL, NULL),
(108, 1, 109, NULL, NULL, '2025/0108', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:22:40', NULL, NULL),
(109, 1, 110, NULL, NULL, '2025/0109', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:24:13', NULL, NULL),
(110, 1, 111, NULL, NULL, '2025/0110', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:25:27', NULL, NULL),
(111, 1, 112, NULL, NULL, '2025/0111', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:26:19', NULL, NULL),
(112, 1, 113, NULL, NULL, '2025/0112', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:27:14', NULL, NULL),
(113, 1, 114, NULL, NULL, '2025/0113', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:28:01', NULL, NULL),
(114, 1, 115, NULL, NULL, '2025/0114', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:29:04', NULL, NULL),
(115, 1, 116, NULL, NULL, '2025/0115', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:30:04', NULL, NULL),
(116, 1, 117, NULL, NULL, '2025/0116', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:30:41', NULL, NULL),
(117, 1, 118, NULL, NULL, '2025/0117', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:31:35', NULL, NULL),
(118, 1, 119, NULL, NULL, '2025/0118', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:32:34', NULL, NULL),
(119, 1, 120, NULL, NULL, '2025/0119', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:33:27', NULL, NULL),
(120, 1, 121, NULL, NULL, '2025/0120', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:34:03', NULL, NULL),
(121, 1, 122, NULL, NULL, '2025/0121', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:34:39', NULL, NULL),
(122, 1, 123, NULL, NULL, '2025/0122', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:36:02', NULL, NULL),
(123, 1, 124, NULL, NULL, '2025/0123', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:36:44', NULL, NULL),
(124, 1, 125, NULL, NULL, '2025/0124', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:37:37', NULL, NULL),
(125, 1, 126, NULL, NULL, '2025/0125', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:38:55', NULL, NULL),
(126, 1, 127, NULL, NULL, '2025/0126', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:39:30', NULL, NULL),
(127, 1, 128, NULL, NULL, '2025/0127', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:42:23', NULL, NULL),
(128, 1, 129, NULL, NULL, '2025/0128', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:46:16', NULL, NULL),
(129, 1, 130, NULL, NULL, '2025/0129', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:47:38', NULL, NULL),
(130, 1, 131, NULL, NULL, '2025/0130', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:48:22', NULL, NULL),
(131, 1, 132, NULL, NULL, '2025/0131', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:49:08', NULL, NULL),
(132, 1, 133, NULL, NULL, '2025/0132', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:49:53', NULL, NULL),
(133, 1, 134, NULL, NULL, '2025/0133', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:50:40', NULL, NULL),
(134, 1, 135, NULL, NULL, '2025/0134', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:52:10', NULL, NULL),
(135, 1, 136, NULL, NULL, '2025/0135', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:53:02', NULL, NULL),
(136, 1, 137, NULL, NULL, '2025/0136', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:54:40', NULL, NULL),
(137, 1, 138, NULL, NULL, '2025/0137', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:55:58', NULL, NULL),
(138, 1, 139, NULL, NULL, '2025/0138', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:56:49', NULL, NULL),
(139, 1, 140, NULL, NULL, '2025/0139', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:58:47', NULL, NULL),
(140, 1, 141, NULL, NULL, '2025/0140', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:59:32', NULL, NULL),
(141, 1, 142, NULL, NULL, '2025/0141', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:00:24', NULL, NULL),
(142, 1, 143, NULL, NULL, '2025/0142', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:01:29', NULL, NULL),
(143, 1, 144, NULL, NULL, '2025/0143', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:02:18', NULL, NULL),
(144, 1, 145, NULL, NULL, '2025/0144', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:03:24', NULL, NULL),
(145, 1, 146, NULL, NULL, '2025/0145', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:04:24', NULL, NULL),
(146, 1, 147, NULL, NULL, '2025/0146', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:05:18', NULL, NULL),
(147, 1, 148, NULL, NULL, '2025/0147', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:06:56', NULL, NULL),
(148, 1, 149, NULL, NULL, '2025/0148', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:07:53', NULL, NULL),
(149, 1, 150, NULL, NULL, '2025/0149', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:09:10', NULL, NULL),
(150, 1, 151, NULL, NULL, '2025/0150', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:10:03', NULL, NULL),
(151, 1, 152, NULL, NULL, '2025/0151', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:11:04', NULL, NULL),
(152, 1, 153, NULL, NULL, '2025/0152', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:12:37', NULL, NULL),
(153, 1, 154, NULL, NULL, '2025/0153', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:14:20', NULL, NULL),
(154, 1, 155, NULL, NULL, '2025/0154', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:15:12', NULL, NULL),
(155, 1, 156, NULL, NULL, '2025/0155', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:16:14', NULL, NULL),
(156, 1, 157, NULL, NULL, '2025/0156', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:17:04', NULL, NULL),
(157, 1, 158, NULL, NULL, '2025/0157', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:18:59', NULL, NULL),
(158, 1, 159, NULL, NULL, '2025/0158', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:20:23', NULL, NULL),
(159, 1, 160, NULL, NULL, '2025/0159', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:21:20', NULL, NULL),
(160, 1, 161, NULL, NULL, '2025/0160', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:22:10', NULL, NULL),
(161, 1, 162, NULL, NULL, '2025/0161', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:22:54', NULL, NULL),
(162, 1, 163, NULL, NULL, '2025/0162', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:23:41', NULL, NULL),
(163, 1, 164, NULL, NULL, '2025/0163', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:24:37', NULL, NULL),
(164, 1, 165, NULL, NULL, '2025/0164', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:25:58', NULL, NULL),
(165, 1, 166, NULL, NULL, '2025/0165', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:26:56', NULL, NULL),
(166, 1, 167, NULL, NULL, '2025/0166', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:27:50', NULL, NULL),
(167, 1, 168, NULL, NULL, '2025/0167', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:28:51', NULL, NULL),
(168, 1, 169, NULL, NULL, '2025/0168', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:29:49', NULL, NULL),
(169, 1, 170, NULL, NULL, '2025/0169', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:30:41', NULL, NULL),
(170, 1, 171, NULL, NULL, '2025/0170', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:32:55', NULL, NULL),
(171, 1, 172, NULL, NULL, '2025/0171', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:33:53', NULL, NULL),
(172, 1, 173, NULL, NULL, '2025/0172', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:34:44', NULL, NULL),
(173, 1, 174, NULL, NULL, '2025/0173', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:35:24', NULL, NULL),
(174, 1, 175, NULL, NULL, '2025/0174', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:36:13', NULL, NULL),
(175, 1, 176, NULL, NULL, '2025/0175', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:37:20', NULL, NULL),
(176, 1, 177, NULL, NULL, '2025/0176', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:38:41', NULL, NULL),
(177, 1, 178, NULL, NULL, '2025/0177', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:39:39', NULL, NULL),
(178, 1, 179, NULL, NULL, '2025/0178', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:40:36', NULL, NULL),
(179, 1, 180, NULL, NULL, '2025/0179', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:41:40', NULL, NULL),
(180, 1, 181, NULL, NULL, '2025/0180', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:42:30', NULL, NULL),
(181, 1, 182, NULL, NULL, '2025/0181', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:43:10', NULL, NULL),
(182, 1, 183, NULL, NULL, '2025/0182', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:44:09', NULL, NULL),
(183, 1, 184, NULL, NULL, '2025/0183', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:44:45', NULL, NULL),
(184, 1, 185, NULL, NULL, '2025/0184', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:48:43', NULL, NULL),
(185, 1, 186, NULL, NULL, '2025/0185', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:49:26', NULL, NULL),
(186, 1, 187, NULL, NULL, '2025/0186', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:50:19', NULL, NULL),
(187, 1, 188, NULL, NULL, '2025/0187', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:51:29', NULL, NULL),
(188, 1, 189, NULL, NULL, '2025/0188', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:52:12', NULL, NULL),
(189, 1, 190, NULL, NULL, '2025/0189', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:52:54', NULL, NULL),
(190, 1, 191, NULL, NULL, '2025/0190', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:53:41', NULL, NULL),
(191, 1, 192, NULL, NULL, '2025/0191', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:54:47', NULL, NULL),
(192, 1, 193, NULL, NULL, '2025/0192', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:55:38', NULL, NULL),
(193, 1, 194, NULL, NULL, '2025/0193', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:56:25', NULL, NULL),
(194, 1, 195, NULL, NULL, '2025/0194', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:58:37', NULL, NULL),
(195, 1, 196, NULL, NULL, '2025/0195', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:59:24', NULL, NULL),
(196, 1, 197, NULL, NULL, '2025/0196', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:00:15', NULL, NULL),
(197, 1, 198, NULL, NULL, '2025/0197', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:01:05', NULL, NULL),
(198, 1, 199, NULL, NULL, '2025/0198', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:01:45', NULL, NULL),
(199, 1, 200, NULL, NULL, '2025/0199', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:02:32', NULL, NULL),
(200, 1, 201, NULL, NULL, '2025/0200', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:03:46', NULL, NULL),
(201, 1, 202, NULL, NULL, '2025/0201', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:04:33', NULL, NULL),
(202, 1, 203, NULL, NULL, '2025/0202', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:05:35', NULL, NULL),
(203, 1, 204, NULL, NULL, '2025/0203', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:06:19', NULL, NULL),
(204, 1, 205, NULL, NULL, '2025/0204', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:06:54', NULL, NULL),
(205, 1, 206, NULL, NULL, '2025/0205', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:07:37', NULL, NULL),
(206, 1, 207, NULL, NULL, '2025/0206', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:08:47', NULL, NULL),
(207, 1, 208, NULL, NULL, '2025/0207', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:09:31', NULL, NULL),
(208, 1, 209, NULL, NULL, '2025/0208', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:10:10', NULL, NULL),
(209, 1, 210, NULL, NULL, '2025/0209', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:11:10', NULL, NULL),
(210, 1, 211, NULL, NULL, '2025/0210', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:11:58', NULL, NULL),
(211, 1, 212, NULL, NULL, '2025/0211', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:13:02', NULL, NULL),
(212, 1, 213, NULL, NULL, '2025/0212', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:13:53', NULL, NULL),
(213, 1, 214, NULL, NULL, '2025/0213', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:14:37', NULL, NULL),
(214, 1, 215, NULL, NULL, '2025/0214', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:15:50', NULL, NULL),
(215, 1, 216, NULL, NULL, '2025/0215', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:16:38', NULL, NULL),
(216, 1, 217, NULL, NULL, '2025/0216', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:17:22', NULL, NULL),
(217, 1, 218, NULL, NULL, '2025/0217', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:18:04', NULL, NULL),
(218, 1, 219, NULL, NULL, '2025/0218', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:18:50', NULL, NULL),
(219, 1, 220, NULL, NULL, '2025/0219', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:19:37', NULL, NULL),
(220, 1, 221, NULL, NULL, '2025/0220', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:20:29', NULL, NULL),
(221, 1, 222, NULL, NULL, '2025/0221', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:57', NULL, NULL),
(222, 1, 223, NULL, NULL, '2025/0222', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:02', NULL, NULL),
(223, 1, 224, NULL, NULL, '2025/0223', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:33', NULL, NULL),
(224, 1, 225, NULL, NULL, '2025/0224', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:25', NULL, NULL),
(225, 1, 226, NULL, NULL, '2025/0225', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:17:55', NULL, NULL),
(226, 1, 227, NULL, NULL, '2025/0226', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:18:42', NULL, NULL),
(227, 1, 228, NULL, NULL, '2025/0227', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:37', NULL, NULL),
(228, 1, 229, NULL, NULL, '2025/0228', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:20:23', NULL, NULL),
(229, 1, 230, NULL, NULL, '2025/0229', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:05', NULL, NULL),
(230, 1, 231, NULL, NULL, '2025/0230', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:44', NULL, NULL),
(231, 1, 232, NULL, NULL, '2025/0231', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:32', NULL, NULL),
(232, 1, 233, NULL, NULL, '2025/0232', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:23', NULL, NULL),
(233, 1, 234, NULL, NULL, '2025/0233', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:16', NULL, NULL),
(234, 1, 235, NULL, NULL, '2025/0234', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:58', NULL, NULL),
(235, 1, 236, NULL, NULL, '2025/0235', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:25:42', NULL, NULL),
(236, 1, 237, NULL, NULL, '2025/0236', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:19', NULL, NULL),
(237, 1, 238, NULL, NULL, '2025/0237', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:27:35', NULL, NULL),
(238, 1, 239, NULL, NULL, '2025/0238', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:28:17', NULL, NULL),
(239, 1, 240, NULL, NULL, '2025/0239', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:06', NULL, NULL),
(240, 1, 241, NULL, NULL, '2025/0240', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:53', NULL, NULL),
(241, 1, 242, NULL, NULL, '2025/0241', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:30:30', NULL, NULL),
(242, 1, 243, NULL, NULL, '2025/0242', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:31', NULL, NULL),
(243, 1, 244, NULL, NULL, '2025/0243', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:35:26', NULL, NULL),
(244, 1, 245, NULL, NULL, '2025/0244', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:17:55', NULL, NULL),
(245, 1, 246, NULL, NULL, '2025/0245', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:18:49', NULL, NULL),
(246, 1, 247, NULL, NULL, '2025/0246', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:41', NULL, NULL),
(247, 1, 248, NULL, NULL, '2025/0247', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:20:26', NULL, NULL),
(248, 1, 249, NULL, NULL, '2025/0248', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:23', NULL, NULL),
(249, 1, 250, NULL, NULL, '2025/0249', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:12', NULL, NULL),
(250, 1, 251, NULL, NULL, '2025/0250', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:03', NULL, NULL),
(251, 1, 252, NULL, NULL, '2025/0251', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:27', NULL, NULL),
(252, 1, 253, NULL, NULL, '2025/0252', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:07', NULL, NULL),
(253, 1, 254, NULL, NULL, '2025/0253', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:56', NULL, NULL),
(254, 1, 255, NULL, NULL, '2025/0254', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:27:53', NULL, NULL),
(255, 1, 256, NULL, NULL, '2025/0255', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:28:38', NULL, NULL),
(256, 1, 257, NULL, NULL, '2025/0256', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:23', NULL, NULL),
(257, 1, 258, NULL, NULL, '2025/0257', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:30:16', NULL, NULL),
(258, 1, 259, NULL, NULL, '2025/0258', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:08', NULL, NULL),
(259, 1, 260, NULL, NULL, '2025/0259', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:49', NULL, NULL),
(260, 1, 261, NULL, NULL, '2025/0260', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:32:31', NULL, NULL),
(261, 1, 262, NULL, NULL, '2025/0261', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:33:35', NULL, NULL),
(262, 1, 263, NULL, NULL, '2025/0262', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:34:24', NULL, NULL),
(263, 1, 264, NULL, NULL, '2025/0263', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:35:04', NULL, NULL),
(264, 1, 265, NULL, NULL, '2025/0264', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:36:01', NULL, NULL),
(265, 1, 266, NULL, NULL, '2025/0265', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:36:43', NULL, NULL),
(266, 1, 267, NULL, NULL, '2025/0266', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:37:21', NULL, NULL),
(267, 1, 268, NULL, NULL, '2025/0267', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:38:00', NULL, NULL),
(268, 1, 269, NULL, NULL, '2025/0268', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:38:45', NULL, NULL),
(269, 1, 270, NULL, NULL, '2025/0269', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:39:43', NULL, NULL),
(270, 1, 271, NULL, NULL, '2025/0270', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:40:26', NULL, NULL),
(271, 1, 272, NULL, NULL, '2025/0271', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:41:11', NULL, NULL),
(272, 1, 273, NULL, NULL, '2025/0272', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:42:42', NULL, NULL),
(273, 1, 274, NULL, NULL, '2025/0273', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:44:44', NULL, NULL),
(274, 1, 275, NULL, NULL, '2025/0274', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:45:26', NULL, NULL),
(275, 1, 276, NULL, NULL, '2025/0275', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:46:10', NULL, NULL),
(276, 1, 277, NULL, NULL, '2025/0276', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:46:51', NULL, NULL),
(277, 1, 278, NULL, NULL, '2025/0277', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:47:34', NULL, NULL),
(278, 1, 279, NULL, NULL, '2025/0278', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:48:14', NULL, NULL),
(279, 1, 280, NULL, NULL, '2025/0279', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:49:01', NULL, NULL),
(280, 1, 281, NULL, NULL, '2025/0280', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:49:42', NULL, NULL),
(281, 1, 282, NULL, NULL, '2025/0281', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:50:25', NULL, NULL),
(282, 1, 283, NULL, NULL, '2025/0282', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:51:27', NULL, NULL),
(283, 1, 284, NULL, NULL, '2025/0283', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:52:38', NULL, NULL),
(284, 1, 285, NULL, NULL, '2025/0284', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:53:30', NULL, NULL),
(285, 1, 286, NULL, NULL, '2025/0285', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:54:15', NULL, NULL),
(286, 1, 287, NULL, NULL, '2025/0286', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:55:17', NULL, NULL),
(287, 1, 288, NULL, NULL, '2025/0287', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:56:04', NULL, NULL),
(288, 1, 289, NULL, NULL, '2025/0288', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:56:48', NULL, NULL),
(289, 1, 290, NULL, NULL, '2025/0289', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:57:49', NULL, NULL),
(290, 1, 291, NULL, NULL, '2025/0290', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:58:44', NULL, NULL),
(291, 1, 292, NULL, NULL, '2025/0291', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:59:36', NULL, NULL),
(292, 1, 293, NULL, NULL, '2025/0292', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:00:23', NULL, NULL),
(293, 1, 294, NULL, NULL, '2025/0293', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:01:07', NULL, NULL),
(294, 1, 295, NULL, NULL, '2025/0294', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:01:50', NULL, NULL),
(295, 1, 296, NULL, NULL, '2025/0295', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:02:28', NULL, NULL),
(296, 1, 297, NULL, NULL, '2025/0296', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:03:09', NULL, NULL),
(297, 1, 298, NULL, NULL, '2025/0297', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:04:08', NULL, NULL),
(298, 1, 299, NULL, NULL, '2025/0298', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:05:01', NULL, NULL),
(299, 1, 300, NULL, NULL, '2025/0299', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:05:47', NULL, NULL),
(300, 1, 301, NULL, NULL, '2025/0300', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:06:44', NULL, NULL),
(301, 1, 302, NULL, NULL, '2025/0301', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:07:21', NULL, NULL),
(302, 1, 303, NULL, NULL, '2025/0302', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:21:28', NULL, NULL),
(303, 1, 304, NULL, NULL, '2025/0303', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:23:01', NULL, NULL),
(304, 1, 305, NULL, NULL, '2025/0304', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:24:15', NULL, NULL),
(305, 1, 306, NULL, NULL, '2025/0305', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:25:04', NULL, NULL),
(306, 1, 307, NULL, NULL, '2025/0306', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:26:09', NULL, NULL),
(307, 1, 308, NULL, NULL, '2025/0307', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:27:06', NULL, NULL),
(308, 1, 309, NULL, NULL, '2025/0308', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:27:55', NULL, NULL),
(309, 1, 310, NULL, NULL, '2025/0309', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:28:47', NULL, NULL),
(310, 1, 311, NULL, NULL, '2025/0310', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:30:54', NULL, NULL),
(311, 1, 312, NULL, NULL, '2025/0311', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:31:47', NULL, NULL),
(312, 1, 313, NULL, NULL, '2025/0312', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:32:33', NULL, NULL),
(313, 1, 314, NULL, NULL, '2025/0313', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:33:35', NULL, NULL),
(314, 1, 315, NULL, NULL, '2025/0314', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:34:19', NULL, NULL),
(315, 1, 316, NULL, NULL, '2025/0315', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:35:10', NULL, NULL),
(316, 1, 317, NULL, NULL, '2025/0316', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:36:01', NULL, NULL),
(317, 1, 318, NULL, NULL, '2025/0317', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:38:35', NULL, NULL),
(318, 1, 319, NULL, NULL, '2025/0318', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:39:57', NULL, NULL),
(319, 1, 320, NULL, NULL, '2025/0319', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:41:02', NULL, NULL),
(320, 1, 321, NULL, NULL, '2025/0320', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:42:07', NULL, NULL),
(321, 1, 322, NULL, NULL, '2025/0321', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:43:19', NULL, NULL),
(322, 1, 323, NULL, NULL, '2025/0322', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:44:29', NULL, NULL),
(323, 1, 324, NULL, NULL, '2025/0323', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:45:57', NULL, NULL),
(324, 1, 325, NULL, NULL, '2025/0324', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:47:09', NULL, NULL),
(325, 1, 326, NULL, NULL, '2025/0325', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:48:05', NULL, NULL),
(326, 1, 327, NULL, NULL, '2025/0326', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:49:00', NULL, NULL),
(327, 1, 328, NULL, NULL, '2025/0327', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:50:00', NULL, NULL),
(328, 1, 329, NULL, NULL, '2025/0328', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:50:50', NULL, NULL),
(329, 1, 330, NULL, NULL, '2025/0329', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:51:30', NULL, NULL),
(330, 1, 331, NULL, NULL, '2025/0330', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:53:00', NULL, NULL),
(331, 1, 332, NULL, NULL, '2025/0331', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:53:39', NULL, NULL),
(332, 1, 333, NULL, NULL, '2025/0332', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:54:43', NULL, NULL),
(333, 1, 334, NULL, NULL, '2025/0333', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:55:29', NULL, NULL),
(334, 1, 335, NULL, NULL, '2025/0334', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:56:16', NULL, NULL),
(335, 1, 336, NULL, NULL, '2025/0335', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:57:56', NULL, NULL),
(336, 1, 337, NULL, NULL, '2025/0336', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:59:00', NULL, NULL),
(337, 1, 338, NULL, NULL, '2025/0337', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:59:57', NULL, NULL),
(338, 1, 339, NULL, NULL, '2025/0338', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:02:10', NULL, NULL),
(339, 1, 340, NULL, NULL, '2025/0339', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:03:08', NULL, NULL),
(340, 1, 341, NULL, NULL, '2025/0340', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:04:37', NULL, NULL),
(341, 1, 342, NULL, NULL, '2025/0341', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:05:51', NULL, NULL),
(342, 1, 343, NULL, NULL, '2025/0342', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:06:48', NULL, NULL),
(343, 1, 344, NULL, NULL, '2025/0343', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:07:59', NULL, NULL),
(344, 1, 345, NULL, NULL, '2025/0344', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:09:35', NULL, NULL),
(345, 1, 346, NULL, NULL, '2025/0345', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:10:30', NULL, NULL),
(346, 1, 347, NULL, NULL, '2025/0346', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:11:30', NULL, NULL),
(347, 1, 348, NULL, NULL, '2025/0347', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:12:37', NULL, NULL),
(348, 1, 349, NULL, NULL, '2025/0348', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:20:40', NULL, NULL),
(349, 1, 350, NULL, NULL, '2025/0349', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:21:34', NULL, NULL),
(350, 1, 351, NULL, NULL, '2025/0350', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:22:43', NULL, NULL),
(351, 1, 352, NULL, NULL, '2025/0351', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:23:45', NULL, NULL),
(352, 1, 353, NULL, NULL, '2025/0352', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:24:59', NULL, NULL),
(353, 1, 354, NULL, NULL, '2025/0353', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:26:11', NULL, NULL),
(354, 1, 355, NULL, NULL, '2025/0354', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:27:06', NULL, NULL),
(355, 1, 356, NULL, NULL, '2025/0355', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:27:55', NULL, NULL),
(356, 1, 357, NULL, NULL, '2025/0356', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:29:03', NULL, NULL),
(357, 1, 358, NULL, NULL, '2025/0357', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:30:03', NULL, NULL),
(358, 1, 359, NULL, NULL, '2025/0358', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:30:59', NULL, NULL),
(359, 1, 360, NULL, NULL, '2025/0359', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:31:51', NULL, NULL),
(360, 1, 361, NULL, NULL, '2025/0360', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:32:47', NULL, NULL),
(361, 1, 362, NULL, NULL, '2025/0361', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:34:07', NULL, NULL),
(362, 1, 363, NULL, NULL, '2025/0362', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:34:58', NULL, NULL),
(363, 1, 364, NULL, NULL, '2025/0363', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:35:59', NULL, NULL),
(364, 1, 365, NULL, NULL, '2025/0364', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:36:59', NULL, NULL),
(365, 1, 366, NULL, NULL, '2025/0365', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:38:15', NULL, NULL),
(366, 1, 367, NULL, NULL, '2025/0366', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:39:32', NULL, NULL),
(367, 1, 368, NULL, NULL, '2025/0367', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:41:17', NULL, NULL),
(368, 1, 369, NULL, NULL, '2025/0368', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:46:21', NULL, NULL),
(369, 1, 370, NULL, NULL, '2025/0369', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:47:32', NULL, NULL),
(370, 1, 371, NULL, NULL, '2025/0370', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:48:37', NULL, NULL),
(371, 1, 372, NULL, NULL, '2025/0371', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:50:10', NULL, NULL),
(372, 1, 373, NULL, NULL, '2025/0372', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:51:37', NULL, NULL),
(373, 1, 374, NULL, NULL, '2025/0373', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:52:21', NULL, NULL),
(374, 1, 375, NULL, NULL, '2025/0374', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:53:09', NULL, NULL),
(375, 1, 376, NULL, NULL, '2025/0375', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:54:10', NULL, NULL),
(376, 1, 377, NULL, NULL, '2025/0376', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:54:49', NULL, NULL),
(377, 1, 378, NULL, NULL, '2025/0377', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:55:59', NULL, NULL),
(378, 1, 379, NULL, NULL, '2025/0378', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:56:50', NULL, NULL),
(379, 1, 380, NULL, NULL, '2025/0379', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:58:32', NULL, NULL),
(380, 1, 381, NULL, NULL, '2025/0380', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:59:21', NULL, NULL),
(381, 1, 382, NULL, NULL, '2025/0381', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:00:17', NULL, NULL),
(382, 1, 383, NULL, NULL, '2025/0382', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:01:37', NULL, NULL),
(383, 1, 384, NULL, NULL, '2025/0383', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:02:33', NULL, NULL),
(384, 1, 385, NULL, NULL, '2025/0384', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:03:27', NULL, NULL),
(385, 1, 386, NULL, NULL, '2025/0385', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:04:22', NULL, NULL),
(386, 1, 387, NULL, NULL, '2025/0386', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:06:56', NULL, NULL),
(387, 1, 388, NULL, NULL, '2025/0387', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:07:43', NULL, NULL),
(388, 1, 389, NULL, NULL, '2025/0388', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:08:43', NULL, NULL),
(389, 1, 390, NULL, NULL, '2025/0389', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:09:31', NULL, NULL),
(390, 1, 391, NULL, NULL, '2025/0390', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:10:13', NULL, NULL),
(391, 1, 392, NULL, NULL, '2025/0391', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:11:28', NULL, NULL),
(392, 1, 393, NULL, NULL, '2025/0392', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:13:16', NULL, NULL),
(393, 1, 394, NULL, NULL, '2025/0393', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:17:35', NULL, NULL),
(394, 1, 395, NULL, NULL, '2025/0394', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:18:22', NULL, NULL),
(395, 1, 396, NULL, NULL, '2025/0395', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:19:18', NULL, NULL),
(396, 1, 397, NULL, NULL, '2025/0396', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:20:32', NULL, NULL),
(397, 1, 398, NULL, NULL, '2025/0397', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:21:31', NULL, NULL),
(398, 1, 399, NULL, NULL, '2025/0398', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:22:23', NULL, NULL),
(399, 1, 400, NULL, NULL, '2025/0399', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:23:11', NULL, NULL),
(400, 1, 401, NULL, NULL, '2025/0400', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:24:17', NULL, NULL),
(401, 1, 402, NULL, NULL, '2025/0401', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:25:07', NULL, NULL),
(402, 1, 403, NULL, NULL, '2025/0402', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:26:07', NULL, NULL),
(403, 1, 404, NULL, NULL, '2025/0403', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:27:53', NULL, NULL),
(404, 1, 405, NULL, NULL, '2025/0404', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:29:06', NULL, NULL),
(405, 1, 406, NULL, NULL, '2025/0405', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:32:03', NULL, NULL),
(406, 1, 407, NULL, NULL, '2025/0406', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:33:08', NULL, NULL),
(407, 1, 408, NULL, NULL, '2025/0407', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:34:01', NULL, NULL),
(408, 1, 409, NULL, NULL, '2025/0408', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:34:49', NULL, NULL),
(409, 1, 410, NULL, NULL, '2025/0409', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:35:36', NULL, NULL),
(410, 1, 411, NULL, NULL, '2025/0410', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:36:20', NULL, NULL),
(411, 1, 412, NULL, NULL, '2025/0411', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:38:18', NULL, NULL),
(412, 1, 413, NULL, NULL, '2025/0412', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:40:34', NULL, NULL),
(413, 1, 414, NULL, NULL, '2025/0413', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:41:41', NULL, NULL),
(414, 1, 415, NULL, NULL, '2025/0414', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:42:29', NULL, NULL),
(415, 1, 416, NULL, NULL, '2025/0415', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:43:38', NULL, NULL),
(416, 1, 417, NULL, NULL, '2025/0416', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:44:52', NULL, NULL),
(417, 1, 418, NULL, NULL, '2025/0417', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:45:56', NULL, NULL),
(418, 1, 419, NULL, NULL, '2025/0418', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:46:58', NULL, NULL),
(419, 1, 420, NULL, NULL, '2025/0419', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:47:47', NULL, NULL),
(420, 1, 421, NULL, NULL, '2025/0420', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:48:39', NULL, NULL),
(421, 1, 422, NULL, NULL, '2025/0421', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:49:40', NULL, NULL),
(422, 1, 423, NULL, NULL, '2025/0422', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:50:37', NULL, NULL),
(423, 1, 424, NULL, NULL, '2025/0423', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:51:23', NULL, NULL),
(424, 1, 425, NULL, NULL, '2025/0424', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:52:13', NULL, NULL),
(425, 1, 426, NULL, NULL, '2025/0425', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:53:04', NULL, NULL),
(426, 1, 427, NULL, NULL, '2025/0426', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:54:07', NULL, NULL),
(427, 1, 428, NULL, NULL, '2025/0427', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:55:04', NULL, NULL),
(428, 1, 429, NULL, NULL, '2025/0428', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:56:06', NULL, NULL),
(429, 1, 430, NULL, NULL, '2025/0429', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:56:55', NULL, NULL),
(430, 1, 431, NULL, NULL, '2025/0430', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:58:07', NULL, NULL),
(431, 1, 432, NULL, NULL, '2025/0431', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:59:07', NULL, NULL),
(432, 1, 433, NULL, NULL, '2025/0432', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:00:05', NULL, NULL),
(433, 1, 434, NULL, NULL, '2025/0433', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:00:47', NULL, NULL),
(434, 1, 435, NULL, NULL, '2025/0434', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:01:44', NULL, NULL),
(435, 1, 436, NULL, NULL, '2025/0435', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:02:39', NULL, NULL),
(436, 1, 437, NULL, NULL, '2025/0436', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:03:39', NULL, NULL),
(437, 1, 438, NULL, NULL, '2025/0437', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:04:42', NULL, NULL),
(438, 1, 439, NULL, NULL, '2025/0438', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:05:29', NULL, NULL),
(439, 1, 440, NULL, NULL, '2025/0439', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:06:25', NULL, NULL),
(440, 1, 441, NULL, NULL, '2025/0440', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:07:18', NULL, NULL),
(441, 1, 442, NULL, NULL, '2025/0441', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:08:08', NULL, NULL),
(442, 1, 443, NULL, NULL, '2025/0442', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:08:58', NULL, NULL),
(443, 1, 444, NULL, NULL, '2025/0443', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:10:05', NULL, NULL),
(444, 1, 445, NULL, NULL, '2025/0444', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:11:12', NULL, NULL),
(445, 1, 446, NULL, NULL, '2025/0445', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:11:58', NULL, NULL),
(446, 1, 447, NULL, NULL, '2025/0446', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:12:46', NULL, NULL),
(447, 1, 448, NULL, NULL, '2025/0447', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:13:29', NULL, NULL),
(448, 1, 449, NULL, NULL, '2025/0448', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:14:25', NULL, NULL),
(449, 1, 450, NULL, NULL, '2025/0449', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:15:14', NULL, NULL),
(450, 1, 451, NULL, NULL, '2025/0450', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:15:59', NULL, NULL),
(451, 1, 452, NULL, NULL, '2025/0451', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:16:50', NULL, NULL),
(452, 1, 453, NULL, NULL, '2025/0452', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:17:39', NULL, NULL),
(453, 1, 454, NULL, NULL, '2025/0453', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:18:25', NULL, NULL),
(457, NULL, 458, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:24:53', NULL, NULL),
(458, NULL, 459, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:25:35', NULL, '2025-08-19 00:26:31'),
(459, NULL, 460, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:42:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student_attendance`
--

CREATE TABLE `student_attendance` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(20) DEFAULT 'present',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_contacts`
--

CREATE TABLE `student_contacts` (
  `student_id` bigint(20) NOT NULL,
  `contact_id` bigint(20) NOT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_contacts`
--

INSERT INTO `student_contacts` (`student_id`, `contact_id`, `relationship`, `is_primary`) VALUES
(102, 1, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student_curriculums`
--

CREATE TABLE `student_curriculums` (
  `student_id` bigint(20) NOT NULL,
  `curriculum_id` tinyint(4) NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_education_levels`
--

CREATE TABLE `student_education_levels` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `education_type` varchar(20) NOT NULL,
  `level_name` varchar(120) NOT NULL,
  `institution` varchar(150) DEFAULT NULL,
  `year_completed` year(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_family_status`
--

CREATE TABLE `student_family_status` (
  `student_id` bigint(20) NOT NULL,
  `orphan_status_id` tinyint(4) DEFAULT NULL,
  `primary_guardian_name` varchar(150) DEFAULT NULL,
  `primary_guardian_contact` varchar(60) DEFAULT NULL,
  `primary_guardian_occupation` varchar(120) DEFAULT NULL,
  `father_name` varchar(150) DEFAULT NULL,
  `father_living_status_id` tinyint(4) DEFAULT NULL,
  `father_occupation` varchar(120) DEFAULT NULL,
  `father_contact` varchar(60) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_fee_items`
--

CREATE TABLE `student_fee_items` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `item` varchar(120) NOT NULL,
  `amount` decimal(14,2) NOT NULL,
  `discount` decimal(14,2) DEFAULT 0.00,
  `paid` decimal(14,2) DEFAULT 0.00,
  `balance` decimal(14,2) GENERATED ALWAYS AS (`amount` - `discount` - `paid`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_hafz_progress_summary`
--

CREATE TABLE `student_hafz_progress_summary` (
  `student_id` bigint(20) NOT NULL,
  `juz_memorized` int(11) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_next_of_kin`
--

CREATE TABLE `student_next_of_kin` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `sequence` tinyint(4) NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `occupation` varchar(120) DEFAULT NULL,
  `contact` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_profiles`
--

CREATE TABLE `student_profiles` (
  `student_id` bigint(20) NOT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `place_of_residence` varchar(150) DEFAULT NULL,
  `district_id` bigint(20) DEFAULT NULL,
  `nationality_id` int(11) DEFAULT NULL,
  `passport_document_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_requirements`
--

CREATE TABLE `student_requirements` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `requirement_id` bigint(20) NOT NULL,
  `brought` tinyint(1) DEFAULT 0,
  `date_reported` date DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subcounties`
--

CREATE TABLE `subcounties` (
  `id` bigint(20) NOT NULL,
  `county_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `subject_type` varchar(20) DEFAULT 'core'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terms`
--

CREATE TABLE `terms` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `academic_year_id` bigint(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `term_progress_log`
--

CREATE TABLE `term_progress_log` (
  `id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `day_date` date NOT NULL,
  `week_no` tinyint(4) DEFAULT NULL,
  `summary` varchar(200) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `term_requirements`
--

CREATE TABLE `term_requirements` (
  `id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `requirement_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `term_requirement_items`
--

CREATE TABLE `term_requirement_items` (
  `id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `mandatory` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `term_student_reports`
--

CREATE TABLE `term_student_reports` (
  `id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `report_date` date NOT NULL,
  `status` varchar(20) DEFAULT 'reported',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `term_student_requirement_status`
--

CREATE TABLE `term_student_requirement_status` (
  `id` bigint(20) NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `brought` tinyint(1) DEFAULT 0,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timetable`
--

CREATE TABLE `timetable` (
  `id` bigint(20) NOT NULL,
  `class_id` bigint(20) NOT NULL,
  `subject_id` bigint(20) NOT NULL,
  `teacher_id` bigint(20) DEFAULT NULL,
  `day_of_week` tinyint(4) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `room` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_people`
--

CREATE TABLE `user_people` (
  `user_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `villages`
--

CREATE TABLE `villages` (
  `id` bigint(20) NOT NULL,
  `parish_id` bigint(20) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `branch_id` bigint(20) DEFAULT NULL,
  `name` varchar(80) NOT NULL,
  `method` varchar(40) NOT NULL,
  `currency` varchar(10) DEFAULT 'UGX',
  `opening_balance` decimal(14,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workplans`
--

CREATE TABLE `workplans` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `owner_type` varchar(20) NOT NULL,
  `owner_id` bigint(20) DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `end_datetime` datetime DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_years`
--
ALTER TABLE `academic_years`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `class_results`
--
ALTER TABLE `class_results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_class_result` (`student_id`,`class_id`,`subject_id`,`term_id`,`result_type_id`);

--
-- Indexes for table `class_subjects`
--
ALTER TABLE `class_subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counties`
--
ALTER TABLE `counties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `curriculums`
--
ALTER TABLE `curriculums`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department_workplans`
--
ALTER TABLE `department_workplans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fee_payments`
--
ALTER TABLE `fee_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fee_structures`
--
ALTER TABLE `fee_structures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finance_categories`
--
ALTER TABLE `finance_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ledger`
--
ALTER TABLE `ledger`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `living_statuses`
--
ALTER TABLE `living_statuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `nationalities`
--
ALTER TABLE `nationalities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `orphan_statuses`
--
ALTER TABLE `orphan_statuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `parishes`
--
ALTER TABLE `parishes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payroll_definitions`
--
ALTER TABLE `payroll_definitions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `report_cards`
--
ALTER TABLE `report_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `report_card_metrics`
--
ALTER TABLE `report_card_metrics`
  ADD PRIMARY KEY (`report_card_id`);

--
-- Indexes for table `report_card_subjects`
--
ALTER TABLE `report_card_subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requirements_master`
--
ALTER TABLE `requirements_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `result_types`
--
ALTER TABLE `result_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`);

--
-- Indexes for table `salary_payments`
--
ALTER TABLE `salary_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schools`
--
ALTER TABLE `schools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `school_settings`
--
ALTER TABLE `school_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_no` (`staff_no`);

--
-- Indexes for table `staff_attendance`
--
ALTER TABLE `staff_attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff_salaries`
--
ALTER TABLE `staff_salaries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `streams`
--
ALTER TABLE `streams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admission_no` (`admission_no`);

--
-- Indexes for table `student_attendance`
--
ALTER TABLE `student_attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_contacts`
--
ALTER TABLE `student_contacts`
  ADD PRIMARY KEY (`student_id`,`contact_id`);

--
-- Indexes for table `student_curriculums`
--
ALTER TABLE `student_curriculums`
  ADD PRIMARY KEY (`student_id`,`curriculum_id`);

--
-- Indexes for table `student_education_levels`
--
ALTER TABLE `student_education_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_family_status`
--
ALTER TABLE `student_family_status`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_fee_items`
--
ALTER TABLE `student_fee_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_hafz_progress_summary`
--
ALTER TABLE `student_hafz_progress_summary`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_next_of_kin`
--
ALTER TABLE `student_next_of_kin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_profiles`
--
ALTER TABLE `student_profiles`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_requirements`
--
ALTER TABLE `student_requirements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subcounties`
--
ALTER TABLE `subcounties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `terms`
--
ALTER TABLE `terms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `term_progress_log`
--
ALTER TABLE `term_progress_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_term_day` (`term_id`,`day_date`);

--
-- Indexes for table `term_requirements`
--
ALTER TABLE `term_requirements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `term_requirement_items`
--
ALTER TABLE `term_requirement_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_term_req_item` (`term_id`,`name`);

--
-- Indexes for table `term_student_reports`
--
ALTER TABLE `term_student_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_term_student` (`term_id`,`student_id`);

--
-- Indexes for table `term_student_requirement_status`
--
ALTER TABLE `term_student_requirement_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_term_student_item` (`term_id`,`student_id`,`item_id`);

--
-- Indexes for table `timetable`
--
ALTER TABLE `timetable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_people`
--
ALTER TABLE `user_people`
  ADD PRIMARY KEY (`user_id`,`person_id`);

--
-- Indexes for table `villages`
--
ALTER TABLE `villages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workplans`
--
ALTER TABLE `workplans`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_years`
--
ALTER TABLE `academic_years`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `class_results`
--
ALTER TABLE `class_results`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_subjects`
--
ALTER TABLE `class_subjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `counties`
--
ALTER TABLE `counties`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `curriculums`
--
ALTER TABLE `curriculums`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department_workplans`
--
ALTER TABLE `department_workplans`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fee_payments`
--
ALTER TABLE `fee_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fee_structures`
--
ALTER TABLE `fee_structures`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_categories`
--
ALTER TABLE `finance_categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ledger`
--
ALTER TABLE `ledger`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `living_statuses`
--
ALTER TABLE `living_statuses`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nationalities`
--
ALTER TABLE `nationalities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orphan_statuses`
--
ALTER TABLE `orphan_statuses`
  MODIFY `id` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `parishes`
--
ALTER TABLE `parishes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payroll_definitions`
--
ALTER TABLE `payroll_definitions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `people`
--
ALTER TABLE `people`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_cards`
--
ALTER TABLE `report_cards`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report_card_subjects`
--
ALTER TABLE `report_card_subjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `requirements_master`
--
ALTER TABLE `requirements_master`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `result_types`
--
ALTER TABLE `result_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salary_payments`
--
ALTER TABLE `salary_payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schools`
--
ALTER TABLE `schools`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `school_settings`
--
ALTER TABLE `school_settings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_attendance`
--
ALTER TABLE `staff_attendance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff_salaries`
--
ALTER TABLE `staff_salaries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `streams`
--
ALTER TABLE `streams`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=460;

--
-- AUTO_INCREMENT for table `student_attendance`
--
ALTER TABLE `student_attendance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_education_levels`
--
ALTER TABLE `student_education_levels`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_fee_items`
--
ALTER TABLE `student_fee_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_next_of_kin`
--
ALTER TABLE `student_next_of_kin`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_requirements`
--
ALTER TABLE `student_requirements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subcounties`
--
ALTER TABLE `subcounties`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `term_progress_log`
--
ALTER TABLE `term_progress_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `term_requirements`
--
ALTER TABLE `term_requirements`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `term_requirement_items`
--
ALTER TABLE `term_requirement_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `term_student_reports`
--
ALTER TABLE `term_student_reports`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `term_student_requirement_status`
--
ALTER TABLE `term_student_requirement_status`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timetable`
--
ALTER TABLE `timetable`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `villages`
--
ALTER TABLE `villages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workplans`
--
ALTER TABLE `workplans`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

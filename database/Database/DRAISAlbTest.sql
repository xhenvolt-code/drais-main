-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 11, 2025 at 06:58 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drais_school`
--

-- --------------------------------------------------------
--
-- Drop existing tables in reverse order of dependencies
--

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `user_people`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `term_student_requirement_status`;
DROP TABLE IF EXISTS `term_student_reports`;
DROP TABLE IF EXISTS `term_requirement_items`;
DROP TABLE IF EXISTS `term_requirements`;
DROP TABLE IF EXISTS `term_progress_log`;
DROP TABLE IF EXISTS `tahfiz_migration_log`;
DROP TABLE IF EXISTS `tahfiz_group_members`;
DROP TABLE IF EXISTS `tahfiz_evaluations`;
DROP TABLE IF EXISTS `tahfiz_records`;
DROP TABLE IF EXISTS `tahfiz_attendance`;
DROP TABLE IF EXISTS `tahfiz_plans`;
DROP TABLE IF EXISTS `tahfiz_portions`;
DROP TABLE IF EXISTS `tahfiz_books`;
DROP TABLE IF EXISTS `tahfiz_groups`;
DROP TABLE IF EXISTS `student_hafz_progress_summary`;
DROP TABLE IF EXISTS `student_requirements`;
DROP TABLE IF EXISTS `student_profiles`;
DROP TABLE IF EXISTS `student_next_of_kin`;
DROP TABLE IF EXISTS `student_fee_items`;
DROP TABLE IF EXISTS `student_family_status`;
DROP TABLE IF EXISTS `student_education_levels`;
DROP TABLE IF EXISTS `student_curriculums`;
DROP TABLE IF EXISTS `student_contacts`;
DROP TABLE IF EXISTS `student_attendance`;
DROP TABLE IF EXISTS `staff_salaries`;
DROP TABLE IF EXISTS `staff_attendance`;
DROP TABLE IF EXISTS `salary_payments`;
DROP TABLE IF EXISTS `role_permissions`;
DROP TABLE IF EXISTS `report_card_subjects`;
DROP TABLE IF EXISTS `report_card_metrics`;
DROP TABLE IF EXISTS `report_cards`;
DROP TABLE IF EXISTS `results`;
DROP TABLE IF EXISTS `fee_payments`;
DROP TABLE IF EXISTS `workplans`;
DROP TABLE IF EXISTS `department_workplans`;
DROP TABLE IF EXISTS `class_subjects`;
DROP TABLE IF EXISTS `class_results`;
DROP TABLE IF EXISTS `enrollments`;
DROP TABLE IF EXISTS `timetable`;
DROP TABLE IF EXISTS `exams`;
DROP TABLE IF EXISTS `documents`;
DROP TABLE IF EXISTS `wallets`;
DROP TABLE IF EXISTS `ledger`;
DROP TABLE IF EXISTS `students`;
DROP TABLE IF EXISTS `staff`;
DROP TABLE IF EXISTS `people`;
DROP TABLE IF EXISTS `contacts`;
DROP TABLE IF EXISTS `classes`;
DROP TABLE IF EXISTS `subjects`;
DROP TABLE IF EXISTS `streams`;
DROP TABLE IF EXISTS `terms`;
DROP TABLE IF EXISTS `academic_years`;
DROP TABLE IF EXISTS `departments`;
DROP TABLE IF EXISTS `branches`;
DROP TABLE IF EXISTS `schools`;
DROP TABLE IF EXISTS `school_settings`;
DROP TABLE IF EXISTS `fee_structures`;
DROP TABLE IF EXISTS `finance_categories`;
DROP TABLE IF EXISTS `payroll_definitions`;
DROP TABLE IF EXISTS `result_types`;
DROP TABLE IF EXISTS `requirements_master`;
DROP TABLE IF EXISTS `document_types`;
DROP TABLE IF EXISTS `curriculums`;
DROP TABLE IF EXISTS `roles`;
DROP TABLE IF EXISTS `permissions`;
DROP TABLE IF EXISTS `events`;
DROP TABLE IF EXISTS `villages`;
DROP TABLE IF EXISTS `parishes`;
DROP TABLE IF EXISTS `subcounties`;
DROP TABLE IF EXISTS `counties`;
DROP TABLE IF EXISTS `districts`;
DROP TABLE IF EXISTS `nationalities`;
DROP TABLE IF EXISTS `living_statuses`;
DROP TABLE IF EXISTS `orphan_statuses`;
DROP TABLE IF EXISTS `audit_log`;

SET FOREIGN_KEY_CHECKS = 1;

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

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(1, NULL, 'update_status', 'students', 586, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 11:59:16'),
(2, NULL, 'update_status', 'students', 583, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 11:59:31'),
(3, NULL, 'update_status', 'students', 583, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 11:59:42'),
(4, NULL, 'update_status', 'students', 587, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:02:46'),
(5, NULL, 'update_status', 'students', 588, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:58:02'),
(6, NULL, 'update_status', 'students', 457, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:58:44'),
(7, NULL, 'update_status', 'students', 467, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:59:04'),
(8, NULL, 'update_status', 'students', 466, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:59:11'),
(9, NULL, 'update_status', 'students', 459, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:59:37'),
(10, NULL, 'update_status', 'students', 460, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:59:49'),
(11, NULL, 'update_status', 'students', 461, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 13:59:59'),
(12, NULL, 'update_status', 'students', 464, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 14:00:06'),
(13, NULL, 'update_status', 'students', 469, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 14:00:33'),
(14, NULL, 'update_status', 'students', 470, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 14:00:47'),
(15, NULL, 'update_status', 'students', 471, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 14:00:57'),
(16, NULL, 'update_status', 'students', 583, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 05:53:32'),
(17, NULL, 'update_status', 'students', 588, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:53:44'),
(18, NULL, 'update_status', 'students', 587, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:54:18'),
(19, NULL, 'update_status', 'students', 586, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:54:27'),
(20, NULL, 'update_status', 'students', 583, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:55:09'),
(21, NULL, 'update_status', 'students', 471, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:55:48'),
(22, NULL, 'update_status', 'students', 470, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:55:58'),
(23, NULL, 'update_status', 'students', 469, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:56:13'),
(24, NULL, 'update_status', 'students', 467, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:56:23'),
(25, NULL, 'update_status', 'students', 466, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 05:56:45'),
(26, NULL, 'update_status', 'students', 464, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 06:00:21'),
(27, NULL, 'update_status', 'students', 461, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 06:00:31'),
(28, NULL, 'update_status', 'students', 220, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 06:01:18'),
(29, NULL, 'update_status', 'students', 192, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 06:01:43'),
(30, NULL, 'update_status', 'students', 391, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 06:41:01'),
(31, NULL, 'update_status', 'students', 590, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 06:50:12'),
(32, NULL, 'update_status', 'students', 592, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 10:52:36'),
(33, NULL, 'update_status', 'students', 2, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:54:54'),
(34, NULL, 'update_status', 'students', 460, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:55:15'),
(35, NULL, 'update_status', 'students', 459, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:55:28'),
(36, NULL, 'update_status', 'students', 457, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:55:35'),
(37, NULL, 'update_status', 'students', 219, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:55:54'),
(38, NULL, 'update_status', 'students', 47, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:56:32'),
(39, NULL, 'update_status', 'students', 48, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:56:40'),
(40, NULL, 'update_status', 'students', 49, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:56:46'),
(41, NULL, 'update_status', 'students', 59, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:56:57'),
(42, NULL, 'update_status', 'students', 58, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:05'),
(43, NULL, 'update_status', 'students', 57, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:15'),
(44, NULL, 'update_status', 'students', 56, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:22'),
(45, NULL, 'update_status', 'students', 55, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:29'),
(46, NULL, 'update_status', 'students', 50, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:38'),
(47, NULL, 'update_status', 'students', 51, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:46'),
(48, NULL, 'update_status', 'students', 52, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:57:54'),
(49, NULL, 'update_status', 'students', 53, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:58:03'),
(50, NULL, 'update_status', 'students', 54, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 10:58:24'),
(51, NULL, 'update_status', 'students', 577, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 11:01:34'),
(52, NULL, 'update_status', 'students', 576, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 11:01:43'),
(53, NULL, 'update_status', 'students', 576, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 07:55:18'),
(54, NULL, 'update_status', 'students', 577, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 07:55:18'),
(55, NULL, 'update_status', 'students', 440, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 07:55:52'),
(56, NULL, 'update_status', 'students', 423, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 07:56:57'),
(57, NULL, 'update_status', 'students', 423, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 07:57:36'),
(58, NULL, 'update_status', 'students', 218, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 07:58:28'),
(59, NULL, 'update_status', 'students', 487, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:02:01'),
(60, NULL, 'update_status', 'students', 487, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:02:01'),
(61, NULL, 'update_status', 'students', 587, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:02:54'),
(62, NULL, 'update_status', 'students', 583, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:03:11'),
(63, NULL, 'update_status', 'students', 579, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:03:21'),
(64, NULL, 'update_status', 'students', 580, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:03:47'),
(65, NULL, 'update_status', 'students', 581, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:03:59'),
(66, NULL, 'update_status', 'students', 523, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:04:12'),
(67, NULL, 'update_status', 'students', 522, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:04:22'),
(68, NULL, 'update_status', 'students', 517, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:04:42'),
(69, NULL, 'update_status', 'students', 472, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:05:01'),
(70, NULL, 'update_status', 'students', 555, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:07:45'),
(71, NULL, 'update_status', 'students', 553, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:07:54'),
(72, NULL, 'update_status', 'students', 568, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:08:12'),
(73, NULL, 'update_status', 'students', 567, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:08:27'),
(74, NULL, 'update_status', 'students', 566, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:08:36'),
(75, NULL, 'update_status', 'students', 565, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:08:49'),
(76, NULL, 'update_status', 'students', 564, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:08:59'),
(77, NULL, 'update_status', 'students', 563, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:09:14'),
(78, NULL, 'update_status', 'students', 562, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:09:24'),
(79, NULL, 'update_status', 'students', 559, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:09:39'),
(80, NULL, 'update_status', 'students', 557, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:09:51'),
(81, NULL, 'update_status', 'students', 554, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:10:14'),
(82, NULL, 'update_status', 'students', 551, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:10:27'),
(83, NULL, 'update_status', 'students', 548, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:10:54'),
(84, NULL, 'update_status', 'students', 547, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:11:08'),
(85, NULL, 'update_status', 'students', 546, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:11:18'),
(86, NULL, 'update_status', 'students', 545, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:11:30'),
(87, NULL, 'update_status', 'students', 542, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:11:44'),
(88, NULL, 'update_status', 'students', 541, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:12:19'),
(89, NULL, 'update_status', 'students', 539, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:12:33'),
(90, NULL, 'update_status', 'students', 538, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:12:42'),
(91, NULL, 'update_status', 'students', 536, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:13:00'),
(92, NULL, 'update_status', 'students', 535, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:13:17'),
(93, NULL, 'update_status', 'students', 534, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:13:28'),
(94, NULL, 'update_status', 'students', 533, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:13:39'),
(95, NULL, 'update_status', 'students', 532, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:13:49'),
(96, NULL, 'update_status', 'students', 531, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:14:04'),
(97, NULL, 'update_status', 'students', 529, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:14:15'),
(98, NULL, 'update_status', 'students', 527, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:14:31'),
(99, NULL, 'update_status', 'students', 526, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:14:41'),
(100, NULL, 'update_status', 'students', 550, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:15:15'),
(101, NULL, 'update_status', 'students', 558, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:15:29'),
(102, NULL, 'update_status', 'students', 556, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:16:08'),
(103, NULL, 'update_status', 'students', 549, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:16:26'),
(104, NULL, 'update_status', 'students', 530, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:16:49'),
(105, NULL, 'update_status', 'students', 525, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:17:10'),
(106, NULL, 'update_status', 'students', 518, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:21:50'),
(107, NULL, 'update_status', 'students', 516, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:22:03'),
(108, NULL, 'update_status', 'students', 514, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:22:14'),
(109, NULL, 'update_status', 'students', 513, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:22:22'),
(110, NULL, 'update_status', 'students', 511, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:22:36'),
(111, NULL, 'update_status', 'students', 509, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:23:04'),
(112, NULL, 'update_status', 'students', 508, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:23:32'),
(113, NULL, 'update_status', 'students', 504, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:23:43'),
(114, NULL, 'update_status', 'students', 502, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:23:52'),
(115, NULL, 'update_status', 'students', 505, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:24:52'),
(116, NULL, 'update_status', 'students', 493, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:25:05'),
(117, NULL, 'update_status', 'students', 491, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:25:19'),
(118, NULL, 'update_status', 'students', 490, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:25:27'),
(119, NULL, 'update_status', 'students', 2, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:25:49'),
(120, NULL, 'update_status', 'students', 486, '{\"status\":\"active\"}', NULL, NULL, '2025-09-22 11:26:25'),
(121, NULL, 'update_status', 'students', 218, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:31:26'),
(122, NULL, 'update_status', 'students', 192, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:31:47'),
(123, NULL, 'update_status', 'students', 132, '{\"status\":\"inactive\"}', NULL, NULL, '2025-08-19 12:32:48'),
(124, NULL, 'update_status', 'students', 574, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:36:56'),
(125, NULL, 'update_status', 'students', 391, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:37:06'),
(126, NULL, 'update_status', 'students', 495, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:38:34'),
(127, NULL, 'update_status', 'students', 496, '{\"status\":\"active\"}', NULL, NULL, '2025-08-19 12:38:50'),
(128, NULL, 'photo_upload', 'student_photo', 66, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_66_1758700914116_a9bloc.jpg\",\"file_name\":\"IMG_20250323_174744.jpg\",\"file_size\":65087,\"student_id\":\"66\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0', '2025-09-24 08:01:57'),
(129, NULL, 'student_update', 'student', 66, '{\"first_name\":\"AALYAH\",\"last_name\":\"HAMZA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":2,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_66_1758700914116_a9bloc.jpg\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0', '2025-09-24 08:02:03'),
(130, NULL, 'student_update', 'student', 440, '{\"first_name\":\"AMASE\",\"last_name\":\"NUSFAT\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"inactive\",\"photo_url\":\"\"}', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:143.0) Gecko/20100101 Firefox/143.0', '2025-09-24 11:06:16'),
(131, NULL, 'update_status', 'students', 467, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:44:06'),
(132, NULL, 'update_status', 'students', 467, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:44:06'),
(133, NULL, 'update_status', 'students', 467, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:45:07'),
(134, NULL, 'update_status', 'students', 510, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:45:49'),
(135, NULL, 'update_status', 'students', 510, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:45:59'),
(136, NULL, 'update_status', 'students', 476, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:46:21'),
(137, NULL, 'update_status', 'students', 476, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:46:28'),
(138, NULL, 'update_status', 'students', 506, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 11:48:52'),
(139, NULL, 'update_status', 'students', 506, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:49:02'),
(140, NULL, 'update_status', 'students', 573, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 11:49:19'),
(141, NULL, 'update_status', 'students', 464, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:50:33'),
(142, NULL, 'update_status', 'students', 464, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:50:40'),
(143, NULL, 'update_status', 'students', 459, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 11:53:03'),
(144, NULL, 'update_status', 'students', 459, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:53:13'),
(145, NULL, 'update_status', 'students', 482, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:04:36'),
(146, NULL, 'update_status', 'students', 482, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:04:45'),
(147, NULL, 'update_status', 'students', 537, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 17:24:39'),
(148, NULL, 'update_status', 'students', 576, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 17:25:10'),
(149, NULL, 'update_status', 'students', 576, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:25:53'),
(150, NULL, 'update_status', 'students', 577, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 17:41:02'),
(151, NULL, 'update_status', 'students', 577, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:41:17'),
(152, NULL, 'update_status', 'students', 595, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:43:40'),
(153, NULL, 'update_status', 'students', 595, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:43:46'),
(154, NULL, 'update_status', 'students', 165, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:49:24'),
(155, NULL, 'update_status', 'students', 162, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:49:48'),
(156, NULL, 'update_status', 'students', 177, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:50:10'),
(157, NULL, 'update_status', 'students', 193, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:50:26'),
(158, NULL, 'update_status', 'students', 173, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:50:50'),
(159, NULL, 'update_status', 'students', 208, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:51:04'),
(160, NULL, 'update_status', 'students', 173, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:52:05'),
(161, NULL, 'update_status', 'students', 177, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:52:20'),
(162, NULL, 'update_status', 'students', 162, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:52:34'),
(163, NULL, 'update_status', 'students', 492, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:56:45'),
(164, NULL, 'update_status', 'students', 492, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:56:53'),
(165, NULL, 'update_status', 'students', 477, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 17:57:52'),
(166, NULL, 'update_status', 'students', 477, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:58:00'),
(167, NULL, 'update_status', 'students', 457, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:58:27'),
(168, NULL, 'update_status', 'students', 457, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:58:33'),
(169, NULL, 'update_status', 'students', 501, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 17:59:06'),
(170, NULL, 'update_status', 'students', 501, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 17:59:11'),
(171, NULL, 'update_status', 'students', 485, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:03:46'),
(172, NULL, 'update_status', 'students', 485, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:03:52'),
(173, NULL, 'update_status', 'students', 479, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 18:04:05'),
(174, NULL, 'update_status', 'students', 479, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:04:11'),
(175, NULL, 'update_status', 'students', 515, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:04:22'),
(176, NULL, 'update_status', 'students', 515, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:04:28'),
(177, NULL, 'update_status', 'students', 507, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:04:49'),
(178, NULL, 'update_status', 'students', 507, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:04:56'),
(179, NULL, 'update_status', 'students', 500, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:05:04'),
(180, NULL, 'update_status', 'students', 500, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:05:12'),
(181, NULL, 'update_status', 'students', 473, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:05:26'),
(182, NULL, 'update_status', 'students', 473, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:05:33'),
(183, NULL, 'update_status', 'students', 484, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:05:53'),
(184, NULL, 'update_status', 'students', 484, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:05:59'),
(185, NULL, 'update_status', 'students', 499, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:06:20'),
(186, NULL, 'update_status', 'students', 499, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:06:28'),
(187, NULL, 'update_status', 'students', 503, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 18:06:40'),
(188, NULL, 'update_status', 'students', 503, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:06:47'),
(189, NULL, 'update_status', 'students', 461, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:07:27'),
(190, NULL, 'update_status', 'students', 461, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:07:33'),
(191, NULL, 'update_status', 'students', 582, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 18:08:34'),
(192, NULL, 'update_status', 'students', 497, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 18:08:43'),
(193, NULL, 'update_status', 'students', 494, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:08:54'),
(194, NULL, 'update_status', 'students', 494, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:09:01'),
(195, NULL, 'update_status', 'students', 519, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 18:09:34'),
(196, NULL, 'update_status', 'students', 519, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:09:41'),
(197, NULL, 'update_status', 'students', 481, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:10:40'),
(198, NULL, 'update_status', 'students', 498, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 18:10:53'),
(199, NULL, 'update_status', 'students', 498, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:10:58'),
(200, NULL, 'update_status', 'students', 470, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 18:11:22'),
(201, NULL, 'update_status', 'students', 470, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:11:27'),
(202, NULL, 'update_status', 'students', 520, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:11:39'),
(203, NULL, 'update_status', 'students', 520, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:11:44'),
(204, NULL, 'update_status', 'students', 471, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 18:12:06'),
(205, NULL, 'update_status', 'students', 482, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 18:12:23'),
(206, NULL, 'update_status', 'students', 482, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:12:28'),
(207, NULL, 'update_status', 'students', 521, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:12:41'),
(208, NULL, 'update_status', 'students', 521, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:12:47'),
(209, NULL, 'update_status', 'students', 512, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:12:57'),
(210, NULL, 'update_status', 'students', 512, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:13:02'),
(211, NULL, 'update_status', 'students', 469, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 18:13:23'),
(212, NULL, 'update_status', 'students', 460, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:13:36'),
(213, NULL, 'update_status', 'students', 460, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:13:42'),
(214, NULL, 'update_status', 'students', 474, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:14:01'),
(215, NULL, 'update_status', 'students', 474, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:14:07'),
(216, NULL, 'update_status', 'students', 478, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:14:44'),
(217, NULL, 'update_status', 'students', 478, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:14:51'),
(218, NULL, 'update_status', 'students', 483, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 18:15:05'),
(219, NULL, 'update_status', 'students', 483, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 18:15:10'),
(220, NULL, 'update_status', 'students', 597, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 11:51:20'),
(221, NULL, 'update_status', 'students', 597, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:51:25'),
(222, NULL, 'update_status', 'students', 598, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 11:52:46'),
(223, NULL, 'update_status', 'students', 598, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:52:51'),
(224, NULL, 'update_status', 'students', 54, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 11:54:51'),
(225, NULL, 'update_status', 'students', 54, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 11:54:56'),
(226, NULL, 'student_update', 'student', 600, '{\"first_name\":\"MUNIRA\",\"last_name\":\"BASEFF\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":\"2\",\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 11:55:44'),
(227, NULL, 'update_status', 'students', 601, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:03:07'),
(228, NULL, 'update_status', 'students', 601, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:03:13'),
(229, NULL, 'update_status', 'students', 596, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:16:15'),
(230, NULL, 'update_status', 'students', 596, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:16:21'),
(231, NULL, 'update_status', 'students', 56, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:16:28'),
(232, NULL, 'update_status', 'students', 56, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:16:34'),
(233, NULL, 'update_status', 'students', 599, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:16:45'),
(234, NULL, 'update_status', 'students', 599, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:16:51'),
(235, NULL, 'update_status', 'students', 58, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:17:01'),
(236, NULL, 'update_status', 'students', 58, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:17:07'),
(237, NULL, 'update_status', 'students', 50, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:21:18'),
(238, NULL, 'update_status', 'students', 50, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:21:23'),
(239, NULL, 'update_status', 'students', 52, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:21:30'),
(240, NULL, 'update_status', 'students', 52, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:21:36'),
(241, NULL, 'update_status', 'students', 51, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:21:46'),
(242, NULL, 'update_status', 'students', 53, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:21:52'),
(243, NULL, 'update_status', 'students', 51, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:22:01'),
(244, NULL, 'update_status', 'students', 53, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:22:07'),
(245, NULL, 'update_status', 'students', 48, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:22:59'),
(246, NULL, 'update_status', 'students', 48, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:23:08'),
(247, NULL, 'student_update', 'student', 48, '{\"first_name\":\"NAKIRANDA\",\"last_name\":\"RAHUMA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":2,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 12:23:25'),
(248, NULL, 'student_update', 'student', 47, '{\"first_name\":\"NAMUWAYA\",\"last_name\":\"SHATURA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":2,\"status\":\"inactive\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 12:23:44'),
(249, NULL, 'update_status', 'students', 47, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:23:54'),
(250, NULL, 'update_status', 'students', 47, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:23:59'),
(251, NULL, 'update_status', 'students', 62, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:24:12'),
(252, NULL, 'update_status', 'students', 62, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:24:19'),
(253, NULL, 'update_status', 'students', 49, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:24:51'),
(254, NULL, 'update_status', 'students', 49, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:24:57'),
(255, NULL, 'update_status', 'students', 59, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:25:03'),
(256, NULL, 'update_status', 'students', 57, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:25:10'),
(257, NULL, 'update_status', 'students', 55, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:25:14'),
(258, NULL, 'update_status', 'students', 59, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:25:20'),
(259, NULL, 'update_status', 'students', 57, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:25:25'),
(260, NULL, 'update_status', 'students', 55, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:25:30'),
(261, NULL, 'update_status', 'students', 572, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:27:20'),
(262, NULL, 'update_status', 'students', 572, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:27:25'),
(263, NULL, 'update_status', 'students', 480, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:29:29'),
(264, NULL, 'update_status', 'students', 552, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:29:50'),
(265, NULL, 'update_status', 'students', 540, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-24 12:30:10'),
(266, NULL, 'update_status', 'students', 524, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:30:20'),
(267, NULL, 'update_status', 'students', 524, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:30:25'),
(268, NULL, 'update_status', 'students', 561, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:30:43'),
(269, NULL, 'update_status', 'students', 561, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:30:50'),
(270, NULL, 'update_status', 'students', 560, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 12:30:57'),
(271, NULL, 'update_status', 'students', 560, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:31:05'),
(272, NULL, 'update_status', 'students', 588, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 12:32:49'),
(273, NULL, 'update_status', 'students', 588, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 12:32:55'),
(274, NULL, 'update_status', 'students', 161, '{\"status\":\"on_leave\"}', NULL, NULL, '2025-09-24 16:25:49'),
(275, NULL, 'update_status', 'students', 174, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 16:26:32'),
(276, NULL, 'student_update', 'student', 211, '{\"first_name\":\"MUSOBYA\",\"last_name\":\"SHAFICK ABUBAKR\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:41'),
(277, NULL, 'student_update', 'student', 178, '{\"first_name\":\"WASOKO\",\"last_name\":\"EDRISA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"on_leave\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:29:04'),
(278, NULL, 'student_update', 'student', 446, '{\"first_name\":\"MUSINGO\",\"last_name\":\"FIRDAUS\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 14:55:21'),
(279, NULL, 'update_status', 'students', 602, '{\"status\":\"suspended\"}', NULL, NULL, '2025-09-24 15:01:32'),
(280, NULL, 'update_status', 'students', 602, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 15:01:36'),
(281, NULL, 'photo_upload', 'student_photo', 605, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_605_1758726128818_gj61lj.jpg\",\"file_name\":\"20250926_115353.jpg\",\"file_size\":3314406,\"student_id\":\"602\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:02:09'),
(282, NULL, 'student_update', 'student', 602, '{\"first_name\":\"ZULFA\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_605_1758726128818_gj61lj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:02:09'),
(283, NULL, 'photo_upload', 'student_photo', 423, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_423_1758730961006_xm5pkq.jpg\",\"file_name\":\"kauthar.jpg\",\"file_size\":3484984,\"student_id\":\"422\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:22:41'),
(284, NULL, 'student_update', 'student', 422, '{\"first_name\":\"SIKYAGATEMA\",\"last_name\":\"KAUTHARA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_423_1758730961006_xm5pkq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:22:42'),
(285, NULL, 'photo_upload', 'student_photo', 420, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_420_1758731021402_9a9b4r.jpg\",\"file_name\":\"nowal.jpg\",\"file_size\":3478840,\"student_id\":\"419\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:23:41'),
(286, NULL, 'student_update', 'student', 419, '{\"first_name\":\"NOWAL\",\"last_name\":\"ABDULLAH\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_420_1758731021402_9a9b4r.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:23:42'),
(287, NULL, 'photo_upload', 'student_photo', 447, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_447_1758731078928_3mbtr9.jpg\",\"file_name\":\"musingo.jpg\",\"file_size\":3602889,\"student_id\":\"446\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:24:39'),
(288, NULL, 'student_update', 'student', 446, '{\"first_name\":\"MUSINGO\",\"last_name\":\"FIRDAUS\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_447_1758731078928_3mbtr9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:24:39'),
(289, NULL, 'photo_upload', 'student_photo', 580, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_580_1758731126125_qsllt6.jpg\",\"file_name\":\"zainab bint ismael.jpg\",\"file_size\":3358716,\"student_id\":\"577\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:25:26'),
(290, NULL, 'student_update', 'student', 577, '{\"first_name\":\"NABILYE\",\"last_name\":\"ZAINAB\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_580_1758731126125_qsllt6.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:25:26'),
(291, NULL, 'photo_upload', 'student_photo', 432, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_432_1758731178206_kiqldo.jpg\",\"file_name\":\"rajjah.jpg\",\"file_size\":3182615,\"student_id\":\"431\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:26:18'),
(292, NULL, 'student_update', 'student', 431, '{\"first_name\":\"BIWEMBA\",\"last_name\":\"RAJAH\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_432_1758731178206_kiqldo.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:26:19'),
(293, NULL, 'photo_upload', 'student_photo', 411, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_411_1758731238439_6i6qy9.jpg\",\"file_name\":\"hindu.jpg\",\"file_size\":3362448,\"student_id\":\"410\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:18'),
(294, NULL, 'student_update', 'student', 410, '{\"first_name\":\"HINDU\",\"last_name\":\"ABDULLAH\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_411_1758731238439_6i6qy9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:19'),
(295, NULL, 'photo_upload', 'student_photo', 595, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_595_1758731288841_opcul7.jpg\",\"file_name\":\"nassim.jpg\",\"file_size\":3350549,\"student_id\":\"592\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:08'),
(296, NULL, 'student_update', 'student', 592, '{\"first_name\":\"NASSIM\",\"last_name\":\"ARAFAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_595_1758731288841_opcul7.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:09'),
(297, NULL, 'photo_upload', 'student_photo', 401, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_401_1758731351988_nwrxc1.jpg\",\"file_name\":\"rabiba.jpg\",\"file_size\":3247601,\"student_id\":\"400\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:29:12'),
(298, NULL, 'student_update', 'student', 400, '{\"first_name\":\"BABIRYE\",\"last_name\":\"HABIBA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_401_1758731351988_nwrxc1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:29:12'),
(299, NULL, 'student_update', 'student', 602, '{\"first_name\":\"ZULFA\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_605_1758726128818_gj61lj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:30:13'),
(300, NULL, 'student_update', 'student', 407, '{\"first_name\":\"NAMPALA\",\"last_name\":\"SHURAIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:36:33'),
(301, NULL, 'student_update', 'student', 605, '{\"first_name\":\"MADINAH\",\"last_name\":\"NAMUZUNGU\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":\"9\",\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 18:42:25'),
(302, NULL, 'student_update', 'student', 604, '{\"first_name\":\"NADIA\",\"last_name\":\"MASITULA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 18:45:01'),
(303, NULL, 'student_update', 'student', 396, '{\"first_name\":\"BALELE\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 14:54:45'),
(304, NULL, 'photo_upload', 'student_photo', 397, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_397_1758727876397_tw0366.jpg\",\"file_name\":\"balele.jpg\",\"file_size\":18339,\"student_id\":\"396\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:31:16'),
(305, NULL, 'student_update', 'student', 396, '{\"first_name\":\"BALELE\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_397_1758727876397_tw0366.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:31:18'),
(306, NULL, 'photo_upload', 'student_photo', 419, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_419_1758727912070_qcklx2.jpg\",\"file_name\":\"didi.jpg\",\"file_size\":18295,\"student_id\":\"418\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:31:52'),
(307, NULL, 'student_update', 'student', 418, '{\"first_name\":\"DIDI\",\"last_name\":\"HUSSEIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_419_1758727912070_qcklx2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:31:52'),
(308, NULL, 'photo_upload', 'student_photo', 435, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_435_1758727942005_685vki.jpg\",\"file_name\":\"IHLAM.jpg\",\"file_size\":18941,\"student_id\":\"434\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:32:22'),
(309, NULL, 'student_update', 'student', 434, '{\"first_name\":\"IHLAM\",\"last_name\":\"ISMAEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_435_1758727942005_685vki.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:32:23'),
(310, NULL, 'photo_upload', 'student_photo', 433, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_433_1758728017130_te9n67.jpg\",\"file_name\":\"asmah.jpg\",\"file_size\":15703,\"student_id\":\"432\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:33:37'),
(311, NULL, 'student_update', 'student', 432, '{\"first_name\":\"JALIRUDEEN\",\"last_name\":\"ASIMA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_433_1758728017130_te9n67.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:33:38'),
(312, NULL, 'student_update', 'student', 432, '{\"first_name\":\"JALIRUDEEN\",\"last_name\":\"ASIMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_433_1758728017130_te9n67.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:33:48'),
(313, NULL, 'photo_upload', 'student_photo', 430, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_430_1758728062770_kkt7f9.jpg\",\"file_name\":\"KISUYI.jpg\",\"file_size\":24267,\"student_id\":\"429\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:34:22'),
(314, NULL, 'student_update', 'student', 429, '{\"first_name\":\"KISUYI\",\"last_name\":\"ABDUL-RAHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_430_1758728062770_kkt7f9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:34:23'),
(315, NULL, 'photo_upload', 'student_photo', 414, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_414_1758728094383_ee780h.jpg\",\"file_name\":\"kyonjo.jpg\",\"file_size\":18752,\"student_id\":\"413\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:34:54'),
(316, NULL, 'student_update', 'student', 413, '{\"first_name\":\"KYONJO\",\"last_name\":\"MUSA\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_414_1758728094383_ee780h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:34:55'),
(317, NULL, 'photo_upload', 'student_photo', 442, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_442_1758728146413_batk16.jpg\",\"file_name\":\"magezi.jpg\",\"file_size\":18369,\"student_id\":\"441\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:35:46'),
(318, NULL, 'student_update', 'student', 441, '{\"first_name\":\"MAGEZI\",\"last_name\":\"SHAFIQ\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_442_1758728146413_batk16.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:35:47');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(319, NULL, 'student_update', 'student', 441, '{\"first_name\":\"MAGEZI\",\"last_name\":\"SHAFIQ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_442_1758728146413_batk16.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:35:58'),
(320, NULL, 'photo_upload', 'student_photo', 440, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_440_1758728187555_qbckvi.jpg\",\"file_name\":\"mastullah .jpg\",\"file_size\":14967,\"student_id\":\"439\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:36:27'),
(321, NULL, 'student_update', 'student', 439, '{\"first_name\":\"MASTULA\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_440_1758728187555_qbckvi.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:36:28'),
(322, NULL, 'photo_upload', 'student_photo', 395, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_395_1758728222058_7s7y1s.jpg\",\"file_name\":\"MUDATHIR.jpg\",\"file_size\":17621,\"student_id\":\"394\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:02'),
(323, NULL, 'student_update', 'student', 394, '{\"first_name\":\"MUDATHIR\",\"last_name\":\"IBRAHIM\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_395_1758728222058_7s7y1s.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:02'),
(324, NULL, 'student_update', 'student', 394, '{\"first_name\":\"MUDATHIR\",\"last_name\":\"IBRAHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_395_1758728222058_7s7y1s.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:14'),
(325, NULL, 'photo_upload', 'student_photo', 445, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_445_1758728256258_52im4v.jpg\",\"file_name\":\"matsad.jpg\",\"file_size\":18219,\"student_id\":\"444\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:36'),
(326, NULL, 'student_update', 'student', 444, '{\"first_name\":\"MATSAD\",\"last_name\":\"HAITHAM\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_445_1758728256258_52im4v.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:36'),
(327, NULL, 'student_update', 'student', 444, '{\"first_name\":\"MATSAD\",\"last_name\":\"HAITHAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_445_1758728256258_52im4v.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:37:48'),
(328, NULL, 'photo_upload', 'student_photo', 394, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_394_1758728289251_w9hyaw.jpg\",\"file_name\":\"isa muhamad.jpg\",\"file_size\":18483,\"student_id\":\"393\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:38:09'),
(329, NULL, 'student_update', 'student', 393, '{\"first_name\":\"MUHAMMAD\",\"last_name\":\"ISA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_394_1758728289251_w9hyaw.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:38:09'),
(330, NULL, 'photo_upload', 'student_photo', 453, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_453_1758728327641_zhi3hb.jpg\",\"file_name\":\"RASHID.jpg\",\"file_size\":24392,\"student_id\":\"452\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:38:47'),
(331, NULL, 'student_update', 'student', 452, '{\"first_name\":\"MUKISA\",\"last_name\":\"RASHID\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_453_1758728327641_zhi3hb.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:38:48'),
(332, NULL, 'student_update', 'student', 452, '{\"first_name\":\"MUKISA\",\"last_name\":\"RASHID\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_453_1758728327641_zhi3hb.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:38:59'),
(333, NULL, 'photo_upload', 'student_photo', 413, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_413_1758728378377_w3ikzn.jpg\",\"file_name\":\"mukose.jpg\",\"file_size\":18324,\"student_id\":\"412\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:39:38'),
(334, NULL, 'student_update', 'student', 412, '{\"first_name\":\"MUKOSE\",\"last_name\":\"AHMED\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_413_1758728378377_w3ikzn.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:39:39'),
(335, NULL, 'photo_upload', 'student_photo', 399, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_399_1758728417036_nxtcs5.jpg\",\"file_name\":\"mulondo.jpg\",\"file_size\":19983,\"student_id\":\"398\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:40:17'),
(336, NULL, 'student_update', 'student', 398, '{\"first_name\":\"MULONDO\",\"last_name\":\"ISHAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_399_1758728417036_nxtcs5.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:40:17'),
(337, NULL, 'photo_upload', 'student_photo', 407, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_407_1758728474681_dogbhi.jpg\",\"file_name\":\"NABIRYO F.jpg\",\"file_size\":3526213,\"student_id\":\"406\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:41:15'),
(338, NULL, 'student_update', 'student', 406, '{\"first_name\":\"NABIRYO\",\"last_name\":\"FAQIHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_407_1758728474681_dogbhi.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:41:15'),
(339, NULL, 'photo_upload', 'student_photo', 417, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_417_1758728543507_fhf8j1.jpg\",\"file_name\":\"sultana.jpg\",\"file_size\":14870,\"student_id\":\"416\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:42:23'),
(340, NULL, 'student_update', 'student', 416, '{\"first_name\":\"NAKIDOODO\",\"last_name\":\"SULTANA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_417_1758728543507_fhf8j1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:42:24'),
(341, NULL, 'photo_upload', 'student_photo', 437, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_437_1758728573423_rbb894.jpg\",\"file_name\":\"hanipha.jpg\",\"file_size\":19340,\"student_id\":\"436\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:42:53'),
(342, NULL, 'student_update', 'student', 436, '{\"first_name\":\"NAKIMBUGWE\",\"last_name\":\"HANIFA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_437_1758728573423_rbb894.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:42:54'),
(343, NULL, 'photo_upload', 'student_photo', 444, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_444_1758728611038_34vi3q.jpg\",\"file_name\":\"mariam nakinyanzi.jpg\",\"file_size\":17370,\"student_id\":\"443\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:43:31'),
(344, NULL, 'student_update', 'student', 443, '{\"first_name\":\"NAKINYANZI\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_444_1758728611038_34vi3q.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:43:32'),
(345, NULL, 'photo_upload', 'student_photo', 402, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_402_1758728642536_9l5mrt.jpg\",\"file_name\":\"shifrah nakiyemba.jpg\",\"file_size\":15694,\"student_id\":\"401\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:44:02'),
(346, NULL, 'student_update', 'student', 401, '{\"first_name\":\"NAKIYEMBA\",\"last_name\":\"SHIFRA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_402_1758728642536_9l5mrt.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:44:03'),
(347, NULL, 'photo_upload', 'student_photo', 436, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_436_1758728667004_tfu4ll.jpg\",\"file_name\":\"muntaha.jpg\",\"file_size\":15647,\"student_id\":\"435\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:44:27'),
(348, NULL, 'student_update', 'student', 435, '{\"first_name\":\"NAMATA\",\"last_name\":\"MUNTAHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_436_1758728667004_tfu4ll.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:44:28'),
(349, NULL, 'photo_upload', 'student_photo', 438, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_438_1758728700520_d5s9fk.jpg\",\"file_name\":\"nambogwe.jpg\",\"file_size\":16495,\"student_id\":\"437\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:45:00'),
(350, NULL, 'student_update', 'student', 437, '{\"first_name\":\"NAMBOGWE\",\"last_name\":\"AISHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_438_1758728700520_d5s9fk.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:45:01'),
(351, NULL, 'photo_upload', 'student_photo', 408, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_408_1758728733241_3janik.jpg\",\"file_name\":\"nampala.jpg\",\"file_size\":18322,\"student_id\":\"407\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:45:33'),
(352, NULL, 'student_update', 'student', 407, '{\"first_name\":\"NAMPALA\",\"last_name\":\"SHURAIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_408_1758728733241_3janik.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:45:34'),
(353, NULL, 'photo_upload', 'student_photo', 404, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_404_1758728760139_pwf9m0.jpg\",\"file_name\":\"shaha.jpg\",\"file_size\":15304,\"student_id\":\"403\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:00'),
(354, NULL, 'student_update', 'student', 403, '{\"first_name\":\"NAMUSUUBO\",\"last_name\":\"SHAHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_404_1758728760139_pwf9m0.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:01'),
(355, NULL, 'photo_upload', 'student_photo', 421, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_421_1758728778482_m9la4t.jpg\",\"file_name\":\"20250926_115421.jpg\",\"file_size\":19664,\"student_id\":\"420\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:18'),
(356, NULL, 'student_update', 'student', 420, '{\"first_name\":\"NANDEGHO\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_421_1758728778482_m9la4t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:19'),
(357, NULL, 'photo_upload', 'student_photo', 434, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_434_1758728809468_3w0zf5.jpg\",\"file_name\":\"zziwa.jpg\",\"file_size\":16057,\"student_id\":\"433\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:49'),
(358, NULL, 'student_update', 'student', 433, '{\"first_name\":\"RAUDHAH\",\"last_name\":\"ZZIWA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_434_1758728809468_3w0zf5.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:46:50'),
(359, NULL, 'photo_upload', 'student_photo', 431, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_431_1758728849148_afdzet.jpg\",\"file_name\":\"munfic.jpg\",\"file_size\":18711,\"student_id\":\"430\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:47:29'),
(360, NULL, 'student_update', 'student', 430, '{\"first_name\":\"SSENOGA\",\"last_name\":\"MUNFIQ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_431_1758728849148_afdzet.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:47:30'),
(361, NULL, 'photo_upload', 'student_photo', 400, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_400_1758728876072_z9dyuu.jpg\",\"file_name\":\"seif.jpg\",\"file_size\":18185,\"student_id\":\"399\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:47:56'),
(362, NULL, 'student_update', 'student', 399, '{\"first_name\":\"SULAIMAN\",\"last_name\":\"SAIF\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_400_1758728876072_z9dyuu.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:47:56'),
(363, NULL, 'photo_upload', 'student_photo', 427, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_427_1758728899350_zrxr60.jpg\",\"file_name\":\"TAGEJJA.jpg\",\"file_size\":18371,\"student_id\":\"426\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:48:19'),
(364, NULL, 'student_update', 'student', 426, '{\"first_name\":\"TAGEJJA\",\"last_name\":\"TAKIYYU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_427_1758728899350_zrxr60.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:48:20'),
(365, NULL, 'photo_upload', 'student_photo', 405, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_405_1758728933701_sxnfzq.jpg\",\"file_name\":\"rashida t.jpg\",\"file_size\":3347109,\"student_id\":\"404\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:48:54'),
(366, NULL, 'student_update', 'student', 404, '{\"first_name\":\"TIBWABYA\",\"last_name\":\"RASHIDAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_405_1758728933701_sxnfzq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:48:54'),
(367, NULL, 'photo_upload', 'student_photo', 448, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_448_1758728965886_qmajfy.jpg\",\"file_name\":\"ukasha rama.jpg\",\"file_size\":19143,\"student_id\":\"447\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:49:25'),
(368, NULL, 'student_update', 'student', 447, '{\"first_name\":\"UKASHA\",\"last_name\":\"RAMADHAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_448_1758728965886_qmajfy.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:49:26'),
(369, NULL, 'photo_upload', 'student_photo', 403, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_403_1758728992884_a0wytx.jpg\",\"file_name\":\"wavamuno.jpg\",\"file_size\":19897,\"student_id\":\"402\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:49:52'),
(370, NULL, 'student_update', 'student', 402, '{\"first_name\":\"WAVAMUNO\",\"last_name\":\"ATWIB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_403_1758728992884_a0wytx.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:49:54'),
(371, NULL, 'photo_upload', 'student_photo', 412, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_412_1758729023978_hdy4dd.jpg\",\"file_name\":\"zainab abdallah.jpg\",\"file_size\":16286,\"student_id\":\"411\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:50:24'),
(372, NULL, 'student_update', 'student', 411, '{\"first_name\":\"ZAINAB\",\"last_name\":\"ABDULLAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_412_1758729023978_hdy4dd.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 15:50:24'),
(373, NULL, 'photo_upload', 'student_photo', 508, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_508_1758732463726_svv7wf.jpg\",\"file_name\":\"Abdul kahal p.5.jpg\",\"file_size\":18496,\"student_id\":\"505\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:47:44'),
(374, NULL, 'student_update', 'student', 505, '{\"first_name\":\"ABDUL QAHARU\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_508_1758732463726_svv7wf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:47:45'),
(375, NULL, 'photo_upload', 'student_photo', 507, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_507_1758732502491_h5dpnu.jpg\",\"file_name\":\"Ayembe p.5.jpg\",\"file_size\":21062,\"student_id\":\"504\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:48:22'),
(376, NULL, 'student_update', 'student', 504, '{\"first_name\":\"ALIYYU\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_507_1758732502491_h5dpnu.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:48:23'),
(377, NULL, 'student_update', 'student', 504, '{\"first_name\":\"AYEMBE\",\"last_name\":\"YAHAYA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_507_1758732502491_h5dpnu.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:50:11'),
(378, NULL, 'photo_upload', 'student_photo', 584, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_584_1758732732227_5hei6l.jpg\",\"file_name\":\"Aliyu p.5.jpg\",\"file_size\":19505,\"student_id\":\"581\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:52:12'),
(379, NULL, 'student_update', 'student', 581, '{\"first_name\":\"ALIYYU\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_584_1758732732227_5hei6l.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:52:13'),
(380, NULL, 'photo_upload', 'student_photo', 511, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_511_1758732769284_7rryfj.jpg\",\"file_name\":\"Dhabuliwo Hashim.jpg\",\"file_size\":19889,\"student_id\":\"508\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:52:49'),
(381, NULL, 'student_update', 'student', 508, '{\"first_name\":\"DHABULIWO\",\"last_name\":\"HUSAMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_511_1758732769284_7rryfj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:52:50'),
(382, NULL, 'photo_upload', 'student_photo', 467, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_467_1758732805904_w4zzgo.jpg\",\"file_name\":\"Gasemba p.5.jpg\",\"file_size\":17500,\"student_id\":\"464\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:53:25'),
(383, NULL, 'student_update', 'student', 464, '{\"first_name\":\"GASEMBA\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_467_1758732805904_w4zzgo.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:53:26'),
(384, NULL, 'photo_upload', 'student_photo', 461, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_461_1758733170635_2tlwda.jpg\",\"file_name\":\"Nkoobe  p.5.jpg\",\"file_size\":19245,\"student_id\":\"460\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:59:30'),
(385, NULL, 'student_update', 'student', 460, '{\"first_name\":\"IDRIS\",\"last_name\":\"NKOOBE\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_461_1758733170635_2tlwda.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:59:31'),
(386, NULL, 'photo_upload', 'student_photo', 494, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_494_1758733207297_3dwro2.jpg\",\"file_name\":\"Isota p.5.jpg\",\"file_size\":19076,\"student_id\":\"491\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 17:00:07'),
(387, NULL, 'student_update', 'student', 491, '{\"first_name\":\"ISOTA\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_494_1758733207297_3dwro2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 17:00:08'),
(388, NULL, 'photo_upload', 'student_photo', 515, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_515_1758731249661_p3lmuc.jpg\",\"file_name\":\"Kakooza p.5.jpg\",\"file_size\":18028,\"student_id\":\"512\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:29'),
(389, NULL, 'student_update', 'student', 512, '{\"first_name\":\"KAKOOZA\",\"last_name\":\"ISMAEL\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_515_1758731249661_p3lmuc.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:31'),
(390, NULL, 'student_update', 'student', 512, '{\"first_name\":\"KAKOOZA\",\"last_name\":\"ISMAEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_515_1758731249661_p3lmuc.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:27:45'),
(391, NULL, 'photo_upload', 'student_photo', 516, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_516_1758731291516_wiiu2h.jpg\",\"file_name\":\"Kiyaga p.5.jpg\",\"file_size\":18181,\"student_id\":\"513\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:11'),
(392, NULL, 'student_update', 'student', 513, '{\"first_name\":\"KIYAGA\",\"last_name\":\"RAUF\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_516_1758731291516_wiiu2h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:12'),
(393, NULL, 'photo_upload', 'student_photo', 523, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_523_1758731324675_7scoio.jpg\",\"file_name\":\"kirya juma p5.jpg\",\"file_size\":17648,\"student_id\":\"520\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:44'),
(394, NULL, 'student_update', 'student', 520, '{\"first_name\":\"KIIRYA\",\"last_name\":\"JUMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_523_1758731324675_7scoio.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:28:45'),
(395, NULL, 'photo_upload', 'student_photo', 499, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_499_1758731387220_mkxd36.jpg\",\"file_name\":\"Ndyeku p.5.jpg\",\"file_size\":18559,\"student_id\":\"496\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:29:47'),
(396, NULL, 'student_update', 'student', 496, '{\"first_name\":\"NDYEKU\",\"last_name\":\"JABELI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_499_1758731387220_mkxd36.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:29:48'),
(397, NULL, 'photo_upload', 'student_photo', 502, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_502_1758731425454_cyq1c3.jpg\",\"file_name\":\"Nalo p.5.jpg\",\"file_size\":19286,\"student_id\":\"499\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:30:25'),
(398, NULL, 'student_update', 'student', 499, '{\"first_name\":\"NALO\",\"last_name\":\"IBRAHIIM   MUHAMMAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_502_1758731425454_cyq1c3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:30:26'),
(399, NULL, 'photo_upload', 'student_photo', 462, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_462_1758731470010_61ep9k.jpg\",\"file_name\":\"Muwaya p.5.jpg\",\"file_size\":22081,\"student_id\":\"461\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:31:10'),
(400, NULL, 'student_update', 'student', 461, '{\"first_name\":\"MUWAYA\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_462_1758731470010_61ep9k.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:31:10'),
(401, NULL, 'photo_upload', 'student_photo', 503, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_503_1758731511933_yd5wf9.jpg\",\"file_name\":\"Rabah p.5.jpg\",\"file_size\":3679350,\"student_id\":\"500\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:31:52'),
(402, NULL, 'student_update', 'student', 500, '{\"first_name\":\"RAYAN\",\"last_name\":\"ABDUL-KARIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_503_1758731511933_yd5wf9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:31:53'),
(403, NULL, 'photo_upload', 'student_photo', 559, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_559_1758731573123_0cot6h.jpg\",\"file_name\":\"Auza e p.6.jpg\",\"file_size\":17361,\"student_id\":\"556\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:32:53'),
(404, NULL, 'student_update', 'student', 556, '{\"first_name\":\"AUZAA-E\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_559_1758731573123_0cot6h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:32:54'),
(405, NULL, 'photo_upload', 'student_photo', 561, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_561_1758731602422_fhzzkg.jpg\",\"file_name\":\"Dhabuliwo shafik p.6.jpg\",\"file_size\":18424,\"student_id\":\"558\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:33:22'),
(406, NULL, 'student_update', 'student', 558, '{\"first_name\":\"DHABULIWO\",\"last_name\":\"SHAFIK\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_561_1758731602422_fhzzkg.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:33:23'),
(407, NULL, 'photo_upload', 'student_photo', 549, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_549_1758731634195_9fj6b4.jpg\",\"file_name\":\"Kyazze p.6.jpg\",\"file_size\":20202,\"student_id\":\"546\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:33:54'),
(408, NULL, 'student_update', 'student', 546, '{\"first_name\":\"KYAZZE\",\"last_name\":\"IBRAHIIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_549_1758731634195_9fj6b4.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:33:55'),
(409, NULL, 'photo_upload', 'student_photo', 556, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_556_1758731664411_fs7x4u.jpg\",\"file_name\":\"Maganda p.6.jpg\",\"file_size\":20382,\"student_id\":\"553\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:34:24'),
(410, NULL, 'student_update', 'student', 553, '{\"first_name\":\"MAGANDA\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_556_1758731664411_fs7x4u.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:34:25'),
(411, NULL, 'student_update', 'student', 553, '{\"first_name\":\"MAGANDA\",\"last_name\":\"MUSTAFA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_556_1758731664411_fs7x4u.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:34:53'),
(412, NULL, 'photo_upload', 'student_photo', 535, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_535_1758731742456_79xxix.jpg\",\"file_name\":\"Mateeka p.65.jpg\",\"file_size\":21164,\"student_id\":\"532\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:35:42'),
(413, NULL, 'student_update', 'student', 532, '{\"first_name\":\"MATEEKA\",\"last_name\":\"SHURAIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_535_1758731742456_79xxix.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:35:43'),
(414, NULL, 'photo_upload', 'student_photo', 560, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_560_1758731768509_fovq8g.jpg\",\"file_name\":\"Mayengo p.6.jpg\",\"file_size\":21374,\"student_id\":\"557\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:36:08'),
(415, NULL, 'student_update', 'student', 557, '{\"first_name\":\"MAYENGO\",\"last_name\":\"ABDUL-RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_560_1758731768509_fovq8g.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:36:09'),
(416, NULL, 'photo_upload', 'student_photo', 551, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_551_1758731801655_7gt65c.jpg\",\"file_name\":\"Mudoola p.6.jpg\",\"file_size\":21559,\"student_id\":\"548\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:36:41'),
(417, NULL, 'student_update', 'student', 548, '{\"first_name\":\"MUDOOLA\",\"last_name\":\"RAYAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_551_1758731801655_7gt65c.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:36:42'),
(418, NULL, 'photo_upload', 'student_photo', 545, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_545_1758731825079_pv5r51.jpg\",\"file_name\":\"Mukasa p.6.jpg\",\"file_size\":20970,\"student_id\":\"542\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:37:05'),
(419, NULL, 'student_update', 'student', 542, '{\"first_name\":\"MUKASA\",\"last_name\":\"ABDUL-RAZAK\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_545_1758731825079_pv5r51.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:37:05'),
(420, NULL, 'bulk_photo_upload', 'student_photo', 521, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_521_1758732105487_p4y284.jpg\",\"original_file_name\":\"20250928_112706[1].jpg\",\"original_file_size\":15646984,\"final_file_size\":15646984,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:41:45'),
(421, NULL, 'student_update', 'student', 518, '{\"first_name\":\"GOOBI\",\"last_name\":\"KHIDHIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_521_1758732105487_p4y284.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:42:28'),
(422, NULL, 'bulk_photo_upload', 'student_photo', 521, '{\"old_photo_url\":\"/uploads/students/person_521_1758732105487_p4y284.jpg\",\"new_photo_url\":\"/uploads/students/person_521_1758732612887_8hu1kt.jpg\",\"original_file_name\":\"20250928_112706[1].jpg\",\"original_file_size\":15646984,\"final_file_size\":15646984,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:50:12'),
(423, NULL, 'bulk_photo_upload', 'student_photo', 514, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_514_1758732616841_q0ndgh.jpg\",\"original_file_name\":\"20250928_104145[1].jpg\",\"original_file_size\":15787049,\"final_file_size\":15787049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:50:17'),
(424, NULL, 'bulk_photo_upload', 'student_photo', 496, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_496_1758732620843_8b1y54.jpg\",\"original_file_name\":\"20250928_104116[1].jpg\",\"original_file_size\":15687263,\"final_file_size\":15687263,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:50:21'),
(425, NULL, 'photo_upload', 'student_photo', 501, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_501_1758733005762_84l516.jpg\",\"file_name\":\"mahad p5.jpg\",\"file_size\":20914,\"student_id\":\"498\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:56:45'),
(426, NULL, 'student_update', 'student', 498, '{\"first_name\":\"KIRABIRA\",\"last_name\":\"MAHAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_501_1758733005762_84l516.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:56:46'),
(427, NULL, 'photo_upload', 'student_photo', 519, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_519_1758733046257_096q6q.jpg\",\"file_name\":\"Mondo p.5.jpg\",\"file_size\":18460,\"student_id\":\"516\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:57:26'),
(428, NULL, 'student_update', 'student', 516, '{\"first_name\":\"MONDO\",\"last_name\":\"SHAKUL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_519_1758733046257_096q6q.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 16:57:27'),
(429, NULL, 'photo_upload', 'student_photo', 509, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_509_1758741147587_roegoh.jpg\",\"file_name\":\"Musa p.5.jpg\",\"file_size\":22602,\"student_id\":\"506\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:12:27'),
(430, NULL, 'student_update', 'student', 506, '{\"first_name\":\"ABDUL-RAHMAN  MUSA\",\"last_name\":\"ISA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_509_1758741147587_roegoh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:12:29'),
(431, NULL, 'photo_upload', 'student_photo', 504, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_504_1758741628457_rrvjwv.jpg\",\"file_name\":\"Onanyango p.5.jpg\",\"file_size\":18009,\"student_id\":\"501\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:20:28');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(432, NULL, 'student_update', 'student', 501, '{\"first_name\":\"ONANYANGO\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_504_1758741628457_rrvjwv.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:20:29'),
(433, NULL, 'photo_upload', 'student_photo', 548, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_548_1758741776231_rxug6j.jpg\",\"file_name\":\"Kamya p.6.jpg\",\"file_size\":17759,\"student_id\":\"545\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:22:56'),
(434, NULL, 'student_update', 'student', 545, '{\"first_name\":\"KAMYA\",\"last_name\":\"HAMIS\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_548_1758741776231_rxug6j.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-24 19:22:57'),
(435, NULL, 'update_status', 'students', 606, '{\"status\":\"active\"}', NULL, NULL, '2025-09-24 23:53:37'),
(436, NULL, 'bulk_photo_upload', 'student_photo', 498, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_498_1758758857631_9li43s.jpg\",\"original_file_name\":\"NAMAKIKA.jpg\",\"original_file_size\":15429961,\"final_file_size\":15429961,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:07:37'),
(437, NULL, 'student_update', 'student', 495, '{\"first_name\":\"NAMAKIKA\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_498_1758758857631_9li43s.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:08:06'),
(438, NULL, 'bulk_photo_upload', 'student_photo', 498, '{\"old_photo_url\":\"/uploads/students/person_498_1758758857631_9li43s.jpg\",\"new_photo_url\":\"/uploads/students/person_498_1758759489593_ladpch.jpg\",\"original_file_name\":\"NAMAKIKA.jpg\",\"original_file_size\":15429961,\"final_file_size\":15429961,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:18:09'),
(439, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_506_1758759573507_2wlzem.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:19:33'),
(440, NULL, 'student_update', 'student', 2, '{\"first_name\":\"NAIRAH MUWAGA\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:20:24'),
(441, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758759573507_2wlzem.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758759684175_8bpdyr.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:21:24'),
(442, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_2_1758759687478_i0z2ec.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:21:27'),
(443, NULL, 'student_update', 'student', 507, '{\"first_name\":\"RAHMAH\",\"last_name\":\"JALIRUDIIN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:22:18'),
(444, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758759684175_8bpdyr.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758759794893_7pqp48.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:23:15'),
(445, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758759687478_i0z2ec.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758759797771_ray7ht.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:23:17'),
(446, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_510_1758759800450_fcodqd.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:23:20'),
(447, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758759794893_7pqp48.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758759868689_axwyxn.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:24:28'),
(448, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758759797771_ray7ht.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758759871494_i6l3ca.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:24:31'),
(449, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758759800450_fcodqd.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758759881382_imkzaa.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:24:41'),
(450, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_458_1758759884137_ycbn5t.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:24:44'),
(451, NULL, 'student_update', 'student', 457, '{\"first_name\":\"NAMWASE\",\"last_name\":\"SWALIHAT\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_458_1758759884137_ycbn5t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:25:01'),
(452, NULL, 'student_update', 'student', 507, '{\"first_name\":\"RAHMAH\",\"last_name\":\"JALIRUDIIN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_510_1758759881382_imkzaa.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:26:17'),
(453, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758759868689_axwyxn.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760077128_grkvh2.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:27:57'),
(454, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758759871494_i6l3ca.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760081956_cyjme3.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:28:02'),
(455, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758759881382_imkzaa.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760085227_hxiz8d.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:28:05'),
(456, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758759884137_ycbn5t.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760089103_vtf6p6.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:28:09'),
(457, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_476_1758760093805_t51etj.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:28:13'),
(458, NULL, 'student_update', 'student', 473, '{\"first_name\":\"NANKISANDA\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_476_1758760093805_t51etj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:28:32'),
(459, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760077128_grkvh2.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760185848_e1o883.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:29:45'),
(460, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760081956_cyjme3.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760189331_ie6vbd.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:29:49'),
(461, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760085227_hxiz8d.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760192360_l458b5.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:29:52'),
(462, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760089103_vtf6p6.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760195700_yavsbo.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:29:55'),
(463, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760093805_t51etj.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760198625_earina.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:29:58'),
(464, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_526_1758760201748_vy0qao.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:30:01'),
(465, NULL, 'student_update', 'student', 523, '{\"first_name\":\"FALUWA  BINT\",\"last_name\":\"YUSUF\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_526_1758760201748_vy0qao.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:30:16'),
(466, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760185848_e1o883.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760289049_8vvfgk.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:29'),
(467, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760189331_ie6vbd.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760292192_s7az8c.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:32'),
(468, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760192360_l458b5.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760295693_5n8l51.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:35'),
(469, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760195700_yavsbo.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760299017_o2y3z5.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:39'),
(470, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760198625_earina.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760303391_dl9diu.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:43'),
(471, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760201748_vy0qao.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760307576_o7x0oh.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:47'),
(472, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_480_1758760311630_6sfxwf.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:31:51'),
(473, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760289049_8vvfgk.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760424882_xu6xw8.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:33:45'),
(474, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760292192_s7az8c.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760428612_1tm4x5.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:33:48'),
(475, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760295693_5n8l51.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760432217_yybggb.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:33:52'),
(476, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760299017_o2y3z5.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760435870_2lcnuh.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:33:55'),
(477, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760303391_dl9diu.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760439657_wajwa2.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:33:59'),
(478, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760307576_o7x0oh.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760443568_wk3tog.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:34:03'),
(479, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758760311630_6sfxwf.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758760448184_c918y0.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:34:08'),
(480, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_482_1758760452865_sxuoe9.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:34:12'),
(481, NULL, 'student_update', 'student', 479, '{\"first_name\":\"TALKAZA\",\"last_name\":\"INAAYA  SALIM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_482_1758760452865_sxuoe9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:34:26'),
(482, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760424882_xu6xw8.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760578291_wjfjig.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:18'),
(483, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760428612_1tm4x5.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760582005_kpwm9t.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:22'),
(484, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760432217_yybggb.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760585787_3ifdqn.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:25'),
(485, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760435870_2lcnuh.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760589408_yu33j8.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:29'),
(486, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760439657_wajwa2.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760593058_gpfrmo.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:33'),
(487, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760443568_wk3tog.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760596537_bw5j56.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:36'),
(488, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758760448184_c918y0.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758760605399_0i92g5.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:45'),
(489, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758760452865_sxuoe9.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758760609441_5cm6o0.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:49'),
(490, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_520_1758760613350_we7oe3.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:36:53'),
(491, NULL, 'student_update', 'student', 517, '{\"first_name\":\"NANTEZA\",\"last_name\":\"SWABURA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_520_1758760613350_we7oe3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:37:14'),
(492, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760578291_wjfjig.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760706663_6lij2l.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:26'),
(493, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760582005_kpwm9t.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760710971_hbrstj.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:31'),
(494, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760585787_3ifdqn.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760714833_8u2wd1.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:34'),
(495, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760589408_yu33j8.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760719102_k1npss.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:39'),
(496, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760593058_gpfrmo.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760723032_l6774m.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:43'),
(497, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760596537_bw5j56.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760727118_9ihphl.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:47'),
(498, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758760605399_0i92g5.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758760730946_v2qkrd.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:51'),
(499, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758760609441_5cm6o0.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758760734652_v55gly.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:38:54'),
(500, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":\"/uploads/students/person_520_1758760613350_we7oe3.jpg\",\"new_photo_url\":\"/uploads/students/person_520_1758760742993_2p74so.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:39:03'),
(501, NULL, 'bulk_photo_upload', 'student_photo', 586, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_586_1758760748169_9tgs5i.jpg\",\"original_file_name\":\"20250929_105300[1].jpg\",\"original_file_size\":15025621,\"final_file_size\":15025621,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:39:08'),
(502, NULL, 'student_update', 'student', 583, '{\"first_name\":\"NUHA\",\"last_name\":\"BASEF\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_586_1758760748169_9tgs5i.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:39:25'),
(503, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760706663_6lij2l.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760839327_320ctl.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:40:39'),
(504, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760710971_hbrstj.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760844671_v6si12.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:40:44'),
(505, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760714833_8u2wd1.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760850126_pcdjvb.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:40:50'),
(506, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760719102_k1npss.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760855513_5l555f.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:40:55'),
(507, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760723032_l6774m.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760860695_7517w7.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:00'),
(508, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760727118_9ihphl.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760867986_40bn1d.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:08'),
(509, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758760730946_v2qkrd.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758760874030_l1wafc.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:14'),
(510, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758760734652_v55gly.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758760879612_j20ylo.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:19'),
(511, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":\"/uploads/students/person_520_1758760742993_2p74so.jpg\",\"new_photo_url\":\"/uploads/students/person_520_1758760885388_t2rjri.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:25'),
(512, NULL, 'bulk_photo_upload', 'student_photo', 586, '{\"old_photo_url\":\"/uploads/students/person_586_1758760748169_9tgs5i.jpg\",\"new_photo_url\":\"/uploads/students/person_586_1758760891135_4r90sx.jpg\",\"original_file_name\":\"20250929_105300[1].jpg\",\"original_file_size\":15025621,\"final_file_size\":15025621,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:31'),
(513, NULL, 'bulk_photo_upload', 'student_photo', 608, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_608_1758760896712_tigxao.jpg\",\"original_file_name\":\"20250929_105319[1].jpg\",\"original_file_size\":15638104,\"final_file_size\":15638104,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:36'),
(514, NULL, 'student_update', 'student', 605, '{\"first_name\":\"MADINAH\",\"last_name\":\"NAMUZUNGU\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_608_1758760896712_tigxao.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:41:47'),
(515, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760839327_320ctl.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758760968653_f95ayj.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:42:48'),
(516, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760844671_v6si12.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758760974377_fknixc.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:42:54'),
(517, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760850126_pcdjvb.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758760979644_575vvq.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:42:59'),
(518, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760855513_5l555f.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758760985075_hbygeq.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:05'),
(519, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760860695_7517w7.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758760990836_ipcwgt.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:11'),
(520, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760867986_40bn1d.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758760996292_4lcc34.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:16'),
(521, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758760874030_l1wafc.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758761001152_5ohdlh.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:21'),
(522, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758760879612_j20ylo.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758761005587_ewxrf8.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:25'),
(523, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":\"/uploads/students/person_520_1758760885388_t2rjri.jpg\",\"new_photo_url\":\"/uploads/students/person_520_1758761010037_izvy1z.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:30'),
(524, NULL, 'bulk_photo_upload', 'student_photo', 586, '{\"old_photo_url\":\"/uploads/students/person_586_1758760891135_4r90sx.jpg\",\"new_photo_url\":\"/uploads/students/person_586_1758761014199_ec8jkm.jpg\",\"original_file_name\":\"20250929_105300[1].jpg\",\"original_file_size\":15025621,\"final_file_size\":15025621,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:34'),
(525, NULL, 'bulk_photo_upload', 'student_photo', 608, '{\"old_photo_url\":\"/uploads/students/person_608_1758760896712_tigxao.jpg\",\"new_photo_url\":\"/uploads/students/person_608_1758761019686_pgys8b.jpg\",\"original_file_name\":\"20250929_105319[1].jpg\",\"original_file_size\":15638104,\"final_file_size\":15638104,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:40'),
(526, NULL, 'bulk_photo_upload', 'student_photo', 493, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_493_1758761026076_j848ov.jpg\",\"original_file_name\":\"20250929_105338[1].jpg\",\"original_file_size\":15685243,\"final_file_size\":15685243,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:43:46'),
(527, NULL, 'student_update', 'student', 490, '{\"first_name\":\"NTONGO\",\"last_name\":\"MARIAM  ABDALLAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_493_1758761026076_j848ov.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:44:03'),
(528, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758760968653_f95ayj.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758761135654_vssxfo.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:45:35'),
(529, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758760974377_fknixc.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758761142233_nxsmp7.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:45:42'),
(530, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758760979644_575vvq.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758761148044_2oq9zy.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:45:48'),
(531, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758760985075_hbygeq.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758761154297_zp8hhq.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:45:54'),
(532, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758760990836_ipcwgt.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758761160651_8hsukp.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:00'),
(533, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758760996292_4lcc34.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758761166877_uj3p8l.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:06');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(534, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758761001152_5ohdlh.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758761173250_1rknvn.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:13'),
(535, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758761005587_ewxrf8.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758761180022_3tqvwk.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:20'),
(536, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":\"/uploads/students/person_520_1758761010037_izvy1z.jpg\",\"new_photo_url\":\"/uploads/students/person_520_1758761186453_qzcwb0.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:26'),
(537, NULL, 'bulk_photo_upload', 'student_photo', 586, '{\"old_photo_url\":\"/uploads/students/person_586_1758761014199_ec8jkm.jpg\",\"new_photo_url\":\"/uploads/students/person_586_1758761192623_k06ppy.jpg\",\"original_file_name\":\"20250929_105300[1].jpg\",\"original_file_size\":15025621,\"final_file_size\":15025621,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:32'),
(538, NULL, 'bulk_photo_upload', 'student_photo', 608, '{\"old_photo_url\":\"/uploads/students/person_608_1758761019686_pgys8b.jpg\",\"new_photo_url\":\"/uploads/students/person_608_1758761199083_h270a9.jpg\",\"original_file_name\":\"20250929_105319[1].jpg\",\"original_file_size\":15638104,\"final_file_size\":15638104,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:39'),
(539, NULL, 'bulk_photo_upload', 'student_photo', 493, '{\"old_photo_url\":\"/uploads/students/person_493_1758761026076_j848ov.jpg\",\"new_photo_url\":\"/uploads/students/person_493_1758761205109_maaf0v.jpg\",\"original_file_name\":\"20250929_105338[1].jpg\",\"original_file_size\":15685243,\"final_file_size\":15685243,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:45'),
(540, NULL, 'bulk_photo_upload', 'student_photo', 518, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_518_1758761212382_wuf95k.jpg\",\"original_file_name\":\"20250929_105445[1].jpg\",\"original_file_size\":15261392,\"final_file_size\":15261392,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:46:52'),
(541, NULL, 'student_update', 'student', 515, '{\"first_name\":\"TUSIIME\",\"last_name\":\"ZAINAB\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_518_1758761212382_wuf95k.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:47:07'),
(542, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758761135654_vssxfo.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758761327381_774tuk.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:48:47'),
(543, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758761142233_nxsmp7.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758761333690_hetv7m.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:48:53'),
(544, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758761148044_2oq9zy.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758761340370_fi8b07.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:00'),
(545, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758761154297_zp8hhq.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758761346675_as77tg.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:06'),
(546, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758761160651_8hsukp.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758761353350_vtc85s.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:13'),
(547, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758761166877_uj3p8l.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758761359703_u1nr6g.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:19'),
(548, NULL, 'bulk_photo_upload', 'student_photo', 480, '{\"old_photo_url\":\"/uploads/students/person_480_1758761173250_1rknvn.jpg\",\"new_photo_url\":\"/uploads/students/person_480_1758761365667_r6lpj5.jpg\",\"original_file_name\":\"20250929_105143[1].jpg\",\"original_file_size\":14952248,\"final_file_size\":14952248,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:25'),
(549, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758761180022_3tqvwk.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758761372836_sup2e0.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:32'),
(550, NULL, 'bulk_photo_upload', 'student_photo', 520, '{\"old_photo_url\":\"/uploads/students/person_520_1758761186453_qzcwb0.jpg\",\"new_photo_url\":\"/uploads/students/person_520_1758761379298_gb7nge.jpg\",\"original_file_name\":\"20250929_105250[1].jpg\",\"original_file_size\":15253519,\"final_file_size\":15253519,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:39'),
(551, NULL, 'bulk_photo_upload', 'student_photo', 586, '{\"old_photo_url\":\"/uploads/students/person_586_1758761192623_k06ppy.jpg\",\"new_photo_url\":\"/uploads/students/person_586_1758761385512_pfaoku.jpg\",\"original_file_name\":\"20250929_105300[1].jpg\",\"original_file_size\":15025621,\"final_file_size\":15025621,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:45'),
(552, NULL, 'bulk_photo_upload', 'student_photo', 608, '{\"old_photo_url\":\"/uploads/students/person_608_1758761199083_h270a9.jpg\",\"new_photo_url\":\"/uploads/students/person_608_1758761392244_90h52m.jpg\",\"original_file_name\":\"20250929_105319[1].jpg\",\"original_file_size\":15638104,\"final_file_size\":15638104,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:52'),
(553, NULL, 'bulk_photo_upload', 'student_photo', 493, '{\"old_photo_url\":\"/uploads/students/person_493_1758761205109_maaf0v.jpg\",\"new_photo_url\":\"/uploads/students/person_493_1758761398276_a8jk25.jpg\",\"original_file_name\":\"20250929_105338[1].jpg\",\"original_file_size\":15685243,\"final_file_size\":15685243,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:49:58'),
(554, NULL, 'bulk_photo_upload', 'student_photo', 518, '{\"old_photo_url\":\"/uploads/students/person_518_1758761212382_wuf95k.jpg\",\"new_photo_url\":\"/uploads/students/person_518_1758761406755_ia2ay1.jpg\",\"original_file_name\":\"20250929_105445[1].jpg\",\"original_file_size\":15261392,\"final_file_size\":15261392,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:50:07'),
(555, NULL, 'bulk_photo_upload', 'student_photo', 475, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_475_1758761413435_nfq6fm.jpg\",\"original_file_name\":\"20250929_105506[1].jpg\",\"original_file_size\":14922989,\"final_file_size\":14922989,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:50:13'),
(556, NULL, 'student_update', 'student', 472, '{\"first_name\":\"MUTESI\",\"last_name\":\"RANIA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_475_1758761413435_nfq6fm.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:51:36'),
(557, NULL, 'bulk_photo_upload', 'student_photo', 506, '{\"old_photo_url\":\"/uploads/students/person_506_1758761327381_774tuk.jpg\",\"new_photo_url\":\"/uploads/students/person_506_1758761584068_xzn2q8.jpg\",\"original_file_name\":\"20250929_104905[1].jpg\",\"original_file_size\":15406049,\"final_file_size\":15406049,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:04'),
(558, NULL, 'bulk_photo_upload', 'student_photo', 2, '{\"old_photo_url\":\"/uploads/students/person_2_1758761333690_hetv7m.jpg\",\"new_photo_url\":\"/uploads/students/person_2_1758761591183_qo3w1r.jpg\",\"original_file_name\":\"20250929_104923[2].jpg\",\"original_file_size\":16260546,\"final_file_size\":16260546,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:11'),
(559, NULL, 'bulk_photo_upload', 'student_photo', 510, '{\"old_photo_url\":\"/uploads/students/person_510_1758761340370_fi8b07.jpg\",\"new_photo_url\":\"/uploads/students/person_510_1758761598084_t51za4.jpg\",\"original_file_name\":\"20250929_104939[1].jpg\",\"original_file_size\":15293929,\"final_file_size\":15293929,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:18'),
(560, NULL, 'bulk_photo_upload', 'student_photo', 458, '{\"old_photo_url\":\"/uploads/students/person_458_1758761346675_as77tg.jpg\",\"new_photo_url\":\"/uploads/students/person_458_1758761605393_dbrw7q.jpg\",\"original_file_name\":\"20250929_105003[1].jpg\",\"original_file_size\":16391970,\"final_file_size\":16391970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:25'),
(561, NULL, 'bulk_photo_upload', 'student_photo', 476, '{\"old_photo_url\":\"/uploads/students/person_476_1758761353350_vtc85s.jpg\",\"new_photo_url\":\"/uploads/students/person_476_1758761611828_gicsyk.jpg\",\"original_file_name\":\"20250929_105021[1].jpg\",\"original_file_size\":15123798,\"final_file_size\":15123798,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:31'),
(562, NULL, 'bulk_photo_upload', 'student_photo', 526, '{\"old_photo_url\":\"/uploads/students/person_526_1758761359703_u1nr6g.jpg\",\"new_photo_url\":\"/uploads/students/person_526_1758761619332_wxa6fe.jpg\",\"original_file_name\":\"20250929_105055[1].jpg\",\"original_file_size\":15520099,\"final_file_size\":15520099,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:39'),
(563, NULL, 'bulk_photo_upload', 'student_photo', 482, '{\"old_photo_url\":\"/uploads/students/person_482_1758761372836_sup2e0.jpg\",\"new_photo_url\":\"/uploads/students/person_482_1758761635334_yalw1e.jpg\",\"original_file_name\":\"20250929_105158[1].jpg\",\"original_file_size\":16563963,\"final_file_size\":16563963,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:53:55'),
(564, NULL, 'bulk_photo_upload', 'student_photo', 518, '{\"old_photo_url\":\"/uploads/students/person_518_1758761406755_ia2ay1.jpg\",\"new_photo_url\":\"/uploads/students/person_518_1758761749320_a8pbg7.jpg\",\"original_file_name\":\"20250929_105445[1].jpg\",\"original_file_size\":15261392,\"final_file_size\":15261392,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:55:50'),
(565, NULL, 'bulk_photo_upload', 'student_photo', 475, '{\"old_photo_url\":\"/uploads/students/person_475_1758761413435_nfq6fm.jpg\",\"new_photo_url\":\"/uploads/students/person_475_1758761798872_011r2l.jpg\",\"original_file_name\":\"20250929_105506[1].jpg\",\"original_file_size\":14922989,\"final_file_size\":14922989,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:56:38'),
(566, NULL, 'bulk_photo_upload', 'student_photo', 490, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_490_1758761804422_0wr3zg.jpg\",\"original_file_name\":\"20250929_110153[1].jpg\",\"original_file_size\":15419286,\"final_file_size\":15419286,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:56:44'),
(567, NULL, 'bulk_photo_upload', 'student_photo', 609, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_609_1758761946820_dkrhvs.jpg\",\"original_file_name\":\"20250929_105520[1].jpg\",\"original_file_size\":16536371,\"final_file_size\":16536371,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:59:07'),
(568, NULL, 'student_update', 'student', 606, '{\"first_name\":\"NANJIYA\",\"last_name\":\"TAUBAH TAIBU\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_609_1758761946820_dkrhvs.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 00:59:21'),
(569, NULL, 'bulk_photo_upload', 'student_photo', 490, '{\"old_photo_url\":\"/uploads/students/person_490_1758761804422_0wr3zg.jpg\",\"new_photo_url\":\"/uploads/students/person_490_1758762107113_co56il.jpg\",\"original_file_name\":\"20250929_110153[2].jpg\",\"original_file_size\":15419286,\"final_file_size\":15419286,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:01:47'),
(570, NULL, 'student_update', 'student', 487, '{\"first_name\":\"NINSIIMA\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_490_1758761804422_0wr3zg.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:01:57'),
(571, NULL, 'bulk_photo_upload', 'student_photo', 512, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_512_1758762229464_lolkem.jpg\",\"original_file_name\":\"20250929_110614[1].jpg\",\"original_file_size\":15553009,\"final_file_size\":15553009,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:03:58'),
(572, NULL, 'student_update', 'student', 509, '{\"first_name\":\"BASHIIRAH\",\"last_name\":\"UTHMAN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_512_1758762229464_lolkem.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:04:22'),
(573, NULL, 'bulk_photo_upload', 'student_photo', 517, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_517_1758762379306_v146cf.jpg\",\"original_file_name\":\"20250929_110700[1].jpg\",\"original_file_size\":16221879,\"final_file_size\":16221879,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:06:19'),
(574, NULL, 'student_update', 'student', 514, '{\"first_name\":\"MPATA\",\"last_name\":\"IDRISS\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_517_1758762379306_v146cf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:06:33'),
(575, NULL, 'student_update', 'student', 579, '{\"first_name\":\"KIBUDE\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:07:04'),
(576, NULL, 'bulk_photo_upload', 'student_photo', 582, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_582_1758762506016_ne6ugh.jpg\",\"original_file_name\":\"20250927_112112[1].jpg\",\"original_file_size\":15851127,\"final_file_size\":15851127,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:08:26'),
(577, NULL, 'student_update', 'student', 579, '{\"first_name\":\"KIBUDE\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_582_1758762506016_ne6ugh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 01:08:40'),
(578, NULL, 'update_status', 'students', 484, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-25 01:12:57'),
(579, NULL, 'update_status', 'students', 497, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-25 01:13:52'),
(580, NULL, 'bulk_photo_upload', 'student_photo', 571, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_571_1758769792258_lk6lxh.jpg\",\"original_file_name\":\"ABASI JUMA.jpg\",\"original_file_size\":15233860,\"final_file_size\":15233860,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:09:52'),
(581, NULL, 'bulk_photo_upload', 'student_photo', 538, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_538_1758769802019_ezlra1.jpg\",\"original_file_name\":\"AFEEFA.jpg\",\"original_file_size\":15200408,\"final_file_size\":15200408,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:10:02'),
(582, NULL, 'bulk_photo_upload', 'student_photo', 529, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_529_1758769810394_xw5z4h.jpg\",\"original_file_name\":\"HUDA MUBARAK.jpg\",\"original_file_size\":15009818,\"final_file_size\":15009818,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:10:10'),
(583, NULL, 'bulk_photo_upload', 'student_photo', 539, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_539_1758769819353_9ru650.jpg\",\"original_file_name\":\"KAZIBA.jpg\",\"original_file_size\":15753860,\"final_file_size\":15753860,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:10:19'),
(584, NULL, 'bulk_photo_upload', 'student_photo', 550, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_550_1758769827895_8fwrpt.jpg\",\"original_file_name\":\"HAJARAH.jpg\",\"original_file_size\":14470897,\"final_file_size\":14470897,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:10:28'),
(585, NULL, 'bulk_photo_upload', 'student_photo', 541, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_541_1758769837301_6pd3b2.jpg\",\"original_file_name\":\"MUTESI SUMAYYA.jpg\",\"original_file_size\":15179742,\"final_file_size\":15179742,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:10:37'),
(586, NULL, 'bulk_photo_upload', 'student_photo', 570, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_570_1758770132691_z8ydtl.jpg\",\"original_file_name\":\"MUYINDA.jpg\",\"original_file_size\":17797064,\"final_file_size\":17797064,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:15:33'),
(587, NULL, 'bulk_photo_upload', 'student_photo', 533, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_533_1758770144581_mr80w3.jpg\",\"original_file_name\":\"NAHYA.jpg\",\"original_file_size\":14687679,\"final_file_size\":14687679,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:15:44'),
(588, NULL, 'bulk_photo_upload', 'student_photo', 569, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_569_1758770155443_9xiicb.jpg\",\"original_file_name\":\"NABUNYA.jpg\",\"original_file_size\":16091203,\"final_file_size\":16091203,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:15:56'),
(589, NULL, 'bulk_photo_upload', 'student_photo', 607, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_607_1758770165452_nvwmah.jpg\",\"original_file_name\":\"NADIA.jpg\",\"original_file_size\":15503575,\"final_file_size\":15503575,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:16:05'),
(590, NULL, 'bulk_photo_upload', 'student_photo', 562, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_562_1758770176209_ssy26y.jpg\",\"original_file_name\":\"MWASIT.jpg\",\"original_file_size\":15459154,\"final_file_size\":15459154,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:16:16'),
(591, NULL, 'bulk_photo_upload', 'student_photo', 553, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_553_1758770188043_70r6os.jpg\",\"original_file_name\":\"SHIFRAH.jpg\",\"original_file_size\":15694831,\"final_file_size\":15694831,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:16:28'),
(592, NULL, 'bulk_photo_upload', 'student_photo', 568, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_568_1758770198777_gegdfk.jpg\",\"original_file_name\":\"JAUHARA.jpg\",\"original_file_size\":15962196,\"final_file_size\":15962196,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:16:39'),
(593, NULL, 'bulk_photo_upload', 'student_photo', 528, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_528_1758770524799_heg62u.jpg\",\"original_file_name\":\"NAKISUYI ASMAH.jpg\",\"original_file_size\":14520819,\"final_file_size\":14520819,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:22:04'),
(594, NULL, 'bulk_photo_upload', 'student_photo', 530, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_530_1758770537911_a0rnsc.jpg\",\"original_file_name\":\"NAKUNGU M.jpg\",\"original_file_size\":14944388,\"final_file_size\":14944388,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:22:18'),
(595, NULL, 'bulk_photo_upload', 'student_photo', 527, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_527_1758770547636_8o9p2h.jpg\",\"original_file_name\":\"SHAFIKA.jpg\",\"original_file_size\":15084668,\"final_file_size\":15084668,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:22:28'),
(596, NULL, 'bulk_photo_upload', 'student_photo', 552, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_552_1758770561134_z2zks2.jpg\",\"original_file_name\":\"NSUBUGA.jpg\",\"original_file_size\":15284987,\"final_file_size\":15284987,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:22:41'),
(597, NULL, 'bulk_photo_upload', 'student_photo', 532, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_532_1758770572139_jmv8zt.jpg\",\"original_file_name\":\"FARIDAH.jpg\",\"original_file_size\":15168084,\"final_file_size\":15168084,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:22:52'),
(598, NULL, 'bulk_photo_upload', 'student_photo', 537, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_537_1758770586656_0p0m43.jpg\",\"original_file_name\":\"SHAINAH.jpg\",\"original_file_size\":15906802,\"final_file_size\":15906802,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:23:06'),
(599, NULL, 'bulk_photo_upload', 'student_photo', 563, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_563_1758770598618_mf3xzj.jpg\",\"original_file_name\":\"ZIYANNAH.jpg\",\"original_file_size\":15769702,\"final_file_size\":15769702,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:23:19'),
(600, NULL, 'bulk_photo_upload', 'student_photo', 554, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_554_1758770611536_yewckh.jpg\",\"original_file_name\":\"KANTONO.jpg\",\"original_file_size\":15259694,\"final_file_size\":15259694,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:23:31'),
(601, NULL, 'update_status', 'students', 544, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-25 03:24:41'),
(602, NULL, 'bulk_photo_upload', 'student_photo', 566, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_566_1758770830564_2voimi.jpg\",\"original_file_name\":\"MUTESI SOPHIE.jpg\",\"original_file_size\":15160805,\"final_file_size\":15160805,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:27:10'),
(603, NULL, 'update_status', 'students', 552, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-25 03:31:30'),
(604, NULL, 'student_update', 'student', 568, '{\"first_name\":\"ABAS\",\"last_name\":\"JUMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_571_1758769792258_lk6lxh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:43:47'),
(605, NULL, 'student_update', 'student', 535, '{\"first_name\":\"AFEEFAH\",\"last_name\":\"MUSASIZI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_538_1758769802019_ezlra1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:44:02'),
(606, NULL, 'student_update', 'student', 564, '{\"first_name\":\"ASMAH\",\"last_name\":\"NANTONGO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:44:15'),
(607, NULL, 'student_update', 'student', 526, '{\"first_name\":\"HUDA\",\"last_name\":\"MUBARAK\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_529_1758769810394_xw5z4h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:44:41'),
(608, NULL, 'student_update', 'student', 536, '{\"first_name\":\"KAZIBA\",\"last_name\":\"ABDUL-RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_539_1758769819353_9ru650.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:46:06'),
(609, NULL, 'bulk_photo_upload', 'student_photo', 545, '{\"old_photo_url\":\"/uploads/students/person_545_1758731825079_pv5r51.jpg\",\"new_photo_url\":\"/uploads/students/person_545_1758772080216_0yuavx.jpg\",\"original_file_name\":\"MUKASA ABDUL RAZAK.jpg\",\"original_file_size\":16076565,\"final_file_size\":16076565,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:48:00'),
(610, NULL, 'student_update', 'student', 542, '{\"first_name\":\"MUKASA\",\"last_name\":\"ABDUL-RAZAK\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_545_1758772080216_0yuavx.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:48:23'),
(611, NULL, 'student_update', 'student', 547, '{\"first_name\":\"MUNABA\",\"last_name\":\"HAJARA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_550_1758769827895_8fwrpt.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:49:07'),
(612, NULL, 'student_update', 'student', 538, '{\"first_name\":\"MUTESI\",\"last_name\":\"SUMAYA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_541_1758769837301_6pd3b2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:49:23'),
(613, NULL, 'student_update', 'student', 567, '{\"first_name\":\"MUYINDA\",\"last_name\":\"BADRDEEN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_570_1758770132691_z8ydtl.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:49:39'),
(614, NULL, 'student_update', 'student', 530, '{\"first_name\":\"NABULUBA\",\"last_name\":\"NAHIA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_533_1758770144581_mr80w3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:49:51'),
(615, NULL, 'student_update', 'student', 566, '{\"first_name\":\"NABUNYA\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_569_1758770155443_9xiicb.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:50:02'),
(616, NULL, 'student_update', 'student', 604, '{\"first_name\":\"NADIA\",\"last_name\":\"MASITULA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_607_1758770165452_nvwmah.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:50:15'),
(617, NULL, 'student_update', 'student', 525, '{\"first_name\":\"NAKISUUYI\",\"last_name\":\"ASMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_528_1758770524799_heg62u.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:50:31'),
(618, NULL, 'student_update', 'student', 527, '{\"first_name\":\"NAKUNGU\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_530_1758770537911_a0rnsc.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:50:43'),
(619, NULL, 'student_update', 'student', 559, '{\"first_name\":\"NAMATENDE\",\"last_name\":\"MWASIT\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_562_1758770176209_ssy26y.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:51:08'),
(620, NULL, 'student_update', 'student', 550, '{\"first_name\":\"NAMBALILWA\",\"last_name\":\"SHIFRAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_553_1758770188043_70r6os.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:51:20'),
(621, NULL, 'student_update', 'student', 565, '{\"first_name\":\"NAMUGABWE\",\"last_name\":\"JAUHARAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_568_1758770198777_gegdfk.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:51:34'),
(622, NULL, 'student_update', 'student', 524, '{\"first_name\":\"NANGOBI\",\"last_name\":\"SHAFKA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_527_1758770547636_8o9p2h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:51:51'),
(623, NULL, 'student_update', 'student', 549, '{\"first_name\":\"NSUBUGA\",\"last_name\":\"ARAFAT\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_552_1758770561134_z2zks2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:52:03'),
(624, NULL, 'student_update', 'student', 529, '{\"first_name\":\"SABANO\",\"last_name\":\"FARIIDA  MODONDO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_532_1758770572139_jmv8zt.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:52:17'),
(625, NULL, 'student_update', 'student', 534, '{\"first_name\":\"SHAINAH\",\"last_name\":\"MUSASIZI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_537_1758770586656_0p0m43.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:52:30'),
(626, NULL, 'student_update', 'student', 563, '{\"first_name\":\"SOPHIA\",\"last_name\":\"MUTESI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_566_1758770830564_2voimi.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:52:43'),
(627, NULL, 'student_update', 'student', 551, '{\"first_name\":\"UMMUSLAIM\",\"last_name\":\"KANTONO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_554_1758770611536_yewckh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:53:07'),
(628, NULL, 'student_update', 'student', 560, '{\"first_name\":\"ZIYANA\",\"last_name\":\"BINT  RAMADHAN  WANYANZE\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_563_1758770598618_mf3xzj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:53:19'),
(629, NULL, 'bulk_photo_upload', 'student_photo', 542, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_542_1758772787463_0rnxfs.jpg\",\"original_file_name\":\"20250929_144558[1].jpg\",\"original_file_size\":15553069,\"final_file_size\":15553069,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 03:59:47'),
(630, NULL, 'bulk_photo_upload', 'student_photo', 564, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_564_1758773006574_32xwtw.jpg\",\"original_file_name\":\"20250927_125350[1].jpg\",\"original_file_size\":15971975,\"final_file_size\":15971975,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:03:27'),
(631, NULL, 'bulk_photo_upload', 'student_photo', 557, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_557_1758773012973_x641gf.jpg\",\"original_file_name\":\"20250927_125253[1].jpg\",\"original_file_size\":16113848,\"final_file_size\":16113848,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:03:33'),
(632, NULL, 'bulk_photo_upload', 'student_photo', 565, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_565_1758773207378_0mp31t.jpg\",\"original_file_name\":\"20250929_144547[1].jpg\",\"original_file_size\":15732536,\"final_file_size\":15732536,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:06:47'),
(633, NULL, 'student_update', 'student', 554, '{\"first_name\":\"UTHMAN\",\"last_name\":\"MUKASA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_557_1758773012973_x641gf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:07:03'),
(634, NULL, 'student_update', 'student', 561, '{\"first_name\":\"SSENYOJO\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_564_1758773006574_32xwtw.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:07:24'),
(635, NULL, 'student_update', 'student', 562, '{\"first_name\":\"NTAMBI\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_565_1758773207378_0mp31t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:07:55'),
(636, NULL, 'student_update', 'student', 539, '{\"first_name\":\"ABDUL-HAIL\",\"last_name\":\"MUKUYE\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_542_1758772787463_0rnxfs.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:10:27'),
(637, NULL, 'student_update', 'student', 531, '{\"first_name\":\"ABDUL-KARIIM\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:10:52'),
(638, NULL, 'bulk_photo_upload', 'student_photo', 534, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_534_1758774573205_ivuwv7.jpg\",\"original_file_name\":\"20250927_125433[1].jpg\",\"original_file_size\":16799240,\"final_file_size\":16799240,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:29:33'),
(639, NULL, 'student_update', 'student', 531, '{\"first_name\":\"ABDUL-KARIIM\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_534_1758774573205_ivuwv7.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:29:51'),
(640, NULL, 'student_update', 'student', 528, '{\"first_name\":\"GULUME\",\"last_name\":\"HAMZAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:30:28'),
(641, NULL, 'student_update', 'student', 567, '{\"first_name\":\"MUYINDA\",\"last_name\":\"BADRDEEN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_570_1758770132691_z8ydtl.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 04:32:10');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(642, NULL, 'student_update', 'student', 66, '{\"first_name\":\"AALYAH\",\"last_name\":\"HAMZA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":2,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_66_1758700914116_a9bloc.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-25 05:02:42'),
(643, NULL, 'bulk_photo_upload', 'student_photo', 422, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_422_1759249753924_rcvztd.jpg\",\"original_file_name\":\"20250930_104013[1].jpg\",\"original_file_size\":15644955,\"final_file_size\":15644955,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:29:14'),
(644, NULL, 'student_update', 'student', 421, '{\"first_name\":\"KIBUYE\",\"last_name\":\"ABUTHAARI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_422_1759249753924_rcvztd.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:29:41'),
(645, NULL, 'bulk_photo_upload', 'student_photo', 579, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_579_1759250757086_wtfb4c.jpg\",\"original_file_name\":\"20250929_133219.jpg\",\"original_file_size\":16315182,\"final_file_size\":16315182,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:45:57'),
(646, NULL, 'bulk_photo_upload', 'student_photo', 443, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_443_1759250760561_n6095e.jpg\",\"original_file_name\":\"20250929_133252.jpg\",\"original_file_size\":17183609,\"final_file_size\":17183609,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:00'),
(647, NULL, 'bulk_photo_upload', 'student_photo', 398, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_398_1759250763894_7urho0.jpg\",\"original_file_name\":\"abdul swabur.jpg\",\"original_file_size\":15904574,\"final_file_size\":15904574,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:04'),
(648, NULL, 'bulk_photo_upload', 'student_photo', 393, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_393_1759250767350_4kl2ml.jpg\",\"original_file_name\":\"bukenya.jpg\",\"original_file_size\":16145314,\"final_file_size\":16145314,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:07'),
(649, NULL, 'bulk_photo_upload', 'student_photo', 425, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_425_1759250771209_rurj13.jpg\",\"original_file_name\":\"hamisi.jpg\",\"original_file_size\":15995317,\"final_file_size\":15995317,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:11'),
(650, NULL, 'bulk_photo_upload', 'student_photo', 446, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_446_1759250774427_c1trng.jpg\",\"original_file_name\":\"harith.jpg\",\"original_file_size\":15822354,\"final_file_size\":15822354,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:14'),
(651, NULL, 'bulk_photo_upload', 'student_photo', 396, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_396_1759250777853_bu8u2x.jpg\",\"original_file_name\":\"imran.jpg\",\"original_file_size\":15992214,\"final_file_size\":15992214,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:18'),
(652, NULL, 'bulk_photo_upload', 'student_photo', 415, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_415_1759250780832_lwzhrc.jpg\",\"original_file_name\":\"rayan.jpg\",\"original_file_size\":15678906,\"final_file_size\":15678906,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:20'),
(653, NULL, 'bulk_photo_upload', 'student_photo', 418, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_418_1759250784012_f698kx.jpg\",\"original_file_name\":\"sadala.jpg\",\"original_file_size\":15540089,\"final_file_size\":15540089,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:24'),
(654, NULL, 'bulk_photo_upload', 'student_photo', 409, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_409_1759250787559_zbhs0v.jpg\",\"original_file_name\":\"walusansa.jpg\",\"original_file_size\":16021405,\"final_file_size\":16021405,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:46:27'),
(655, NULL, 'bulk_photo_upload', 'student_photo', 416, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_416_1759250863366_xfzb6g.jpg\",\"original_file_name\":\"gamusi.jpg\",\"original_file_size\":16111681,\"final_file_size\":16111681,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:47:43'),
(656, NULL, 'student_update', 'student', 395, '{\"first_name\":\"KAKAIRE\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_396_1759250777853_bu8u2x.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:48:04'),
(657, NULL, 'student_update', 'student', 576, '{\"first_name\":\"KHAIRAT ABDALLAH\",\"last_name\":\"NANKISA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_579_1759250757086_wtfb4c.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:48:26'),
(658, NULL, 'student_update', 'student', 414, '{\"first_name\":\"KIYIMBA\",\"last_name\":\"RAYAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_415_1759250780832_lwzhrc.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:48:45'),
(659, NULL, 'student_update', 'student', 415, '{\"first_name\":\"KULUTUBI\",\"last_name\":\"GAMUSI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_416_1759250863366_xfzb6g.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:49:02'),
(660, NULL, 'student_update', 'student', 400, '{\"first_name\":\"BABIRYE\",\"last_name\":\"HABIBA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_401_1758731351988_nwrxc1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:49:32'),
(661, NULL, 'student_update', 'student', 431, '{\"first_name\":\"BIWEMBA\",\"last_name\":\"RAJAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_432_1758731178206_kiqldo.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:49:53'),
(662, NULL, 'student_update', 'student', 392, '{\"first_name\":\"BUKENYA\",\"last_name\":\"HASSAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_393_1759250767350_4kl2ml.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:50:06'),
(663, NULL, 'student_update', 'student', 418, '{\"first_name\":\"DIDI\",\"last_name\":\"HUSSEIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_419_1758727912070_qcklx2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:50:15'),
(664, NULL, 'student_update', 'student', 410, '{\"first_name\":\"HINDU\",\"last_name\":\"ABDULLAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_411_1758731238439_6i6qy9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:50:54'),
(665, NULL, 'student_update', 'student', 424, '{\"first_name\":\"HAMISI\",\"last_name\":\"MUGOYA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_425_1759250771209_rurj13.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:51:14'),
(666, NULL, 'student_update', 'student', 423, '{\"first_name\":\"ISMAEL\",\"last_name\":\"AZED\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:51:27'),
(667, NULL, 'student_update', 'student', 432, '{\"first_name\":\"JALIRUDEEN\",\"last_name\":\"ASIMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_433_1758728017130_te9n67.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:51:43'),
(668, NULL, 'student_update', 'student', 395, '{\"first_name\":\"KAKAIRE\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_396_1759250777853_bu8u2x.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:51:53'),
(669, NULL, 'student_update', 'student', 576, '{\"first_name\":\"KHAIRAT ABDALLAH\",\"last_name\":\"NANKISA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_579_1759250757086_wtfb4c.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:52:04'),
(670, NULL, 'student_update', 'student', 413, '{\"first_name\":\"KYONJO\",\"last_name\":\"MUSA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_414_1758728094383_ee780h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:52:39'),
(671, NULL, 'student_update', 'student', 441, '{\"first_name\":\"MAGEZI\",\"last_name\":\"SHAFIQ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_442_1758728146413_batk16.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:52:55'),
(672, NULL, 'student_update', 'student', 439, '{\"first_name\":\"MASTULA\",\"last_name\":\"MARIAM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_440_1758728187555_qbckvi.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:53:09'),
(673, NULL, 'student_update', 'student', 397, '{\"first_name\":\"MUNOBWA\",\"last_name\":\"ABDUL-SWABAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_398_1759250763894_7urho0.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:54:14'),
(674, NULL, 'photo_upload', 'student_photo', 598, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_598_1759251340403_ycur6b.jpg\",\"file_name\":\"sumayya.jpg\",\"file_size\":16374,\"student_id\":\"595\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:55:40'),
(675, NULL, 'student_update', 'student', 595, '{\"first_name\":\"NAKABAMBWE\",\"last_name\":\"SUMMAYAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_598_1759251340403_ycur6b.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:55:41'),
(676, NULL, 'student_update', 'student', 417, '{\"first_name\":\"SADALA\",\"last_name\":\"ISA  GASEMBA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_418_1759250784012_f698kx.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:56:26'),
(677, NULL, 'student_update', 'student', 445, '{\"first_name\":\"NGOOBI\",\"last_name\":\"HAARITH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_446_1759250774427_c1trng.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:56:41'),
(678, NULL, 'student_update', 'student', 442, '{\"first_name\":\"NATABI\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_443_1759250760561_n6095e.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:57:18'),
(679, NULL, 'student_update', 'student', 422, '{\"first_name\":\"SIKYAGATEMA\",\"last_name\":\"KAUTHARA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_423_1758730961006_xm5pkq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:57:45'),
(680, NULL, 'student_update', 'student', 426, '{\"first_name\":\"TAGEJJA\",\"last_name\":\"TAKIYYU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_427_1758728899350_zrxr60.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:58:21'),
(681, NULL, 'student_update', 'student', 408, '{\"first_name\":\"WALUSANSA\",\"last_name\":\"ISA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_409_1759250787559_zbhs0v.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 16:58:42'),
(682, NULL, 'student_update', 'student', 493, '{\"first_name\":\"UKASHA\",\"last_name\":\"WANDERA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_496_1758732620843_8b1y54.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 17:12:01'),
(683, NULL, 'student_update', 'student', 483, '{\"first_name\":\"ABDUL-BASIT\",\"last_name\":\"UKASHA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 17:12:34'),
(684, NULL, 'student_update', 'student', 467, '{\"first_name\":\"ABDUL-MUTWALIB\",\"last_name\":\"GUUYA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 17:12:43'),
(685, NULL, 'update_status', 'students', 178, '{\"status\":\"active\"}', NULL, NULL, '2025-09-30 19:20:52'),
(686, NULL, 'student_update', 'student', 180, '{\"first_name\":\"ABDUL AZIZ\",\"last_name\":\"MUYIIMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:21:14'),
(687, NULL, 'student_update', 'student', 176, '{\"first_name\":\"ABDUL AZIZI\",\"last_name\":\"SAIF LA WAYA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:22:02'),
(688, NULL, 'student_update', 'student', 187, '{\"first_name\":\"ABDUL MALIK\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:22:18'),
(689, NULL, 'student_update', 'student', 186, '{\"first_name\":\"ABDUL NASWIR MUHAMMAD\",\"last_name\":\"NGOBI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:23:26'),
(690, NULL, 'student_update', 'student', 197, '{\"first_name\":\"ABDUL RAHMAN SHURAIM\",\"last_name\":\"WAFULA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:23:40'),
(691, NULL, 'student_update', 'student', 150, '{\"first_name\":\"ABDUL SHAKUR\",\"last_name\":\"SWALEH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:24:01'),
(692, NULL, 'student_update', 'student', 206, '{\"first_name\":\"ABDUL-AZIZI\",\"last_name\":\"ZIZINGA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:24:12'),
(693, NULL, 'student_update', 'student', 191, '{\"first_name\":\"ABDURAHMAN HASSAN\",\"last_name\":\"WASSWA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:24:30'),
(694, NULL, 'student_update', 'student', 139, '{\"first_name\":\"ABUBAKAR\",\"last_name\":\"SWIDIQ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:24:55'),
(695, NULL, 'student_update', 'student', 132, '{\"first_name\":\"ARAFAT\",\"last_name\":\"KIGENYI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"inactive\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:25:48'),
(696, NULL, 'student_update', 'student', 154, '{\"first_name\":\"ATWA-U\",\"last_name\":\"MWASE\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:26:22'),
(697, NULL, 'student_update', 'student', 158, '{\"first_name\":\"BALE\",\"last_name\":\"ABDL-SHAKUR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:26:34'),
(698, NULL, 'update_status', 'students', 220, '{\"status\":\"active\"}', NULL, NULL, '2025-09-30 19:26:46'),
(699, NULL, 'student_update', 'student', 220, '{\"first_name\":\"BASHIR\",\"last_name\":\"ABDUL HAFIDHU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:26:57'),
(700, NULL, 'student_update', 'student', 199, '{\"first_name\":\"BASHIRA\",\"last_name\":\"ABDUL KARIM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:27:20'),
(701, NULL, 'student_update', 'student', 170, '{\"first_name\":\"BUKENYA\",\"last_name\":\"ABDUL GHAFAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:27:48'),
(702, NULL, 'student_update', 'student', 134, '{\"first_name\":\"BUWEMBO\",\"last_name\":\"MUDATHIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"MUKONO\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:28:02'),
(703, NULL, 'student_update', 'student', 170, '{\"first_name\":\"BUKENYA\",\"last_name\":\"ABDUL GHAFAR\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:29:19'),
(704, NULL, 'student_update', 'student', 138, '{\"first_name\":\"BWANIKA\",\"last_name\":\"RIDHIWANI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:29:30'),
(705, NULL, 'student_update', 'student', 134, '{\"first_name\":\"BUWEMBO\",\"last_name\":\"MUDATHIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"MUKONO\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:29:39'),
(706, NULL, 'student_update', 'student', 159, '{\"first_name\":\"BYARUHANGA\",\"last_name\":\"NASIIB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:29:52'),
(707, NULL, 'student_update', 'student', 170, '{\"first_name\":\"BUKENYA\",\"last_name\":\"ABDUL GHAFAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:30:12'),
(708, NULL, 'student_update', 'student', 189, '{\"first_name\":\"FADHIL\",\"last_name\":\"HUBAIBU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:30:41'),
(709, NULL, 'student_update', 'student', 188, '{\"first_name\":\"FADHIL\",\"last_name\":\"HUZAIFAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:30:55'),
(710, NULL, 'student_update', 'student', 190, '{\"first_name\":\"FADHIL\",\"last_name\":\"UWAIS\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:31:15'),
(711, NULL, 'student_update', 'student', 203, '{\"first_name\":\"HAIRAT\",\"last_name\":\"NASSUNA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:31:38'),
(712, NULL, 'student_update', 'student', 179, '{\"first_name\":\"HAMIDAH\",\"last_name\":\"QASSIM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:31:56'),
(713, NULL, 'student_update', 'student', 209, '{\"first_name\":\"HASNAT\",\"last_name\":\"UTHUMAN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:32:17'),
(714, NULL, 'student_update', 'student', 168, '{\"first_name\":\"HASSAN\",\"last_name\":\"QASSIM WASSWA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:32:31'),
(715, NULL, 'student_update', 'student', 202, '{\"first_name\":\"HIBATULLAH\",\"last_name\":\"ABAS\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:32:50'),
(716, NULL, 'student_update', 'student', 201, '{\"first_name\":\"IDRIS\",\"last_name\":\"MOHAMED MUHAMMUD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:33:05'),
(717, NULL, 'student_update', 'student', 200, '{\"first_name\":\"IQLAS MOHAMED\",\"last_name\":\"MUHAMMUD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:33:19'),
(718, NULL, 'student_update', 'student', 214, '{\"first_name\":\"JAMILA\",\"last_name\":\"JUMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:33:42'),
(719, NULL, 'student_update', 'student', 130, '{\"first_name\":\"JUMBA\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:33:53'),
(720, NULL, 'student_update', 'student', 156, '{\"first_name\":\"KALEMA\",\"last_name\":\"FADHIL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:34:11'),
(721, NULL, 'student_update', 'student', 166, '{\"first_name\":\"KALUNGI\",\"last_name\":\"UKASHA UMAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"on_leave\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:34:30'),
(722, NULL, 'student_update', 'student', 172, '{\"first_name\":\"KANAKULYA\",\"last_name\":\"RAJAB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:34:47'),
(723, NULL, 'student_update', 'student', 192, '{\"first_name\":\"KANYIKE\",\"last_name\":\"MUHAMMAD YASIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:35:18'),
(724, NULL, 'student_update', 'student', 192, '{\"first_name\":\"KANYIKE\",\"last_name\":\"MUHAMMAD YASIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:36:03'),
(725, NULL, 'student_update', 'student', 136, '{\"first_name\":\"KASEKENDE\",\"last_name\":\"ABDUL-RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:36:25'),
(726, NULL, 'student_update', 'student', 144, '{\"first_name\":\"KATEGA\",\"last_name\":\"AYUB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:36:43'),
(727, NULL, 'student_update', 'student', 146, '{\"first_name\":\"KATUSIIME\",\"last_name\":\"FAHIIMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:37:12'),
(728, NULL, 'student_update', 'student', 196, '{\"first_name\":\"KAWOOYA\",\"last_name\":\"UMAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:37:53'),
(729, NULL, 'student_update', 'student', 198, '{\"first_name\":\"KAZIBWE\",\"last_name\":\"ISMAEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:39:08'),
(730, NULL, 'student_update', 'student', 216, '{\"first_name\":\"KIIRA\",\"last_name\":\"MUHAAMAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:40:13'),
(731, NULL, 'student_update', 'student', 140, '{\"first_name\":\"KIRUNDA\",\"last_name\":\"ISMAEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:40:24'),
(732, NULL, 'student_update', 'student', 171, '{\"first_name\":\"LUKWAGO\",\"last_name\":\"SUDAIS\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:40:38'),
(733, NULL, 'student_update', 'student', 161, '{\"first_name\":\"LUQMAN\",\"last_name\":\"KAYONDO\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"on_leave\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:40:50'),
(734, NULL, 'student_update', 'student', 137, '{\"first_name\":\"LUSWATA\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:41:04'),
(735, NULL, 'update_status', 'students', 174, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-30 19:41:19'),
(736, NULL, 'student_update', 'student', 127, '{\"first_name\":\"MAGOOLA\",\"last_name\":\"BASHIRI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"IGANGA\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:41:28'),
(737, NULL, 'student_update', 'student', 185, '{\"first_name\":\"MISBAHU\",\"last_name\":\"ASHIRAF\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:41:41'),
(738, NULL, 'student_update', 'student', 160, '{\"first_name\":\"MUBIRU\",\"last_name\":\"AZHAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:41:53'),
(739, NULL, 'student_update', 'student', 184, '{\"first_name\":\"MUBIRU\",\"last_name\":\"MUSTAFA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:42:10'),
(740, NULL, 'update_status', 'students', 208, '{\"status\":\"active\"}', NULL, NULL, '2025-09-30 19:42:19'),
(741, NULL, 'student_update', 'student', 208, '{\"first_name\":\"MUGUNDA\",\"last_name\":\"YUSUF\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:42:27'),
(742, NULL, 'student_update', 'student', 142, '{\"first_name\":\"MUHAMMAD ALI\",\"last_name\":\"SSERUBOGO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:42:38'),
(743, NULL, 'student_update', 'student', 149, '{\"first_name\":\"MUKOSE\",\"last_name\":\"TWAHIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:42:56'),
(744, NULL, 'student_update', 'student', 151, '{\"first_name\":\"MULANGIRA\",\"last_name\":\"ABDUL RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:43:16'),
(745, NULL, 'student_update', 'student', 211, '{\"first_name\":\"MUSOBYA\",\"last_name\":\"SHAFICK ABUBAKR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:43:32'),
(746, NULL, 'student_update', 'student', 211, '{\"first_name\":\"MUSOBYA\",\"last_name\":\"SHAFICK ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:43:46'),
(747, NULL, 'student_update', 'student', 157, '{\"first_name\":\"MUYOMBA\",\"last_name\":\"ANWAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:44:00'),
(748, NULL, 'student_update', 'student', 195, '{\"first_name\":\"MUYOMBA\",\"last_name\":\"UMAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:44:14'),
(749, NULL, 'student_update', 'student', 153, '{\"first_name\":\"NABABENGA\",\"last_name\":\"HABIBAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:44:34'),
(750, NULL, 'student_update', 'student', 173, '{\"first_name\":\"NAIGAGA\",\"last_name\":\"HAJARA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:44:46'),
(751, NULL, 'student_update', 'student', 173, '{\"first_name\":\"NAIGAGA\",\"last_name\":\"HAJARAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:44:59'),
(752, NULL, 'student_update', 'student', 212, '{\"first_name\":\"NAKANTU\",\"last_name\":\"HAFIDHWA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:45:19'),
(753, NULL, 'student_update', 'student', 213, '{\"first_name\":\"NAKANTU\",\"last_name\":\"HUNAISA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:45:31'),
(754, NULL, 'update_status', 'students', 193, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 19:46:22'),
(755, NULL, 'student_update', 'student', 177, '{\"first_name\":\"NANGOBI\",\"last_name\":\"SUMMAYAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:46:34'),
(756, NULL, 'student_update', 'student', 204, '{\"first_name\":\"NSIMBI\",\"last_name\":\"NAJIB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:47:46'),
(757, NULL, 'student_update', 'student', 135, '{\"first_name\":\"NSUBUGA\",\"last_name\":\"ABDUL-AZIZI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:47:59');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(758, NULL, 'student_update', 'student', 141, '{\"first_name\":\"NYANJA\",\"last_name\":\"NOORDEEN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:48:11'),
(759, NULL, 'student_update', 'student', 143, '{\"first_name\":\"NYANZI\",\"last_name\":\"ABDUL SWAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:48:39'),
(760, NULL, 'student_update', 'student', 218, '{\"first_name\":\"QAYIM\",\"last_name\":\"UTHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:48:53'),
(761, NULL, 'student_update', 'student', 215, '{\"first_name\":\"RAHMA\",\"last_name\":\"FADHIL\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:49:05'),
(762, NULL, 'student_update', 'student', 183, '{\"first_name\":\"RAYAN\",\"last_name\":\"KAGABA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:49:21'),
(763, NULL, 'student_update', 'student', 131, '{\"first_name\":\"RAYAN\",\"last_name\":\"RAMADHAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:49:49'),
(764, NULL, 'student_update', 'student', 133, '{\"first_name\":\"RUKINDU\",\"last_name\":\"ASHIRAF MUSA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:50:32'),
(765, NULL, 'student_update', 'student', 147, '{\"first_name\":\"SEGUJJA\",\"last_name\":\"HUSSEIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:52:11'),
(766, NULL, 'update_status', 'students', 165, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 19:52:34'),
(767, NULL, 'student_update', 'student', 210, '{\"first_name\":\"SHAKIB\",\"last_name\":\"MUGANGA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:52:46'),
(768, NULL, 'student_update', 'student', 145, '{\"first_name\":\"SONKO\",\"last_name\":\"SHARAF KIGANDA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:52:59'),
(769, NULL, 'student_update', 'student', 169, '{\"first_name\":\"SSEKADU\",\"last_name\":\"HAMAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:53:19'),
(770, NULL, 'student_update', 'student', 148, '{\"first_name\":\"SSEMWANGA\",\"last_name\":\"RAYAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:53:29'),
(771, NULL, 'student_update', 'student', 163, '{\"first_name\":\"SSENOGA\",\"last_name\":\"MAHAWISH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:53:50'),
(772, NULL, 'student_update', 'student', 163, '{\"first_name\":\"SSENOGA\",\"last_name\":\"MAHAWISH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:54:10'),
(773, NULL, 'student_update', 'student', 175, '{\"first_name\":\"TAUFIC\",\"last_name\":\"LUKOMWA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:54:24'),
(774, NULL, 'student_update', 'student', 182, '{\"first_name\":\"THURAYYA\",\"last_name\":\"MBAZIIRA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:54:36'),
(775, NULL, 'student_update', 'student', 588, '{\"first_name\":\"TILIBUZA\",\"last_name\":\"SHADAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:54:49'),
(776, NULL, 'student_update', 'student', 205, '{\"first_name\":\"TIMUNTU\",\"last_name\":\"ABDUL-RAZAK\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:55:02'),
(777, NULL, 'student_update', 'student', 181, '{\"first_name\":\"UMAR\",\"last_name\":\"MUSA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:55:17'),
(778, NULL, 'student_update', 'student', 164, '{\"first_name\":\"WALUGEMBE\",\"last_name\":\"HAITHAM ABDUL KARIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:55:30'),
(779, NULL, 'student_update', 'student', 152, '{\"first_name\":\"WANDERA\",\"last_name\":\"MUSTAPHA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:55:50'),
(780, NULL, 'student_update', 'student', 155, '{\"first_name\":\"WAWAYANGA\",\"last_name\":\"ABDUL HAIRI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:56:05'),
(781, NULL, 'student_update', 'student', 207, '{\"first_name\":\"WILDAN\",\"last_name\":\"TWAIB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:56:21'),
(782, NULL, 'student_update', 'student', 128, '{\"first_name\":\"ZAHARA ABDALLAH\",\"last_name\":\"NAKIBUULE\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"KAMPALA\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:56:33'),
(783, NULL, 'student_update', 'student', 129, '{\"first_name\":\"ZAINAB ABDALLAH\",\"last_name\":\"NAMUGENYI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:56:45'),
(784, NULL, 'student_update', 'student', 194, '{\"first_name\":\"ZAITUNI\",\"last_name\":\"NAISAMULA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:56:59'),
(785, NULL, 'student_update', 'student', 219, '{\"first_name\":\"ZAMZAM\",\"last_name\":\"NAKALEMBE\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"inactive\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 19:57:08'),
(786, NULL, 'update_status', 'students', 573, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 19:58:46'),
(787, NULL, 'update_status', 'students', 161, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 19:59:12'),
(788, NULL, 'update_status', 'students', 166, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 19:59:22'),
(789, NULL, 'student_update', 'student', 165, '{\"first_name\":\"SHADIAH\",\"last_name\":\"BINTI ZAIDI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"at_home\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:00:22'),
(790, NULL, 'student_update', 'student', 193, '{\"first_name\":\"NAKATE\",\"last_name\":\"AFUWA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"at_home\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:00:35'),
(791, NULL, 'student_update', 'student', 573, '{\"first_name\":\"AKSAM\",\"last_name\":\"NGAYIRE\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"at_home\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:00:58'),
(792, NULL, 'photo_upload', 'student_photo', 147, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_147_1759264405232_a8ot3a.jpg\",\"file_name\":\"IMG_20250323_174744.jpg\",\"file_size\":82141,\"student_id\":\"146\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:33:25'),
(793, NULL, 'student_update', 'student', 146, '{\"first_name\":\"KATUSIIME\",\"last_name\":\"FAHIIMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_147_1759264405232_a8ot3a.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:33:27'),
(794, NULL, 'student_update', 'student', 142, '{\"first_name\":\"MUHAMMAD ALI\",\"last_name\":\"SSERUBOGO\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:33:48'),
(795, NULL, 'photo_upload', 'student_photo', 213, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_213_1759264456453_x0jm94.jpg\",\"file_name\":\"IMG_20250323_174744.jpg\",\"file_size\":82141,\"student_id\":\"212\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:34:16'),
(796, NULL, 'student_update', 'student', 212, '{\"first_name\":\"NAKANTU\",\"last_name\":\"HAFIDHWA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_213_1759264456453_x0jm94.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 20:34:17'),
(797, NULL, 'update_status', 'students', 573, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-09-30 20:35:34'),
(798, NULL, 'update_status', 'students', 219, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 23:35:24'),
(799, NULL, 'update_status', 'students', 213, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 23:37:42'),
(800, NULL, 'student_update', 'student', 158, '{\"first_name\":\"BALE\",\"last_name\":\"ABDUL-SHAKUR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 23:43:36'),
(801, NULL, 'student_update', 'student', 220, '{\"first_name\":\"BASHIR\",\"last_name\":\"ABDUL HAFIDHI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-09-30 23:44:25'),
(802, NULL, 'update_status', 'students', 440, '{\"status\":\"at_home\"}', NULL, NULL, '2025-09-30 23:58:32'),
(803, NULL, 'bulk_photo_upload', 'student_photo', 204, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_204_1759280578244_fmapzw.jpg\",\"original_file_name\":\"20251001_111624.jpg\",\"original_file_size\":1628132,\"final_file_size\":1628132,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:02:58'),
(804, NULL, 'bulk_photo_upload', 'student_photo', 200, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_200_1759280580669_no0j4q.jpg\",\"original_file_name\":\"bashirah.jpg\",\"original_file_size\":1506316,\"final_file_size\":1506316,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:00'),
(805, NULL, 'bulk_photo_upload', 'student_photo', 147, '{\"old_photo_url\":\"/uploads/students/person_147_1759264405232_a8ot3a.jpg\",\"new_photo_url\":\"/uploads/students/person_147_1759280582424_txvz6v.jpg\",\"original_file_name\":\"fahimah.jpg\",\"original_file_size\":1524159,\"final_file_size\":1524159,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:02'),
(806, NULL, 'bulk_photo_upload', 'student_photo', 154, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_154_1759280584152_9j87nl.jpg\",\"original_file_name\":\"habibah.jpg\",\"original_file_size\":1453912,\"final_file_size\":1453912,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:04'),
(807, NULL, 'bulk_photo_upload', 'student_photo', 174, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_174_1759280586504_eu9jvz.jpg\",\"original_file_name\":\"hajjarah.jpg\",\"original_file_size\":1558853,\"final_file_size\":1558853,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:06'),
(808, NULL, 'bulk_photo_upload', 'student_photo', 210, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_210_1759280588455_v0m5te.jpg\",\"original_file_name\":\"hassanah.jpg\",\"original_file_size\":1568348,\"final_file_size\":1568348,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:08'),
(809, NULL, 'bulk_photo_upload', 'student_photo', 203, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_203_1759280590629_9qzhzo.jpg\",\"original_file_name\":\"hibatullah.jpg\",\"original_file_size\":1452471,\"final_file_size\":1452471,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:10'),
(810, NULL, 'bulk_photo_upload', 'student_photo', 215, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_215_1759280592565_7eleka.jpg\",\"original_file_name\":\"jamilah.jpg\",\"original_file_size\":1546136,\"final_file_size\":1546136,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:12'),
(811, NULL, 'bulk_photo_upload', 'student_photo', 164, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_164_1759280594955_3nfl6k.jpg\",\"original_file_name\":\"mahwish.jpg\",\"original_file_size\":1496400,\"final_file_size\":1496400,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:15'),
(812, NULL, 'bulk_photo_upload', 'student_photo', 213, '{\"old_photo_url\":\"/uploads/students/person_213_1759264456453_x0jm94.jpg\",\"new_photo_url\":\"/uploads/students/person_213_1759280596656_jlytez.jpg\",\"original_file_name\":\"nakantu.jpg\",\"original_file_size\":1637541,\"final_file_size\":1637541,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:16'),
(813, NULL, 'bulk_photo_upload', 'student_photo', 216, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_216_1759280598576_lpp17v.jpg\",\"original_file_name\":\"rahmah.jpg\",\"original_file_size\":1616620,\"final_file_size\":1616620,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:18'),
(814, NULL, 'bulk_photo_upload', 'student_photo', 178, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_178_1759280600778_4p0nxl.jpg\",\"original_file_name\":\"summayya.jpg\",\"original_file_size\":1527975,\"final_file_size\":1527975,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:20'),
(815, NULL, 'bulk_photo_upload', 'student_photo', 183, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_183_1759280603685_bg22uu.jpg\",\"original_file_name\":\"thurayya.jpg\",\"original_file_size\":1512221,\"final_file_size\":1512221,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:23'),
(816, NULL, 'bulk_photo_upload', 'student_photo', 129, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_129_1759280605229_eaoax1.jpg\",\"original_file_name\":\"zaharah.jpg\",\"original_file_size\":1547003,\"final_file_size\":1547003,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:25'),
(817, NULL, 'bulk_photo_upload', 'student_photo', 130, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_130_1759280606968_6zjikf.jpg\",\"original_file_name\":\"zainab abdallah.jpg\",\"original_file_size\":1494697,\"final_file_size\":1494697,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:27'),
(818, NULL, 'bulk_photo_upload', 'student_photo', 195, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_195_1759280608684_90harw.jpg\",\"original_file_name\":\"zaituni.jpg\",\"original_file_size\":1607641,\"final_file_size\":1607641,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:03:28'),
(819, NULL, 'student_update', 'student', 200, '{\"first_name\":\"IQLAS MOHAMED\",\"last_name\":\"MUHAMMUD\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:04:30'),
(820, NULL, 'bulk_photo_upload', 'student_photo', 204, '{\"old_photo_url\":\"/uploads/students/person_204_1759280578244_fmapzw.jpg\",\"new_photo_url\":\"/uploads/students/person_204_1759280717949_3u8w3b.jpg\",\"original_file_name\":\"20251001_111624.jpg\",\"original_file_size\":1628132,\"final_file_size\":1628132,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:17'),
(821, NULL, 'bulk_photo_upload', 'student_photo', 200, '{\"old_photo_url\":\"/uploads/students/person_200_1759280580669_no0j4q.jpg\",\"new_photo_url\":\"/uploads/students/person_200_1759280720113_c1z1mg.jpg\",\"original_file_name\":\"bashirah.jpg\",\"original_file_size\":1506316,\"final_file_size\":1506316,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:20'),
(822, NULL, 'bulk_photo_upload', 'student_photo', 147, '{\"old_photo_url\":\"/uploads/students/person_147_1759280582424_txvz6v.jpg\",\"new_photo_url\":\"/uploads/students/person_147_1759280721292_f5om05.jpg\",\"original_file_name\":\"fahimah.jpg\",\"original_file_size\":1524159,\"final_file_size\":1524159,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:21'),
(823, NULL, 'bulk_photo_upload', 'student_photo', 154, '{\"old_photo_url\":\"/uploads/students/person_154_1759280584152_9j87nl.jpg\",\"new_photo_url\":\"/uploads/students/person_154_1759280722700_kni3h1.jpg\",\"original_file_name\":\"habibah.jpg\",\"original_file_size\":1453912,\"final_file_size\":1453912,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:22'),
(824, NULL, 'bulk_photo_upload', 'student_photo', 174, '{\"old_photo_url\":\"/uploads/students/person_174_1759280586504_eu9jvz.jpg\",\"new_photo_url\":\"/uploads/students/person_174_1759280723905_nemyy4.jpg\",\"original_file_name\":\"hajjarah.jpg\",\"original_file_size\":1558853,\"final_file_size\":1558853,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:23'),
(825, NULL, 'bulk_photo_upload', 'student_photo', 210, '{\"old_photo_url\":\"/uploads/students/person_210_1759280588455_v0m5te.jpg\",\"new_photo_url\":\"/uploads/students/person_210_1759280725218_ilpvx0.jpg\",\"original_file_name\":\"hassanah.jpg\",\"original_file_size\":1568348,\"final_file_size\":1568348,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:25'),
(826, NULL, 'bulk_photo_upload', 'student_photo', 203, '{\"old_photo_url\":\"/uploads/students/person_203_1759280590629_9qzhzo.jpg\",\"new_photo_url\":\"/uploads/students/person_203_1759280727097_v93zrd.jpg\",\"original_file_name\":\"hibatullah.jpg\",\"original_file_size\":1452471,\"final_file_size\":1452471,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:27'),
(827, NULL, 'bulk_photo_upload', 'student_photo', 201, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_201_1759280730172_jmdp3s.jpg\",\"original_file_name\":\"iqlas (2).jpg\",\"original_file_size\":13080285,\"final_file_size\":13080285,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:30'),
(828, NULL, 'bulk_photo_upload', 'student_photo', 215, '{\"old_photo_url\":\"/uploads/students/person_215_1759280592565_7eleka.jpg\",\"new_photo_url\":\"/uploads/students/person_215_1759280731544_308ro2.jpg\",\"original_file_name\":\"jamilah.jpg\",\"original_file_size\":1546136,\"final_file_size\":1546136,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:31'),
(829, NULL, 'bulk_photo_upload', 'student_photo', 164, '{\"old_photo_url\":\"/uploads/students/person_164_1759280594955_3nfl6k.jpg\",\"new_photo_url\":\"/uploads/students/person_164_1759280732875_pqgnqw.jpg\",\"original_file_name\":\"mahwish.jpg\",\"original_file_size\":1496400,\"final_file_size\":1496400,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:32'),
(830, NULL, 'bulk_photo_upload', 'student_photo', 213, '{\"old_photo_url\":\"/uploads/students/person_213_1759280596656_jlytez.jpg\",\"new_photo_url\":\"/uploads/students/person_213_1759280734276_5lqkor.jpg\",\"original_file_name\":\"nakantu.jpg\",\"original_file_size\":1637541,\"final_file_size\":1637541,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:34'),
(831, NULL, 'bulk_photo_upload', 'student_photo', 216, '{\"old_photo_url\":\"/uploads/students/person_216_1759280598576_lpp17v.jpg\",\"new_photo_url\":\"/uploads/students/person_216_1759280735464_1v42gz.jpg\",\"original_file_name\":\"rahmah.jpg\",\"original_file_size\":1616620,\"final_file_size\":1616620,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:35'),
(832, NULL, 'bulk_photo_upload', 'student_photo', 178, '{\"old_photo_url\":\"/uploads/students/person_178_1759280600778_4p0nxl.jpg\",\"new_photo_url\":\"/uploads/students/person_178_1759280736781_aeb3u4.jpg\",\"original_file_name\":\"summayya.jpg\",\"original_file_size\":1527975,\"final_file_size\":1527975,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:36'),
(833, NULL, 'bulk_photo_upload', 'student_photo', 183, '{\"old_photo_url\":\"/uploads/students/person_183_1759280603685_bg22uu.jpg\",\"new_photo_url\":\"/uploads/students/person_183_1759280737834_yakr4e.jpg\",\"original_file_name\":\"thurayya.jpg\",\"original_file_size\":1512221,\"final_file_size\":1512221,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:37'),
(834, NULL, 'bulk_photo_upload', 'student_photo', 129, '{\"old_photo_url\":\"/uploads/students/person_129_1759280605229_eaoax1.jpg\",\"new_photo_url\":\"/uploads/students/person_129_1759280739108_740p22.jpg\",\"original_file_name\":\"zaharah.jpg\",\"original_file_size\":1547003,\"final_file_size\":1547003,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:39'),
(835, NULL, 'bulk_photo_upload', 'student_photo', 130, '{\"old_photo_url\":\"/uploads/students/person_130_1759280606968_6zjikf.jpg\",\"new_photo_url\":\"/uploads/students/person_130_1759280740503_tudwab.jpg\",\"original_file_name\":\"zainab abdallah.jpg\",\"original_file_size\":1494697,\"final_file_size\":1494697,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:40'),
(836, NULL, 'bulk_photo_upload', 'student_photo', 195, '{\"old_photo_url\":\"/uploads/students/person_195_1759280608684_90harw.jpg\",\"new_photo_url\":\"/uploads/students/person_195_1759280741632_1t1t5r.jpg\",\"original_file_name\":\"zaituni.jpg\",\"original_file_size\":1607641,\"final_file_size\":1607641,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:05:41'),
(837, NULL, 'student_update', 'student', 607, '{\"first_name\":\"SHUKRAN\",\"last_name\":\"SSEMAKULA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:08:59'),
(838, NULL, 'student_update', 'student', 167, '{\"first_name\":\"ASIMWE\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:10:06'),
(839, NULL, 'bulk_photo_upload', 'student_photo', 168, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_168_1759281060578_nm2uiq.jpg\",\"original_file_name\":\"rahmah asiimwe.jpg\",\"original_file_size\":1475799,\"final_file_size\":1475799,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:11:00'),
(840, NULL, 'bulk_photo_upload', 'student_photo', 610, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_610_1759281105976_balipg.jpg\",\"original_file_name\":\"shukran.jpg\",\"original_file_size\":1562085,\"final_file_size\":1562085,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 01:11:45'),
(841, NULL, 'bulk_photo_upload', 'student_photo', 148, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_148_1759284789458_w4w1l2.jpg\",\"original_file_name\":\"ABDUL KARIM SSEGUJJA.jpg\",\"original_file_size\":12209207,\"final_file_size\":12209207,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:09'),
(842, NULL, 'bulk_photo_upload', 'student_photo', 158, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_158_1759284792325_u875fl.jpg\",\"original_file_name\":\"ANWAR.jpg\",\"original_file_size\":12034318,\"final_file_size\":12034318,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:12'),
(843, NULL, 'bulk_photo_upload', 'student_photo', 159, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_159_1759284794850_s3frpc.jpg\",\"original_file_name\":\"BALE.jpg\",\"original_file_size\":12231439,\"final_file_size\":12231439,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:14'),
(844, NULL, 'bulk_photo_upload', 'student_photo', 179, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_179_1759284796536_km7u5a.jpg\",\"original_file_name\":\"EDRISS.jpg\",\"original_file_size\":11626606,\"final_file_size\":11626606,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:16'),
(845, NULL, 'bulk_photo_upload', 'student_photo', 170, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_170_1759284799142_i7e67b.jpg\",\"original_file_name\":\"HAMAM.jpg\",\"original_file_size\":12256326,\"final_file_size\":12256326,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:19'),
(846, NULL, 'bulk_photo_upload', 'student_photo', 192, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_192_1759284801760_z0xneo.jpg\",\"original_file_name\":\"HASSAN WASWA.jpg\",\"original_file_size\":12126291,\"final_file_size\":12126291,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:21'),
(847, NULL, 'bulk_photo_upload', 'student_photo', 145, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_145_1759284810386_x3u8t8.jpg\",\"original_file_name\":\"KATEGA (1).jpg\",\"original_file_size\":11827671,\"final_file_size\":11827671,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:13:30'),
(848, NULL, 'bulk_photo_upload', 'student_photo', 202, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_202_1759285522327_1z9kgd.jpg\",\"original_file_name\":\"edrisa.jpg\",\"original_file_size\":2073964,\"final_file_size\":2073964,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:25:22'),
(849, NULL, 'bulk_photo_upload', 'student_photo', 171, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_171_1759286208182_f8gxpm.jpg\",\"original_file_name\":\"ABDUL GHAFAR.jpg\",\"original_file_size\":11298525,\"final_file_size\":11298525,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:36:48'),
(850, NULL, 'bulk_photo_upload', 'student_photo', 221, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_221_1759286211904_t3caex.jpg\",\"original_file_name\":\"ABDUL HAFIDHI - Copy.jpg\",\"original_file_size\":11817530,\"final_file_size\":11817530,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:36:51'),
(851, NULL, 'bulk_photo_upload', 'student_photo', 187, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_187_1759286214258_052db7.jpg\",\"original_file_name\":\"ABDUL NASIR - Copy - Copy.jpg\",\"original_file_size\":11014557,\"final_file_size\":11014557,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:36:54'),
(852, NULL, 'bulk_photo_upload', 'student_photo', 144, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_144_1759286217961_rbn717.jpg\",\"original_file_name\":\"ABDUL SWABUR - Copy (2).jpg\",\"original_file_size\":12152984,\"final_file_size\":12152984,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:36:58'),
(853, NULL, 'bulk_photo_upload', 'student_photo', 161, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_161_1759286221553_dcwhmz.jpg\",\"original_file_name\":\"AZIHAL - Copy.jpg\",\"original_file_size\":11972419,\"final_file_size\":11972419,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:01'),
(854, NULL, 'bulk_photo_upload', 'student_photo', 135, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_135_1759286223905_e383pk.jpg\",\"original_file_name\":\"BUWEMBO - Copy.jpg\",\"original_file_size\":12702039,\"final_file_size\":12702039,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:03'),
(855, NULL, 'bulk_photo_upload', 'student_photo', 139, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_139_1759286227008_x15x19.jpg\",\"original_file_name\":\"BWANIKA - Copy.jpg\",\"original_file_size\":12054485,\"final_file_size\":12054485,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:07'),
(856, NULL, 'bulk_photo_upload', 'student_photo', 160, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_160_1759286231342_2jez1f.jpg\",\"original_file_name\":\"BYARUHANGA.jpg\",\"original_file_size\":11575711,\"final_file_size\":11575711,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:11'),
(857, NULL, 'bulk_photo_upload', 'student_photo', 196, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_196_1759286233467_w8yp9a.jpg\",\"original_file_name\":\"DAMBA MUYOMBA - Copy.jpg\",\"original_file_size\":11815350,\"final_file_size\":11815350,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:13'),
(858, NULL, 'bulk_photo_upload', 'student_photo', 157, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_157_1759286237603_aow2hn.jpg\",\"original_file_name\":\"FADHIL ABDUL RAHMAN.jpg\",\"original_file_size\":12117393,\"final_file_size\":12117393,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:17'),
(859, NULL, 'bulk_photo_upload', 'student_photo', 169, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_169_1759286241107_rhgxhq.jpg\",\"original_file_name\":\"HASSAN QASSIM - Copy.jpg\",\"original_file_size\":12153433,\"final_file_size\":12153433,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:37:21'),
(860, NULL, 'student_update', 'student', 143, '{\"first_name\":\"NYANZI\",\"last_name\":\"ABDUL SWABUR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_144_1759286217961_rbn717.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 02:38:08'),
(861, NULL, 'bulk_photo_upload', 'student_photo', 131, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_131_1759288349290_nji1dc.jpg\",\"original_file_name\":\"JUMBA.jpg\",\"original_file_size\":11848062,\"final_file_size\":11848062,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:29'),
(862, NULL, 'bulk_photo_upload', 'student_photo', 173, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_173_1759288352038_6g2cvs.jpg\",\"original_file_name\":\"KANAKULYA - Copy.jpg\",\"original_file_size\":11837114,\"final_file_size\":11837114,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:32'),
(863, NULL, 'bulk_photo_upload', 'student_photo', 193, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_193_1759288354669_yf3me0.jpg\",\"original_file_name\":\"KANYIKE.jpg\",\"original_file_size\":11946766,\"final_file_size\":11946766,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:34'),
(864, NULL, 'bulk_photo_upload', 'student_photo', 199, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_199_1759288358259_g9g5wu.jpg\",\"original_file_name\":\"KAZIBWE.jpg\",\"original_file_size\":12094433,\"final_file_size\":12094433,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:38'),
(865, NULL, 'bulk_photo_upload', 'student_photo', 217, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_217_1759288361787_27f7v7.jpg\",\"original_file_name\":\"KIIRA.jpg\",\"original_file_size\":11763936,\"final_file_size\":11763936,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:41'),
(866, NULL, 'bulk_photo_upload', 'student_photo', 176, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_176_1759288364477_rvylhu.jpg\",\"original_file_name\":\"LUKOMWA.jpg\",\"original_file_size\":11777824,\"final_file_size\":11777824,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:44'),
(867, NULL, 'bulk_photo_upload', 'student_photo', 138, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_138_1759288368119_5ef2bn.jpg\",\"original_file_name\":\"LUSWATA.jpg\",\"original_file_size\":12101366,\"final_file_size\":12101366,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 03:12:48'),
(868, NULL, 'bulk_photo_upload', 'student_photo', 188, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_188_1759291368641_gry1oa.jpg\",\"original_file_name\":\"MALICK.jpg\",\"original_file_size\":12288682,\"final_file_size\":12288682,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:02:55'),
(869, NULL, 'bulk_photo_upload', 'student_photo', 181, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_181_1759291473987_yrcch4.jpg\",\"original_file_name\":\"MUYIMA.jpg\",\"original_file_size\":11937403,\"final_file_size\":11937403,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:04:49'),
(870, NULL, 'bulk_photo_upload', 'student_photo', 177, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_177_1759291497097_5ajfox.jpg\",\"original_file_name\":\"SAIF LA WAYA.jpg\",\"original_file_size\":2897177,\"final_file_size\":2897177,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:04:57'),
(871, NULL, 'bulk_photo_upload', 'student_photo', 198, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_198_1759291706993_o99gql.jpg\",\"original_file_name\":\"WAFULA.jpg\",\"original_file_size\":12299686,\"final_file_size\":12299686,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:08:27'),
(872, NULL, 'student_update', 'student', 260, '{\"first_name\":\"AKISM BWANA\",\"last_name\":\"ABDUL-RAHIM\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:09:36'),
(873, NULL, 'student_update', 'student', 260, '{\"first_name\":\"AKISM BWANA\",\"last_name\":\"ABDUL-RAHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:09:46'),
(874, NULL, 'bulk_photo_upload', 'student_photo', 209, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_209_1759292020345_45qdhx.jpg\",\"original_file_name\":\"MUGUNDA.jpg\",\"original_file_size\":12048274,\"final_file_size\":12048274,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:13:40');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(875, NULL, 'bulk_photo_upload', 'student_photo', 136, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_136_1759292023242_2rk2n6.jpg\",\"original_file_name\":\"NSUBUGA.jpg\",\"original_file_size\":12109050,\"final_file_size\":12109050,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:13:43'),
(876, NULL, 'bulk_photo_upload', 'student_photo', 172, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_172_1759292025023_g6jllo.jpg\",\"original_file_name\":\"SUDAIS.jpg\",\"original_file_size\":11934784,\"final_file_size\":11934784,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:13:45'),
(877, NULL, 'bulk_photo_upload', 'student_photo', 128, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_128_1759292106066_rrxm75.jpg\",\"original_file_name\":\"MAGOLA.jpg\",\"original_file_size\":12118800,\"final_file_size\":12118800,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:06'),
(878, NULL, 'bulk_photo_upload', 'student_photo', 186, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_186_1759292109322_jo363f.jpg\",\"original_file_name\":\"MISBAH.jpg\",\"original_file_size\":11995134,\"final_file_size\":11995134,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:09'),
(879, NULL, 'bulk_photo_upload', 'student_photo', 185, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_185_1759292112529_1meivz.jpg\",\"original_file_name\":\"MUBIRU MUSTAFA.jpg\",\"original_file_size\":11853497,\"final_file_size\":11853497,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:12'),
(880, NULL, 'bulk_photo_upload', 'student_photo', 209, '{\"old_photo_url\":\"/uploads/students/person_209_1759292020345_45qdhx.jpg\",\"new_photo_url\":\"/uploads/students/person_209_1759292114882_jffdx1.jpg\",\"original_file_name\":\"MUGUNDA.jpg\",\"original_file_size\":12048274,\"final_file_size\":12048274,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:14'),
(881, NULL, 'bulk_photo_upload', 'student_photo', 150, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_150_1759292117860_vt3mgr.jpg\",\"original_file_name\":\"MUKOSE.jpg\",\"original_file_size\":12303960,\"final_file_size\":12303960,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:17'),
(882, NULL, 'bulk_photo_upload', 'student_photo', 136, '{\"old_photo_url\":\"/uploads/students/person_136_1759292023242_2rk2n6.jpg\",\"new_photo_url\":\"/uploads/students/person_136_1759292119528_mpvcne.jpg\",\"original_file_name\":\"NSUBUGA.jpg\",\"original_file_size\":12109050,\"final_file_size\":12109050,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:19'),
(883, NULL, 'bulk_photo_upload', 'student_photo', 172, '{\"old_photo_url\":\"/uploads/students/person_172_1759292025023_g6jllo.jpg\",\"new_photo_url\":\"/uploads/students/person_172_1759292121518_2pb1wm.jpg\",\"original_file_name\":\"SUDAIS.jpg\",\"original_file_size\":11934784,\"final_file_size\":11934784,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:15:21'),
(884, NULL, 'student_update', 'student', 211, '{\"first_name\":\"MUSOBYA\",\"last_name\":\"SHAFIE ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:16:01'),
(885, NULL, 'update_status', 'students', 151, '{\"status\":\"at_home\"}', NULL, NULL, '2025-10-01 04:16:17'),
(886, NULL, 'bulk_photo_upload', 'student_photo', 149, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_149_1759292454068_tpnb7k.jpg\",\"original_file_name\":\"RAYAN SSEMWANGA.jpg\",\"original_file_size\":12633074,\"final_file_size\":12633074,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:20:54'),
(887, NULL, 'bulk_photo_upload', 'student_photo', 134, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_134_1759292456479_apmq6r.jpg\",\"original_file_name\":\"RUKINDU.jpg\",\"original_file_size\":12254223,\"final_file_size\":12254223,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:20:56'),
(888, NULL, 'bulk_photo_upload', 'student_photo', 212, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_212_1759292458548_7784ip.jpg\",\"original_file_name\":\"SHAFIE.jpg\",\"original_file_size\":12039845,\"final_file_size\":12039845,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:20:58'),
(889, NULL, 'bulk_photo_upload', 'student_photo', 143, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_143_1759292461915_07hgpw.jpg\",\"original_file_name\":\"SSERUBOGO.jpg\",\"original_file_size\":12587788,\"final_file_size\":12587788,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:21:02'),
(890, NULL, 'bulk_photo_upload', 'student_photo', 146, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_146_1759292464210_u9zdiu.jpg\",\"original_file_name\":\"SSONKO.jpg\",\"original_file_size\":12056551,\"final_file_size\":12056551,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:21:04'),
(891, NULL, 'bulk_photo_upload', 'student_photo', 591, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_591_1759292467751_ik6i1m.jpg\",\"original_file_name\":\"TILIBUZA.jpg\",\"original_file_size\":11934125,\"final_file_size\":11934125,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:21:07'),
(892, NULL, 'bulk_photo_upload', 'student_photo', 142, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_142_1759292539434_3u12se.jpg\",\"original_file_name\":\"NYANJA.jpg\",\"original_file_size\":11121834,\"final_file_size\":11121834,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:22:19'),
(893, NULL, 'bulk_photo_upload', 'student_photo', 165, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_165_1759292627844_ob1e09.jpg\",\"original_file_name\":\"WALUGEMBE.jpg\",\"original_file_size\":11630015,\"final_file_size\":11630015,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:23:47'),
(894, NULL, 'bulk_photo_upload', 'student_photo', 153, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_153_1759292630905_u1rs18.jpg\",\"original_file_name\":\"WANDERA M.jpg\",\"original_file_size\":12072198,\"final_file_size\":12072198,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:23:50'),
(895, NULL, 'bulk_photo_upload', 'student_photo', 156, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_156_1759292634083_8o3qac.jpg\",\"original_file_name\":\"WAWAYANGA.jpg\",\"original_file_size\":12924258,\"final_file_size\":12924258,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:23:54'),
(896, NULL, 'bulk_photo_upload', 'student_photo', 208, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_208_1759292636171_b8q8wh.jpg\",\"original_file_name\":\"WILDAN.jpg\",\"original_file_size\":13014688,\"final_file_size\":13014688,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:23:56'),
(897, NULL, 'bulk_photo_upload', 'student_photo', 182, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_182_1759292700074_l65rb8.jpg\",\"original_file_name\":\"UMAR MUSA.jpg\",\"original_file_size\":11650372,\"final_file_size\":11650372,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:25:00'),
(898, NULL, 'bulk_photo_upload', 'student_photo', 182, '{\"old_photo_url\":\"/uploads/students/person_182_1759292700074_l65rb8.jpg\",\"new_photo_url\":\"/uploads/students/person_182_1759292720336_p3uiki.jpg\",\"original_file_name\":\"UMAR MUSA.jpg\",\"original_file_size\":11650372,\"final_file_size\":11650372,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:25:20'),
(899, NULL, 'bulk_photo_upload', 'student_photo', 197, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_197_1759292752689_oixnff.jpg\",\"original_file_name\":\"UMAR.jpg\",\"original_file_size\":12508536,\"final_file_size\":12508536,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:25:52'),
(900, NULL, 'bulk_photo_upload', 'student_photo', 191, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_191_1759293029066_j5fget.jpg\",\"original_file_name\":\"UWAIS SSEKATAWA.jpg\",\"original_file_size\":13073767,\"final_file_size\":13073767,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:30:29'),
(901, NULL, 'bulk_photo_upload', 'student_photo', 189, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_189_1759293068313_fz44wp.jpg\",\"original_file_name\":\"HUZAFA.jpg\",\"original_file_size\":12511684,\"final_file_size\":12511684,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:31:08'),
(902, NULL, 'bulk_photo_upload', 'student_photo', 190, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_190_1759293157586_i2v0hh.jpg\",\"original_file_name\":\"UBAIBU SSEKATAWA.jpg\",\"original_file_size\":13232116,\"final_file_size\":13232116,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 04:32:37'),
(903, NULL, 'update_status', 'students', 132, '{\"status\":\"at_home\"}', NULL, NULL, '2025-10-01 04:33:10'),
(904, NULL, 'update_status', 'students', 608, '{\"status\":\"active\"}', NULL, NULL, '2025-10-01 05:27:40'),
(905, NULL, 'student_update', 'student', 608, '{\"first_name\":\"AAYAT\",\"last_name\":\"UTHMAN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":\"13\",\"status\":\"active\",\"photo_url\":\"/uploads/students/1759296412680-ayat.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 05:27:57'),
(906, NULL, 'bulk_photo_upload', 'student_photo', 151, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_151_1759299513269_eslv72.jpg\",\"original_file_name\":\"20251002_095249[1].jpg\",\"original_file_size\":12074052,\"final_file_size\":12074052,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:18:33'),
(907, NULL, 'bulk_photo_upload', 'student_photo', 211, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_211_1759299931035_voekh3.jpg\",\"original_file_name\":\"20251002_095405.jpg\",\"original_file_size\":11926847,\"final_file_size\":11926847,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:31'),
(908, NULL, 'bulk_photo_upload', 'student_photo', 137, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_137_1759299934364_rotd9j.jpg\",\"original_file_name\":\"20251002_095426.jpg\",\"original_file_size\":11785749,\"final_file_size\":11785749,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:34'),
(909, NULL, 'bulk_photo_upload', 'student_photo', 141, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_141_1759299936889_ig5aof.jpg\",\"original_file_name\":\"20251002_095615.jpg\",\"original_file_size\":2816669,\"final_file_size\":2816669,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:36'),
(910, NULL, 'bulk_photo_upload', 'student_photo', 205, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_205_1759299939935_r4qgju.jpg\",\"original_file_name\":\"20251002_095746.jpg\",\"original_file_size\":11830534,\"final_file_size\":11830534,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:40'),
(911, NULL, 'bulk_photo_upload', 'student_photo', 206, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_206_1759299943414_s0hnse.jpg\",\"original_file_name\":\"20251002_100203.jpg\",\"original_file_size\":11925765,\"final_file_size\":11925765,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:43'),
(912, NULL, 'bulk_photo_upload', 'student_photo', 140, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_140_1759299947004_g0b09l.jpg\",\"original_file_name\":\"20251002_100301.jpg\",\"original_file_size\":11070870,\"final_file_size\":11070870,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:47'),
(913, NULL, 'bulk_photo_upload', 'student_photo', 184, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_184_1759299949843_9vqw6a.jpg\",\"original_file_name\":\"20251002_100342.jpg\",\"original_file_size\":11132720,\"final_file_size\":11132720,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:50'),
(914, NULL, 'bulk_photo_upload', 'student_photo', 219, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_219_1759299953399_1oviws.jpg\",\"original_file_name\":\"20251002_101624.jpg\",\"original_file_size\":11871635,\"final_file_size\":11871635,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-01 06:25:53'),
(915, NULL, 'student_update', 'student', 476, '{\"first_name\":\"ABDUL-RAZAK\",\"last_name\":\"AHMED\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:33:54'),
(916, NULL, 'student_update', 'student', 510, '{\"first_name\":\"ABDUL-WAHAB\",\"last_name\":\"MUHSIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:34:12'),
(917, NULL, 'student_update', 'student', 587, '{\"first_name\":\"FRAIHA\",\"last_name\":\"BINT MUHAMMAD\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:34:30'),
(918, NULL, 'student_update', 'student', 478, '{\"first_name\":\"GASEMBA\",\"last_name\":\"ALI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:34:44'),
(919, NULL, 'student_update', 'student', 459, '{\"first_name\":\"HASSAN\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:35:43'),
(920, NULL, 'update_status', 'students', 466, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 10:37:33'),
(921, NULL, 'student_update', 'student', 466, '{\"first_name\":\"IWUMBWE\",\"last_name\":\"FARAHAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:37:42'),
(922, NULL, 'student_update', 'student', 521, '{\"first_name\":\"KALINISE\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:38:09'),
(923, NULL, 'student_update', 'student', 482, '{\"first_name\":\"KASADHA\",\"last_name\":\"FAJIRDIIN FAHMAI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:38:30'),
(924, NULL, 'student_update', 'student', 470, '{\"first_name\":\"KINTU\",\"last_name\":\"NAJIB\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:38:42'),
(925, NULL, 'update_status', 'students', 475, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 10:40:11'),
(926, NULL, 'student_update', 'student', 519, '{\"first_name\":\"MAGANDA\",\"last_name\":\"BADIRUDIIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:40:22'),
(927, NULL, 'student_update', 'student', 494, '{\"first_name\":\"MAGANDA\",\"last_name\":\"MUHSIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:40:34'),
(928, NULL, 'student_update', 'student', 505, '{\"first_name\":\"ABDUL QAHALU\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_508_1758732463726_svv7wf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 10:54:28'),
(929, NULL, 'update_status', 'students', 573, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 10:56:18'),
(930, NULL, 'update_status', 'students', 132, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 10:56:42'),
(931, NULL, 'bulk_photo_upload', 'student_photo', 544, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_544_1759406858864_tj5r3h.jpg\",\"original_file_name\":\"20251006_130216[1].jpg\",\"original_file_size\":12368866,\"final_file_size\":12368866,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:07:39'),
(932, NULL, 'bulk_photo_upload', 'student_photo', 536, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_536_1759406861779_3ulj2s.jpg\",\"original_file_name\":\"20251006_130237[1].jpg\",\"original_file_size\":10902934,\"final_file_size\":10902934,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:07:41'),
(933, NULL, 'student_update', 'student', 533, '{\"first_name\":\"NAWEMBA\",\"last_name\":\"SINAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_536_1759406861779_3ulj2s.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:08:25'),
(934, NULL, 'student_update', 'student', 541, '{\"first_name\":\"KIJAMBU\",\"last_name\":\"MAITHARAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_544_1759406858864_tj5r3h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:08:49'),
(935, NULL, 'update_status', 'students', 193, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 12:10:42'),
(936, NULL, 'student_update', 'student', 372, '{\"first_name\":\"ABUBAKALI\",\"last_name\":\"SWIDIQ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:26:07'),
(937, NULL, 'bulk_photo_upload', 'student_photo', 373, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_373_1759408226055_5x69hb.jpg\",\"original_file_name\":\"Abubakar swidiq.jpg\",\"original_file_size\":11817001,\"final_file_size\":11817001,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:26'),
(938, NULL, 'bulk_photo_upload', 'student_photo', 345, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_345_1759408229775_z5r4we.jpg\",\"original_file_name\":\"Ahmed mudathir.jpg\",\"original_file_size\":12078452,\"final_file_size\":12078452,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:29'),
(939, NULL, 'bulk_photo_upload', 'student_photo', 337, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_337_1759408233202_fekabf.jpg\",\"original_file_name\":\"Amirah Husna.jpg\",\"original_file_size\":11054669,\"final_file_size\":11054669,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:33'),
(940, NULL, 'bulk_photo_upload', 'student_photo', 353, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_353_1759408236856_h643eh.jpg\",\"original_file_name\":\"Aqeil.jpg\",\"original_file_size\":12265123,\"final_file_size\":12265123,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:37'),
(941, NULL, 'bulk_photo_upload', 'student_photo', 371, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_371_1759408239603_deo7x3.jpg\",\"original_file_name\":\"Ashiba bunt yusf.jpg\",\"original_file_size\":10686142,\"final_file_size\":10686142,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:39'),
(942, NULL, 'bulk_photo_upload', 'student_photo', 377, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_377_1759408242137_jpcoh1.jpg\",\"original_file_name\":\"Asiimwe fahim.jpg\",\"original_file_size\":12427442,\"final_file_size\":12427442,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:42'),
(943, NULL, 'bulk_photo_upload', 'student_photo', 354, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_354_1759408243726_zew13c.jpg\",\"original_file_name\":\"Asima bint falid.jpg\",\"original_file_size\":10491420,\"final_file_size\":10491420,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:43'),
(944, NULL, 'bulk_photo_upload', 'student_photo', 577, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_577_1759408246415_9xgwrq.jpg\",\"original_file_name\":\"Bakaki jamada.jpg\",\"original_file_size\":11648312,\"final_file_size\":11648312,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:46'),
(945, NULL, 'bulk_photo_upload', 'student_photo', 388, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_388_1759408249117_jcm204.jpg\",\"original_file_name\":\"Bakaki swabur.jpg\",\"original_file_size\":12226683,\"final_file_size\":12226683,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:49'),
(946, NULL, 'bulk_photo_upload', 'student_photo', 376, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_376_1759408251794_e9etne.jpg\",\"original_file_name\":\"Bamulanzeki rama.jpg\",\"original_file_size\":11844688,\"final_file_size\":11844688,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:52'),
(947, NULL, 'bulk_photo_upload', 'student_photo', 380, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_380_1759408253971_og6gi9.jpg\",\"original_file_name\":\"Bikadho adam.jpg\",\"original_file_size\":12243794,\"final_file_size\":12243794,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:54'),
(948, NULL, 'bulk_photo_upload', 'student_photo', 357, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_357_1759408256487_witv40.jpg\",\"original_file_name\":\"Fahmat nakisuyi.jpg\",\"original_file_size\":11117943,\"final_file_size\":11117943,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:30:56'),
(949, NULL, 'student_update', 'student', 344, '{\"first_name\":\"AHMED\",\"last_name\":\"MUDATHIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_345_1759408229775_z5r4we.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:31:27'),
(950, NULL, 'student_update', 'student', 336, '{\"first_name\":\"AMIRAH\",\"last_name\":\"HUSSNAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_337_1759408233202_fekabf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:31:40'),
(951, NULL, 'student_update', 'student', 357, '{\"first_name\":\"ANISHA\",\"last_name\":\"MUTESI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:31:54'),
(952, NULL, 'bulk_photo_upload', 'student_photo', 356, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_356_1759408646596_3sohnz.jpg\",\"original_file_name\":\"Gasemba azed.jpg\",\"original_file_size\":12125056,\"final_file_size\":12125056,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:26'),
(953, NULL, 'bulk_photo_upload', 'student_photo', 389, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_389_1759408650195_m1kwws.jpg\",\"original_file_name\":\"Gobi .jpg\",\"original_file_size\":12597680,\"final_file_size\":12597680,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:30'),
(954, NULL, 'bulk_photo_upload', 'student_photo', 344, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_344_1759408653336_3d1j4k.jpg\",\"original_file_name\":\"Kakaire ukasha.jpg\",\"original_file_size\":11176125,\"final_file_size\":11176125,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:33'),
(955, NULL, 'bulk_photo_upload', 'student_photo', 355, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_355_1759408655555_7patul.jpg\",\"original_file_name\":\"Kakoza huzair.jpg\",\"original_file_size\":12245369,\"final_file_size\":12245369,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:35'),
(956, NULL, 'bulk_photo_upload', 'student_photo', 391, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_391_1759408658710_p5z00j.jpg\",\"original_file_name\":\"Kansime hassana.jpg\",\"original_file_size\":11044059,\"final_file_size\":11044059,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:38'),
(957, NULL, 'bulk_photo_upload', 'student_photo', 340, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_340_1759408661825_prr3rm.jpg\",\"original_file_name\":\"Katende.jpg\",\"original_file_size\":12048105,\"final_file_size\":12048105,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:41'),
(958, NULL, 'bulk_photo_upload', 'student_photo', 342, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_342_1759408664036_xiybjz.jpg\",\"original_file_name\":\"Kato Hussein.jpg\",\"original_file_size\":11242150,\"final_file_size\":11242150,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:44'),
(959, NULL, 'bulk_photo_upload', 'student_photo', 348, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_348_1759408667301_v7ycp3.jpg\",\"original_file_name\":\"Kisuyi huzair.jpg\",\"original_file_size\":11686970,\"final_file_size\":11686970,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:47'),
(960, NULL, 'bulk_photo_upload', 'student_photo', 347, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_347_1759408670420_z0q8a4.jpg\",\"original_file_name\":\"Konera husna.jpg\",\"original_file_size\":11113791,\"final_file_size\":11113791,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:50'),
(961, NULL, 'bulk_photo_upload', 'student_photo', 392, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_392_1759408672723_fy3i17.jpg\",\"original_file_name\":\"Matenda rauf.jpg\",\"original_file_size\":11633779,\"final_file_size\":11633779,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:52'),
(962, NULL, 'bulk_photo_upload', 'student_photo', 382, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_382_1759408676108_18jgp7.jpg\",\"original_file_name\":\"Mondo .jpg\",\"original_file_size\":11579457,\"final_file_size\":11579457,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:56'),
(963, NULL, 'bulk_photo_upload', 'student_photo', 350, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_350_1759408679264_oxthsd.jpg\",\"original_file_name\":\"Mpaulo shaban.jpg\",\"original_file_size\":11725445,\"final_file_size\":11725445,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:37:59'),
(964, NULL, 'bulk_photo_upload', 'student_photo', 383, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_383_1759408681553_0eqs4u.jpg\",\"original_file_name\":\"Muhsin abdul k.jpg\",\"original_file_size\":10892165,\"final_file_size\":10892165,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:38:01'),
(965, NULL, 'bulk_photo_upload', 'student_photo', 358, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_358_1759408684763_4b5pbz.jpg\",\"original_file_name\":\"Mutesa anisha.jpg\",\"original_file_size\":10471891,\"final_file_size\":10471891,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:38:04'),
(966, NULL, 'bulk_photo_upload', 'student_photo', 338, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_338_1759408688111_kmrsyf.jpg\",\"original_file_name\":\"Mutesi rahma.jpg\",\"original_file_size\":11919598,\"final_file_size\":11919598,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:38:08'),
(967, NULL, 'bulk_photo_upload', 'student_photo', 346, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_346_1759408690334_m12jf3.jpg\",\"original_file_name\":\"Mutuba.jpg\",\"original_file_size\":11824025,\"final_file_size\":11824025,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:38:10'),
(968, NULL, 'bulk_photo_upload', 'student_photo', 381, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_381_1759408694176_b20k7k.jpg\",\"original_file_name\":\"Mwase sudais.jpg\",\"original_file_size\":11201955,\"final_file_size\":11201955,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:38:14'),
(969, NULL, 'bulk_photo_upload', 'student_photo', 384, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_384_1759408830185_wf802t.jpg\",\"original_file_name\":\"Nakimuli.jpg\",\"original_file_size\":10910793,\"final_file_size\":10910793,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:40:30'),
(970, NULL, 'bulk_photo_upload', 'student_photo', 359, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_359_1759408835743_c3kra4.jpg\",\"original_file_name\":\"Salim.jpg\",\"original_file_size\":12179802,\"final_file_size\":12179802,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:40:35'),
(971, NULL, 'bulk_photo_upload', 'student_photo', 352, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_352_1759408881740_pdsibr.jpg\",\"original_file_name\":\"Quraish.jpg\",\"original_file_size\":11406310,\"final_file_size\":11406310,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:41:22'),
(972, NULL, 'bulk_photo_upload', 'student_photo', 374, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_374_1759408955598_qgr5sy.jpg\",\"original_file_name\":\"Pavez.jpg\",\"original_file_size\":12312831,\"final_file_size\":12312831,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:42:35'),
(973, NULL, 'bulk_photo_upload', 'student_photo', 378, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_378_1759408961387_3iwq5g.jpg\",\"original_file_name\":\"Nakibinge.jpg\",\"original_file_size\":11774747,\"final_file_size\":11774747,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:42:41'),
(974, NULL, 'bulk_photo_upload', 'student_photo', 360, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_360_1759409131610_td22b1.jpg\",\"original_file_name\":\"Nakagolo.jpg\",\"original_file_size\":10108060,\"final_file_size\":10108060,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:31'),
(975, NULL, 'bulk_photo_upload', 'student_photo', 364, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_364_1759409135833_z9498t.jpg\",\"original_file_name\":\"Naluwangula noor.jpg\",\"original_file_size\":10948026,\"final_file_size\":10948026,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:35'),
(976, NULL, 'bulk_photo_upload', 'student_photo', 385, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_385_1759409141280_21g5fj.jpg\",\"original_file_name\":\"Namaganda raudha.jpg\",\"original_file_size\":10733046,\"final_file_size\":10733046,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:41'),
(977, NULL, 'bulk_photo_upload', 'student_photo', 336, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_336_1759409146144_ahpdh3.jpg\",\"original_file_name\":\"Namatende Aisha.jpg\",\"original_file_size\":10660906,\"final_file_size\":10660906,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:46'),
(978, NULL, 'bulk_photo_upload', 'student_photo', 362, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_362_1759409150238_6zmzhq.jpg\",\"original_file_name\":\"Nampala Rahma.jpg\",\"original_file_size\":11249307,\"final_file_size\":11249307,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:50'),
(979, NULL, 'bulk_photo_upload', 'student_photo', 390, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_390_1759409152549_dbz1w5.jpg\",\"original_file_name\":\"Namulondo .jpg\",\"original_file_size\":2543564,\"final_file_size\":2543564,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:54'),
(980, NULL, 'bulk_photo_upload', 'student_photo', 363, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_363_1759409157904_8cfgeq.jpg\",\"original_file_name\":\"Namuwaya rahma.jpg\",\"original_file_size\":10809866,\"final_file_size\":10809866,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:45:58'),
(981, NULL, 'bulk_photo_upload', 'student_photo', 366, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_366_1759409163913_f5dosh.jpg\",\"original_file_name\":\"Nangira.jpg\",\"original_file_size\":12085897,\"final_file_size\":12085897,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:04'),
(982, NULL, 'bulk_photo_upload', 'student_photo', 339, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_339_1759409170144_9eimlg.jpg\",\"original_file_name\":\"Nangobi fariha.jpg\",\"original_file_size\":11373187,\"final_file_size\":11373187,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:10'),
(983, NULL, 'bulk_photo_upload', 'student_photo', 372, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_372_1759409174646_260x2c.jpg\",\"original_file_name\":\"Nassali.jpg\",\"original_file_size\":10723776,\"final_file_size\":10723776,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:14'),
(984, NULL, 'bulk_photo_upload', 'student_photo', 365, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_365_1759409180839_cvn8iv.jpg\",\"original_file_name\":\"Sooma.jpg\",\"original_file_size\":11814018,\"final_file_size\":11814018,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:20'),
(985, NULL, 'bulk_photo_upload', 'student_photo', 351, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_351_1759409186005_43tdj2.jpg\",\"original_file_name\":\"Ssebuganda.jpg\",\"original_file_size\":11946845,\"final_file_size\":11946845,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:26'),
(986, NULL, 'bulk_photo_upload', 'student_photo', 375, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_375_1759409190170_sv6b6z.jpg\",\"original_file_name\":\"Sudais abdul Rahman.jpg\",\"original_file_size\":12154739,\"final_file_size\":12154739,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:30'),
(987, NULL, 'bulk_photo_upload', 'student_photo', 367, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_367_1759409196840_4n95eb.jpg\",\"original_file_name\":\"Tibaga.jpg\",\"original_file_size\":10290128,\"final_file_size\":10290128,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:36'),
(988, NULL, 'bulk_photo_upload', 'student_photo', 379, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_379_1759409202484_mqcljg.jpg\",\"original_file_name\":\"Uthman Abubakar.jpg\",\"original_file_size\":12215634,\"final_file_size\":12215634,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:46:42'),
(989, NULL, 'bulk_photo_upload', 'student_photo', 386, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_386_1759409266913_vbw8mh.jpg\",\"original_file_name\":\"Waira muswab.jpg\",\"original_file_size\":11346834,\"final_file_size\":11346834,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:47:47'),
(990, NULL, 'bulk_photo_upload', 'student_photo', 341, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_341_1759409272350_8ohvva.jpg\",\"original_file_name\":\"Waiswa.jpg\",\"original_file_size\":11756321,\"final_file_size\":11756321,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:47:52'),
(991, NULL, 'bulk_photo_upload', 'student_photo', 349, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_349_1759409275298_a27j02.jpg\",\"original_file_name\":\"Yahaya muchaina.jpg\",\"original_file_size\":11978439,\"final_file_size\":11978439,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:47:55'),
(992, NULL, 'student_update', 'student', 383, '{\"first_name\":\"ASHAR\",\"last_name\":\"NAKIMULI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_384_1759408830185_wf802t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:48:22');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(993, NULL, 'student_update', 'student', 376, '{\"first_name\":\"ASIIMWE\",\"last_name\":\"FAHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_377_1759408242137_jpcoh1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:48:43'),
(994, NULL, 'student_update', 'student', 353, '{\"first_name\":\"ASIMA\",\"last_name\":\"FATIHA  FARID\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_354_1759408243726_zew13c.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:48:56'),
(995, NULL, 'student_update', 'student', 387, '{\"first_name\":\"BAKAKI\",\"last_name\":\"SWABAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_388_1759408249117_jcm204.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:49:10'),
(996, NULL, 'student_update', 'student', 375, '{\"first_name\":\"BAMULANZEKI\",\"last_name\":\"RAMADHAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_376_1759408251794_e9etne.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:49:20'),
(997, NULL, 'student_update', 'student', 358, '{\"first_name\":\"BAMULANZEKI\",\"last_name\":\"SALIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_359_1759408835743_c3kra4.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:49:30'),
(998, NULL, 'student_update', 'student', 379, '{\"first_name\":\"BIKADHO\",\"last_name\":\"ADAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_380_1759408253971_og6gi9.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:49:55'),
(999, NULL, 'student_update', 'student', 370, '{\"first_name\":\"BINT YUSUF\",\"last_name\":\"ASHIBA  NANTABO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_371_1759408239603_deo7x3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:50:18'),
(1000, NULL, 'update_status', 'students', 386, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 12:50:33'),
(1001, NULL, 'student_update', 'student', 355, '{\"first_name\":\"GASEMBA\",\"last_name\":\"AZED\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_356_1759408646596_3sohnz.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:50:43'),
(1002, NULL, 'student_update', 'student', 388, '{\"first_name\":\"GOOBI\",\"last_name\":\"ABASI  HANAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_389_1759408650195_m1kwws.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:50:55'),
(1003, NULL, 'student_update', 'student', 351, '{\"first_name\":\"HANIPH\",\"last_name\":\"QURAISH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_352_1759408881740_pdsibr.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:51:05'),
(1004, NULL, 'student_update', 'student', 390, '{\"first_name\":\"HASSANAT\",\"last_name\":\"KANSIIME\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_391_1759408658710_p5z00j.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:51:17'),
(1005, NULL, 'student_update', 'student', 574, '{\"first_name\":\"JAMADAH\",\"last_name\":\"BAKAKI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_577_1759408246415_9xgwrq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:51:29'),
(1006, NULL, 'student_update', 'student', 343, '{\"first_name\":\"KAKAIRE\",\"last_name\":\"UKASHA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_344_1759408653336_3d1j4k.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:51:39'),
(1007, NULL, 'student_update', 'student', 354, '{\"first_name\":\"KAKOOZA\",\"last_name\":\"HUZAIR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_355_1759408655555_7patul.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:51:53'),
(1008, NULL, 'student_update', 'student', 339, '{\"first_name\":\"KATENDE\",\"last_name\":\"ABDUL-RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_340_1759408661825_prr3rm.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:52:09'),
(1009, NULL, 'student_update', 'student', 341, '{\"first_name\":\"KATO\",\"last_name\":\"HUSSEIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_342_1759408664036_xiybjz.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:52:18'),
(1010, NULL, 'student_update', 'student', 347, '{\"first_name\":\"KISUYI\",\"last_name\":\"HUZAIRU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_348_1759408667301_v7ycp3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:52:53'),
(1011, NULL, 'student_update', 'student', 346, '{\"first_name\":\"KONERA\",\"last_name\":\"HUSNAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_347_1759408670420_z0q8a4.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:53:05'),
(1012, NULL, 'student_update', 'student', 391, '{\"first_name\":\"MATENDE\",\"last_name\":\"ABDUL-RAUF\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_392_1759408672723_fy3i17.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:53:19'),
(1013, NULL, 'student_update', 'student', 381, '{\"first_name\":\"MONDO\",\"last_name\":\"HASSAN  RAHUL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_382_1759408676108_18jgp7.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:53:31'),
(1014, NULL, 'student_update', 'student', 349, '{\"first_name\":\"MPAULO\",\"last_name\":\"SHABAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_350_1759408679264_oxthsd.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:53:44'),
(1015, NULL, 'student_update', 'student', 382, '{\"first_name\":\"MUHSIN\",\"last_name\":\"ABDUL-KARIM  NSAMBA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_383_1759408681553_0eqs4u.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:54:12'),
(1016, NULL, 'student_update', 'student', 352, '{\"first_name\":\"MUSASIZI\",\"last_name\":\"AQIEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_353_1759408236856_h643eh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:54:25'),
(1017, NULL, 'student_update', 'student', 373, '{\"first_name\":\"MUSTAFA\",\"last_name\":\"PAVEZ\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_374_1759408955598_qgr5sy.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:54:37'),
(1018, NULL, 'student_update', 'student', 337, '{\"first_name\":\"MUTESI\",\"last_name\":\"RASHMAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_338_1759408688111_kmrsyf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:54:50'),
(1019, NULL, 'student_update', 'student', 345, '{\"first_name\":\"MUTUBA\",\"last_name\":\"IMRAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_346_1759408690334_m12jf3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:55:01'),
(1020, NULL, 'student_update', 'student', 380, '{\"first_name\":\"MWASE\",\"last_name\":\"SUDAIS\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_381_1759408694176_b20k7k.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:55:12'),
(1021, NULL, 'student_update', 'student', 377, '{\"first_name\":\"NAKIBINGE\",\"last_name\":\"IBRA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_378_1759408961387_3iwq5g.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:55:26'),
(1022, NULL, 'student_update', 'student', 356, '{\"first_name\":\"NAKISUYI  FAHMAT\",\"last_name\":\"FAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_357_1759408256487_witv40.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:55:37'),
(1023, NULL, 'student_update', 'student', 363, '{\"first_name\":\"NALUWAGULA\",\"last_name\":\"NOOR\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_364_1759409135833_z9498t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:55:54'),
(1024, NULL, 'student_update', 'student', 384, '{\"first_name\":\"NAMAGANDA\",\"last_name\":\"RAUDHAT\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_385_1759409141280_21g5fj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:56:10'),
(1025, NULL, 'student_update', 'student', 335, '{\"first_name\":\"NAMATENDE\",\"last_name\":\"AISHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_336_1759409146144_ahpdh3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:56:29'),
(1026, NULL, 'student_update', 'student', 361, '{\"first_name\":\"NAMPALA\",\"last_name\":\"RAHMA  MINJA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_362_1759409150238_6zmzhq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:56:42'),
(1027, NULL, 'student_update', 'student', 361, '{\"first_name\":\"NAMPALA\",\"last_name\":\"RAHMA  MINJA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_362_1759409150238_6zmzhq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:56:54'),
(1028, NULL, 'student_update', 'student', 389, '{\"first_name\":\"NAMULONDO\",\"last_name\":\"ZAINAB  RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_390_1759409152549_dbz1w5.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:57:07'),
(1029, NULL, 'student_update', 'student', 362, '{\"first_name\":\"NAMUWAYA\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_363_1759409157904_8cfgeq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:57:24'),
(1030, NULL, 'student_update', 'student', 365, '{\"first_name\":\"NANGIRA\",\"last_name\":\"ABDUL-AYAT\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_366_1759409163913_f5dosh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:57:35'),
(1031, NULL, 'student_update', 'student', 338, '{\"first_name\":\"NANGOBI\",\"last_name\":\"FARIHA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_339_1759409170144_9eimlg.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:57:49'),
(1032, NULL, 'student_update', 'student', 371, '{\"first_name\":\"NASSALI\",\"last_name\":\"FARIHYA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_372_1759409174646_260x2c.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:58:04'),
(1033, NULL, 'student_update', 'student', 359, '{\"first_name\":\"RAHMA\",\"last_name\":\"NAKAGOLO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_360_1759409131610_td22b1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:58:17'),
(1034, NULL, 'student_update', 'student', 350, '{\"first_name\":\"SEBUGANDA\",\"last_name\":\"SHURAIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_351_1759409186005_43tdj2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:58:32'),
(1035, NULL, 'student_update', 'student', 364, '{\"first_name\":\"SOOMA\",\"last_name\":\"ASHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_365_1759409180839_cvn8iv.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:58:48'),
(1036, NULL, 'student_update', 'student', 374, '{\"first_name\":\"SUDAIS\",\"last_name\":\"ABDUL-RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_375_1759409190170_sv6b6z.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:58:59'),
(1037, NULL, 'student_update', 'student', 366, '{\"first_name\":\"TIBAGA\",\"last_name\":\"NUSUFA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_367_1759409196840_4n95eb.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:59:10'),
(1038, NULL, 'student_update', 'student', 378, '{\"first_name\":\"UTHMAN\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_379_1759409202484_mqcljg.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:59:23'),
(1039, NULL, 'student_update', 'student', 385, '{\"first_name\":\"WAIRA\",\"last_name\":\"MUSWABU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_386_1759409266913_vbw8mh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:59:35'),
(1040, NULL, 'student_update', 'student', 348, '{\"first_name\":\"YAHAYA\",\"last_name\":\"MUCHAINA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_349_1759409275298_a27j02.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 12:59:45'),
(1041, NULL, 'student_update', 'student', 573, '{\"first_name\":\"AKSAM\",\"last_name\":\"NGAYIRE LUGOMWA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:03:19'),
(1042, NULL, 'bulk_photo_upload', 'student_photo', 132, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_132_1759410296267_383dyr.jpg\",\"original_file_name\":\"20251002_170810.jpg\",\"original_file_size\":12831972,\"final_file_size\":12831972,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:04:56'),
(1043, NULL, 'bulk_photo_upload', 'student_photo', 194, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_194_1759410371781_75nc97.jpg\",\"original_file_name\":\"20251006_140357.jpg\",\"original_file_size\":1353275,\"final_file_size\":1353275,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:06:11'),
(1044, NULL, 'bulk_photo_upload', 'student_photo', 180, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_180_1759410372697_1l494f.jpg\",\"original_file_name\":\"20251006_140418.jpg\",\"original_file_size\":1369160,\"final_file_size\":1369160,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:06:12'),
(1045, NULL, 'student_update', 'student', 179, '{\"first_name\":\"HAMIDAH\",\"last_name\":\"QASSIM\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":13,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_180_1759410372697_1l494f.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:06:32'),
(1046, NULL, 'bulk_photo_upload', 'student_photo', 404, '{\"old_photo_url\":\"/uploads/students/person_404_1758728760139_pwf9m0.jpg\",\"new_photo_url\":\"/uploads/students/person_404_1759410548390_7fs4dj.jpg\",\"original_file_name\":\"20251006_140900[1].jpg\",\"original_file_size\":11250953,\"final_file_size\":11250953,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:09:08'),
(1047, NULL, 'bulk_photo_upload', 'student_photo', 424, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_424_1759410661539_4taejc.jpg\",\"original_file_name\":\"20251006_140812[1].jpg\",\"original_file_size\":12518429,\"final_file_size\":12518429,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:11:01'),
(1048, NULL, 'bulk_photo_upload', 'student_photo', 406, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_406_1759410689978_zp2pr0.jpg\",\"original_file_name\":\"20251006_140826[1].jpg\",\"original_file_size\":11748090,\"final_file_size\":11748090,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:11:30'),
(1049, NULL, 'student_update', 'student', 405, '{\"first_name\":\"LUWANGULA\",\"last_name\":\"JUMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":8,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_406_1759410689978_zp2pr0.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-02 13:11:48'),
(1050, NULL, 'update_status', 'students', 425, '{\"status\":\"at_home\"}', NULL, NULL, '2025-10-02 13:12:19'),
(1051, NULL, 'update_status', 'students', 409, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 13:12:31'),
(1052, NULL, 'update_status', 'students', 438, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 13:12:37'),
(1053, NULL, 'update_status', 'students', 399, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 13:13:01'),
(1054, NULL, 'update_status', 'students', 166, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-02 13:14:17'),
(1055, NULL, 'update_status', 'students', 151, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 13:14:40'),
(1056, NULL, 'update_status', 'students', 213, '{\"status\":\"active\"}', NULL, NULL, '2025-10-02 13:15:47'),
(1057, NULL, 'bulk_photo_upload', 'student_photo', 133, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_133_1759782452301_1v9oy3.jpg\",\"original_file_name\":\"20251007_163320[1].jpg\",\"original_file_size\":11710695,\"final_file_size\":11710695,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:27:33'),
(1058, NULL, 'bulk_photo_upload', 'student_photo', 155, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_155_1759782584431_blsjbj.jpg\",\"original_file_name\":\"20251007_163447[1].jpg\",\"original_file_size\":11439260,\"final_file_size\":11439260,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:29:45'),
(1059, NULL, 'bulk_photo_upload', 'student_photo', 495, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_495_1759783860473_z84uqf.jpg\",\"original_file_name\":\"Farhan.jpg\",\"original_file_size\":10858222,\"final_file_size\":10858222,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:01'),
(1060, NULL, 'bulk_photo_upload', 'student_photo', 460, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_460_1759783863786_ohu7g5.jpg\",\"original_file_name\":\"Hassan abdallah.jpg\",\"original_file_size\":11404156,\"final_file_size\":11404156,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:03'),
(1061, NULL, 'bulk_photo_upload', 'student_photo', 469, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_469_1759783866833_364fpc.jpg\",\"original_file_name\":\"Iwumbwe.jpg\",\"original_file_size\":11381699,\"final_file_size\":11381699,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:06'),
(1062, NULL, 'bulk_photo_upload', 'student_photo', 524, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_524_1759783869817_tef9yk.jpg\",\"original_file_name\":\"Kalinise.jpg\",\"original_file_size\":11234540,\"final_file_size\":11234540,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:09'),
(1063, NULL, 'bulk_photo_upload', 'student_photo', 522, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_522_1759783873606_yhg391.jpg\",\"original_file_name\":\"Maganda badirudin.jpg\",\"original_file_size\":11105285,\"final_file_size\":11105285,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:13'),
(1064, NULL, 'bulk_photo_upload', 'student_photo', 497, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_497_1759783876507_084drl.jpg\",\"original_file_name\":\"Maganda muhsin.jpg\",\"original_file_size\":10676656,\"final_file_size\":10676656,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:16'),
(1065, NULL, 'bulk_photo_upload', 'student_photo', 505, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_505_1759783878513_gjgd3i.jpg\",\"original_file_name\":\"Mudola.jpg\",\"original_file_size\":11214131,\"final_file_size\":11214131,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:18'),
(1066, NULL, 'bulk_photo_upload', 'student_photo', 488, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_488_1759783881605_xr62cf.jpg\",\"original_file_name\":\"Ssembatya.jpg\",\"original_file_size\":11208449,\"final_file_size\":11208449,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:21'),
(1067, NULL, 'bulk_photo_upload', 'student_photo', 489, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_489_1759783884696_mmjsg9.jpg\",\"original_file_name\":\"Ssonzi.jpg\",\"original_file_size\":11348553,\"final_file_size\":11348553,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:51:24'),
(1068, NULL, 'student_update', 'student', 474, '{\"first_name\":\"IBRAHIIM\",\"last_name\":\"ABUBAKAR\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 20:53:35'),
(1069, NULL, 'update_status', 'students', 481, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-06 20:57:54'),
(1070, NULL, 'student_update', 'student', 609, '{\"first_name\":\"MASOLO\",\"last_name\":\"RASHID\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/1759793020602-Masolo.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 23:24:22'),
(1071, NULL, 'student_update', 'student', 611, '{\"first_name\":\"MUSENE\",\"last_name\":\"HAFIDHI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/1759793189845-Musene.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 23:27:13'),
(1072, NULL, 'student_update', 'student', 610, '{\"first_name\":\"KIRUNDA\",\"last_name\":\"UKASHA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/1759793136755-Kirunda ukasha.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 23:27:51'),
(1073, NULL, 'update_status', 'students', 368, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-06 23:28:53'),
(1074, NULL, 'bulk_photo_upload', 'student_photo', 567, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_567_1759793545225_h37fq8.jpg\",\"original_file_name\":\"asmah nn.jpg\",\"original_file_size\":11294325,\"final_file_size\":11294325,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-06 23:32:25'),
(1075, NULL, 'bulk_photo_upload', 'student_photo', 611, '{\"old_photo_url\":\"/uploads/students/1759296412680-ayat.jpg\",\"new_photo_url\":\"/uploads/students/person_611_1760020942546_6bjtc5.jpg\",\"original_file_name\":\"ayat.jpg\",\"original_file_size\":1497816,\"final_file_size\":1497816,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 14:42:24'),
(1076, NULL, 'bulk_photo_upload', 'student_photo', 610, '{\"old_photo_url\":\"/uploads/students/person_610_1759281105976_balipg.jpg\",\"new_photo_url\":\"/uploads/students/person_610_1760020949639_bciwuz.jpg\",\"original_file_name\":\"shukran.jpg\",\"original_file_size\":1562085,\"final_file_size\":1562085,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 14:42:30'),
(1077, NULL, 'bulk_photo_upload', 'student_photo', 207, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_207_1760021421858_1s7lt1.jpg\",\"original_file_name\":\"20251009_104145[1].jpg\",\"original_file_size\":11722177,\"final_file_size\":11722177,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 14:50:22'),
(1078, NULL, 'bulk_photo_upload', 'student_photo', 477, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_477_1760039420176_77qcb5.jpg\",\"original_file_name\":\"abubakr.jpg\",\"original_file_size\":12622273,\"final_file_size\":12622273,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:21'),
(1079, NULL, 'bulk_photo_upload', 'student_photo', 590, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_590_1760039425700_b8n0mz.jpg\",\"original_file_name\":\"fraiha.jpg\",\"original_file_size\":11831157,\"final_file_size\":11831157,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:25'),
(1080, NULL, 'bulk_photo_upload', 'student_photo', 481, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_481_1760039429021_poolld.jpg\",\"original_file_name\":\"gasemba ali.jpg\",\"original_file_size\":13265478,\"final_file_size\":13265478,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:29'),
(1081, NULL, 'bulk_photo_upload', 'student_photo', 513, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_513_1760039433637_b9pe01.jpg\",\"original_file_name\":\"guya.jpg\",\"original_file_size\":12934601,\"final_file_size\":12934601,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:33'),
(1082, NULL, 'bulk_photo_upload', 'student_photo', 467, '{\"old_photo_url\":\"/uploads/students/person_467_1758732805904_w4zzgo.jpg\",\"new_photo_url\":\"/uploads/students/person_467_1760039434686_ybl2re.jpg\",\"original_file_name\":\"IMG-20241031-WA0012.jpg\",\"original_file_size\":123938,\"final_file_size\":123938,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:34'),
(1083, NULL, 'bulk_photo_upload', 'student_photo', 485, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_485_1760039440182_d81yv3.jpg\",\"original_file_name\":\"kasadha.jpg\",\"original_file_size\":12448544,\"final_file_size\":12448544,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:40'),
(1084, NULL, 'bulk_photo_upload', 'student_photo', 472, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_472_1760039446552_ow88aq.jpg\",\"original_file_name\":\"kiza.jpg\",\"original_file_size\":12436325,\"final_file_size\":12436325,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:46'),
(1085, NULL, 'bulk_photo_upload', 'student_photo', 525, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_525_1760039449744_00r2mh.jpg\",\"original_file_name\":\"mukisa.jpg\",\"original_file_size\":13783439,\"final_file_size\":13783439,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:50:49'),
(1086, NULL, 'bulk_photo_upload', 'student_photo', 470, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_470_1760039632739_2uqie4.jpg\",\"original_file_name\":\"guya.jpg\",\"original_file_size\":12934601,\"final_file_size\":12934601,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:53:52'),
(1087, NULL, 'student_update', 'student', 510, '{\"first_name\":\"ABDUL-WAHAB\",\"last_name\":\"MUHSIN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"dropped_out\",\"photo_url\":\"/uploads/students/person_513_1760039433637_b9pe01.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 19:55:24'),
(1088, NULL, 'update_status', 'students', 469, '{\"status\":\"active\"}', NULL, NULL, '2025-10-09 19:56:26'),
(1089, NULL, 'update_status', 'students', 580, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-09 19:57:37'),
(1090, NULL, 'update_status', 'students', 440, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-09 19:58:05'),
(1091, NULL, 'bulk_photo_upload', 'student_photo', 576, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_576_1760040036182_yccyzn.jpg\",\"original_file_name\":\"20251010_112907[1].jpg\",\"original_file_size\":11692423,\"final_file_size\":11692423,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 20:00:36'),
(1092, NULL, 'student_update', 'student', 383, '{\"first_name\":\"AISHA\",\"last_name\":\"NAKIMULI\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_384_1759408830185_wf802t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 21:21:37'),
(1093, NULL, 'student_update', 'student', 337, '{\"first_name\":\"MUTESI\",\"last_name\":\"RAHMAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":7,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_338_1759408688111_kmrsyf.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 21:22:35'),
(1094, NULL, 'student_update', 'student', 290, '{\"first_name\":\"ABDALLAH\",\"last_name\":\"HABIBU\",\"other_name\":\"\",\"gender\":\"\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:34:46'),
(1095, NULL, 'student_update', 'student', 287, '{\"first_name\":\"ASHURAH\",\"last_name\":\"FAHIMAH\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:35:13'),
(1096, NULL, 'student_update', 'student', 315, '{\"first_name\":\"GAALI\",\"last_name\":\"FARAFAT\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:39:25'),
(1097, NULL, 'student_update', 'student', 273, '{\"first_name\":\"KASADHA\",\"last_name\":\"RAIHAN\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:40:10'),
(1098, NULL, 'student_update', 'student', 301, '{\"first_name\":\"KATIIKI\",\"last_name\":\"RAHMA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:40:39'),
(1099, NULL, 'student_update', 'student', 319, '{\"first_name\":\"UTHUMAN\",\"last_name\":\"MINSHAWI\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:41:31'),
(1100, NULL, 'student_update', 'student', 307, '{\"first_name\":\"MUGEYI\",\"last_name\":\"HISHAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:42:24'),
(1101, NULL, 'student_update', 'student', 293, '{\"first_name\":\"NABUKERA\",\"last_name\":\"RAUFA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:43:15'),
(1102, NULL, 'student_update', 'student', 291, '{\"first_name\":\"NAKAGOLO\",\"last_name\":\"SHATURAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:43:40'),
(1103, NULL, 'student_update', 'student', 320, '{\"first_name\":\"NALUZZE\",\"last_name\":\"THUWAIBAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:44:22'),
(1104, NULL, 'student_update', 'student', 277, '{\"first_name\":\"NANYANZI\",\"last_name\":\"LEILA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:44:50'),
(1105, NULL, 'student_update', 'student', 290, '{\"first_name\":\"ABDALLAH\",\"last_name\":\"HABIBU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:45:56'),
(1106, NULL, 'student_update', 'student', 278, '{\"first_name\":\"ABDUL\",\"last_name\":\"BAAR ISA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:46:07'),
(1107, NULL, 'student_update', 'student', 326, '{\"first_name\":\"ABDUL-KARIM\",\"last_name\":\"ABDALLAH\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:46:42'),
(1108, NULL, 'student_update', 'student', 288, '{\"first_name\":\"ABDUL-QAWIYU\",\"last_name\":\"WAKO\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:46:57'),
(1109, NULL, 'student_update', 'student', 303, '{\"first_name\":\"ABDUL-SHAKUR\",\"last_name\":\"MALINZI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:47:39');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(1110, NULL, 'student_update', 'student', 287, '{\"first_name\":\"ASHURAH\",\"last_name\":\"FAHIMAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-09 23:47:53'),
(1111, NULL, 'student_update', 'student', 315, '{\"first_name\":\"GAALI\",\"last_name\":\"FARAHAT\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 13:16:31'),
(1112, NULL, 'update_status', 'students', 625, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 15:40:40'),
(1113, NULL, 'student_update', 'student', 252, '{\"first_name\":\"KISIGE\",\"last_name\":\"SHAHID\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:02:12'),
(1114, NULL, 'student_update', 'student', 240, '{\"first_name\":\"NAMUYANGU\",\"last_name\":\"SHUKRAN\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:02:47'),
(1115, NULL, 'student_update', 'student', 237, '{\"first_name\":\"SSERUNJOJI\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:03:24'),
(1116, NULL, 'student_update', 'student', 229, '{\"first_name\":\"UTHUMAN\",\"last_name\":\"KALISA\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:04:16'),
(1117, NULL, 'student_update', 'student', 100, '{\"first_name\":\"NANGOBI\",\"last_name\":\"HAMZAH\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":4,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:05:18'),
(1118, NULL, 'student_update', 'student', 102, '{\"first_name\":\"SWALLAHUDIN\",\"last_name\":\"BUN UMAR MENYA\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":4,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:06:18'),
(1119, NULL, 'student_update', 'student', 74, '{\"first_name\":\"NAMUWAYA\",\"last_name\":\"SAUYA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":3,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 19:07:11'),
(1120, 1, 'edit_result', 'class_result', 1897, '{\"before\":{\"id\":1897,\"student_id\":583,\"class_id\":9,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:54:11.000Z\",\"updated_at\":null},\"after\":{\"id\":1897,\"student_id\":583,\"class_id\":9,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"51.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:54:11.000Z\",\"updated_at\":\"2025-10-17T21:59:22.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:59:24'),
(1121, 1, 'edit_result', 'class_result', 1912, '{\"before\":{\"id\":1912,\"student_id\":579,\"class_id\":9,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"35.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:54:12.000Z\",\"updated_at\":null},\"after\":{\"id\":1912,\"student_id\":579,\"class_id\":9,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"35.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:54:12.000Z\",\"updated_at\":\"2025-10-17T22:00:02.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:00:02'),
(1122, NULL, 'student_update', 'student', 508, '{\"first_name\":\"DHABULIWO\",\"last_name\":\"HASHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":9,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_511_1758732769284_7rryfj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:02:26'),
(1123, 1, 'edit_result', 'class_result', 2304, '{\"before\":{\"id\":2304,\"student_id\":452,\"class_id\":8,\"subject_id\":1,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:36:10.000Z\",\"updated_at\":null},\"after\":{\"id\":2304,\"student_id\":452,\"class_id\":8,\"subject_id\":1,\"term_id\":1,\"result_type_id\":2,\"score\":\"18.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:36:10.000Z\",\"updated_at\":\"2025-10-17T22:55:27.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:55:29'),
(1124, 1, 'edit_result', 'class_result', 1665, '{\"before\":{\"id\":1665,\"student_id\":61,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:42.000Z\",\"updated_at\":null},\"after\":{\"id\":1665,\"student_id\":61,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:42.000Z\",\"updated_at\":\"2025-10-17T23:39:14.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:39:15'),
(1125, 1, 'edit_result', 'class_result', 1647, '{\"before\":{\"id\":1647,\"student_id\":52,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"90.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:41.000Z\",\"updated_at\":null},\"after\":{\"id\":1647,\"student_id\":52,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:41.000Z\",\"updated_at\":\"2025-10-17T23:39:39.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:39:39'),
(1126, 1, 'edit_result', 'class_result', 1771, '{\"before\":{\"id\":1771,\"student_id\":52,\"class_id\":2,\"subject_id\":18,\"term_id\":1,\"result_type_id\":2,\"score\":\"89.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:54:03.000Z\",\"updated_at\":null},\"after\":{\"id\":1771,\"student_id\":52,\"class_id\":2,\"subject_id\":18,\"term_id\":1,\"result_type_id\":2,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:54:03.000Z\",\"updated_at\":\"2025-10-17T23:44:00.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:44:00'),
(1127, 1, 'edit_result', 'class_result', 1647, '{\"before\":{\"id\":1647,\"student_id\":52,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:41.000Z\",\"updated_at\":\"2025-10-17T23:39:39.000Z\"},\"after\":{\"id\":1647,\"student_id\":52,\"class_id\":2,\"subject_id\":16,\"term_id\":1,\"result_type_id\":2,\"score\":\"90.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:36:41.000Z\",\"updated_at\":\"2025-10-17T23:44:22.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:44:22'),
(1128, 1, 'edit_result', 'class_result', 1758, '{\"before\":{\"id\":1758,\"student_id\":47,\"class_id\":2,\"subject_id\":17,\"term_id\":1,\"result_type_id\":2,\"score\":\"88.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:50:24.000Z\",\"updated_at\":null},\"after\":{\"id\":1758,\"student_id\":47,\"class_id\":2,\"subject_id\":17,\"term_id\":1,\"result_type_id\":2,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T17:50:24.000Z\",\"updated_at\":\"2025-10-17T23:45:20.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:45:20'),
(1129, NULL, 'student_update', 'student', 565, '{\"first_name\":\"NAMUGABO\",\"last_name\":\"JAUHARAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_568_1758770198777_gegdfk.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:49:33'),
(1130, NULL, 'student_update', 'student', 604, '{\"first_name\":\"NADIA\",\"last_name\":\"MASITULA HITLA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_607_1758770165452_nvwmah.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:50:10'),
(1131, NULL, 'student_update', 'student', 530, '{\"first_name\":\"NABULUMBA\",\"last_name\":\"NAHIYAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_533_1758770144581_mr80w3.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:51:15'),
(1132, NULL, 'student_update', 'student', 551, '{\"first_name\":\"UMMUSULAIMU\",\"last_name\":\"KANTONO\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_554_1758770611536_yewckh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:51:48'),
(1133, NULL, 'student_update', 'student', 524, '{\"first_name\":\"NANGOBI\",\"last_name\":\"SHAFUKA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":10,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_527_1758770547636_8o9p2h.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:52:34'),
(1134, 1, 'edit_result', 'class_result', 2460, '{\"before\":{\"id\":2460,\"student_id\":604,\"class_id\":10,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T21:13:40.000Z\",\"updated_at\":null},\"after\":{\"id\":2460,\"student_id\":604,\"class_id\":10,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"52.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T21:13:40.000Z\",\"updated_at\":\"2025-10-17T23:53:32.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:53:32'),
(1135, 1, 'edit_result', 'class_result', 2468, '{\"before\":{\"id\":2468,\"student_id\":563,\"class_id\":10,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T21:13:40.000Z\",\"updated_at\":null},\"after\":{\"id\":2468,\"student_id\":563,\"class_id\":10,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"37.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T21:13:40.000Z\",\"updated_at\":\"2025-10-17T23:53:51.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:53:51'),
(1136, NULL, 'student_update', 'student', 271, '{\"first_name\":\"BIYINZIKA\",\"last_name\":\"PIAUS\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:47:16'),
(1137, NULL, 'student_update', 'student', 226, '{\"first_name\":\"MPAULO\",\"last_name\":\"SWALIK\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:47:42'),
(1138, NULL, 'student_update', 'student', 236, '{\"first_name\":\"ARIAN\",\"last_name\":\"MUHAMAAD\",\"other_name\":\"\",\"gender\":\"\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:48:21'),
(1139, NULL, 'student_update', 'student', 257, '{\"first_name\":\"NDAADA\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:48:47'),
(1140, NULL, 'student_update', 'student', 242, '{\"first_name\":\"NAMUSUSWA\",\"last_name\":\"RASHIM\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:49:23'),
(1141, NULL, 'student_update', 'student', 572, '{\"first_name\":\"CLOCK\",\"last_name\":\"ROSHAN\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:50:09'),
(1142, NULL, 'student_update', 'student', 316, '{\"first_name\":\"NANGOBI\",\"last_name\":\"AALIYA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:50:54'),
(1143, 1, 'edit_result', 'class_result', 811, '{\"before\":{\"id\":811,\"student_id\":313,\"class_id\":6,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:44:10.000Z\",\"updated_at\":null},\"after\":{\"id\":811,\"student_id\":313,\"class_id\":6,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"49.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:44:10.000Z\",\"updated_at\":\"2025-10-17T21:54:32.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:54:32'),
(1144, 1, 'edit_result', 'class_result', 884, '{\"before\":{\"id\":884,\"student_id\":313,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:01.000Z\",\"updated_at\":null},\"after\":{\"id\":884,\"student_id\":313,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:01.000Z\",\"updated_at\":\"2025-10-17T21:54:37.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:54:37'),
(1145, 1, 'edit_result', 'class_result', 884, '{\"before\":{\"id\":884,\"student_id\":313,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:01.000Z\",\"updated_at\":\"2025-10-17T21:54:37.000Z\"},\"after\":{\"id\":884,\"student_id\":313,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"46.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:01.000Z\",\"updated_at\":\"2025-10-17T21:54:58.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:54:58'),
(1146, 1, 'edit_result', 'class_result', 865, '{\"before\":{\"id\":865,\"student_id\":325,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:00.000Z\",\"updated_at\":null},\"after\":{\"id\":865,\"student_id\":325,\"class_id\":6,\"subject_id\":7,\"term_id\":1,\"result_type_id\":2,\"score\":\"88.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T00:56:00.000Z\",\"updated_at\":\"2025-10-17T21:56:01.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:56:01'),
(1147, 1, 'edit_result', 'class_result', 934, '{\"before\":{\"id\":934,\"student_id\":325,\"class_id\":6,\"subject_id\":8,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T01:09:28.000Z\",\"updated_at\":null},\"after\":{\"id\":934,\"student_id\":325,\"class_id\":6,\"subject_id\":8,\"term_id\":1,\"result_type_id\":2,\"score\":\"86.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T01:09:28.000Z\",\"updated_at\":\"2025-10-17T21:56:21.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:56:21'),
(1148, 1, 'edit_result', 'class_result', 1011, '{\"before\":{\"id\":1011,\"student_id\":325,\"class_id\":6,\"subject_id\":9,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T01:22:05.000Z\",\"updated_at\":null},\"after\":{\"id\":1011,\"student_id\":325,\"class_id\":6,\"subject_id\":9,\"term_id\":1,\"result_type_id\":2,\"score\":\"78.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-10T01:22:05.000Z\",\"updated_at\":\"2025-10-17T21:56:34.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 21:56:34'),
(1149, 1, 'edit_result', 'class_result', 2198, '{\"before\":{\"id\":2198,\"student_id\":432,\"class_id\":8,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:25:39.000Z\",\"updated_at\":null},\"after\":{\"id\":2198,\"student_id\":432,\"class_id\":8,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"82.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:25:39.000Z\",\"updated_at\":\"2025-10-17T22:33:59.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:33:59'),
(1150, 1, 'edit_result', 'class_result', 2128, '{\"before\":{\"id\":2128,\"student_id\":432,\"class_id\":8,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:12:17.000Z\",\"updated_at\":null},\"after\":{\"id\":2128,\"student_id\":432,\"class_id\":8,\"subject_id\":3,\"term_id\":1,\"result_type_id\":2,\"score\":\"82.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:12:17.000Z\",\"updated_at\":\"2025-10-17T22:34:10.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:34:10'),
(1151, 1, 'edit_result', 'class_result', 2267, '{\"before\":{\"id\":2267,\"student_id\":432,\"class_id\":8,\"subject_id\":1,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:36:08.000Z\",\"updated_at\":null},\"after\":{\"id\":2267,\"student_id\":432,\"class_id\":8,\"subject_id\":1,\"term_id\":1,\"result_type_id\":2,\"score\":\"72.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:36:08.000Z\",\"updated_at\":\"2025-10-17T22:34:24.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:34:25'),
(1152, 1, 'edit_result', 'class_result', 2336, '{\"before\":{\"id\":2336,\"student_id\":432,\"class_id\":8,\"subject_id\":2,\"term_id\":1,\"result_type_id\":2,\"score\":\"0.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:45:09.000Z\",\"updated_at\":null},\"after\":{\"id\":2336,\"student_id\":432,\"class_id\":8,\"subject_id\":2,\"term_id\":1,\"result_type_id\":2,\"score\":\"84.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:45:09.000Z\",\"updated_at\":\"2025-10-17T22:34:42.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:34:42'),
(1153, NULL, 'bulk_photo_upload', 'student_photo', 291, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_291_1760741856578_r3zuwo.jpg\",\"original_file_name\":\"Abdallah habibu.jpg\",\"original_file_size\":349341,\"final_file_size\":349341,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:37'),
(1154, NULL, 'bulk_photo_upload', 'student_photo', 323, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_323_1760741858703_6ko3pu.jpg\",\"original_file_name\":\"Abdul Hamid sharifa.jpg\",\"original_file_size\":1266493,\"final_file_size\":1266493,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:38'),
(1155, NULL, 'bulk_photo_upload', 'student_photo', 279, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_279_1760741860804_rjordl.jpg\",\"original_file_name\":\"Abuba isa.jpg\",\"original_file_size\":540561,\"final_file_size\":540561,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:40'),
(1156, NULL, 'bulk_photo_upload', 'student_photo', 288, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_288_1760741862301_sc59ax.jpg\",\"original_file_name\":\"Ashura fahima.jpg\",\"original_file_size\":594943,\"final_file_size\":594943,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:42'),
(1157, NULL, 'bulk_photo_upload', 'student_photo', 306, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_306_1760741864291_ntlhl4.jpg\",\"original_file_name\":\"Balele.jpg\",\"original_file_size\":351602,\"final_file_size\":351602,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:44'),
(1158, NULL, 'bulk_photo_upload', 'student_photo', 575, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_575_1760741866201_wbdm1q.jpg\",\"original_file_name\":\"Clock.jpg\",\"original_file_size\":553186,\"final_file_size\":553186,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:46'),
(1159, NULL, 'bulk_photo_upload', 'student_photo', 305, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_305_1760741867753_5do2h4.jpg\",\"original_file_name\":\"Dhakaba.jpg\",\"original_file_size\":809978,\"final_file_size\":809978,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:47'),
(1160, NULL, 'bulk_photo_upload', 'student_photo', 325, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_325_1760741869301_n6maqg.jpg\",\"original_file_name\":\"Fitra.jpg\",\"original_file_size\":782921,\"final_file_size\":782921,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:49'),
(1161, NULL, 'bulk_photo_upload', 'student_photo', 316, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_316_1760741871010_nvszxo.jpg\",\"original_file_name\":\"Gaali.jpg\",\"original_file_size\":417821,\"final_file_size\":417821,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:51'),
(1162, NULL, 'bulk_photo_upload', 'student_photo', 619, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_619_1760741872334_twgz1g.jpg\",\"original_file_name\":\"Husna.jpg\",\"original_file_size\":423450,\"final_file_size\":423450,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:52'),
(1163, NULL, 'bulk_photo_upload', 'student_photo', 275, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_275_1760741873549_wy67nt.jpg\",\"original_file_name\":\"Kagubiru.jpg\",\"original_file_size\":477152,\"final_file_size\":477152,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:53'),
(1164, NULL, 'bulk_photo_upload', 'student_photo', 327, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_327_1760741874977_gm4bcq.jpg\",\"original_file_name\":\"Kareem.jpg\",\"original_file_size\":476173,\"final_file_size\":476173,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:55'),
(1165, NULL, 'bulk_photo_upload', 'student_photo', 274, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_274_1760741876368_uvasy1.jpg\",\"original_file_name\":\"Kasadha rayhan.jpg\",\"original_file_size\":673383,\"final_file_size\":673383,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:56'),
(1166, NULL, 'bulk_photo_upload', 'student_photo', 324, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_324_1760741877730_hek1y7.jpg\",\"original_file_name\":\"Kasadha yakub.jpg\",\"original_file_size\":568362,\"final_file_size\":568362,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:57'),
(1167, NULL, 'bulk_photo_upload', 'student_photo', 302, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_302_1760741879020_gfte8t.jpg\",\"original_file_name\":\"Katiki.jpg\",\"original_file_size\":396555,\"final_file_size\":396555,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:57:59'),
(1168, NULL, 'bulk_photo_upload', 'student_photo', 296, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_296_1760741880356_iohtih.jpg\",\"original_file_name\":\"Kato sseng.jpg\",\"original_file_size\":1153942,\"final_file_size\":1153942,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:00'),
(1169, NULL, 'bulk_photo_upload', 'student_photo', 315, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_315_1760741882852_6yxmfk.jpg\",\"original_file_name\":\"Kisige.jpg\",\"original_file_size\":384720,\"final_file_size\":384720,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:03'),
(1170, NULL, 'bulk_photo_upload', 'student_photo', 293, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_293_1760741884844_kyd60f.jpg\",\"original_file_name\":\"Kiwanuka.jpg\",\"original_file_size\":596144,\"final_file_size\":596144,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:04'),
(1171, NULL, 'bulk_photo_upload', 'student_photo', 329, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_329_1760741886172_p0kvqz.jpg\",\"original_file_name\":\"Magumba.jpg\",\"original_file_size\":891292,\"final_file_size\":891292,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:06'),
(1172, NULL, 'bulk_photo_upload', 'student_photo', 304, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_304_1760741887681_e956bj.jpg\",\"original_file_name\":\"Malinzi .jpg\",\"original_file_size\":400464,\"final_file_size\":400464,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:07'),
(1173, NULL, 'photo_upload', 'student_photo', 289, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_289_1760741936871_8oiyce.jpg\",\"file_name\":\"Wako.jpg\",\"file_size\":943927,\"student_id\":\"288\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:57'),
(1174, NULL, 'student_update', 'student', 288, '{\"first_name\":\"ABDUL-QAWIYU\",\"last_name\":\"WAKO\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_289_1760741936871_8oiyce.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:58:58'),
(1175, NULL, 'photo_upload', 'student_photo', 313, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_313_1760741982280_2hrmze.jpg\",\"file_name\":\"Unaisa.jpg\",\"file_size\":261446,\"student_id\":\"312\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:59:42'),
(1176, NULL, 'student_update', 'student', 312, '{\"first_name\":\"HUNAISA\",\"last_name\":\"YUSUF\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_313_1760741982280_2hrmze.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 22:59:43'),
(1177, NULL, 'update_status', 'students', 616, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 23:00:00'),
(1178, NULL, 'student_update', 'student', 616, '{\"first_name\":\"HUSNAH\",\"last_name\":\"UTHMAN\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_619_1760741872334_twgz1g.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:00:27'),
(1179, NULL, 'student_update', 'student', 317, '{\"first_name\":\"KALUNGI\",\"last_name\":\"RAYD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:03:24'),
(1180, NULL, 'bulk_photo_upload', 'student_photo', 318, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_318_1760742253846_ioy2z2.jpg\",\"original_file_name\":\"Rayd[1].jpg\",\"original_file_size\":12360497,\"final_file_size\":12360497,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:04:14'),
(1181, NULL, 'photo_upload', 'student_photo', 331, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_331_1760742291415_s5bkjh.jpg\",\"file_name\":\"Yasmine.jpg\",\"file_size\":529898,\"student_id\":\"330\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:04:51'),
(1182, NULL, 'student_update', 'student', 330, '{\"first_name\":\"KANSIIME\",\"last_name\":\"YASMINE\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_331_1760742291415_s5bkjh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:04:52'),
(1183, NULL, 'photo_upload', 'student_photo', 333, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_333_1760742325734_fg608w.jpg\",\"file_name\":\"Mugaga.jpg\",\"file_size\":901159,\"student_id\":\"332\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:05:25'),
(1184, NULL, 'student_update', 'student', 332, '{\"first_name\":\"KATERAGA\",\"last_name\":\"MUGAGA ISMAEL\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_333_1760742325734_fg608w.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:05:26'),
(1185, NULL, 'bulk_photo_upload', 'student_photo', 281, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_281_1760742491048_182i0w.jpg\",\"original_file_name\":\"Kiza_swale[1].jpg\",\"original_file_size\":11992499,\"final_file_size\":11992499,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:08:11'),
(1186, NULL, 'photo_upload', 'student_photo', 277, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_277_1760742718338_1xwhjh.jpg\",\"file_name\":\"Menya.jpg\",\"file_size\":581188,\"student_id\":\"276\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:11:58'),
(1187, NULL, 'student_update', 'student', 276, '{\"first_name\":\"MENYA\",\"last_name\":\"ISMA\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_277_1760742718338_1xwhjh.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:11:59'),
(1188, NULL, 'photo_upload', 'student_photo', 308, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_308_1760742750118_457h21.jpg\",\"file_name\":\"Mugeya.jpg\",\"file_size\":460349,\"student_id\":\"307\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:12:30'),
(1189, NULL, 'student_update', 'student', 307, '{\"first_name\":\"MUGEYI\",\"last_name\":\"HISHAM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_308_1760742750118_457h21.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:12:30'),
(1190, NULL, 'photo_upload', 'student_photo', 319, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_319_1760742771369_qgfhs6.jpg\",\"file_name\":\"Mugowa fahad.jpg\",\"file_size\":359289,\"student_id\":\"318\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:12:51'),
(1191, NULL, 'student_update', 'student', 318, '{\"first_name\":\"MUGOWA\",\"last_name\":\"FAHAD\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_319_1760742771369_qgfhs6.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:12:52'),
(1192, NULL, 'student_update', 'student', 318, '{\"first_name\":\"MUGOWA\",\"last_name\":\"FAHAD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_319_1760742771369_qgfhs6.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:13:03'),
(1193, NULL, 'bulk_photo_upload', 'student_photo', 300, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_300_1760743014741_ysw1j6.jpg\",\"original_file_name\":\"Mongole.jpg\",\"original_file_size\":986205,\"final_file_size\":986205,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:16:54'),
(1194, NULL, 'bulk_photo_upload', 'student_photo', 334, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_334_1760743016849_8qfyve.jpg\",\"original_file_name\":\"Mukisa.jpg\",\"original_file_size\":757319,\"final_file_size\":757319,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:16:56'),
(1195, NULL, 'bulk_photo_upload', 'student_photo', 314, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_314_1760743019310_mcz7kx.jpg\",\"original_file_name\":\"Mulinya.jpg\",\"original_file_size\":514582,\"final_file_size\":514582,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:00'),
(1196, NULL, 'bulk_photo_upload', 'student_photo', 332, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_332_1760743023169_k76gn1.jpg\",\"original_file_name\":\"Munuro.jpg\",\"original_file_size\":340370,\"final_file_size\":340370,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:03'),
(1197, NULL, 'bulk_photo_upload', 'student_photo', 297, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_297_1760743026026_wtsgg3.jpg\",\"original_file_name\":\"Musenze.jpg\",\"original_file_size\":1043334,\"final_file_size\":1043334,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:06'),
(1198, NULL, 'bulk_photo_upload', 'student_photo', 312, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_312_1760743028876_806kf5.jpg\",\"original_file_name\":\"Mutagobwa.jpg\",\"original_file_size\":358383,\"final_file_size\":358383,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:08'),
(1199, NULL, 'bulk_photo_upload', 'student_photo', 309, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_309_1760743032147_z2nakc.jpg\",\"original_file_name\":\"Mutyaba.jpg\",\"original_file_size\":380830,\"final_file_size\":380830,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:13'),
(1200, NULL, 'bulk_photo_upload', 'student_photo', 307, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_307_1760743036664_ftgt75.jpg\",\"original_file_name\":\"Muwaya Abdallah.jpg\",\"original_file_size\":820052,\"final_file_size\":820052,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:16'),
(1201, NULL, 'bulk_photo_upload', 'student_photo', 285, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_285_1760743038467_jw5guv.jpg\",\"original_file_name\":\"Muwayi.jpg\",\"original_file_size\":454701,\"final_file_size\":454701,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:18'),
(1202, NULL, 'bulk_photo_upload', 'student_photo', 328, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_328_1760743041062_1y0u71.jpg\",\"original_file_name\":\"Nabandha.jpg\",\"original_file_size\":388585,\"final_file_size\":388585,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:21'),
(1203, NULL, 'bulk_photo_upload', 'student_photo', 294, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_294_1760743043946_m94i9m.jpg\",\"original_file_name\":\"Nabukera.jpg\",\"original_file_size\":863996,\"final_file_size\":863996,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:24'),
(1204, NULL, 'bulk_photo_upload', 'student_photo', 615, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_615_1760743046255_kjrvie.jpg\",\"original_file_name\":\"Nakato shifra.jpg\",\"original_file_size\":486508,\"final_file_size\":486508,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:26'),
(1205, NULL, 'bulk_photo_upload', 'student_photo', 299, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_299_1760743048160_amlgwf.jpg\",\"original_file_name\":\"Nalubega.jpg\",\"original_file_size\":345171,\"final_file_size\":345171,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:28'),
(1206, NULL, 'bulk_photo_upload', 'student_photo', 326, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_326_1760743050502_mvbv6n.jpg\",\"original_file_name\":\"Nambi hawa.jpg\",\"original_file_size\":388245,\"final_file_size\":388245,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:31'),
(1207, NULL, 'bulk_photo_upload', 'student_photo', 317, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_317_1760743052828_2ucwrc.jpg\",\"original_file_name\":\"Nangobi aaliy.jpg\",\"original_file_size\":373174,\"final_file_size\":373174,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:32'),
(1208, NULL, 'bulk_photo_upload', 'student_photo', 290, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_290_1760743055003_cb32zm.jpg\",\"original_file_name\":\"Nansana nooriat.jpg\",\"original_file_size\":374764,\"final_file_size\":374764,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:35'),
(1209, NULL, 'bulk_photo_upload', 'student_photo', 284, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_284_1760743057177_cy8rl3.jpg\",\"original_file_name\":\"Nasejje.jpg\",\"original_file_size\":400404,\"final_file_size\":400404,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:37'),
(1210, NULL, 'bulk_photo_upload', 'student_photo', 303, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_303_1760743059430_tot0vw.jpg\",\"original_file_name\":\"Obo.jpg\",\"original_file_size\":494679,\"final_file_size\":494679,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:39'),
(1211, NULL, 'bulk_photo_upload', 'student_photo', 301, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_301_1760743062677_q9pc2r.jpg\",\"original_file_name\":\"Othieno.jpg\",\"original_file_size\":382927,\"final_file_size\":382927,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:17:42'),
(1212, NULL, 'photo_upload', 'student_photo', 292, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_292_1760743092615_2fxkq1.jpg\",\"file_name\":\"Share nakagolo.jpg\",\"file_size\":391327,\"student_id\":\"291\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:18:12');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(1213, NULL, 'student_update', 'student', 291, '{\"first_name\":\"NAKAGOLO\",\"last_name\":\"SHATURAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_292_1760743092615_2fxkq1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:18:13'),
(1214, NULL, 'photo_upload', 'student_photo', 321, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_321_1760743114477_1xngpr.jpg\",\"file_name\":\"Thuwaiba.jpg\",\"file_size\":587028,\"student_id\":\"320\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:18:34'),
(1215, NULL, 'student_update', 'student', 320, '{\"first_name\":\"NALUZZE\",\"last_name\":\"THUWAIBAH\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_321_1760743114477_1xngpr.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:18:35'),
(1216, NULL, 'update_status', 'students', 613, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 23:18:49'),
(1217, NULL, 'photo_upload', 'student_photo', 616, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_616_1760743164472_dvn7pn.jpg\",\"file_name\":\"Regea shsrif.jpg\",\"file_size\":388060,\"student_id\":\"613\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:19:24'),
(1218, NULL, 'student_update', 'student', 613, '{\"first_name\":\"REGEAH\",\"last_name\":\"SHARIF\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_616_1760743164472_dvn7pn.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:19:25'),
(1219, NULL, 'student_update', 'student', 613, '{\"first_name\":\"REGEAH\",\"last_name\":\"SHARIF\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_616_1760743164472_dvn7pn.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:19:34'),
(1220, NULL, 'photo_upload', 'student_photo', 280, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_280_1760743205758_ayv4hv.jpg\",\"file_name\":\"Ssewanyana hanan.jpg\",\"file_size\":386703,\"student_id\":\"279\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:20:05'),
(1221, NULL, 'student_update', 'student', 279, '{\"first_name\":\"SEWANYANA\",\"last_name\":\"ABDUL RAHMAN\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_280_1760743205758_ayv4hv.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:20:06'),
(1222, NULL, 'update_status', 'students', 612, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 23:21:16'),
(1223, NULL, 'bulk_photo_upload', 'student_photo', 282, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_282_1760743394815_sqa186.jpg\",\"original_file_name\":\"Taqiyudin.jpg\",\"original_file_size\":1028419,\"final_file_size\":1028419,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:14'),
(1224, NULL, 'bulk_photo_upload', 'student_photo', 322, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_322_1760743397368_pi2f7i.jpg\",\"original_file_name\":\"Taufiq ssenyonjo.jpg\",\"original_file_size\":495872,\"final_file_size\":495872,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:17'),
(1225, NULL, 'bulk_photo_upload', 'student_photo', 298, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_298_1760743402372_v0t1ks.jpg\",\"original_file_name\":\"Wafula.jpg\",\"original_file_size\":496845,\"final_file_size\":496845,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:22'),
(1226, NULL, 'bulk_photo_upload', 'student_photo', 295, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_295_1760743404820_utp9un.jpg\",\"original_file_name\":\"Waswa aqma.jpg\",\"original_file_size\":1099575,\"final_file_size\":1099575,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:25'),
(1227, NULL, 'photo_upload', 'student_photo', 273, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_273_1760743432265_noknbz.jpg\",\"file_name\":\"Rabiba.jpg\",\"file_size\":351547,\"student_id\":\"272\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:52'),
(1228, NULL, 'student_update', 'student', 272, '{\"first_name\":\"ZZIWA\",\"last_name\":\"RABIBA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_273_1760743432265_noknbz.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:23:52'),
(1229, NULL, 'bulk_photo_upload', 'student_photo', 320, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_320_1760743485389_yv7rda.jpg\",\"original_file_name\":\"Minshawi[1].jpg\",\"original_file_size\":11072969,\"final_file_size\":11072969,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:24:45'),
(1230, NULL, 'student_update', 'student', 319, '{\"first_name\":\"UTHUMAN\",\"last_name\":\"MINSHAWI\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_320_1760743485389_yv7rda.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-17 23:24:59'),
(1231, NULL, 'update_status', 'students', 619, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 23:32:18'),
(1232, NULL, 'update_status', 'students', 620, '{\"status\":\"active\"}', NULL, NULL, '2025-10-17 23:32:37'),
(1233, 1, 'edit_result', 'class_result', 2417, '{\"before\":{\"id\":2417,\"student_id\":553,\"class_id\":10,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"89.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:54:54.000Z\",\"updated_at\":null},\"after\":{\"id\":2417,\"student_id\":553,\"class_id\":10,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"89.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T20:54:54.000Z\",\"updated_at\":\"2025-10-22T22:17:21.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:17:22'),
(1234, NULL, 'photo_upload', 'student_photo', 222, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_222_1761172539590_lfjova.jpg\",\"file_name\":\"Damuzungu.jpg\",\"file_size\":755723,\"student_id\":\"221\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:35:39'),
(1235, NULL, 'student_update', 'student', 221, '{\"first_name\":\"ABDUL RAHMAN\",\"last_name\":\"DAMUZUNGU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_222_1761172539590_lfjova.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:35:42'),
(1236, NULL, 'bulk_photo_upload', 'student_photo', 237, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_237_1761172756819_cqs3lk.jpg\",\"original_file_name\":\"Ariana.jpg\",\"original_file_size\":481321,\"final_file_size\":481321,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:17'),
(1237, NULL, 'bulk_photo_upload', 'student_photo', 252, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_252_1761172760615_l6d0f8.jpg\",\"original_file_name\":\"Azed Abdul.jpg\",\"original_file_size\":563641,\"final_file_size\":563641,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:20'),
(1238, NULL, 'bulk_photo_upload', 'student_photo', 235, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_235_1761172765269_rtks0f.jpg\",\"original_file_name\":\"Bidi.jpg\",\"original_file_size\":422443,\"final_file_size\":422443,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:25'),
(1239, NULL, 'bulk_photo_upload', 'student_photo', 272, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_272_1761172769094_nq7zot.jpg\",\"original_file_name\":\"Biyinzika.jpg\",\"original_file_size\":409142,\"final_file_size\":409142,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:29'),
(1240, NULL, 'bulk_photo_upload', 'student_photo', 271, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_271_1761172773118_yhr944.jpg\",\"original_file_name\":\"Buthaina Basef.jpg\",\"original_file_size\":396022,\"final_file_size\":396022,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:33'),
(1241, NULL, 'bulk_photo_upload', 'student_photo', 262, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_262_1761172776623_bfg8os.jpg\",\"original_file_name\":\"Isiko.jpg\",\"original_file_size\":525958,\"final_file_size\":525958,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:36'),
(1242, NULL, 'bulk_photo_upload', 'student_photo', 251, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_251_1761172780181_wba3mk.jpg\",\"original_file_name\":\"Jibril.jpg\",\"original_file_size\":562920,\"final_file_size\":562920,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:40'),
(1243, NULL, 'bulk_photo_upload', 'student_photo', 234, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_234_1761172783567_0bwjef.jpg\",\"original_file_name\":\"Kagoya.jpg\",\"original_file_size\":560308,\"final_file_size\":560308,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:43'),
(1244, NULL, 'bulk_photo_upload', 'student_photo', 248, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_248_1761172786870_hrerel.jpg\",\"original_file_name\":\"Kakaire buruhani.jpg\",\"original_file_size\":584185,\"final_file_size\":584185,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:47'),
(1245, NULL, 'bulk_photo_upload', 'student_photo', 244, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_244_1761172790186_vvxrf5.jpg\",\"original_file_name\":\"Kalembe nusura.jpg\",\"original_file_size\":609539,\"final_file_size\":609539,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:50'),
(1246, NULL, 'bulk_photo_upload', 'student_photo', 260, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_260_1761172794228_107s2y.jpg\",\"original_file_name\":\"Kantono mariam.jpg\",\"original_file_size\":618919,\"final_file_size\":618919,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:54'),
(1247, NULL, 'bulk_photo_upload', 'student_photo', 228, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_228_1761172797608_ycnqmu.jpg\",\"original_file_name\":\"Kauka.jpg\",\"original_file_size\":608028,\"final_file_size\":608028,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:39:57'),
(1248, NULL, 'bulk_photo_upload', 'student_photo', 624, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_624_1761172802746_nk4els.jpg\",\"original_file_name\":\"Kyolaba .jpg\",\"original_file_size\":616161,\"final_file_size\":616161,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:40:02'),
(1249, NULL, 'bulk_photo_upload', 'student_photo', 229, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_229_1761172806431_llx0m4.jpg\",\"original_file_name\":\"Kyotaite.jpg\",\"original_file_size\":525857,\"final_file_size\":525857,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:40:06'),
(1250, NULL, 'bulk_photo_upload', 'student_photo', 246, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_246_1761172809651_kkapb6.jpg\",\"original_file_name\":\"Menya hash.jpg\",\"original_file_size\":685466,\"final_file_size\":685466,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:40:09'),
(1251, NULL, 'photo_upload', 'student_photo', 261, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_261_1761172844963_obw3dm.jpg\",\"file_name\":\"Abdulrahim.jpg\",\"file_size\":491623,\"student_id\":\"260\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:40:45'),
(1252, NULL, 'student_update', 'student', 260, '{\"first_name\":\"AKISM BWANA\",\"last_name\":\"ABDUL-RAHIM\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_261_1761172844963_obw3dm.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:40:46'),
(1253, NULL, 'photo_upload', 'student_photo', 269, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_269_1761172946637_7ai2nj.jpg\",\"file_name\":\"Baseke.jpg\",\"file_size\":621717,\"student_id\":\"268\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:42:26'),
(1254, NULL, 'student_update', 'student', 268, '{\"first_name\":\"BASEKE\",\"last_name\":\"ABDUL-MAJID\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_269_1761172946637_7ai2nj.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:42:27'),
(1255, NULL, 'student_update', 'student', 251, '{\"first_name\":\"AZEDI .A.\",\"last_name\":\"GANIYU\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_252_1761172760615_l6d0f8.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:42:42'),
(1256, NULL, 'update_status', 'students', 621, '{\"status\":\"active\"}', NULL, NULL, '2025-10-22 22:43:19'),
(1257, NULL, 'photo_upload', 'student_photo', 227, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_227_1761173069012_moepx1.jpg\",\"file_name\":\"Mpaulo.jpg\",\"file_size\":472996,\"student_id\":\"226\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:44:29'),
(1258, NULL, 'student_update', 'student', 226, '{\"first_name\":\"MPAULO\",\"last_name\":\"SWALIK\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_227_1761173069012_moepx1.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:44:30'),
(1259, NULL, 'photo_upload', 'student_photo', 257, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_257_1761173089414_ntsz10.jpg\",\"file_name\":\"Mugowa tahiya.jpg\",\"file_size\":760132,\"student_id\":\"256\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:44:49'),
(1260, NULL, 'student_update', 'student', 256, '{\"first_name\":\"MUGOOWA\",\"last_name\":\"TAHIA\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_257_1761173089414_ntsz10.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:44:51'),
(1261, NULL, 'student_update', 'student', 256, '{\"first_name\":\"MUGOOWA\",\"last_name\":\"TAHIA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_257_1761173089414_ntsz10.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:45:03'),
(1262, NULL, 'photo_upload', 'student_photo', 270, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_270_1761173121895_iti6nq.jpg\",\"file_name\":\"Mpindi.jpg\",\"file_size\":933227,\"student_id\":\"269\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:45:22'),
(1263, NULL, 'student_update', 'student', 269, '{\"first_name\":\"MUHAMMAD\",\"last_name\":\"SHARIF MPINDI\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_270_1761173121895_iti6nq.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:45:23'),
(1264, NULL, 'photo_upload', 'student_photo', 250, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_250_1761173173655_xpnnn6.jpg\",\"file_name\":\"Makubuya .jpg\",\"file_size\":664402,\"student_id\":\"249\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:46:13'),
(1265, NULL, 'student_update', 'student', 249, '{\"first_name\":\"MUKUBYA\",\"last_name\":\"HISHAM\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_250_1761173173655_xpnnn6.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:46:15'),
(1266, NULL, 'photo_upload', 'student_photo', 240, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_240_1761173203998_ylpk0e.jpg\",\"file_name\":\"Naigaga bushira.jpg\",\"file_size\":1027958,\"student_id\":\"239\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:46:44'),
(1267, NULL, 'student_update', 'student', 239, '{\"first_name\":\"NAIGAGA\",\"last_name\":\"BUSHIRA\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_240_1761173203998_ylpk0e.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:46:45'),
(1268, NULL, 'photo_upload', 'student_photo', 249, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_249_1761173233103_qjsmzm.jpg\",\"file_name\":\"Shonera.jpg\",\"file_size\":526310,\"student_id\":\"248\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:47:13'),
(1269, NULL, 'student_update', 'student', 248, '{\"first_name\":\"NAIGAGA\",\"last_name\":\"SHUNURAH\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_249_1761173233103_qjsmzm.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:47:14'),
(1270, NULL, 'photo_upload', 'student_photo', 247, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_247_1761173319091_zohm4w.jpg\",\"file_name\":\"Namu noel.jpg\",\"file_size\":648772,\"student_id\":\"246\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:48:39'),
(1271, NULL, 'student_update', 'student', 246, '{\"first_name\":\"NAM\",\"last_name\":\"NOEL\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_247_1761173319091_zohm4w.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:48:40'),
(1272, NULL, 'bulk_photo_upload', 'student_photo', 232, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_232_1761173529325_r406p2.jpg\",\"original_file_name\":\"Gasemba .jpg\",\"original_file_size\":894146,\"final_file_size\":894146,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:09'),
(1273, NULL, 'bulk_photo_upload', 'student_photo', 245, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_245_1761173533104_u7fune.jpg\",\"original_file_name\":\"Namatende .jpg\",\"original_file_size\":427997,\"final_file_size\":427997,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:13'),
(1274, NULL, 'bulk_photo_upload', 'student_photo', 255, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_255_1761173536084_lx9opk.jpg\",\"original_file_name\":\"Nampeera.jpg\",\"original_file_size\":783725,\"final_file_size\":783725,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:16'),
(1275, NULL, 'bulk_photo_upload', 'student_photo', 243, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_243_1761173541014_ukcthm.jpg\",\"original_file_name\":\"Namususwa.jpg\",\"original_file_size\":513992,\"final_file_size\":513992,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:21'),
(1276, NULL, 'bulk_photo_upload', 'student_photo', 626, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_626_1761173544341_9o4jlm.jpg\",\"original_file_name\":\"Namwase shukran.jpg\",\"original_file_size\":526785,\"final_file_size\":526785,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:24'),
(1277, NULL, 'bulk_photo_upload', 'student_photo', 266, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_266_1761173548527_dq03yf.jpg\",\"original_file_name\":\"Naqiyu.jpg\",\"original_file_size\":778491,\"final_file_size\":778491,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:28'),
(1278, NULL, 'bulk_photo_upload', 'student_photo', 258, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_258_1761173551838_kiu0nq.jpg\",\"original_file_name\":\"Ndada.jpg\",\"original_file_size\":763807,\"final_file_size\":763807,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:32'),
(1279, NULL, 'bulk_photo_upload', 'student_photo', 267, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_267_1761173554758_jgbd93.jpg\",\"original_file_name\":\"Ngobishamran.jpg\",\"original_file_size\":412893,\"final_file_size\":412893,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:34'),
(1280, NULL, 'bulk_photo_upload', 'student_photo', 236, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_236_1761173557860_ftt5ck.jpg\",\"original_file_name\":\"Ntalo.jpg\",\"original_file_size\":644523,\"final_file_size\":644523,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:38'),
(1281, NULL, 'bulk_photo_upload', 'student_photo', 254, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_254_1761173561195_e6kdvn.jpg\",\"original_file_name\":\"Ntuuyo.jpg\",\"original_file_size\":543138,\"final_file_size\":543138,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:41'),
(1282, NULL, 'bulk_photo_upload', 'student_photo', 224, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_224_1761173564553_bji8zl.jpg\",\"original_file_name\":\"Rahiya.jpg\",\"original_file_size\":921304,\"final_file_size\":921304,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:45'),
(1283, NULL, 'bulk_photo_upload', 'student_photo', 627, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_627_1761173567873_olkckz.jpg\",\"original_file_name\":\"Rukayya.jpg\",\"original_file_size\":806373,\"final_file_size\":806373,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:48'),
(1284, NULL, 'bulk_photo_upload', 'student_photo', 265, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_265_1761173571246_lmt3kw.jpg\",\"original_file_name\":\"Sarah.jpg\",\"original_file_size\":567264,\"final_file_size\":567264,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:51'),
(1285, NULL, 'bulk_photo_upload', 'student_photo', 256, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_256_1761173574618_hqglcg.jpg\",\"original_file_name\":\"Shafie.jpg\",\"original_file_size\":669819,\"final_file_size\":669819,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:54'),
(1286, NULL, 'bulk_photo_upload', 'student_photo', 238, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_238_1761173578071_6cvbtz.jpg\",\"original_file_name\":\"Sserunjoji.jpg\",\"original_file_size\":429339,\"final_file_size\":429339,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:52:58'),
(1287, NULL, 'bulk_photo_upload', 'student_photo', 225, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_225_1761173581603_tp5zn0.jpg\",\"original_file_name\":\"Sultan Ali.jpg\",\"original_file_size\":588233,\"final_file_size\":588233,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:53:01'),
(1288, NULL, 'bulk_photo_upload', 'student_photo', 231, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_231_1761173584616_djt3xi.jpg\",\"original_file_name\":\"Usamabin farid.jpg\",\"original_file_size\":417679,\"final_file_size\":417679,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:53:04'),
(1289, NULL, 'bulk_photo_upload', 'student_photo', 230, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_230_1761173587981_xxp0ma.jpg\",\"original_file_name\":\"Uthuman.jpg\",\"original_file_size\":433661,\"final_file_size\":433661,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:53:08'),
(1290, NULL, 'update_status', 'students', 622, '{\"status\":\"active\"}', NULL, NULL, '2025-10-22 22:53:22'),
(1291, NULL, 'update_status', 'students', 623, '{\"status\":\"active\"}', NULL, NULL, '2025-10-22 22:53:28'),
(1292, NULL, 'update_status', 'students', 624, '{\"status\":\"active\"}', NULL, NULL, '2025-10-22 22:53:49'),
(1293, NULL, 'student_update', 'student', 624, '{\"first_name\":\"RUKAYYA\",\"last_name\":\"SSEBADUKA ABAS\",\"other_name\":\"\",\"gender\":\"female\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":5,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_627_1761173567873_olkckz.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:54:00'),
(1294, NULL, 'bulk_photo_upload', 'student_photo', 91, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_91_1761173858223_n6coa0.jpg\",\"original_file_name\":\"Ashlyn.jpg\",\"original_file_size\":930258,\"final_file_size\":930258,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:38'),
(1295, NULL, 'bulk_photo_upload', 'student_photo', 85, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_85_1761173861707_jysisx.jpg\",\"original_file_name\":\"Bamwagale.jpg\",\"original_file_size\":540212,\"final_file_size\":540212,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:41'),
(1296, NULL, 'bulk_photo_upload', 'student_photo', 78, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_78_1761173865172_1eardk.jpg\",\"original_file_name\":\"Bidi saida.jpg\",\"original_file_size\":973418,\"final_file_size\":973418,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:45'),
(1297, NULL, 'bulk_photo_upload', 'student_photo', 81, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_81_1761173869217_wt7t24.jpg\",\"original_file_name\":\"Dhakaba.jpg\",\"original_file_size\":1053019,\"final_file_size\":1053019,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:49'),
(1298, NULL, 'bulk_photo_upload', 'student_photo', 92, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_92_1761173872818_aczf7i.jpg\",\"original_file_name\":\"Edris.jpg\",\"original_file_size\":581508,\"final_file_size\":581508,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:53'),
(1299, NULL, 'bulk_photo_upload', 'student_photo', 75, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_75_1761173876558_l7010a.jpg\",\"original_file_name\":\"Huzaifa .jpg\",\"original_file_size\":544144,\"final_file_size\":544144,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:57:56'),
(1300, NULL, 'bulk_photo_upload', 'student_photo', 82, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_82_1761173879784_h5ijcr.jpg\",\"original_file_name\":\"Kasadha husna.jpg\",\"original_file_size\":661475,\"final_file_size\":661475,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:00'),
(1301, NULL, 'bulk_photo_upload', 'student_photo', 84, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_84_1761173883824_nbbyv3.jpg\",\"original_file_name\":\"Katendeyasir.jpg\",\"original_file_size\":1139808,\"final_file_size\":1139808,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:03'),
(1302, NULL, 'bulk_photo_upload', 'student_photo', 71, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_71_1761173886966_g7mhi0.jpg\",\"original_file_name\":\"Kibirige.jpg\",\"original_file_size\":987791,\"final_file_size\":987791,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:07'),
(1303, NULL, 'bulk_photo_upload', 'student_photo', 90, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_90_1761173892346_dighvo.jpg\",\"original_file_name\":\"Kintu sad.jpg\",\"original_file_size\":937499,\"final_file_size\":937499,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:12'),
(1304, NULL, 'bulk_photo_upload', 'student_photo', 87, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_87_1761173895651_tcxkip.jpg\",\"original_file_name\":\"Lwantale.jpg\",\"original_file_size\":839557,\"final_file_size\":839557,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:15'),
(1305, NULL, 'bulk_photo_upload', 'student_photo', 77, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_77_1761173898513_8hrkvj.jpg\",\"original_file_name\":\"Magumba.jpg\",\"original_file_size\":899920,\"final_file_size\":899920,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:18'),
(1306, NULL, 'bulk_photo_upload', 'student_photo', 70, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_70_1761173901777_d31zc3.jpg\",\"original_file_name\":\"Matende Shuraim.jpg\",\"original_file_size\":1159062,\"final_file_size\":1159062,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:21'),
(1307, NULL, 'bulk_photo_upload', 'student_photo', 76, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_76_1761173905178_8e9rhn.jpg\",\"original_file_name\":\"Mulinda.jpg\",\"original_file_size\":1017945,\"final_file_size\":1017945,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:25'),
(1308, NULL, 'bulk_photo_upload', 'student_photo', 73, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_73_1761173908294_jw8iew.jpg\",\"original_file_name\":\"Muyima.jpg\",\"original_file_size\":1057109,\"final_file_size\":1057109,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:28'),
(1309, NULL, 'bulk_photo_upload', 'student_photo', 72, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_72_1761173911628_yq4b52.jpg\",\"original_file_name\":\"Namuwaya Ashia.jpg\",\"original_file_size\":653457,\"final_file_size\":653457,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:32'),
(1310, NULL, 'bulk_photo_upload', 'student_photo', 74, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_74_1761173917389_btr5vd.jpg\",\"original_file_name\":\"Namuwaya.jpg\",\"original_file_size\":1137608,\"final_file_size\":1137608,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:37'),
(1311, NULL, 'bulk_photo_upload', 'student_photo', 88, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_88_1761173920269_grnpgw.jpg\",\"original_file_name\":\"Ramazan.jpg\",\"original_file_size\":1081928,\"final_file_size\":1081928,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:40'),
(1312, NULL, 'bulk_photo_upload', 'student_photo', 86, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_86_1761173923621_l2z34w.jpg\",\"original_file_name\":\"Shuraim Ali.jpg\",\"original_file_size\":992537,\"final_file_size\":992537,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:43'),
(1313, NULL, 'bulk_photo_upload', 'student_photo', 89, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_89_1761173927409_rh0y80.jpg\",\"original_file_name\":\"Swabur.jpg\",\"original_file_size\":1069129,\"final_file_size\":1069129,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:47'),
(1314, NULL, 'bulk_photo_upload', 'student_photo', 83, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_83_1761173930831_372goy.jpg\",\"original_file_name\":\"Yahyaisa.jpg\",\"original_file_size\":925761,\"final_file_size\":925761,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:50'),
(1315, NULL, 'bulk_photo_upload', 'student_photo', 79, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_79_1761173934217_nowpd3.jpg\",\"original_file_name\":\"Ziwa.jpg\",\"original_file_size\":1077803,\"final_file_size\":1077803,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 22:58:54'),
(1316, NULL, 'bulk_photo_upload', 'student_photo', 122, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_122_1761174277368_m8k57t.jpg\",\"original_file_name\":\"Baasil Uthuman (1).jpg\",\"original_file_size\":578277,\"final_file_size\":578277,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:37'),
(1317, NULL, 'bulk_photo_upload', 'student_photo', 109, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_109_1761174280414_46cuwi.jpg\",\"original_file_name\":\"Babirye shaufa (1).jpg\",\"original_file_size\":529095,\"final_file_size\":529095,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:42'),
(1318, NULL, 'bulk_photo_upload', 'student_photo', 630, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_630_1761174286229_s0fdfu.jpg\",\"original_file_name\":\"Didi fauzan yusuf (1).jpg\",\"original_file_size\":906893,\"final_file_size\":906893,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:46'),
(1319, NULL, 'bulk_photo_upload', 'student_photo', 126, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_126_1761174289413_78g9c4.jpg\",\"original_file_name\":\"Guloba (1).jpg\",\"original_file_size\":932004,\"final_file_size\":932004,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:49'),
(1320, NULL, 'bulk_photo_upload', 'student_photo', 108, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_108_1761174292630_ex2rey.jpg\",\"original_file_name\":\"Gulume  (1).jpg\",\"original_file_size\":668478,\"final_file_size\":668478,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:52'),
(1321, NULL, 'bulk_photo_upload', 'student_photo', 125, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_125_1761174297410_w488r0.jpg\",\"original_file_name\":\"Hiba (1).jpg\",\"original_file_size\":488208,\"final_file_size\":488208,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:04:57'),
(1322, NULL, 'bulk_photo_upload', 'student_photo', 110, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_110_1761174300485_x01ou4.jpg\",\"original_file_name\":\"Imran (1).jpg\",\"original_file_size\":724011,\"final_file_size\":724011,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:00'),
(1323, NULL, 'bulk_photo_upload', 'student_photo', 95, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_95_1761174303695_emqjmv.jpg\",\"original_file_name\":\"Kagoya rahma (1).jpg\",\"original_file_size\":546408,\"final_file_size\":546408,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:03'),
(1324, NULL, 'bulk_photo_upload', 'student_photo', 107, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_107_1761174307272_ubnsg3.jpg\",\"original_file_name\":\"Kataba (1).jpg\",\"original_file_size\":699019,\"final_file_size\":699019,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:07'),
(1325, NULL, 'bulk_photo_upload', 'student_photo', 98, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_98_1761174312337_37jojg.jpg\",\"original_file_name\":\"KawumaShatra (1).jpg\",\"original_file_size\":549595,\"final_file_size\":549595,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:12'),
(1326, NULL, 'bulk_photo_upload', 'student_photo', 94, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_94_1761174315805_xurxd8.jpg\",\"original_file_name\":\"Kiranda azan (1).jpg\",\"original_file_size\":978999,\"final_file_size\":978999,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:15'),
(1327, NULL, 'bulk_photo_upload', 'student_photo', 101, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_101_1761174319770_xhm9vw.jpg\",\"original_file_name\":\"Kumugonza khadijah (1).jpg\",\"original_file_size\":783228,\"final_file_size\":783228,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:19'),
(1328, NULL, 'bulk_photo_upload', 'student_photo', 121, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_121_1761174322658_59kj32.jpg\",\"original_file_name\":\"Magumba rayan.jpg\",\"original_file_size\":603439,\"final_file_size\":603439,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:22'),
(1329, NULL, 'bulk_photo_upload', 'student_photo', 112, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_112_1761174325983_v1t81s.jpg\",\"original_file_name\":\"Munulo afra nankya.jpg\",\"original_file_size\":617410,\"final_file_size\":617410,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:26'),
(1330, NULL, 'bulk_photo_upload', 'student_photo', 99, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_99_1761174329249_6xoekr.jpg\",\"original_file_name\":\"Muyanja abdul rahim.jpg\",\"original_file_size\":716016,\"final_file_size\":716016,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:29');
INSERT INTO `audit_log` (`id`, `actor_user_id`, `action`, `entity_type`, `entity_id`, `changes_json`, `ip`, `user_agent`, `created_at`) VALUES
(1331, NULL, 'bulk_photo_upload', 'student_photo', 124, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_124_1761174332591_iwprrt.jpg\",\"original_file_name\":\"Muzale ali.jpg\",\"original_file_size\":1128453,\"final_file_size\":1128453,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:32'),
(1332, NULL, 'bulk_photo_upload', 'student_photo', 96, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_96_1761174335641_ym8o9f.jpg\",\"original_file_name\":\"Nakamanya.jpg\",\"original_file_size\":610131,\"final_file_size\":610131,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:35'),
(1333, NULL, 'bulk_photo_upload', 'student_photo', 119, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_119_1761174338803_9spqix.jpg\",\"original_file_name\":\"Nakisige.jpg\",\"original_file_size\":810184,\"final_file_size\":810184,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:39'),
(1334, NULL, 'bulk_photo_upload', 'student_photo', 116, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_116_1761174341904_l5sw66.jpg\",\"original_file_name\":\"Nampala musa.jpg\",\"original_file_size\":629752,\"final_file_size\":629752,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:42'),
(1335, NULL, 'bulk_photo_upload', 'student_photo', 120, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_120_1761174347624_lr4bk3.jpg\",\"original_file_name\":\"Namugaya.jpg\",\"original_file_size\":429232,\"final_file_size\":429232,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:47'),
(1336, NULL, 'bulk_photo_upload', 'student_photo', 628, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_628_1761174351024_5cw87e.jpg\",\"original_file_name\":\"Nangiya shamirah abdallah.jpg\",\"original_file_size\":526894,\"final_file_size\":526894,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:51'),
(1337, NULL, 'bulk_photo_upload', 'student_photo', 100, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_100_1761174354070_b7xwrb.jpg\",\"original_file_name\":\"Nangobi.jpg\",\"original_file_size\":515641,\"final_file_size\":515641,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:54'),
(1338, NULL, 'bulk_photo_upload', 'student_photo', 117, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_117_1761174357071_i5g8je.jpg\",\"original_file_name\":\"Nanjiya .jpg\",\"original_file_size\":608690,\"final_file_size\":608690,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:05:57'),
(1339, NULL, 'bulk_photo_upload', 'student_photo', 123, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_123_1761174360521_kotld9.jpg\",\"original_file_name\":\"Naqiya.jpg\",\"original_file_size\":825012,\"final_file_size\":825012,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:00'),
(1340, NULL, 'bulk_photo_upload', 'student_photo', 118, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_118_1761174363837_1jdpwo.jpg\",\"original_file_name\":\"Ndyeku rashid.jpg\",\"original_file_size\":687419,\"final_file_size\":687419,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:04'),
(1341, NULL, 'bulk_photo_upload', 'student_photo', 97, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_97_1761174367120_me62c2.jpg\",\"original_file_name\":\"Shuraimbin zaid.jpg\",\"original_file_size\":843805,\"final_file_size\":843805,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:07'),
(1342, NULL, 'bulk_photo_upload', 'student_photo', 102, '{\"old_photo_url\":\"\",\"new_photo_url\":\"/uploads/students/person_102_1761174370277_4nmyds.jpg\",\"original_file_name\":\"Swallahudin bun umar.jpg\",\"original_file_size\":692718,\"final_file_size\":692718,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:10'),
(1343, NULL, 'bulk_photo_upload', 'student_photo', 106, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_106_1761174373490_iledjc.jpg\",\"original_file_name\":\"Taika rayan.jpg\",\"original_file_size\":607796,\"final_file_size\":607796,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:13'),
(1344, NULL, 'bulk_photo_upload', 'student_photo', 93, '{\"old_photo_url\":null,\"new_photo_url\":\"/uploads/students/person_93_1761174376784_7rydtz.jpg\",\"original_file_name\":\"Tasneem.jpg\",\"original_file_size\":618659,\"final_file_size\":618659,\"compressed\":false}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:17'),
(1345, NULL, 'student_update', 'student', 124, '{\"first_name\":\"HIBATULAH\",\"last_name\":\"MUHAMMAD\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":4,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_125_1761174297410_w488r0.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:06:49'),
(1346, NULL, 'update_status', 'students', 110, '{\"status\":\"dropped_out\"}', NULL, NULL, '2025-10-22 23:07:02'),
(1347, NULL, 'student_update', 'student', 101, '{\"first_name\":\"KUMUGONZA\",\"last_name\":\"KHADIJJA\",\"other_name\":\"\",\"gender\":\"F\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":4,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_101_1761174319770_xhm9vw.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:07:40'),
(1348, NULL, 'update_status', 'students', 627, '{\"status\":\"active\"}', NULL, NULL, '2025-10-22 23:07:55'),
(1349, NULL, 'student_update', 'student', 121, '{\"first_name\":\"UTHUMAN\",\"last_name\":\"BAASIL\",\"other_name\":\"\",\"gender\":\"M\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":4,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_122_1761174277368_m8k57t.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36 OPR/120.0.0.0', '2025-10-22 23:08:14'),
(1350, 1, 'edit_result', 'class_result', 1868, '{\"before\":{\"id\":1868,\"student_id\":606,\"class_id\":9,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"80.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:13:31.000Z\",\"updated_at\":null},\"after\":{\"id\":1868,\"student_id\":606,\"class_id\":9,\"subject_id\":4,\"term_id\":1,\"result_type_id\":2,\"score\":\"80.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-10-17T18:13:31.000Z\",\"updated_at\":\"2025-11-11T14:07:50.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0', '2025-11-11 14:07:50'),
(1351, 1, 'edit_result', 'class_result', 2694, '{\"before\":{\"id\":2694,\"student_id\":231,\"class_id\":5,\"subject_id\":7,\"term_id\":1,\"result_type_id\":5,\"score\":\"88.99\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-11-11T15:04:26.000Z\",\"updated_at\":null},\"after\":{\"id\":2694,\"student_id\":231,\"class_id\":5,\"subject_id\":7,\"term_id\":1,\"result_type_id\":5,\"score\":\"89.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-11-11T15:04:26.000Z\",\"updated_at\":\"2025-11-11T15:05:59.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0', '2025-11-11 15:06:00'),
(1352, NULL, 'student_update', 'student', 317, '{\"first_name\":\"KIMERA\",\"last_name\":\"RAYD\",\"other_name\":\"\",\"gender\":\"male\",\"date_of_birth\":\"\",\"phone\":\"\",\"email\":\"\",\"address\":\"\",\"class_id\":6,\"status\":\"active\",\"photo_url\":\"/uploads/students/person_318_1760742253846_ioy2z2.jpg\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0', '2025-11-11 16:00:33'),
(1353, 1, 'edit_result', 'class_result', 2837, '{\"before\":{\"id\":2837,\"student_id\":315,\"class_id\":6,\"subject_id\":4,\"term_id\":1,\"result_type_id\":5,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-11-11T16:28:17.000Z\",\"updated_at\":null},\"after\":{\"id\":2837,\"student_id\":315,\"class_id\":6,\"subject_id\":4,\"term_id\":1,\"result_type_id\":5,\"score\":\"98.00\",\"grade\":null,\"remarks\":null,\"created_at\":\"2025-11-11T16:28:17.000Z\",\"updated_at\":\"2025-11-11T17:18:11.000Z\"}}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 OPR/123.0.0.0', '2025-11-11 17:18:11');

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
(13, 1, 'TAHFIZ', 2, NULL, NULL);

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

--
-- Dumping data for table `class_results`
--

INSERT INTO `class_results` (`id`, `student_id`, `class_id`, `subject_id`, `term_id`, `result_type_id`, `score`, `grade`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 531, 10, 1, 1, 1, 87.00, NULL, NULL, '2025-08-19 00:58:09', NULL),
(2, 463, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:09', NULL),
(3, 464, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:09', NULL),
(4, 465, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:09', NULL),
(5, 459, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:10', NULL),
(6, 491, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:10', NULL),
(7, 521, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(8, 501, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(9, 561, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:10', NULL),
(10, 451, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(12, 449, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(14, 500, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(15, 536, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(16, 557, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(17, 485, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(18, 542, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(19, 543, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:10', NULL),
(20, 505, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(21, 504, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(22, 556, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(23, 474, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(24, 553, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(25, 462, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(26, 461, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(27, 476, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(28, 503, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(29, 511, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(30, 478, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(31, 549, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(32, 525, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(33, 519, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(34, 567, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(35, 481, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(36, 497, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(37, 560, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(38, 482, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(39, 466, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(40, 492, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:11', NULL),
(41, 529, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(42, 467, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(43, 547, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(44, 471, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(45, 545, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(46, 528, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(47, 484, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(48, 486, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(49, 508, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(50, 546, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(51, 499, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(52, 514, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(53, 562, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(54, 479, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(55, 506, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(56, 512, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(57, 496, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(58, 507, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(59, 565, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(60, 568, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(61, 520, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(62, 551, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(63, 569, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(64, 518, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(65, 498, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(66, 541, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(67, 566, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(68, 527, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(69, 489, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(70, 487, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(71, 488, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(72, 490, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(73, 526, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(74, 510, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(75, 494, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(76, 554, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:12', NULL),
(77, 539, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(78, 535, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(79, 534, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(80, 468, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(81, 469, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(82, 555, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(83, 563, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(84, 559, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(85, 530, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(86, 470, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(87, 564, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(88, 448, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(90, 460, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(91, 480, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(92, 522, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(93, 473, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(94, 495, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(95, 472, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(96, 452, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(98, 477, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(99, 513, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(100, 548, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(101, 502, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(102, 552, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(103, 558, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(104, 524, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(105, 516, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(106, 544, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(107, 537, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(108, 550, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(109, 532, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:13', NULL),
(110, 533, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(111, 540, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(112, 475, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(113, 538, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(114, 517, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(115, 457, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(116, 458, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(117, 483, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:14', NULL),
(118, 453, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:14', NULL),
(120, 509, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:14', NULL),
(121, 493, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(122, 523, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(123, 450, 10, 1, 1, 1, 98.00, NULL, NULL, '2025-08-19 00:58:14', NULL),
(125, 515, 10, 1, 1, 1, NULL, NULL, NULL, '2025-08-19 00:58:14', NULL),
(251, 388, 7, 5, 1, 1, 17.00, NULL, NULL, '2025-10-06 19:59:15', NULL),
(252, 365, 7, 5, 1, 1, 23.00, NULL, NULL, '2025-10-06 19:59:15', NULL),
(253, 382, 7, 5, 1, 1, 34.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(254, 386, 7, 5, 1, 1, 46.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(255, 339, 7, 5, 1, 1, 68.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(256, 374, 7, 5, 1, 1, 95.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(257, 391, 7, 5, 1, 1, 23.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(258, 378, 7, 5, 1, 1, 34.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(259, 379, 7, 5, 1, 1, 19.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(260, 335, 7, 5, 1, 1, 12.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(261, 352, 7, 5, 1, 1, 78.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(262, 370, 7, 5, 1, 1, 90.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(263, 364, 7, 5, 1, 1, 89.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(264, 355, 7, 5, 1, 1, 67.00, NULL, NULL, '2025-10-06 19:59:16', NULL),
(265, 574, 7, 5, 1, 1, 23.00, NULL, NULL, '2025-10-06 19:59:17', NULL),
(266, 50, 2, 4, NULL, 1, 98.00, NULL, NULL, '2025-10-06 20:08:05', NULL),
(267, 64, 2, 4, NULL, 1, 23.00, NULL, NULL, '2025-10-06 20:08:05', NULL),
(268, 54, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:05', NULL),
(269, 55, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:05', NULL),
(270, 57, 2, 4, NULL, 1, 89.00, NULL, NULL, '2025-10-06 20:08:05', NULL),
(271, 56, 2, 4, NULL, 1, 87.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(272, 52, 2, 4, NULL, 1, 98.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(273, 600, 2, 4, NULL, 1, 90.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(274, 597, 2, 4, NULL, 1, 89.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(275, 53, 2, 4, NULL, 1, 98.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(276, 594, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(277, 66, 2, 4, NULL, 1, 87.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(278, 596, 2, 4, NULL, 1, 98.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(279, 599, 2, 4, NULL, 1, 67.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(280, 62, 2, 4, NULL, 1, 75.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(281, 67, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(282, 586, 2, 4, NULL, 1, 90.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(283, 51, 2, 4, NULL, 1, 97.99, NULL, NULL, '2025-10-06 20:08:06', NULL),
(284, 48, 2, 4, NULL, 1, 89.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(285, 68, 2, 4, NULL, 1, 34.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(286, 63, 2, 4, NULL, 1, 67.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(287, 60, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(288, 59, 2, 4, NULL, 1, 88.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(289, 47, 2, 4, NULL, 1, 88.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(290, 61, 2, 4, NULL, 1, 88.99, NULL, NULL, '2025-10-06 20:08:06', NULL),
(291, 69, 2, 4, NULL, 1, 90.00, NULL, NULL, '2025-10-06 20:08:06', NULL),
(292, 598, 2, 4, NULL, 1, 78.00, NULL, NULL, '2025-10-06 20:08:07', NULL),
(293, 65, 2, 4, NULL, 1, 90.00, NULL, NULL, '2025-10-06 20:08:07', NULL),
(294, 58, 2, 4, NULL, 1, 88.98, NULL, NULL, '2025-10-06 20:08:07', NULL),
(295, 49, 2, 4, NULL, 1, 90.00, NULL, NULL, '2025-10-06 20:08:07', NULL),
(296, 388, 7, 5, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(297, 365, 7, 5, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(298, 382, 7, 5, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(299, 386, 7, 5, 1, 4, 0.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(300, 339, 7, 5, 1, 4, 68.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(301, 374, 7, 5, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(302, 391, 7, 5, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(303, 378, 7, 5, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(304, 379, 7, 5, 1, 4, 23.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(305, 335, 7, 5, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(306, 352, 7, 5, 1, 4, 23.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(307, 370, 7, 5, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(308, 364, 7, 5, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(309, 355, 7, 5, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(310, 574, 7, 5, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(311, 376, 7, 5, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(312, 356, 7, 5, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(313, 338, 7, 5, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(314, 371, 7, 5, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(315, 353, 7, 5, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:09:33', NULL),
(316, 388, 7, 4, 1, 4, 70.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(317, 365, 7, 4, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(318, 382, 7, 4, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(319, 386, 7, 4, 1, 4, 0.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(320, 339, 7, 4, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(321, 374, 7, 4, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:11:23', NULL),
(322, 391, 7, 4, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(323, 378, 7, 4, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(324, 379, 7, 4, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(325, 335, 7, 4, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(326, 352, 7, 4, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(327, 370, 7, 4, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(328, 364, 7, 4, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(329, 355, 7, 4, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(330, 574, 7, 4, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(331, 376, 7, 4, 1, 4, 57.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(332, 356, 7, 4, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(333, 338, 7, 4, 1, 4, 98.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(334, 371, 7, 4, 1, 4, 49.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(335, 353, 7, 4, 1, 4, 80.00, NULL, NULL, '2025-10-09 20:11:24', NULL),
(336, 388, 7, 3, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(337, 365, 7, 3, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(338, 382, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(339, 386, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(340, 339, 7, 3, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(341, 374, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(342, 391, 7, 3, 1, 4, 97.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(343, 378, 7, 3, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(344, 379, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(345, 335, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(346, 352, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:55', NULL),
(347, 370, 7, 3, 1, 4, 9.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(348, 364, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(349, 355, 7, 3, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(350, 574, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(351, 376, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(352, 356, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(353, 338, 7, 3, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(354, 371, 7, 3, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(355, 353, 7, 3, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:13:56', NULL),
(356, 388, 7, 6, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:22:17', NULL),
(357, 365, 7, 6, 1, 4, 90.00, NULL, NULL, '2025-10-09 20:22:17', NULL),
(358, 382, 7, 6, 1, 4, 45.00, NULL, NULL, '2025-10-09 20:22:17', NULL),
(359, 386, 7, 6, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:22:17', NULL),
(360, 339, 7, 6, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(361, 374, 7, 6, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(362, 391, 7, 6, 1, 4, 73.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(363, 378, 7, 6, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(364, 379, 7, 6, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(365, 335, 7, 6, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(366, 352, 7, 6, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(367, 370, 7, 6, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(368, 364, 7, 6, 1, 4, 34.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(369, 355, 7, 6, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(370, 574, 7, 6, 1, 4, 67.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(371, 376, 7, 6, 1, 4, 78.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(372, 356, 7, 6, 1, 4, 89.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(373, 338, 7, 6, 1, 4, 98.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(374, 371, 7, 6, 1, 4, 98.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(375, 353, 7, 6, 1, 4, 56.00, NULL, NULL, '2025-10-09 20:22:18', NULL),
(376, 388, 7, 4, 1, 2, 66.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(377, 365, 7, 4, 1, 2, 26.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(378, 382, 7, 4, 1, 2, 79.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(379, 386, 7, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(380, 339, 7, 4, 1, 2, 60.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(381, 374, 7, 4, 1, 2, 76.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(382, 391, 7, 4, 1, 2, 16.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(383, 378, 7, 4, 1, 2, 78.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(384, 379, 7, 4, 1, 2, 65.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(385, 335, 7, 4, 1, 2, 34.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(386, 370, 7, 4, 1, 2, 54.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(387, 364, 7, 4, 1, 2, 77.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(388, 355, 7, 4, 1, 2, 36.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(389, 574, 7, 4, 1, 2, 28.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(390, 376, 7, 4, 1, 2, 87.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(391, 356, 7, 4, 1, 2, 80.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(392, 338, 7, 4, 1, 2, 62.00, NULL, NULL, '2025-10-09 21:38:57', NULL),
(393, 371, 7, 4, 1, 2, 78.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(394, 353, 7, 4, 1, 2, 45.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(395, 611, 7, 4, 1, 2, 72.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(396, 368, 7, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(397, 340, 7, 4, 1, 2, 45.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(398, 381, 7, 4, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(399, 346, 7, 4, 1, 2, 59.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(400, 341, 7, 4, 1, 2, 40.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(401, 336, 7, 4, 1, 2, 81.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(402, 354, 7, 4, 1, 2, 31.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(403, 347, 7, 4, 1, 2, 71.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(404, 377, 7, 4, 1, 2, 46.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(405, 345, 7, 4, 1, 2, 27.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(406, 390, 7, 4, 1, 2, 88.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(407, 342, 7, 4, 1, 2, 66.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(408, 348, 7, 4, 1, 2, 76.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(409, 344, 7, 4, 1, 2, 42.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(410, 385, 7, 4, 1, 2, 30.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(411, 357, 7, 4, 1, 2, 62.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(412, 359, 7, 4, 1, 2, 33.00, NULL, NULL, '2025-10-09 21:38:58', NULL),
(413, 383, 7, 4, 1, 2, 57.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(414, 363, 7, 4, 1, 2, 60.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(415, 366, 7, 4, 1, 2, 60.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(416, 373, 7, 4, 1, 2, 75.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(417, 351, 7, 4, 1, 2, 32.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(418, 362, 7, 4, 1, 2, 62.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(419, 361, 7, 4, 1, 2, 62.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(420, 337, 7, 4, 1, 2, 56.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(421, 375, 7, 4, 1, 2, 53.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(422, 609, 7, 4, 1, 2, 59.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(423, 384, 7, 4, 1, 2, 59.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(424, 360, 7, 4, 1, 2, 38.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(425, 358, 7, 4, 1, 2, 44.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(426, 349, 7, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(427, 369, 7, 4, 1, 2, 23.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(428, 350, 7, 4, 1, 2, 57.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(429, 380, 7, 4, 1, 2, 69.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(430, 387, 7, 4, 1, 2, 20.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(431, 372, 7, 4, 1, 2, 22.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(432, 343, 7, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(433, 610, 7, 4, 1, 2, 38.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(434, 367, 7, 4, 1, 2, 12.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(435, 389, 7, 4, 1, 2, 53.00, NULL, NULL, '2025-10-09 21:38:59', NULL),
(436, 352, 7, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:39:24', NULL),
(437, 575, 7, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:39:24', NULL),
(438, 388, 7, 3, 1, 2, 86.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(439, 365, 7, 3, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(440, 382, 7, 3, 1, 2, 88.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(441, 386, 7, 3, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(442, 339, 7, 3, 1, 2, 75.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(443, 374, 7, 3, 1, 2, 77.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(444, 391, 7, 3, 1, 2, 58.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(445, 378, 7, 3, 1, 2, 93.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(446, 379, 7, 3, 1, 2, 72.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(447, 335, 7, 3, 1, 2, 45.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(448, 352, 7, 3, 1, 2, 83.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(449, 370, 7, 3, 1, 2, 63.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(450, 364, 7, 3, 1, 2, 84.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(451, 355, 7, 3, 1, 2, 71.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(452, 574, 7, 3, 1, 2, 40.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(453, 376, 7, 3, 1, 2, 85.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(454, 356, 7, 3, 1, 2, 74.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(455, 338, 7, 3, 1, 2, 40.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(456, 371, 7, 3, 1, 2, 81.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(457, 353, 7, 3, 1, 2, 71.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(458, 611, 7, 3, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(459, 368, 7, 3, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:52:13', NULL),
(460, 340, 7, 3, 1, 2, 75.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(461, 381, 7, 3, 1, 2, 73.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(462, 346, 7, 3, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(463, 341, 7, 3, 1, 2, 44.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(464, 336, 7, 3, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(465, 354, 7, 3, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(466, 347, 7, 3, 1, 2, 74.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(467, 377, 7, 3, 1, 2, 69.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(468, 345, 7, 3, 1, 2, 52.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(469, 390, 7, 3, 1, 2, 85.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(470, 342, 7, 3, 1, 2, 69.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(471, 348, 7, 3, 1, 2, 64.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(472, 344, 7, 3, 1, 2, 67.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(473, 385, 7, 3, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(474, 357, 7, 3, 1, 2, 70.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(475, 359, 7, 3, 1, 2, 48.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(476, 383, 7, 3, 1, 2, 86.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(477, 575, 7, 3, 1, 2, 0.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(478, 363, 7, 3, 1, 2, 65.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(479, 366, 7, 3, 1, 2, 76.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(480, 373, 7, 3, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(481, 351, 7, 3, 1, 2, 45.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(482, 362, 7, 3, 1, 2, 85.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(483, 361, 7, 3, 1, 2, 81.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(484, 337, 7, 3, 1, 2, 36.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(485, 375, 7, 3, 1, 2, 78.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(486, 609, 7, 3, 1, 2, 60.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(487, 384, 7, 3, 1, 2, 64.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(488, 360, 7, 3, 1, 2, 52.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(489, 358, 7, 3, 1, 2, 67.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(490, 349, 7, 3, 1, 2, 76.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(491, 369, 7, 3, 1, 2, 54.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(492, 350, 7, 3, 1, 2, 50.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(493, 380, 7, 3, 1, 2, 79.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(494, 387, 7, 3, 1, 2, 57.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(495, 372, 7, 3, 1, 2, 40.00, NULL, NULL, '2025-10-09 21:52:14', NULL),
(496, 343, 7, 3, 1, 2, 68.00, NULL, NULL, '2025-10-09 21:52:15', NULL),
(497, 610, 7, 3, 1, 2, 62.00, NULL, NULL, '2025-10-09 21:52:15', NULL),
(498, 367, 7, 3, 1, 2, 21.00, NULL, NULL, '2025-10-09 21:52:15', NULL),
(499, 389, 7, 3, 1, 2, 63.00, NULL, NULL, '2025-10-09 21:52:15', NULL),
(500, 388, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:45', NULL),
(501, 365, 7, 7, 1, 2, 66.00, NULL, NULL, '2025-10-09 22:08:45', NULL),
(502, 382, 7, 7, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(503, 386, 7, 7, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(504, 339, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(505, 374, 7, 7, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(506, 391, 7, 7, 1, 2, 62.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(507, 378, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(508, 379, 7, 7, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(509, 335, 7, 7, 1, 2, 71.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(510, 352, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(511, 370, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(512, 364, 7, 7, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(513, 355, 7, 7, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(514, 574, 7, 7, 1, 2, 56.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(515, 376, 7, 7, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(516, 356, 7, 7, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(517, 338, 7, 7, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(518, 371, 7, 7, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(519, 353, 7, 7, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(520, 611, 7, 7, 1, 2, 78.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(521, 368, 7, 7, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(522, 340, 7, 7, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(523, 381, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(524, 346, 7, 7, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(525, 341, 7, 7, 1, 2, 48.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(526, 336, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(527, 354, 7, 7, 1, 2, 52.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(528, 347, 7, 7, 1, 2, 88.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(529, 377, 7, 7, 1, 2, 62.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(530, 345, 7, 7, 1, 2, 72.00, NULL, NULL, '2025-10-09 22:08:46', NULL),
(531, 390, 7, 7, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(532, 342, 7, 7, 1, 2, 86.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(533, 348, 7, 7, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(534, 344, 7, 7, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(535, 385, 7, 7, 1, 2, 56.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(536, 357, 7, 7, 1, 2, 86.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(537, 359, 7, 7, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(538, 383, 7, 7, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(539, 575, 7, 7, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(540, 363, 7, 7, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(541, 366, 7, 7, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(542, 373, 7, 7, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(543, 351, 7, 7, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(544, 362, 7, 7, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(545, 361, 7, 7, 1, 2, 85.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(546, 337, 7, 7, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(547, 375, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(548, 609, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(549, 384, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(550, 360, 7, 7, 1, 2, 64.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(551, 358, 7, 7, 1, 2, 88.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(552, 349, 7, 7, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(553, 369, 7, 7, 1, 2, 60.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(554, 350, 7, 7, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(555, 380, 7, 7, 1, 2, 80.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(556, 387, 7, 7, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(557, 372, 7, 7, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(558, 343, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:47', NULL),
(559, 610, 7, 7, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:08:48', NULL),
(560, 367, 7, 7, 1, 2, 52.00, NULL, NULL, '2025-10-09 22:08:48', NULL),
(561, 389, 7, 7, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:08:48', NULL),
(562, 388, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(563, 365, 7, 8, 1, 2, 66.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(564, 382, 7, 8, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(565, 386, 7, 8, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(566, 339, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(567, 374, 7, 8, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(568, 391, 7, 8, 1, 2, 62.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(569, 378, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:03', NULL),
(570, 379, 7, 8, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(571, 335, 7, 8, 1, 2, 71.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(572, 352, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(573, 370, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(574, 364, 7, 8, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(575, 355, 7, 8, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(576, 574, 7, 8, 1, 2, 56.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(577, 376, 7, 8, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(578, 356, 7, 8, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(579, 338, 7, 8, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(580, 371, 7, 8, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(581, 353, 7, 8, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(582, 611, 7, 8, 1, 2, 78.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(583, 368, 7, 8, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(584, 340, 7, 8, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(585, 381, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(586, 346, 7, 8, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(587, 341, 7, 8, 1, 2, 48.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(588, 336, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(589, 354, 7, 8, 1, 2, 52.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(590, 347, 7, 8, 1, 2, 88.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(591, 377, 7, 8, 1, 2, 62.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(592, 345, 7, 8, 1, 2, 72.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(593, 390, 7, 8, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(594, 342, 7, 8, 1, 2, 86.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(595, 348, 7, 8, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(596, 344, 7, 8, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(597, 385, 7, 8, 1, 2, 56.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(598, 357, 7, 8, 1, 2, 86.00, NULL, NULL, '2025-10-09 22:27:04', NULL),
(599, 359, 7, 8, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(600, 383, 7, 8, 1, 2, 82.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(601, 575, 7, 8, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(602, 363, 7, 8, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(603, 366, 7, 8, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(604, 373, 7, 8, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(605, 351, 7, 8, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(606, 362, 7, 8, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(607, 361, 7, 8, 1, 2, 85.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(608, 337, 7, 8, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(609, 375, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(610, 609, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(611, 384, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(612, 360, 7, 8, 1, 2, 64.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(613, 358, 7, 8, 1, 2, 88.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(614, 349, 7, 8, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(615, 369, 7, 8, 1, 2, 60.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(616, 350, 7, 8, 1, 2, 94.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(617, 380, 7, 8, 1, 2, 80.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(618, 387, 7, 8, 1, 2, 96.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(619, 372, 7, 8, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(620, 343, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(621, 610, 7, 8, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(622, 367, 7, 8, 1, 2, 52.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(623, 389, 7, 8, 1, 2, 90.00, NULL, NULL, '2025-10-09 22:27:05', NULL),
(624, 388, 7, 9, 1, 2, 89.00, NULL, NULL, '2025-10-09 22:43:53', NULL),
(625, 365, 7, 9, 1, 2, 26.00, NULL, NULL, '2025-10-09 22:43:53', NULL),
(626, 382, 7, 9, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(627, 386, 7, 9, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(628, 339, 7, 9, 1, 2, 80.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(629, 374, 7, 9, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(630, 391, 7, 9, 1, 2, 22.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(631, 378, 7, 9, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(632, 379, 7, 9, 1, 2, 55.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(633, 335, 7, 9, 1, 2, 41.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(634, 352, 7, 9, 1, 2, 68.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(635, 370, 7, 9, 1, 2, 75.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(636, 364, 7, 9, 1, 2, 93.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(637, 355, 7, 9, 1, 2, 74.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(638, 574, 7, 9, 1, 2, 63.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(639, 376, 7, 9, 1, 2, 86.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(640, 356, 7, 9, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(641, 338, 7, 9, 1, 2, 73.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(642, 371, 7, 9, 1, 2, 92.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(643, 353, 7, 9, 1, 2, 67.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(644, 611, 7, 9, 1, 2, 63.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(645, 368, 7, 9, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(646, 340, 7, 9, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(647, 381, 7, 9, 1, 2, 84.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(648, 346, 7, 9, 1, 2, 58.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(649, 341, 7, 9, 1, 2, 51.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(650, 336, 7, 9, 1, 2, 87.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(651, 354, 7, 9, 1, 2, 55.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(652, 347, 7, 9, 1, 2, 81.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(653, 377, 7, 9, 1, 2, 75.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(654, 345, 7, 9, 1, 2, 59.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(655, 390, 7, 9, 1, 2, 80.00, NULL, NULL, '2025-10-09 22:43:54', NULL),
(656, 342, 7, 9, 1, 2, 76.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(657, 348, 7, 9, 1, 2, 77.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(658, 344, 7, 9, 1, 2, 51.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(659, 385, 7, 9, 1, 2, 65.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(660, 357, 7, 9, 1, 2, 68.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(661, 359, 7, 9, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(662, 383, 7, 9, 1, 2, 64.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(663, 575, 7, 9, 1, 2, 0.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(664, 363, 7, 9, 1, 2, 75.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(665, 366, 7, 9, 1, 2, 79.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(666, 373, 7, 9, 1, 2, 57.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(667, 351, 7, 9, 1, 2, 63.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(668, 362, 7, 9, 1, 2, 70.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(669, 361, 7, 9, 1, 2, 78.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(670, 337, 7, 9, 1, 2, 67.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(671, 375, 7, 9, 1, 2, 75.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(672, 609, 7, 9, 1, 2, 71.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(673, 384, 7, 9, 1, 2, 54.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(674, 360, 7, 9, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(675, 358, 7, 9, 1, 2, 66.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(676, 349, 7, 9, 1, 2, 73.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(677, 369, 7, 9, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(678, 350, 7, 9, 1, 2, 65.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(679, 380, 7, 9, 1, 2, 62.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(680, 387, 7, 9, 1, 2, 65.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(681, 372, 7, 9, 1, 2, 40.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(682, 343, 7, 9, 1, 2, 79.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(683, 610, 7, 9, 1, 2, 56.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(684, 367, 7, 9, 1, 2, 12.00, NULL, NULL, '2025-10-09 22:43:55', NULL),
(685, 389, 7, 9, 1, 2, 78.00, NULL, NULL, '2025-10-09 22:43:56', NULL),
(686, 326, 6, 4, 1, 2, 79.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(687, 279, 6, 4, 1, 2, 84.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(688, 274, 6, 4, 1, 2, 48.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(689, 322, 6, 4, 1, 2, 95.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(690, 305, 6, 4, 1, 2, 82.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(691, 328, 6, 4, 1, 2, 45.00, NULL, NULL, '2025-10-09 23:33:11', NULL),
(692, 306, 6, 4, 1, 2, 77.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(693, 297, 6, 4, 1, 2, 66.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(694, 333, 6, 4, 1, 2, 88.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(695, 311, 6, 4, 1, 2, 94.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(696, 316, 6, 4, 1, 2, 90.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(697, 294, 6, 4, 1, 2, 86.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(698, 315, 6, 4, 1, 2, 98.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(699, 298, 6, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(700, 308, 6, 4, 1, 2, 83.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(701, 278, 6, 4, 1, 2, 94.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(702, 285, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(703, 304, 6, 4, 1, 2, 58.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(704, 318, 6, 4, 1, 2, 72.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(705, 287, 6, 4, 1, 2, 76.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(706, 329, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(707, 324, 6, 4, 1, 2, 75.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(708, 290, 6, 4, 1, 2, 75.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(709, 327, 6, 4, 1, 2, 62.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(710, 334, 6, 4, 1, 2, 73.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(711, 296, 6, 4, 1, 2, 48.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(712, 307, 6, 4, 1, 2, 50.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(713, 281, 6, 4, 1, 2, 82.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(714, 299, 6, 4, 1, 2, 92.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(715, 325, 6, 4, 1, 2, 92.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(716, 292, 6, 4, 1, 2, 68.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(717, 276, 6, 4, 1, 2, 78.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(718, 309, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(719, 300, 6, 4, 1, 2, 66.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(720, 310, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(721, 295, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(722, 277, 6, 4, 1, 2, 40.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(723, 303, 6, 4, 1, 2, 99.00, NULL, NULL, '2025-10-09 23:33:12', NULL),
(724, 319, 6, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(725, 332, 6, 4, 1, 2, 63.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(726, 289, 6, 4, 1, 2, 60.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(727, 272, 6, 4, 1, 2, 95.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(728, 301, 6, 4, 1, 2, 72.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(729, 601, 6, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(730, 293, 6, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(731, 572, 6, 4, 1, 2, 68.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(732, 273, 6, 4, 1, 2, 92.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(733, 313, 6, 4, 1, 2, 68.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(734, 284, 6, 4, 1, 2, 73.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(735, 302, 6, 4, 1, 2, 46.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(736, 317, 6, 4, 1, 2, 93.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(737, 331, 6, 4, 1, 2, 78.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(738, 282, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(739, 291, 6, 4, 1, 2, 81.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(740, 314, 6, 4, 1, 2, 70.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(741, 280, 6, 4, 1, 2, 95.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(742, 283, 6, 4, 1, 2, 36.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(743, 321, 6, 4, 1, 2, 79.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(744, 320, 6, 4, 1, 2, 94.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(745, 288, 6, 4, 1, 2, 51.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(746, 323, 6, 4, 1, 2, 91.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(747, 330, 6, 4, 1, 2, 82.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(748, 312, 6, 4, 1, 2, 81.00, NULL, NULL, '2025-10-09 23:33:13', NULL),
(749, 620, 6, 4, 1, 2, 50.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(750, 618, 6, 4, 1, 2, 79.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(751, 614, 6, 4, 1, 2, 95.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(752, 615, 6, 4, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(753, 619, 6, 4, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(754, 613, 6, 4, 1, 2, 52.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(755, 612, 6, 4, 1, 2, 48.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(756, 616, 6, 4, 1, 2, 44.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(757, 617, 6, 4, 1, 2, 44.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(758, 286, 6, 4, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:29:43', NULL),
(759, 620, 6, 3, 1, 2, 32.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(760, 618, 6, 3, 1, 2, 79.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(761, 326, 6, 3, 1, 2, 79.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(762, 614, 6, 3, 1, 2, 81.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(763, 279, 6, 3, 1, 2, 52.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(764, 615, 6, 3, 1, 2, 52.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(765, 274, 6, 3, 1, 2, 40.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(766, 322, 6, 3, 1, 2, 81.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(767, 305, 6, 3, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(768, 328, 6, 3, 1, 2, 43.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(769, 306, 6, 3, 1, 2, 43.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(770, 297, 6, 3, 1, 2, 47.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(771, 333, 6, 3, 1, 2, 92.00, NULL, NULL, '2025-10-10 00:44:08', NULL),
(772, 311, 6, 3, 1, 2, 83.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(773, 316, 6, 3, 1, 2, 68.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(774, 294, 6, 3, 1, 2, 96.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(775, 298, 6, 3, 1, 2, 44.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(776, 308, 6, 3, 1, 2, 61.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(777, 278, 6, 3, 1, 2, 57.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(778, 285, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(779, 304, 6, 3, 1, 2, 42.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(780, 619, 6, 3, 1, 2, 77.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(781, 318, 6, 3, 1, 2, 72.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(782, 287, 6, 3, 1, 2, 54.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(783, 315, 6, 3, 1, 2, 95.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(784, 329, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(785, 324, 6, 3, 1, 2, 63.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(786, 290, 6, 3, 1, 2, 37.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(787, 327, 6, 3, 1, 2, 42.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(788, 334, 6, 3, 1, 2, 43.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(789, 296, 6, 3, 1, 2, 31.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(790, 281, 6, 3, 1, 2, 72.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(791, 299, 6, 3, 1, 2, 77.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(792, 325, 6, 3, 1, 2, 59.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(793, 307, 6, 3, 1, 2, 53.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(794, 292, 6, 3, 1, 2, 44.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(795, 276, 6, 3, 1, 2, 75.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(796, 309, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(797, 300, 6, 3, 1, 2, 30.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(798, 310, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(799, 295, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:09', NULL),
(800, 277, 6, 3, 1, 2, 45.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(801, 303, 6, 3, 1, 2, 81.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(802, 319, 6, 3, 1, 2, 68.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(803, 332, 6, 3, 1, 2, 52.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(804, 289, 6, 3, 1, 2, 40.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(805, 272, 6, 3, 1, 2, 79.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(806, 301, 6, 3, 1, 2, 55.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(807, 601, 6, 3, 1, 2, 49.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(808, 273, 6, 3, 1, 2, 83.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(809, 293, 6, 3, 1, 2, 31.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(810, 572, 6, 3, 1, 2, 77.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(811, 313, 6, 3, 1, 2, 49.00, NULL, NULL, '2025-10-10 00:44:10', '2025-10-17 21:54:32'),
(812, 284, 6, 3, 1, 2, 51.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(813, 302, 6, 3, 1, 2, 60.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(814, 317, 6, 3, 1, 2, 70.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(815, 331, 6, 3, 1, 2, 53.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(816, 613, 6, 3, 1, 2, 40.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(817, 282, 6, 3, 1, 2, 30.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(818, 291, 6, 3, 1, 2, 56.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(819, 612, 6, 3, 1, 2, 38.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(820, 314, 6, 3, 1, 2, 33.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(821, 280, 6, 3, 1, 2, 93.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(822, 283, 6, 3, 1, 2, 27.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(823, 321, 6, 3, 1, 2, 54.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(824, 320, 6, 3, 1, 2, 60.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(825, 617, 6, 3, 1, 2, 28.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(826, 616, 6, 3, 1, 2, 28.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(827, 286, 6, 3, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(828, 288, 6, 3, 1, 2, 71.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(829, 323, 6, 3, 1, 2, 81.00, NULL, NULL, '2025-10-10 00:44:10', NULL),
(830, 330, 6, 3, 1, 2, 67.00, NULL, NULL, '2025-10-10 00:44:11', NULL),
(831, 312, 6, 3, 1, 2, 69.00, NULL, NULL, '2025-10-10 00:44:11', NULL),
(832, 620, 6, 7, 1, 2, 50.00, NULL, NULL, '2025-10-10 00:55:58', NULL),
(833, 618, 6, 7, 1, 2, 96.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(834, 326, 6, 7, 1, 2, 96.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(835, 614, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(836, 279, 6, 7, 1, 2, 72.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(837, 615, 6, 7, 1, 2, 72.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(838, 274, 6, 7, 1, 2, 50.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(839, 322, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(840, 305, 6, 7, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(841, 328, 6, 7, 1, 2, 22.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(842, 306, 6, 7, 1, 2, 70.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(843, 297, 6, 7, 1, 2, 64.00, NULL, NULL, '2025-10-10 00:55:59', NULL);
INSERT INTO `class_results` (`id`, `student_id`, `class_id`, `subject_id`, `term_id`, `result_type_id`, `score`, `grade`, `remarks`, `created_at`, `updated_at`) VALUES
(844, 333, 6, 7, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(845, 311, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(846, 316, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(847, 294, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(848, 298, 6, 7, 1, 2, 42.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(849, 308, 6, 7, 1, 2, 84.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(850, 278, 6, 7, 1, 2, 82.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(851, 285, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(852, 304, 6, 7, 1, 2, 83.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(853, 619, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(854, 318, 6, 7, 1, 2, 82.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(855, 287, 6, 7, 1, 2, 68.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(856, 315, 6, 7, 1, 2, 94.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(857, 329, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(858, 324, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(859, 290, 6, 7, 1, 2, 50.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(860, 327, 6, 7, 1, 2, 58.00, NULL, NULL, '2025-10-10 00:55:59', NULL),
(861, 334, 6, 7, 1, 2, 36.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(862, 296, 6, 7, 1, 2, 24.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(863, 281, 6, 7, 1, 2, 82.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(864, 299, 6, 7, 1, 2, 96.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(865, 325, 6, 7, 1, 2, 88.00, NULL, NULL, '2025-10-10 00:56:00', '2025-10-17 21:56:01'),
(866, 307, 6, 7, 1, 2, 68.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(867, 292, 6, 7, 1, 2, 74.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(868, 276, 6, 7, 1, 2, 70.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(869, 309, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(870, 300, 6, 7, 1, 2, 64.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(871, 310, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(872, 295, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(873, 277, 6, 7, 1, 2, 70.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(874, 303, 6, 7, 1, 2, 90.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(875, 319, 6, 7, 1, 2, 66.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(876, 332, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(877, 289, 6, 7, 1, 2, 74.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(878, 272, 6, 7, 1, 2, 88.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(879, 301, 6, 7, 1, 2, 74.00, NULL, NULL, '2025-10-10 00:56:00', NULL),
(880, 601, 6, 7, 1, 2, 42.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(881, 273, 6, 7, 1, 2, 76.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(882, 293, 6, 7, 1, 2, 78.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(883, 572, 6, 7, 1, 2, 76.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(884, 313, 6, 7, 1, 2, 46.00, NULL, NULL, '2025-10-10 00:56:01', '2025-10-17 21:54:58'),
(885, 284, 6, 7, 1, 2, 70.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(886, 302, 6, 7, 1, 2, 54.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(887, 317, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(888, 331, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(889, 613, 6, 7, 1, 2, 58.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(890, 282, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(891, 291, 6, 7, 1, 2, 74.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(892, 612, 6, 7, 1, 2, 48.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(893, 314, 6, 7, 1, 2, 64.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(894, 280, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(895, 283, 6, 7, 1, 2, 50.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(896, 321, 6, 7, 1, 2, 76.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(897, 320, 6, 7, 1, 2, 92.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(898, 617, 6, 7, 1, 2, 76.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(899, 616, 6, 7, 1, 2, 76.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(900, 286, 6, 7, 1, 2, 0.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(901, 288, 6, 7, 1, 2, 58.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(902, 323, 6, 7, 1, 2, 86.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(903, 330, 6, 7, 1, 2, 94.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(904, 312, 6, 7, 1, 2, 80.00, NULL, NULL, '2025-10-10 00:56:01', NULL),
(905, 620, 6, 8, 1, 2, 60.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(906, 618, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(907, 279, 6, 8, 1, 2, 88.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(908, 615, 6, 8, 1, 2, 88.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(909, 305, 6, 8, 1, 2, 96.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(910, 328, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(911, 306, 6, 8, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(912, 297, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(913, 333, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:27', NULL),
(914, 311, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(915, 316, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(916, 294, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(917, 298, 6, 8, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(918, 308, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(919, 278, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(920, 285, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(921, 304, 6, 8, 1, 2, 90.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(922, 619, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(923, 318, 6, 8, 1, 2, 78.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(924, 287, 6, 8, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(925, 315, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(926, 329, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(927, 324, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(928, 290, 6, 8, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(929, 327, 6, 8, 1, 2, 76.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(930, 334, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(931, 296, 6, 8, 1, 2, 50.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(932, 281, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(933, 299, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(934, 325, 6, 8, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:09:28', '2025-10-17 21:56:21'),
(935, 307, 6, 8, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(936, 292, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(937, 276, 6, 8, 1, 2, 90.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(938, 309, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(939, 300, 6, 8, 1, 2, 72.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(940, 310, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(941, 295, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(942, 277, 6, 8, 1, 2, 58.00, NULL, NULL, '2025-10-10 01:09:28', NULL),
(943, 303, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(944, 319, 6, 8, 1, 2, 68.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(945, 332, 6, 8, 1, 2, 66.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(946, 289, 6, 8, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(947, 272, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(948, 301, 6, 8, 1, 2, 82.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(949, 601, 6, 8, 1, 2, 94.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(950, 273, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(951, 293, 6, 8, 1, 2, 76.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(952, 572, 6, 8, 1, 2, 90.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(953, 313, 6, 8, 1, 2, 68.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(954, 284, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(955, 302, 6, 8, 1, 2, 48.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(956, 317, 6, 8, 1, 2, 94.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(957, 331, 6, 8, 1, 2, 76.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(958, 613, 6, 8, 1, 2, 64.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(959, 282, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(960, 291, 6, 8, 1, 2, 88.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(961, 612, 6, 8, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(962, 314, 6, 8, 1, 2, 68.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(963, 280, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(964, 283, 6, 8, 1, 2, 68.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(965, 321, 6, 8, 1, 2, 94.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(966, 320, 6, 8, 1, 2, 92.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(967, 617, 6, 8, 1, 2, 66.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(968, 616, 6, 8, 1, 2, 66.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(969, 286, 6, 8, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(970, 288, 6, 8, 1, 2, 90.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(971, 323, 6, 8, 1, 2, 99.00, NULL, NULL, '2025-10-10 01:09:29', NULL),
(972, 330, 6, 8, 1, 2, 94.00, NULL, NULL, '2025-10-10 01:09:30', NULL),
(973, 312, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:09:30', NULL),
(974, 326, 6, 8, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:10:19', NULL),
(975, 614, 6, 8, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:10:20', NULL),
(976, 274, 6, 8, 1, 2, 56.00, NULL, NULL, '2025-10-10 01:10:20', NULL),
(977, 322, 6, 8, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:10:20', NULL),
(978, 620, 6, 9, 1, 2, 52.00, NULL, NULL, '2025-10-10 01:22:03', NULL),
(979, 618, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:03', NULL),
(980, 326, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:03', NULL),
(981, 614, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:03', NULL),
(982, 279, 6, 9, 1, 2, 64.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(983, 615, 6, 9, 1, 2, 64.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(984, 274, 6, 9, 1, 2, 54.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(985, 322, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(986, 305, 6, 9, 1, 2, 70.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(987, 328, 6, 9, 1, 2, 52.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(988, 306, 6, 9, 1, 2, 60.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(989, 297, 6, 9, 1, 2, 58.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(990, 333, 6, 9, 1, 2, 72.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(991, 311, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(992, 316, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(993, 294, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(994, 298, 6, 9, 1, 2, 58.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(995, 308, 6, 9, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(996, 278, 6, 9, 1, 2, 60.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(997, 285, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(998, 304, 6, 9, 1, 2, 52.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(999, 619, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(1000, 318, 6, 9, 1, 2, 98.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(1001, 287, 6, 9, 1, 2, 74.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(1002, 315, 6, 9, 1, 2, 96.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(1003, 329, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:04', NULL),
(1004, 324, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1005, 290, 6, 9, 1, 2, 46.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1006, 327, 6, 9, 1, 2, 58.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1007, 334, 6, 9, 1, 2, 34.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1008, 296, 6, 9, 1, 2, 34.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1009, 281, 6, 9, 1, 2, 88.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1010, 299, 6, 9, 1, 2, 90.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1011, 325, 6, 9, 1, 2, 78.00, NULL, NULL, '2025-10-10 01:22:05', '2025-10-17 21:56:34'),
(1012, 307, 6, 9, 1, 2, 56.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1013, 292, 6, 9, 1, 2, 50.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1014, 276, 6, 9, 1, 2, 78.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1015, 309, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1016, 300, 6, 9, 1, 2, 54.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1017, 310, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1018, 295, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1019, 277, 6, 9, 1, 2, 50.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1020, 303, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:05', NULL),
(1021, 319, 6, 9, 1, 2, 56.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1022, 332, 6, 9, 1, 2, 54.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1023, 289, 6, 9, 1, 2, 60.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1024, 272, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1025, 301, 6, 9, 1, 2, 54.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1026, 601, 6, 9, 1, 2, 34.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1027, 273, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1028, 293, 6, 9, 1, 2, 42.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1029, 572, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1030, 313, 6, 9, 1, 2, 56.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1031, 284, 6, 9, 1, 2, 62.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1032, 302, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1033, 317, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1034, 331, 6, 9, 1, 2, 52.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1035, 613, 6, 9, 1, 2, 32.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1036, 282, 6, 9, 1, 2, 52.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1037, 291, 6, 9, 1, 2, 80.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1038, 612, 6, 9, 1, 2, 42.00, NULL, NULL, '2025-10-10 01:22:06', NULL),
(1039, 314, 6, 9, 1, 2, 62.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1040, 280, 6, 9, 1, 2, 84.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1041, 283, 6, 9, 1, 2, 36.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1042, 321, 6, 9, 1, 2, 62.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1043, 320, 6, 9, 1, 2, 48.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1044, 617, 6, 9, 1, 2, 38.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1045, 616, 6, 9, 1, 2, 38.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1046, 286, 6, 9, 1, 2, 0.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1047, 288, 6, 9, 1, 2, 70.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1048, 323, 6, 9, 1, 2, 86.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1049, 330, 6, 9, 1, 2, 78.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1050, 312, 6, 9, 1, 2, 82.00, NULL, NULL, '2025-10-10 01:22:07', NULL),
(1051, 268, 5, 4, 1, 2, 65.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1052, 260, 5, 4, 1, 2, 83.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1053, 262, 5, 4, 1, 2, 95.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1054, 224, 5, 4, 1, 2, 63.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1055, 241, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1056, 270, 5, 4, 1, 2, 73.00, NULL, NULL, '2025-10-17 14:01:06', NULL),
(1057, 247, 5, 4, 1, 2, 78.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1058, 239, 5, 4, 1, 2, 66.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1059, 221, 5, 4, 1, 2, 67.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1060, 261, 5, 4, 1, 2, 95.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1061, 230, 5, 4, 1, 2, 82.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1062, 251, 5, 4, 1, 2, 67.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1063, 234, 5, 4, 1, 2, 95.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1064, 267, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1065, 253, 5, 4, 1, 2, 51.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1066, 245, 5, 4, 1, 2, 44.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1067, 250, 5, 4, 1, 2, 85.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1068, 249, 5, 4, 1, 2, 82.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1069, 235, 5, 4, 1, 2, 40.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1070, 231, 5, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1071, 229, 5, 4, 1, 2, 53.00, NULL, NULL, '2025-10-17 14:01:07', NULL),
(1072, 227, 5, 4, 1, 2, 45.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1073, 259, 5, 4, 1, 2, 97.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1074, 257, 5, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1075, 237, 5, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1076, 236, 5, 4, 1, 2, 80.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1077, 264, 5, 4, 1, 2, 90.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1078, 246, 5, 4, 1, 2, 91.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1079, 243, 5, 4, 1, 2, 80.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1080, 271, 5, 4, 1, 2, 68.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1081, 225, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1082, 238, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:08', NULL),
(1083, 228, 5, 4, 1, 2, 83.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1084, 242, 5, 4, 1, 2, 67.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1085, 252, 5, 4, 1, 2, 32.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1086, 266, 5, 4, 1, 2, 73.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1087, 232, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1088, 269, 5, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1089, 244, 5, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1090, 263, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1091, 233, 5, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1092, 240, 5, 4, 1, 2, 48.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1093, 258, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1094, 248, 5, 4, 1, 2, 56.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1095, 255, 5, 4, 1, 2, 94.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1096, 222, 5, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1097, 226, 5, 4, 1, 2, 76.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1098, 256, 5, 4, 1, 2, 72.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1099, 254, 5, 4, 1, 2, 90.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1100, 265, 5, 4, 1, 2, 88.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1101, 223, 5, 4, 1, 2, 83.00, NULL, NULL, '2025-10-17 14:01:09', NULL),
(1102, 621, 5, 4, 1, 2, 96.00, NULL, NULL, '2025-10-17 14:42:16', NULL),
(1103, 622, 5, 4, 1, 2, 50.00, NULL, NULL, '2025-10-17 14:42:16', NULL),
(1104, 623, 5, 4, 1, 2, 90.00, NULL, NULL, '2025-10-17 14:42:16', NULL),
(1105, 624, 5, 4, 1, 2, 75.00, NULL, NULL, '2025-10-17 14:42:16', NULL),
(1106, 268, 5, 3, 1, 2, 52.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1107, 260, 5, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1108, 262, 5, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1109, 224, 5, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1110, 241, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1111, 270, 5, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1112, 247, 5, 3, 1, 2, 48.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1113, 239, 5, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1114, 221, 5, 3, 1, 2, 62.00, NULL, NULL, '2025-10-17 14:50:32', NULL),
(1115, 261, 5, 3, 1, 2, 76.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1116, 230, 5, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1117, 621, 5, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1118, 251, 5, 3, 1, 2, 52.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1119, 234, 5, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1120, 267, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1121, 253, 5, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1122, 245, 5, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1123, 250, 5, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1124, 249, 5, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1125, 235, 5, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1126, 231, 5, 3, 1, 2, 66.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1127, 229, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1128, 227, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1129, 259, 5, 3, 1, 2, 82.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1130, 257, 5, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1131, 237, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:33', NULL),
(1132, 236, 5, 3, 1, 2, 62.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1133, 264, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1134, 246, 5, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1135, 243, 5, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1136, 271, 5, 3, 1, 2, 76.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1137, 225, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1138, 238, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1139, 228, 5, 3, 1, 2, 86.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1140, 622, 5, 3, 1, 2, 66.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1141, 242, 5, 3, 1, 2, 56.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1142, 252, 5, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1143, 266, 5, 3, 1, 2, 66.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1144, 232, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1145, 269, 5, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1146, 244, 5, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1147, 263, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1148, 623, 5, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1149, 233, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1150, 240, 5, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1151, 258, 5, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1152, 248, 5, 3, 1, 2, 42.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1153, 255, 5, 3, 1, 2, 88.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1154, 624, 5, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1155, 222, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1156, 226, 5, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1157, 256, 5, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 14:50:34', NULL),
(1158, 254, 5, 3, 1, 2, 82.00, NULL, NULL, '2025-10-17 14:50:35', NULL),
(1159, 265, 5, 3, 1, 2, 84.00, NULL, NULL, '2025-10-17 14:50:35', NULL),
(1160, 223, 5, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 14:50:35', NULL),
(1161, 268, 5, 7, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1162, 260, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1163, 262, 5, 7, 1, 2, 92.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1164, 224, 5, 7, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1165, 241, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1166, 270, 5, 7, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1167, 247, 5, 7, 1, 2, 30.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1168, 239, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1169, 221, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1170, 261, 5, 7, 1, 2, 96.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1171, 230, 5, 7, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1172, 621, 5, 7, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1173, 251, 5, 7, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1174, 234, 5, 7, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1175, 267, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1176, 253, 5, 7, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1177, 245, 5, 7, 1, 2, 56.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1178, 250, 5, 7, 1, 2, 52.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1179, 249, 5, 7, 1, 2, 60.00, NULL, NULL, '2025-10-17 15:07:56', NULL),
(1180, 235, 5, 7, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1181, 231, 5, 7, 1, 2, 66.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1182, 229, 5, 7, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1183, 227, 5, 7, 1, 2, 56.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1184, 259, 5, 7, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1185, 257, 5, 7, 1, 2, 60.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1186, 237, 5, 7, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1187, 236, 5, 7, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1188, 264, 5, 7, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1189, 246, 5, 7, 1, 2, 92.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1190, 243, 5, 7, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1191, 271, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1192, 225, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1193, 238, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1194, 228, 5, 7, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1195, 622, 5, 7, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1196, 242, 5, 7, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1197, 252, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1198, 266, 5, 7, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1199, 232, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1200, 269, 5, 7, 1, 2, 68.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1201, 244, 5, 7, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:07:57', NULL),
(1202, 263, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1203, 623, 5, 7, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1204, 233, 5, 7, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1205, 240, 5, 7, 1, 2, 66.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1206, 258, 5, 7, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1207, 248, 5, 7, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1208, 255, 5, 7, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1209, 624, 5, 7, 1, 2, 88.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1210, 222, 5, 7, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:07:58', NULL),
(1211, 226, 5, 7, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:07:59', NULL),
(1212, 256, 5, 7, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:07:59', NULL),
(1213, 254, 5, 7, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:07:59', NULL),
(1214, 265, 5, 7, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:07:59', NULL),
(1215, 223, 5, 7, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:07:59', NULL),
(1216, 268, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:52', NULL),
(1217, 260, 5, 8, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:14:52', NULL),
(1218, 262, 5, 8, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:14:52', NULL),
(1219, 224, 5, 8, 1, 2, 67.00, NULL, NULL, '2025-10-17 15:14:52', NULL),
(1220, 241, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:52', NULL),
(1221, 270, 5, 8, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1222, 247, 5, 8, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1223, 239, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1224, 221, 5, 8, 1, 2, 77.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1225, 261, 5, 8, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1226, 230, 5, 8, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1227, 621, 5, 8, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1228, 251, 5, 8, 1, 2, 73.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1229, 234, 5, 8, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1230, 267, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1231, 253, 5, 8, 1, 2, 66.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1232, 245, 5, 8, 1, 2, 61.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1233, 250, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1234, 249, 5, 8, 1, 2, 50.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1235, 235, 5, 8, 1, 2, 62.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1236, 231, 5, 8, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1237, 229, 5, 8, 1, 2, 73.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1238, 227, 5, 8, 1, 2, 64.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1239, 259, 5, 8, 1, 2, 93.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1240, 257, 5, 8, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1241, 237, 5, 8, 1, 2, 79.00, NULL, NULL, '2025-10-17 15:14:53', NULL),
(1242, 236, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1243, 264, 5, 8, 1, 2, 85.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1244, 246, 5, 8, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1245, 243, 5, 8, 1, 2, 88.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1246, 271, 5, 8, 1, 2, 77.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1247, 225, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1248, 238, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1249, 228, 5, 8, 1, 2, 83.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1250, 622, 5, 8, 1, 2, 65.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1251, 242, 5, 8, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1252, 252, 5, 8, 1, 2, 52.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1253, 266, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1254, 232, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1255, 269, 5, 8, 1, 2, 83.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1256, 244, 5, 8, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1257, 263, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1258, 623, 5, 8, 1, 2, 87.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1259, 233, 5, 8, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1260, 240, 5, 8, 1, 2, 43.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1261, 258, 5, 8, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:14:54', NULL),
(1262, 248, 5, 8, 1, 2, 60.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1263, 255, 5, 8, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1264, 624, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1265, 222, 5, 8, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1266, 226, 5, 8, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1267, 256, 5, 8, 1, 2, 62.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1268, 254, 5, 8, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1269, 265, 5, 8, 1, 2, 87.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1270, 223, 5, 8, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:14:55', NULL),
(1271, 268, 5, 9, 1, 2, 56.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1272, 260, 5, 9, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1273, 262, 5, 9, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1274, 224, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1275, 241, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1276, 270, 5, 9, 1, 2, 88.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1277, 247, 5, 9, 1, 2, 64.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1278, 239, 5, 9, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1279, 221, 5, 9, 1, 2, 66.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1280, 261, 5, 9, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1281, 230, 5, 9, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1282, 621, 5, 9, 1, 2, 88.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1283, 251, 5, 9, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1284, 234, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1285, 267, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1286, 253, 5, 9, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1287, 245, 5, 9, 1, 2, 62.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1288, 250, 5, 9, 1, 2, 58.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1289, 249, 5, 9, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1290, 235, 5, 9, 1, 2, 60.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1291, 231, 5, 9, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:21:03', NULL),
(1292, 229, 5, 9, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1293, 227, 5, 9, 1, 2, 62.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1294, 259, 5, 9, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1295, 257, 5, 9, 1, 2, 70.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1296, 237, 5, 9, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1297, 236, 5, 9, 1, 2, 82.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1298, 264, 5, 9, 1, 2, 84.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1299, 246, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1300, 243, 5, 9, 1, 2, 68.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1301, 271, 5, 9, 1, 2, 78.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1302, 225, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1303, 238, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1304, 228, 5, 9, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1305, 622, 5, 9, 1, 2, 66.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1306, 242, 5, 9, 1, 2, 68.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1307, 252, 5, 9, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1308, 266, 5, 9, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1309, 232, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1310, 269, 5, 9, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1311, 244, 5, 9, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1312, 263, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1313, 623, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1314, 233, 5, 9, 1, 2, 62.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1315, 240, 5, 9, 1, 2, 60.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1316, 258, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1317, 248, 5, 9, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1318, 255, 5, 9, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:21:04', NULL),
(1319, 624, 5, 9, 1, 2, 76.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1320, 222, 5, 9, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1321, 226, 5, 9, 1, 2, 74.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1322, 256, 5, 9, 1, 2, 72.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1323, 254, 5, 9, 1, 2, 88.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1324, 265, 5, 9, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1325, 223, 5, 9, 1, 2, 86.00, NULL, NULL, '2025-10-17 15:21:05', NULL),
(1326, 113, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1327, 99, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1328, 110, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1329, 123, 4, 11, 1, 2, 85.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1330, 593, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1331, 94, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1332, 100, 4, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1333, 112, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1334, 121, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1335, 102, 4, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1336, 107, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1337, 103, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1338, 578, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1339, 109, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1340, 125, 4, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1341, 114, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:09', NULL),
(1342, 569, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1343, 101, 4, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1344, 96, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1345, 124, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1346, 115, 4, 11, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1347, 118, 4, 11, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1348, 111, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1349, 126, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1350, 95, 4, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1351, 117, 4, 11, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1352, 120, 4, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1353, 104, 4, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1354, 119, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1355, 98, 4, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1356, 108, 4, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1357, 116, 4, 11, 1, 2, 96.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1358, 105, 4, 11, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1359, 106, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1360, 93, 4, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1361, 122, 4, 11, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1362, 97, 4, 11, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:37:10', NULL),
(1363, 627, 4, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:42:27', NULL),
(1364, 626, 4, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:42:27', NULL),
(1365, 625, 4, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:42:27', NULL),
(1366, 113, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:41', NULL),
(1367, 99, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:41', NULL),
(1368, 110, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:41', NULL),
(1369, 123, 4, 10, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:48:41', NULL),
(1370, 94, 4, 10, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:48:41', NULL),
(1371, 100, 4, 10, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1372, 112, 4, 10, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1373, 121, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1374, 102, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1375, 627, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1376, 107, 4, 10, 1, 2, 94.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1377, 103, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1378, 578, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1379, 109, 4, 10, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1380, 125, 4, 10, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1381, 114, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1382, 569, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1383, 101, 4, 10, 1, 2, 80.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1384, 96, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1385, 124, 4, 10, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1386, 115, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1387, 118, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1388, 111, 4, 10, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1389, 126, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1390, 95, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1391, 117, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1392, 120, 4, 10, 1, 2, 85.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1393, 104, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1394, 119, 4, 10, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1395, 625, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1396, 626, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1397, 98, 4, 10, 1, 2, 96.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1398, 108, 4, 10, 1, 2, 85.00, NULL, NULL, '2025-10-17 15:48:42', NULL),
(1399, 116, 4, 10, 1, 2, 90.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1400, 105, 4, 10, 1, 2, 98.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1401, 106, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1402, 93, 4, 10, 1, 2, 97.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1403, 122, 4, 10, 1, 2, 99.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1404, 97, 4, 10, 1, 2, 95.00, NULL, NULL, '2025-10-17 15:48:43', NULL),
(1405, 593, 4, 10, 1, 2, 0.00, NULL, NULL, '2025-10-17 15:49:12', NULL),
(1406, 113, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:39', NULL),
(1407, 99, 4, 12, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1408, 110, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1409, 123, 4, 12, 1, 2, 80.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1410, 593, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1411, 94, 4, 12, 1, 2, 90.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1412, 100, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1413, 112, 4, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1414, 121, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1415, 102, 4, 12, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1416, 627, 4, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1417, 107, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1418, 103, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1419, 578, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1420, 109, 4, 12, 1, 2, 95.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1421, 125, 4, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1422, 114, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1423, 569, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1424, 101, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1425, 96, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1426, 124, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1427, 115, 4, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1428, 118, 4, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1429, 111, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1430, 126, 4, 12, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1431, 95, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1432, 117, 4, 12, 1, 2, 95.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1433, 120, 4, 12, 1, 2, 80.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1434, 104, 4, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1435, 119, 4, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:38:40', NULL),
(1436, 626, 4, 12, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1437, 625, 4, 12, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1438, 98, 4, 12, 1, 2, 95.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1439, 108, 4, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1440, 116, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1441, 105, 4, 12, 1, 2, 95.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1442, 106, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1443, 93, 4, 12, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1444, 122, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1445, 97, 4, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:38:41', NULL),
(1446, 113, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1447, 99, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1448, 110, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1449, 123, 4, 15, 1, 2, 80.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1450, 593, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1451, 94, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1452, 100, 4, 15, 1, 2, 99.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1453, 112, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1454, 121, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1455, 102, 4, 15, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1456, 627, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1457, 107, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:35', NULL),
(1458, 103, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1459, 578, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1460, 109, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1461, 125, 4, 15, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1462, 114, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1463, 569, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1464, 101, 4, 15, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1465, 96, 4, 15, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1466, 124, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1467, 115, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1468, 118, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1469, 111, 4, 15, 1, 2, 97.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1470, 126, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1471, 95, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:36', NULL),
(1472, 117, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1473, 120, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1474, 104, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1475, 119, 4, 15, 1, 2, 99.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1476, 626, 4, 15, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1477, 625, 4, 15, 1, 2, 100.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1478, 98, 4, 15, 1, 2, 0.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1479, 108, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1480, 116, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1481, 105, 4, 15, 1, 2, 96.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1482, 106, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1483, 93, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1484, 122, 4, 15, 1, 2, 99.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1485, 97, 4, 15, 1, 2, 98.00, NULL, NULL, '2025-10-17 16:58:37', NULL),
(1486, 113, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1487, 99, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1488, 110, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1489, 123, 4, 14, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1490, 593, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1491, 94, 4, 14, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1492, 100, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1493, 112, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1494, 121, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1495, 102, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1496, 627, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1497, 107, 4, 14, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1498, 103, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1499, 578, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1500, 109, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1501, 125, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1502, 114, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1503, 569, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1504, 101, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1505, 96, 4, 14, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:06:11', NULL),
(1506, 124, 4, 14, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1507, 115, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1508, 118, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1509, 111, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1510, 126, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1511, 95, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1512, 117, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1513, 120, 4, 14, 1, 2, 80.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1514, 104, 4, 14, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1515, 119, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1516, 626, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1517, 625, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1518, 98, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1519, 108, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1520, 116, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1521, 105, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1522, 106, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1523, 93, 4, 14, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1524, 122, 4, 14, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1525, 97, 4, 14, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:06:12', NULL),
(1526, 85, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1527, 73, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1528, 89, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1529, 76, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1530, 77, 3, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1531, 71, 3, 4, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1532, 86, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1533, 74, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1534, 91, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1535, 82, 3, 4, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1536, 75, 3, 4, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1537, 92, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1538, 83, 3, 4, 1, 2, 92.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1539, 88, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:43', NULL),
(1540, 80, 3, 4, 1, 2, 82.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1541, 79, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1542, 90, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1543, 78, 3, 4, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1544, 81, 3, 4, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1545, 87, 3, 4, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:11:44', NULL);
INSERT INTO `class_results` (`id`, `student_id`, `class_id`, `subject_id`, `term_id`, `result_type_id`, `score`, `grade`, `remarks`, `created_at`, `updated_at`) VALUES
(1546, 70, 3, 4, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1547, 72, 3, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1548, 84, 3, 4, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:11:44', NULL),
(1549, 85, 3, 3, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1550, 73, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1551, 89, 3, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1552, 76, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1553, 77, 3, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1554, 71, 3, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1555, 86, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1556, 74, 3, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1557, 91, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1558, 82, 3, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1559, 75, 3, 3, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1560, 92, 3, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1561, 83, 3, 3, 1, 2, 88.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1562, 88, 3, 3, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1563, 80, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1564, 79, 3, 3, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1565, 90, 3, 3, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1566, 78, 3, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1567, 81, 3, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1568, 87, 3, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1569, 70, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:10', NULL),
(1570, 72, 3, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:16:11', NULL),
(1571, 84, 3, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:16:11', NULL),
(1572, 85, 3, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1573, 73, 3, 11, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1574, 89, 3, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1575, 76, 3, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1576, 77, 3, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1577, 71, 3, 11, 1, 2, 92.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1578, 86, 3, 11, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1579, 74, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1580, 91, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1581, 82, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1582, 75, 3, 11, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1583, 92, 3, 11, 1, 2, 88.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1584, 83, 3, 11, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1585, 88, 3, 11, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1586, 80, 3, 11, 1, 2, 92.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1587, 79, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1588, 90, 3, 11, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:19:58', NULL),
(1589, 78, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1590, 81, 3, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1591, 87, 3, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1592, 70, 3, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1593, 72, 3, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1594, 84, 3, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:19:59', NULL),
(1595, 85, 3, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1596, 73, 3, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1597, 89, 3, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1598, 76, 3, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1599, 77, 3, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1600, 71, 3, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1601, 86, 3, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1602, 74, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1603, 91, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1604, 82, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1605, 75, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1606, 92, 3, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1607, 83, 3, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:24:22', NULL),
(1608, 88, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1609, 80, 3, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1610, 79, 3, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1611, 90, 3, 12, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1612, 78, 3, 12, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1613, 81, 3, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1614, 87, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1615, 70, 3, 12, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1616, 72, 3, 12, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1617, 84, 3, 12, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:24:23', NULL),
(1618, 85, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:13', NULL),
(1619, 73, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:13', NULL),
(1620, 89, 3, 16, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1621, 76, 3, 16, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1622, 77, 3, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1623, 71, 3, 16, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1624, 86, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1625, 74, 3, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1626, 91, 3, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1627, 82, 3, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1628, 75, 3, 16, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1629, 92, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1630, 83, 3, 16, 1, 2, 88.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1631, 88, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1632, 80, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1633, 79, 3, 16, 1, 2, 88.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1634, 90, 3, 16, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:30:14', NULL),
(1635, 78, 3, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1636, 81, 3, 16, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1637, 87, 3, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1638, 70, 3, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1639, 72, 3, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1640, 84, 3, 16, 1, 2, 96.00, NULL, NULL, '2025-10-17 17:30:15', NULL),
(1641, 50, 2, 16, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:36:40', NULL),
(1642, 64, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1643, 54, 2, 16, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1644, 55, 2, 16, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1645, 57, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1646, 56, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1647, 52, 2, 16, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:36:41', '2025-10-17 23:44:22'),
(1648, 600, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1649, 597, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1650, 53, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1651, 594, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1652, 66, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1653, 596, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1654, 599, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1655, 62, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1656, 67, 2, 16, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1657, 586, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1658, 51, 2, 16, 1, 2, 92.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1659, 48, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1660, 68, 2, 16, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1661, 63, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1662, 60, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:41', NULL),
(1663, 59, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1664, 47, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1665, 61, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:36:42', '2025-10-17 23:39:14'),
(1666, 69, 2, 16, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1667, 598, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1668, 65, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1669, 58, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1670, 49, 2, 16, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:36:42', NULL),
(1671, 628, 2, 16, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:39:57', NULL),
(1672, 50, 2, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:44:18', NULL),
(1673, 64, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:18', NULL),
(1674, 54, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:21', NULL),
(1675, 55, 2, 11, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:44:21', NULL),
(1676, 57, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:21', NULL),
(1677, 56, 2, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:44:22', NULL),
(1678, 52, 2, 11, 1, 2, 88.00, NULL, NULL, '2025-10-17 17:44:22', NULL),
(1679, 600, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1680, 628, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1681, 597, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1682, 53, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1683, 66, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1684, 594, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1685, 596, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:23', NULL),
(1686, 599, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1687, 62, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1688, 67, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1689, 586, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1690, 51, 2, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1691, 48, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1692, 68, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1693, 63, 2, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:44:24', NULL),
(1694, 60, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1695, 59, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1696, 47, 2, 11, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1697, 61, 2, 11, 1, 2, 95.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1698, 69, 2, 11, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1699, 598, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:25', NULL),
(1700, 65, 2, 11, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:44:26', NULL),
(1701, 58, 2, 11, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:44:26', NULL),
(1702, 49, 2, 11, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:44:26', NULL),
(1703, 50, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1704, 64, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1705, 54, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1706, 55, 2, 3, 1, 2, 95.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1707, 57, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1708, 56, 2, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1709, 52, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1710, 600, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1711, 628, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1712, 597, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1713, 53, 2, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1714, 66, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1715, 594, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1716, 596, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1717, 599, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1718, 62, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1719, 67, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1720, 586, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1721, 51, 2, 3, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1722, 48, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1723, 68, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1724, 63, 2, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1725, 60, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1726, 59, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1727, 47, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1728, 61, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:27', NULL),
(1729, 69, 2, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:47:28', NULL),
(1730, 598, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:28', NULL),
(1731, 65, 2, 3, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:47:28', NULL),
(1732, 58, 2, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:47:28', NULL),
(1733, 49, 2, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:47:28', NULL),
(1734, 50, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1735, 64, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1736, 54, 2, 17, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1737, 55, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1738, 57, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1739, 56, 2, 17, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1740, 52, 2, 17, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:50:23', NULL),
(1741, 600, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1742, 628, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1743, 597, 2, 17, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1744, 53, 2, 17, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1745, 66, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1746, 594, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1747, 596, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1748, 599, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1749, 62, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1750, 67, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1751, 586, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1752, 51, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1753, 48, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1754, 68, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1755, 63, 2, 17, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1756, 60, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1757, 59, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1758, 47, 2, 17, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:50:24', '2025-10-17 23:45:20'),
(1759, 61, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1760, 69, 2, 17, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1761, 598, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1762, 65, 2, 17, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1763, 58, 2, 17, 1, 2, 90.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1764, 49, 2, 17, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:50:24', NULL),
(1765, 50, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:02', NULL),
(1766, 64, 2, 18, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:54:02', NULL),
(1767, 54, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1768, 55, 2, 18, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1769, 57, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1770, 56, 2, 18, 1, 2, 94.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1771, 52, 2, 18, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:54:03', '2025-10-17 23:44:00'),
(1772, 600, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1773, 628, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1774, 597, 2, 18, 1, 2, 92.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1775, 53, 2, 18, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1776, 66, 2, 18, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1777, 594, 2, 18, 1, 2, 89.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1778, 596, 2, 18, 1, 2, 95.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1779, 599, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1780, 62, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1781, 67, 2, 18, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1782, 586, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1783, 51, 2, 18, 1, 2, 95.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1784, 48, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1785, 68, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1786, 63, 2, 18, 1, 2, 97.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1787, 60, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1788, 59, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1789, 47, 2, 18, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1790, 61, 2, 18, 1, 2, 98.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1791, 69, 2, 18, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1792, 598, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1793, 65, 2, 18, 1, 2, 100.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1794, 58, 2, 18, 1, 2, 99.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1795, 49, 2, 18, 1, 2, 0.00, NULL, NULL, '2025-10-17 17:54:03', NULL),
(1796, 465, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:28', NULL),
(1797, 464, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1798, 463, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1799, 459, 9, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1800, 491, 9, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1801, 521, 9, 4, 1, 2, 49.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1802, 501, 9, 4, 1, 2, 18.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1803, 500, 9, 4, 1, 2, 41.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1804, 485, 9, 4, 1, 2, 23.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1805, 505, 9, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1806, 581, 9, 4, 1, 2, 40.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1807, 474, 9, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1808, 462, 9, 4, 1, 2, 55.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1809, 461, 9, 4, 1, 2, 55.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1810, 590, 9, 4, 1, 2, 34.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1811, 476, 9, 4, 1, 2, 34.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1812, 503, 9, 4, 1, 2, 50.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1813, 511, 9, 4, 1, 2, 43.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1814, 478, 9, 4, 1, 2, 62.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1815, 580, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1816, 519, 9, 4, 1, 2, 3.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1817, 481, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1818, 583, 9, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 18:13:29', NULL),
(1819, 497, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1820, 584, 9, 4, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1821, 587, 9, 4, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1822, 480, 9, 4, 1, 2, 30.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1823, 482, 9, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1824, 466, 9, 4, 1, 2, 34.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1825, 492, 9, 4, 1, 2, 54.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1826, 467, 9, 4, 1, 2, 55.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1827, 471, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1828, 484, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1829, 486, 9, 4, 1, 2, 50.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1830, 508, 9, 4, 1, 2, 74.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1831, 499, 9, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1832, 514, 9, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1833, 579, 9, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1834, 578, 9, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1835, 479, 9, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1836, 506, 9, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1837, 512, 9, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1838, 496, 9, 4, 1, 2, 46.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1839, 507, 9, 4, 1, 2, 51.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1840, 520, 9, 4, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1841, 518, 9, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1842, 498, 9, 4, 1, 2, 56.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1843, 487, 9, 4, 1, 2, 65.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1844, 489, 9, 4, 1, 2, 65.00, NULL, NULL, '2025-10-17 18:13:30', NULL),
(1845, 488, 9, 4, 1, 2, 65.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1846, 490, 9, 4, 1, 2, 66.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1847, 2, 9, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1848, 510, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1849, 494, 9, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1850, 468, 9, 4, 1, 2, 28.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1851, 469, 9, 4, 1, 2, 28.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1852, 470, 9, 4, 1, 2, 17.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1853, 605, 9, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1854, 460, 9, 4, 1, 2, 93.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1855, 522, 9, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1856, 495, 9, 4, 1, 2, 47.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1857, 473, 9, 4, 1, 2, 75.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1858, 472, 9, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1859, 477, 9, 4, 1, 2, 68.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1860, 513, 9, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1861, 502, 9, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1862, 516, 9, 4, 1, 2, 79.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1863, 582, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1864, 475, 9, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1865, 517, 9, 4, 1, 2, 63.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1866, 458, 9, 4, 1, 2, 49.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1867, 457, 9, 4, 1, 2, 49.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1868, 606, 9, 4, 1, 2, 80.00, NULL, NULL, '2025-10-17 18:13:31', '2025-11-11 14:07:50'),
(1869, 483, 9, 4, 1, 2, 7.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1870, 509, 9, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1871, 493, 9, 4, 1, 2, 39.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1872, 504, 9, 4, 1, 2, 62.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1873, 523, 9, 4, 1, 2, 8.00, NULL, NULL, '2025-10-17 18:13:31', NULL),
(1874, 515, 9, 4, 1, 2, 21.00, NULL, NULL, '2025-10-17 18:13:32', NULL),
(1875, 465, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:09', NULL),
(1876, 464, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:09', NULL),
(1877, 463, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:09', NULL),
(1878, 459, 9, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 18:54:09', NULL),
(1879, 491, 9, 3, 1, 2, 69.00, NULL, NULL, '2025-10-17 18:54:09', NULL),
(1880, 521, 9, 3, 1, 2, 27.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1881, 501, 9, 3, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1882, 500, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1883, 485, 9, 3, 1, 2, 33.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1884, 505, 9, 3, 1, 2, 90.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1885, 581, 9, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1886, 474, 9, 3, 1, 2, 57.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1887, 462, 9, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1888, 461, 9, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1889, 590, 9, 3, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1890, 476, 9, 3, 1, 2, 26.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1891, 503, 9, 3, 1, 2, 56.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1892, 511, 9, 3, 1, 2, 62.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1893, 478, 9, 3, 1, 2, 49.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1894, 580, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:10', NULL),
(1895, 519, 9, 3, 1, 2, 25.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1896, 481, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1897, 583, 9, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 18:54:11', '2025-10-17 21:59:22'),
(1898, 497, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1899, 584, 9, 3, 1, 2, 30.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1900, 587, 9, 3, 1, 2, 30.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1901, 480, 9, 3, 1, 2, 49.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1902, 482, 9, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1903, 466, 9, 3, 1, 2, 37.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1904, 492, 9, 3, 1, 2, 55.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1905, 467, 9, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1906, 471, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1907, 484, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1908, 486, 9, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1909, 508, 9, 3, 1, 2, 73.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1910, 499, 9, 3, 1, 2, 58.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1911, 514, 9, 3, 1, 2, 43.00, NULL, NULL, '2025-10-17 18:54:11', NULL),
(1912, 579, 9, 3, 1, 2, 35.00, NULL, NULL, '2025-10-17 18:54:12', '2025-10-17 22:00:02'),
(1913, 578, 9, 3, 1, 2, 35.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1914, 479, 9, 3, 1, 2, 63.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1915, 506, 9, 3, 1, 2, 73.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1916, 512, 9, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1917, 496, 9, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1918, 507, 9, 3, 1, 2, 58.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1919, 520, 9, 3, 1, 2, 55.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1920, 518, 9, 3, 1, 2, 39.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1921, 498, 9, 3, 1, 2, 52.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1922, 487, 9, 3, 1, 2, 77.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1923, 489, 9, 3, 1, 2, 77.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1924, 488, 9, 3, 1, 2, 77.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1925, 490, 9, 3, 1, 2, 67.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1926, 2, 9, 3, 1, 2, 39.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1927, 510, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1928, 494, 9, 3, 1, 2, 27.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1929, 468, 9, 3, 1, 2, 21.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1930, 469, 9, 3, 1, 2, 21.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1931, 470, 9, 3, 1, 2, 20.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1932, 605, 9, 3, 1, 2, 22.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1933, 460, 9, 3, 1, 2, 87.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1934, 522, 9, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1935, 495, 9, 3, 1, 2, 45.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1936, 473, 9, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1937, 472, 9, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1938, 477, 9, 3, 1, 2, 67.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1939, 513, 9, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1940, 502, 9, 3, 1, 2, 42.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1941, 516, 9, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1942, 582, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1943, 475, 9, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1944, 517, 9, 3, 1, 2, 67.00, NULL, NULL, '2025-10-17 18:54:12', NULL),
(1945, 458, 9, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1946, 457, 9, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1947, 606, 9, 3, 1, 2, 91.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1948, 483, 9, 3, 1, 2, 39.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1949, 509, 9, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1950, 493, 9, 3, 1, 2, 31.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1951, 504, 9, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1952, 523, 9, 3, 1, 2, 5.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1953, 515, 9, 3, 1, 2, 43.00, NULL, NULL, '2025-10-17 18:54:13', NULL),
(1954, 465, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1955, 464, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1956, 463, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1957, 459, 9, 1, 1, 2, 52.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1958, 491, 9, 1, 1, 2, 68.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1959, 521, 9, 1, 1, 2, 36.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1960, 501, 9, 1, 1, 2, 30.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1961, 500, 9, 1, 1, 2, 17.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1962, 485, 9, 1, 1, 2, 47.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1963, 505, 9, 1, 1, 2, 82.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1964, 581, 9, 1, 1, 2, 30.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1965, 474, 9, 1, 1, 2, 53.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1966, 462, 9, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1967, 461, 9, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1968, 590, 9, 1, 1, 2, 34.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1969, 476, 9, 1, 1, 2, 34.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1970, 503, 9, 1, 1, 2, 64.00, NULL, NULL, '2025-10-17 19:34:27', NULL),
(1971, 511, 9, 1, 1, 2, 68.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1972, 478, 9, 1, 1, 2, 67.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1973, 580, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1974, 519, 9, 1, 1, 2, 9.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1975, 481, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1976, 583, 9, 1, 1, 2, 74.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1977, 497, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1978, 587, 9, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1979, 584, 9, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1980, 480, 9, 1, 1, 2, 24.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1981, 482, 9, 1, 1, 2, 69.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1982, 466, 9, 1, 1, 2, 42.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1983, 492, 9, 1, 1, 2, 79.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1984, 467, 9, 1, 1, 2, 41.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1985, 471, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1986, 484, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1987, 486, 9, 1, 1, 2, 75.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1988, 508, 9, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1989, 499, 9, 1, 1, 2, 80.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1990, 514, 9, 1, 1, 2, 69.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1991, 579, 9, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1992, 578, 9, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1993, 479, 9, 1, 1, 2, 64.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1994, 506, 9, 1, 1, 2, 57.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1995, 512, 9, 1, 1, 2, 66.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1996, 496, 9, 1, 1, 2, 43.00, NULL, NULL, '2025-10-17 19:34:28', NULL),
(1997, 507, 9, 1, 1, 2, 73.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(1998, 520, 9, 1, 1, 2, 37.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(1999, 518, 9, 1, 1, 2, 66.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2000, 498, 9, 1, 1, 2, 38.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2001, 487, 9, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2002, 489, 9, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2003, 488, 9, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2004, 490, 9, 1, 1, 2, 73.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2005, 2, 9, 1, 1, 2, 49.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2006, 510, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2007, 494, 9, 1, 1, 2, 29.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2008, 468, 9, 1, 1, 2, 44.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2009, 469, 9, 1, 1, 2, 44.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2010, 470, 9, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2011, 605, 9, 1, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2012, 460, 9, 1, 1, 2, 80.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2013, 522, 9, 1, 1, 2, 86.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2014, 495, 9, 1, 1, 2, 73.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2015, 473, 9, 1, 1, 2, 62.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2016, 472, 9, 1, 1, 2, 57.00, NULL, NULL, '2025-10-17 19:34:29', NULL),
(2017, 477, 9, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2018, 513, 9, 1, 1, 2, 87.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2019, 502, 9, 1, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2020, 516, 9, 1, 1, 2, 66.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2021, 582, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2022, 475, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2023, 517, 9, 1, 1, 2, 71.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2024, 458, 9, 1, 1, 2, 59.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2025, 457, 9, 1, 1, 2, 59.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2026, 606, 9, 1, 1, 2, 87.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2027, 483, 9, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2028, 509, 9, 1, 1, 2, 75.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2029, 493, 9, 1, 1, 2, 46.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2030, 504, 9, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2031, 523, 9, 1, 1, 2, 10.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2032, 515, 9, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:34:30', NULL),
(2033, 465, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2034, 464, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2035, 463, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2036, 459, 9, 2, 1, 2, 62.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2037, 491, 9, 2, 1, 2, 49.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2038, 521, 9, 2, 1, 2, 44.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2039, 501, 9, 2, 1, 2, 18.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2040, 500, 9, 2, 1, 2, 11.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2041, 485, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2042, 505, 9, 2, 1, 2, 83.00, NULL, NULL, '2025-10-17 19:46:32', NULL),
(2043, 581, 9, 2, 1, 2, 30.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2044, 474, 9, 2, 1, 2, 49.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2045, 462, 9, 2, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2046, 461, 9, 2, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2047, 590, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2048, 476, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2049, 503, 9, 2, 1, 2, 50.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2050, 511, 9, 2, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2051, 478, 9, 2, 1, 2, 52.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2052, 580, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2053, 519, 9, 2, 1, 2, 9.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2054, 481, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2055, 583, 9, 2, 1, 2, 69.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2056, 497, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2057, 587, 9, 2, 1, 2, 29.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2058, 584, 9, 2, 1, 2, 29.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2059, 480, 9, 2, 1, 2, 31.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2060, 482, 9, 2, 1, 2, 66.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2061, 466, 9, 2, 1, 2, 38.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2062, 492, 9, 2, 1, 2, 64.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2063, 467, 9, 2, 1, 2, 46.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2064, 471, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2065, 484, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2066, 486, 9, 2, 1, 2, 60.00, NULL, NULL, '2025-10-17 19:46:33', NULL),
(2067, 508, 9, 2, 1, 2, 52.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2068, 499, 9, 2, 1, 2, 75.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2069, 514, 9, 2, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2070, 579, 9, 2, 1, 2, 35.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2071, 578, 9, 2, 1, 2, 35.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2072, 479, 9, 2, 1, 2, 60.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2073, 506, 9, 2, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2074, 512, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2075, 496, 9, 2, 1, 2, 36.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2076, 507, 9, 2, 1, 2, 69.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2077, 520, 9, 2, 1, 2, 23.00, NULL, NULL, '2025-10-17 19:46:34', NULL),
(2078, 518, 9, 2, 1, 2, 62.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2079, 498, 9, 2, 1, 2, 48.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2080, 487, 9, 2, 1, 2, 57.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2081, 489, 9, 2, 1, 2, 57.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2082, 488, 9, 2, 1, 2, 57.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2083, 490, 9, 2, 1, 2, 67.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2084, 2, 9, 2, 1, 2, 62.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2085, 510, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2086, 494, 9, 2, 1, 2, 22.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2087, 468, 9, 2, 1, 2, 39.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2088, 469, 9, 2, 1, 2, 39.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2089, 470, 9, 2, 1, 2, 24.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2090, 605, 9, 2, 1, 2, 24.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2091, 460, 9, 2, 1, 2, 64.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2092, 522, 9, 2, 1, 2, 80.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2093, 495, 9, 2, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2094, 473, 9, 2, 1, 2, 55.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2095, 472, 9, 2, 1, 2, 42.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2096, 477, 9, 2, 1, 2, 58.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2097, 513, 9, 2, 1, 2, 80.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2098, 502, 9, 2, 1, 2, 39.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2099, 516, 9, 2, 1, 2, 58.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2100, 582, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2101, 475, 9, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2102, 517, 9, 2, 1, 2, 61.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2103, 458, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2104, 457, 9, 2, 1, 2, 40.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2105, 606, 9, 2, 1, 2, 76.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2106, 483, 9, 2, 1, 2, 31.00, NULL, NULL, '2025-10-17 19:46:35', NULL),
(2107, 509, 9, 2, 1, 2, 68.00, NULL, NULL, '2025-10-17 19:46:36', NULL),
(2108, 493, 9, 2, 1, 2, 45.00, NULL, NULL, '2025-10-17 19:46:36', NULL),
(2109, 504, 9, 2, 1, 2, 71.00, NULL, NULL, '2025-10-17 19:46:36', NULL),
(2110, 523, 9, 2, 1, 2, 7.00, NULL, NULL, '2025-10-17 19:46:36', NULL),
(2111, 515, 9, 2, 1, 2, 70.00, NULL, NULL, '2025-10-17 19:46:36', NULL),
(2112, 451, 8, 3, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:12:16', NULL),
(2113, 602, 8, 3, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:12:16', NULL),
(2114, 449, 8, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:12:16', NULL),
(2115, 428, 8, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:12:16', NULL),
(2116, 429, 8, 3, 1, 2, 44.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2117, 397, 8, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2118, 410, 8, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2119, 425, 8, 3, 1, 2, 47.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2120, 419, 8, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2121, 411, 8, 3, 1, 2, 24.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2122, 396, 8, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2123, 421, 8, 3, 1, 2, 24.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2124, 412, 8, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2125, 437, 8, 3, 1, 2, 37.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2126, 592, 8, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2127, 438, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2128, 432, 8, 3, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:12:17', '2025-10-17 22:34:10'),
(2129, 402, 8, 3, 1, 2, 37.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2130, 423, 8, 3, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2131, 406, 8, 3, 1, 2, 55.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2132, 446, 8, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2133, 415, 8, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2134, 445, 8, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2135, 400, 8, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2136, 444, 8, 3, 1, 2, 58.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2137, 436, 8, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2138, 392, 8, 3, 1, 2, 57.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2139, 418, 8, 3, 1, 2, 56.00, NULL, NULL, '2025-10-17 20:12:17', NULL),
(2140, 394, 8, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2141, 395, 8, 3, 1, 2, 26.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2142, 393, 8, 3, 1, 2, 56.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2143, 408, 8, 3, 1, 2, 59.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2144, 417, 8, 3, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2145, 398, 8, 3, 1, 2, 18.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2146, 434, 8, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2147, 405, 8, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2148, 422, 8, 3, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2149, 439, 8, 3, 1, 2, 45.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2150, 443, 8, 3, 1, 2, 38.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2151, 424, 8, 3, 1, 2, 42.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2152, 430, 8, 3, 1, 2, 53.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2153, 435, 8, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2154, 413, 8, 3, 1, 2, 57.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2155, 576, 8, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2156, 448, 8, 3, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2157, 440, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2158, 420, 8, 3, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2159, 442, 8, 3, 1, 2, 74.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2160, 431, 8, 3, 1, 2, 58.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2161, 427, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2162, 447, 8, 3, 1, 2, 52.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2163, 409, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2164, 452, 8, 3, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2165, 404, 8, 3, 1, 2, 79.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2166, 414, 8, 3, 1, 2, 45.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2167, 399, 8, 3, 1, 2, 57.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2168, 441, 8, 3, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2169, 403, 8, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2170, 401, 8, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2171, 407, 8, 3, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:12:18', NULL),
(2172, 416, 8, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2173, 595, 8, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2174, 426, 8, 3, 1, 2, 47.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2175, 453, 8, 3, 1, 2, 55.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2176, 577, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2177, 450, 8, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2178, 433, 8, 3, 1, 2, 42.00, NULL, NULL, '2025-10-17 20:12:19', NULL),
(2179, 629, 8, 3, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:16:57', NULL),
(2180, 630, 8, 3, 1, 2, 46.00, NULL, NULL, '2025-10-17 20:16:57', NULL),
(2181, 451, 8, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2182, 602, 8, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2183, 449, 8, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2184, 428, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2185, 429, 8, 4, 1, 2, 12.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2186, 397, 8, 4, 1, 2, 44.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2187, 410, 8, 4, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2188, 425, 8, 4, 1, 2, 34.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2189, 419, 8, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2190, 411, 8, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2191, 396, 8, 4, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2192, 421, 8, 4, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2193, 412, 8, 4, 1, 2, 6.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2194, 437, 8, 4, 1, 2, 9.00, NULL, NULL, '2025-10-17 20:25:38', NULL),
(2195, 629, 8, 4, 1, 2, 13.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2196, 592, 8, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2197, 438, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2198, 432, 8, 4, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:25:39', '2025-10-17 22:33:59'),
(2199, 402, 8, 4, 1, 2, 27.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2200, 423, 8, 4, 1, 2, 12.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2201, 630, 8, 4, 1, 2, 48.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2202, 406, 8, 4, 1, 2, 22.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2203, 446, 8, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2204, 415, 8, 4, 1, 2, 37.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2205, 445, 8, 4, 1, 2, 83.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2206, 400, 8, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2207, 444, 8, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2208, 436, 8, 4, 1, 2, 59.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2209, 392, 8, 4, 1, 2, 66.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2210, 418, 8, 4, 1, 2, 66.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2211, 394, 8, 4, 1, 2, 54.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2212, 395, 8, 4, 1, 2, 26.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2213, 393, 8, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2214, 408, 8, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2215, 417, 8, 4, 1, 2, 41.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2216, 398, 8, 4, 1, 2, 14.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2217, 434, 8, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2218, 405, 8, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2219, 422, 8, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2220, 439, 8, 4, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2221, 443, 8, 4, 1, 2, 12.00, NULL, NULL, '2025-10-17 20:25:39', NULL),
(2222, 424, 8, 4, 1, 2, 54.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2223, 430, 8, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2224, 435, 8, 4, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2225, 413, 8, 4, 1, 2, 37.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2226, 576, 8, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2227, 448, 8, 4, 1, 2, 30.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2228, 440, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2229, 420, 8, 4, 1, 2, 24.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2230, 442, 8, 4, 1, 2, 73.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2231, 431, 8, 4, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2232, 427, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2233, 447, 8, 4, 1, 2, 39.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2234, 409, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2235, 452, 8, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2236, 404, 8, 4, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2237, 414, 8, 4, 1, 2, 38.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2238, 399, 8, 4, 1, 2, 37.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2239, 441, 8, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2240, 403, 8, 4, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2241, 401, 8, 4, 1, 2, 34.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2242, 407, 8, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2243, 416, 8, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2244, 595, 8, 4, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2245, 426, 8, 4, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2246, 453, 8, 4, 1, 2, 45.00, NULL, NULL, '2025-10-17 20:25:40', NULL);
INSERT INTO `class_results` (`id`, `student_id`, `class_id`, `subject_id`, `term_id`, `result_type_id`, `score`, `grade`, `remarks`, `created_at`, `updated_at`) VALUES
(2247, 577, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2248, 450, 8, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2249, 433, 8, 4, 1, 2, 41.00, NULL, NULL, '2025-10-17 20:25:40', NULL),
(2250, 451, 8, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2251, 602, 8, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2252, 449, 8, 1, 1, 2, 73.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2253, 428, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2254, 429, 8, 1, 1, 2, 14.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2255, 397, 8, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2256, 410, 8, 1, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2257, 425, 8, 1, 1, 2, 42.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2258, 419, 8, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2259, 411, 8, 1, 1, 2, 38.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2260, 396, 8, 1, 1, 2, 76.00, NULL, NULL, '2025-10-17 20:36:07', NULL),
(2261, 421, 8, 1, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2262, 412, 8, 1, 1, 2, 19.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2263, 437, 8, 1, 1, 2, 17.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2264, 629, 8, 1, 1, 2, 19.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2265, 592, 8, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2266, 438, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2267, 432, 8, 1, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:36:08', '2025-10-17 22:34:24'),
(2268, 402, 8, 1, 1, 2, 27.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2269, 423, 8, 1, 1, 2, 30.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2270, 630, 8, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2271, 406, 8, 1, 1, 2, 26.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2272, 446, 8, 1, 1, 2, 46.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2273, 415, 8, 1, 1, 2, 41.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2274, 445, 8, 1, 1, 2, 80.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2275, 400, 8, 1, 1, 2, 63.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2276, 444, 8, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2277, 436, 8, 1, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2278, 392, 8, 1, 1, 2, 63.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2279, 418, 8, 1, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2280, 394, 8, 1, 1, 2, 55.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2281, 395, 8, 1, 1, 2, 8.00, NULL, NULL, '2025-10-17 20:36:08', NULL),
(2282, 393, 8, 1, 1, 2, 53.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2283, 408, 8, 1, 1, 2, 28.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2284, 417, 8, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2285, 398, 8, 1, 1, 2, 20.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2286, 434, 8, 1, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2287, 405, 8, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2288, 422, 8, 1, 1, 2, 75.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2289, 439, 8, 1, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2290, 443, 8, 1, 1, 2, 27.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2291, 424, 8, 1, 1, 2, 75.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2292, 430, 8, 1, 1, 2, 48.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2293, 435, 8, 1, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2294, 413, 8, 1, 1, 2, 4.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2295, 576, 8, 1, 1, 2, 73.00, NULL, NULL, '2025-10-17 20:36:09', NULL),
(2296, 448, 8, 1, 1, 2, 46.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2297, 440, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2298, 420, 8, 1, 1, 2, 34.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2299, 442, 8, 1, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2300, 431, 8, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2301, 427, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2302, 447, 8, 1, 1, 2, 26.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2303, 409, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2304, 452, 8, 1, 1, 2, 18.00, NULL, NULL, '2025-10-17 20:36:10', '2025-10-17 22:55:27'),
(2305, 404, 8, 1, 1, 2, 43.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2306, 414, 8, 1, 1, 2, 44.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2307, 399, 8, 1, 1, 2, 29.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2308, 441, 8, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2309, 403, 8, 1, 1, 2, 56.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2310, 401, 8, 1, 1, 2, 35.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2311, 407, 8, 1, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2312, 416, 8, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2313, 595, 8, 1, 1, 2, 44.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2314, 426, 8, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2315, 453, 8, 1, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2316, 577, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2317, 450, 8, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2318, 433, 8, 1, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:36:10', NULL),
(2319, 451, 8, 2, 1, 2, 78.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2320, 602, 8, 2, 1, 2, 78.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2321, 449, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2322, 428, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2323, 429, 8, 2, 1, 2, 29.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2324, 397, 8, 2, 1, 2, 76.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2325, 410, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2326, 425, 8, 2, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2327, 419, 8, 2, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:45:08', NULL),
(2328, 411, 8, 2, 1, 2, 24.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2329, 396, 8, 2, 1, 2, 84.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2330, 421, 8, 2, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2331, 412, 8, 2, 1, 2, 29.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2332, 437, 8, 2, 1, 2, 33.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2333, 629, 8, 2, 1, 2, 35.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2334, 592, 8, 2, 1, 2, 86.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2335, 438, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2336, 432, 8, 2, 1, 2, 84.00, NULL, NULL, '2025-10-17 20:45:09', '2025-10-17 22:34:42'),
(2337, 402, 8, 2, 1, 2, 46.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2338, 423, 8, 2, 1, 2, 43.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2339, 630, 8, 2, 1, 2, 83.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2340, 406, 8, 2, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2341, 446, 8, 2, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2342, 415, 8, 2, 1, 2, 67.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2343, 445, 8, 2, 1, 2, 87.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2344, 400, 8, 2, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2345, 444, 8, 2, 1, 2, 77.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2346, 436, 8, 2, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2347, 392, 8, 2, 1, 2, 77.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2348, 418, 8, 2, 1, 2, 51.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2349, 394, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2350, 395, 8, 2, 1, 2, 42.00, NULL, NULL, '2025-10-17 20:45:09', NULL),
(2351, 393, 8, 2, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2352, 408, 8, 2, 1, 2, 59.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2353, 417, 8, 2, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2354, 398, 8, 2, 1, 2, 30.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2355, 434, 8, 2, 1, 2, 45.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2356, 405, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2357, 422, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2358, 439, 8, 2, 1, 2, 81.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2359, 443, 8, 2, 1, 2, 58.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2360, 424, 8, 2, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2361, 430, 8, 2, 1, 2, 68.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2362, 435, 8, 2, 1, 2, 90.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2363, 413, 8, 2, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2364, 576, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2365, 448, 8, 2, 1, 2, 63.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2366, 440, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2367, 420, 8, 2, 1, 2, 51.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2368, 442, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:10', NULL),
(2369, 431, 8, 2, 1, 2, 53.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2370, 427, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2371, 447, 8, 2, 1, 2, 43.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2372, 409, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2373, 452, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2374, 404, 8, 2, 1, 2, 74.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2375, 414, 8, 2, 1, 2, 41.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2376, 399, 8, 2, 1, 2, 63.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2377, 441, 8, 2, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2378, 403, 8, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2379, 401, 8, 2, 1, 2, 38.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2380, 407, 8, 2, 1, 2, 85.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2381, 416, 8, 2, 1, 2, 84.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2382, 595, 8, 2, 1, 2, 69.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2383, 426, 8, 2, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2384, 453, 8, 2, 1, 2, 75.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2385, 577, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2386, 450, 8, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2387, 433, 8, 2, 1, 2, 76.00, NULL, NULL, '2025-10-17 20:45:11', NULL),
(2388, 531, 10, 4, 1, 2, 39.00, NULL, NULL, '2025-10-17 20:54:52', NULL),
(2389, 561, 10, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 20:54:52', NULL),
(2390, 536, 10, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 20:54:52', NULL),
(2391, 557, 10, 4, 1, 2, 42.00, NULL, NULL, '2025-10-17 20:54:52', NULL),
(2392, 543, 10, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2393, 542, 10, 4, 1, 2, 52.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2394, 556, 10, 4, 1, 2, 48.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2395, 549, 10, 4, 1, 2, 55.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2396, 525, 10, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2397, 567, 10, 4, 1, 2, 61.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2398, 560, 10, 4, 1, 2, 64.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2399, 529, 10, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2400, 547, 10, 4, 1, 2, 54.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2401, 545, 10, 4, 1, 2, 87.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2402, 528, 10, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2403, 546, 10, 4, 1, 2, 38.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2404, 562, 10, 4, 1, 2, 36.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2405, 565, 10, 4, 1, 2, 41.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2406, 568, 10, 4, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2407, 551, 10, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2408, 541, 10, 4, 1, 2, 31.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2409, 566, 10, 4, 1, 2, 51.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2410, 527, 10, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2411, 604, 10, 4, 1, 2, 72.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2412, 526, 10, 4, 1, 2, 81.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2413, 554, 10, 4, 1, 2, 62.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2414, 539, 10, 4, 1, 2, 35.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2415, 535, 10, 4, 1, 2, 87.00, NULL, NULL, '2025-10-17 20:54:53', NULL),
(2416, 534, 10, 4, 1, 2, 77.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2417, 553, 10, 4, 1, 2, 89.00, NULL, NULL, '2025-10-17 20:54:54', '2025-10-22 22:17:21'),
(2418, 555, 10, 4, 1, 2, 89.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2419, 563, 10, 4, 1, 2, 27.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2420, 559, 10, 4, 1, 2, 56.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2421, 530, 10, 4, 1, 2, 58.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2422, 564, 10, 4, 1, 2, 83.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2423, 548, 10, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2424, 552, 10, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2425, 558, 10, 4, 1, 2, 70.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2426, 524, 10, 4, 1, 2, 73.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2427, 544, 10, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2428, 537, 10, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2429, 550, 10, 4, 1, 2, 60.00, NULL, NULL, '2025-10-17 20:54:54', NULL),
(2430, 532, 10, 4, 1, 2, 71.00, NULL, NULL, '2025-10-17 20:54:55', NULL),
(2431, 533, 10, 4, 1, 2, 49.00, NULL, NULL, '2025-10-17 20:54:55', NULL),
(2432, 540, 10, 4, 1, 2, 0.00, NULL, NULL, '2025-10-17 20:54:55', NULL),
(2433, 538, 10, 4, 1, 2, 65.00, NULL, NULL, '2025-10-17 20:54:55', NULL),
(2434, 632, 10, 4, 1, 2, 53.00, NULL, NULL, '2025-10-17 20:59:23', NULL),
(2435, 631, 10, 4, 1, 2, 50.00, NULL, NULL, '2025-10-17 20:59:24', NULL),
(2436, 531, 10, 3, 1, 2, 44.00, NULL, NULL, '2025-10-17 21:13:38', NULL),
(2437, 561, 10, 3, 1, 2, 85.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2438, 536, 10, 3, 1, 2, 61.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2439, 557, 10, 3, 1, 2, 61.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2440, 543, 10, 3, 1, 2, 33.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2441, 542, 10, 3, 1, 2, 33.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2442, 556, 10, 3, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2443, 549, 10, 3, 1, 2, 73.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2444, 525, 10, 3, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2445, 567, 10, 3, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2446, 560, 10, 3, 1, 2, 58.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2447, 529, 10, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2448, 547, 10, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2449, 545, 10, 3, 1, 2, 83.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2450, 528, 10, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2451, 546, 10, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2452, 562, 10, 3, 1, 2, 20.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2453, 565, 10, 3, 1, 2, 54.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2454, 568, 10, 3, 1, 2, 84.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2455, 551, 10, 3, 1, 2, 64.00, NULL, NULL, '2025-10-17 21:13:39', NULL),
(2456, 632, 10, 3, 1, 2, 63.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2457, 541, 10, 3, 1, 2, 47.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2458, 566, 10, 3, 1, 2, 55.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2459, 527, 10, 3, 1, 2, 37.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2460, 604, 10, 3, 1, 2, 52.00, NULL, NULL, '2025-10-17 21:13:40', '2025-10-17 23:53:32'),
(2461, 526, 10, 3, 1, 2, 66.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2462, 554, 10, 3, 1, 2, 65.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2463, 539, 10, 3, 1, 2, 23.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2464, 535, 10, 3, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2465, 534, 10, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2466, 553, 10, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2467, 555, 10, 3, 1, 2, 80.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2468, 563, 10, 3, 1, 2, 37.00, NULL, NULL, '2025-10-17 21:13:40', '2025-10-17 23:53:51'),
(2469, 559, 10, 3, 1, 2, 61.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2470, 530, 10, 3, 1, 2, 51.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2471, 564, 10, 3, 1, 2, 68.00, NULL, NULL, '2025-10-17 21:13:40', NULL),
(2472, 548, 10, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2473, 552, 10, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2474, 558, 10, 3, 1, 2, 66.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2475, 524, 10, 3, 1, 2, 76.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2476, 544, 10, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2477, 537, 10, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2478, 550, 10, 3, 1, 2, 78.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2479, 532, 10, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2480, 533, 10, 3, 1, 2, 35.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2481, 540, 10, 3, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2482, 538, 10, 3, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2483, 631, 10, 3, 1, 2, 50.00, NULL, NULL, '2025-10-17 21:13:41', NULL),
(2484, 531, 10, 1, 1, 2, 43.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2485, 561, 10, 1, 1, 2, 72.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2486, 536, 10, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2487, 557, 10, 1, 1, 2, 67.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2488, 543, 10, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2489, 542, 10, 1, 1, 2, 45.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2490, 556, 10, 1, 1, 2, 69.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2491, 549, 10, 1, 1, 2, 75.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2492, 525, 10, 1, 1, 2, 58.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2493, 567, 10, 1, 1, 2, 69.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2494, 560, 10, 1, 1, 2, 41.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2495, 529, 10, 1, 1, 2, 59.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2496, 547, 10, 1, 1, 2, 68.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2497, 545, 10, 1, 1, 2, 86.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2498, 528, 10, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:22:57', NULL),
(2499, 546, 10, 1, 1, 2, 78.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2500, 562, 10, 1, 1, 2, 35.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2501, 565, 10, 1, 1, 2, 49.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2502, 568, 10, 1, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2503, 551, 10, 1, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2504, 632, 10, 1, 1, 2, 40.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2505, 541, 10, 1, 1, 2, 49.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2506, 566, 10, 1, 1, 2, 31.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2507, 527, 10, 1, 1, 2, 64.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2508, 604, 10, 1, 1, 2, 65.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2509, 526, 10, 1, 1, 2, 74.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2510, 554, 10, 1, 1, 2, 82.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2511, 539, 10, 1, 1, 2, 21.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2512, 535, 10, 1, 1, 2, 68.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2513, 534, 10, 1, 1, 2, 67.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2514, 553, 10, 1, 1, 2, 94.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2515, 555, 10, 1, 1, 2, 94.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2516, 563, 10, 1, 1, 2, 14.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2517, 559, 10, 1, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2518, 530, 10, 1, 1, 2, 56.00, NULL, NULL, '2025-10-17 21:22:58', NULL),
(2519, 564, 10, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2520, 548, 10, 1, 1, 2, 63.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2521, 552, 10, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2522, 558, 10, 1, 1, 2, 74.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2523, 524, 10, 1, 1, 2, 64.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2524, 544, 10, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2525, 537, 10, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2526, 550, 10, 1, 1, 2, 61.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2527, 532, 10, 1, 1, 2, 68.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2528, 533, 10, 1, 1, 2, 44.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2529, 540, 10, 1, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2530, 538, 10, 1, 1, 2, 70.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2531, 631, 10, 1, 1, 2, 43.00, NULL, NULL, '2025-10-17 21:22:59', NULL),
(2532, 531, 10, 2, 1, 2, 45.00, NULL, NULL, '2025-10-17 21:31:02', NULL),
(2533, 561, 10, 2, 1, 2, 73.00, NULL, NULL, '2025-10-17 21:31:02', NULL),
(2534, 536, 10, 2, 1, 2, 67.00, NULL, NULL, '2025-10-17 21:31:02', NULL),
(2535, 557, 10, 2, 1, 2, 48.00, NULL, NULL, '2025-10-17 21:31:02', NULL),
(2536, 543, 10, 2, 1, 2, 20.00, NULL, NULL, '2025-10-17 21:31:02', NULL),
(2537, 542, 10, 2, 1, 2, 20.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2538, 556, 10, 2, 1, 2, 54.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2539, 549, 10, 2, 1, 2, 68.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2540, 525, 10, 2, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2541, 567, 10, 2, 1, 2, 63.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2542, 560, 10, 2, 1, 2, 44.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2543, 529, 10, 2, 1, 2, 80.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2544, 547, 10, 2, 1, 2, 46.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2545, 545, 10, 2, 1, 2, 96.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2546, 528, 10, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2547, 546, 10, 2, 1, 2, 35.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2548, 562, 10, 2, 1, 2, 38.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2549, 565, 10, 2, 1, 2, 27.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2550, 568, 10, 2, 1, 2, 73.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2551, 551, 10, 2, 1, 2, 52.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2552, 632, 10, 2, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:31:03', NULL),
(2553, 541, 10, 2, 1, 2, 39.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2554, 566, 10, 2, 1, 2, 55.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2555, 527, 10, 2, 1, 2, 55.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2556, 604, 10, 2, 1, 2, 61.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2557, 526, 10, 2, 1, 2, 72.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2558, 554, 10, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2559, 539, 10, 2, 1, 2, 14.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2560, 535, 10, 2, 1, 2, 84.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2561, 534, 10, 2, 1, 2, 75.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2562, 553, 10, 2, 1, 2, 95.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2563, 555, 10, 2, 1, 2, 95.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2564, 563, 10, 2, 1, 2, 21.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2565, 559, 10, 2, 1, 2, 53.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2566, 530, 10, 2, 1, 2, 35.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2567, 564, 10, 2, 1, 2, 78.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2568, 548, 10, 2, 1, 2, 75.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2569, 552, 10, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2570, 558, 10, 2, 1, 2, 82.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2571, 524, 10, 2, 1, 2, 71.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2572, 544, 10, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:31:04', NULL),
(2573, 537, 10, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2574, 550, 10, 2, 1, 2, 54.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2575, 532, 10, 2, 1, 2, 78.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2576, 533, 10, 2, 1, 2, 58.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2577, 540, 10, 2, 1, 2, 0.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2578, 538, 10, 2, 1, 2, 62.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2579, 631, 10, 2, 1, 2, 60.00, NULL, NULL, '2025-10-17 21:31:05', NULL),
(2580, 388, 7, 4, 1, 5, 45.00, NULL, NULL, '2025-10-22 22:28:13', NULL),
(2581, 365, 7, 4, 1, 5, 78.00, NULL, NULL, '2025-10-22 22:28:14', NULL),
(2582, 382, 7, 4, 1, 5, 90.00, NULL, NULL, '2025-10-22 22:28:14', NULL),
(2583, 268, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:01', NULL),
(2584, 260, 5, 4, 1, 5, 76.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2585, 262, 5, 4, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2586, 224, 5, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2587, 270, 5, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2588, 247, 5, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2589, 239, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2590, 221, 5, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2591, 261, 5, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2592, 230, 5, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2593, 621, 5, 4, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2594, 251, 5, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2595, 234, 5, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:22:02', NULL),
(2596, 253, 5, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2597, 245, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2598, 250, 5, 4, 1, 5, 74.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2599, 249, 5, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2600, 235, 5, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2601, 231, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2602, 229, 5, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2603, 227, 5, 4, 1, 5, 72.00, NULL, NULL, '2025-11-11 14:22:03', NULL),
(2604, 259, 5, 4, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2605, 236, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2606, 257, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2607, 237, 5, 4, 1, 5, 82.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2608, 246, 5, 4, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2609, 243, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2610, 271, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:04', NULL),
(2611, 225, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:05', NULL),
(2612, 228, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:06', NULL),
(2613, 622, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:07', NULL),
(2614, 242, 5, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 14:22:07', NULL),
(2615, 252, 5, 4, 1, 5, 78.00, NULL, NULL, '2025-11-11 14:22:07', NULL),
(2616, 266, 5, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:22:07', NULL),
(2617, 269, 5, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2618, 244, 5, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2619, 240, 5, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2620, 623, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2621, 233, 5, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2622, 248, 5, 4, 1, 5, 72.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2623, 255, 5, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2624, 624, 5, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2625, 226, 5, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2626, 256, 5, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2627, 254, 5, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2628, 265, 5, 4, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2629, 223, 5, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:22:08', NULL),
(2630, 268, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2631, 260, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2632, 262, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2633, 224, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2634, 270, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2635, 247, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2636, 239, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:25', NULL),
(2637, 221, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2638, 261, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2639, 230, 5, 3, 1, 5, 98.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2640, 621, 5, 3, 1, 5, 98.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2641, 251, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2642, 234, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2643, 253, 5, 3, 1, 5, 82.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2644, 245, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2645, 250, 5, 3, 1, 5, 79.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2646, 249, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2647, 235, 5, 3, 1, 5, 82.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2648, 231, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2649, 229, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2650, 227, 5, 3, 1, 5, 72.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2651, 259, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:26', NULL),
(2652, 236, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2653, 257, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2654, 237, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2655, 264, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2656, 246, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2657, 243, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2658, 271, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2659, 228, 5, 3, 1, 5, 96.00, NULL, NULL, '2025-11-11 14:49:27', NULL),
(2660, 242, 5, 3, 1, 5, 78.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2661, 252, 5, 3, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2662, 266, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2663, 269, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2664, 244, 5, 3, 1, 5, 90.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2665, 240, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2666, 623, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2667, 233, 5, 3, 1, 5, 92.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2668, 248, 5, 3, 1, 5, 78.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2669, 255, 5, 3, 1, 5, 98.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2670, 624, 5, 3, 1, 5, 84.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2671, 226, 5, 3, 1, 5, 88.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2672, 256, 5, 3, 1, 5, 80.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2673, 254, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2674, 265, 5, 3, 1, 5, 94.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2675, 223, 5, 3, 1, 5, 98.00, NULL, NULL, '2025-11-11 14:49:28', NULL),
(2676, 268, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2677, 260, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2678, 262, 5, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2679, 224, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2680, 270, 5, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2681, 247, 5, 7, 1, 5, 79.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2682, 239, 5, 7, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2683, 221, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2684, 261, 5, 7, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2685, 230, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2686, 621, 5, 7, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:04:25', NULL),
(2687, 251, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2688, 234, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2689, 253, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2690, 245, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2691, 250, 5, 7, 1, 5, 78.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2692, 249, 5, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2693, 235, 5, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2694, 231, 5, 7, 1, 5, 89.00, NULL, NULL, '2025-11-11 15:04:26', '2025-11-11 15:05:59'),
(2695, 229, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2696, 227, 5, 7, 1, 5, 89.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2697, 259, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2698, 236, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2699, 257, 5, 7, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2700, 237, 5, 7, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2701, 264, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2702, 246, 5, 7, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2703, 243, 5, 7, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:04:26', NULL),
(2704, 271, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2705, 228, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2706, 622, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2707, 242, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2708, 252, 5, 7, 1, 5, 84.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2709, 266, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2710, 269, 5, 7, 1, 5, 89.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2711, 244, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2712, 240, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2713, 623, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2714, 233, 5, 7, 1, 5, 89.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2715, 248, 5, 7, 1, 5, 89.00, NULL, NULL, '2025-11-11 15:04:27', NULL),
(2716, 255, 5, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2717, 624, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2718, 226, 5, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2719, 256, 5, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2720, 254, 5, 7, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2721, 265, 5, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2722, 223, 5, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:04:28', NULL),
(2723, 268, 5, 8, 1, 5, 86.00, NULL, NULL, '2025-11-11 15:14:52', NULL),
(2724, 260, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:52', NULL),
(2725, 224, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2726, 270, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2727, 247, 5, 8, 1, 5, 66.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2728, 239, 5, 8, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2729, 221, 5, 8, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2730, 261, 5, 8, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2731, 230, 5, 8, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2732, 621, 5, 8, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2733, 251, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2734, 234, 5, 8, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2735, 253, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2736, 245, 5, 8, 1, 5, 78.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2737, 250, 5, 8, 1, 5, 74.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2738, 249, 5, 8, 1, 5, 77.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2739, 235, 5, 8, 1, 5, 80.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2740, 231, 5, 8, 1, 5, 76.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2741, 229, 5, 8, 1, 5, 84.00, NULL, NULL, '2025-11-11 15:14:53', NULL),
(2742, 227, 5, 8, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2743, 259, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2744, 236, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2745, 257, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2746, 237, 5, 8, 1, 5, 80.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2747, 264, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2748, 246, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2749, 243, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2750, 271, 5, 8, 1, 5, 84.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2751, 228, 5, 8, 1, 5, 89.98, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2752, 622, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2753, 242, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:54', NULL),
(2754, 252, 5, 8, 1, 5, 80.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2755, 266, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2756, 269, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2757, 244, 5, 8, 1, 5, 92.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2758, 240, 5, 8, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2759, 623, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2760, 233, 5, 8, 1, 5, 86.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2761, 248, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2762, 255, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2763, 624, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2764, 226, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2765, 256, 5, 8, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2766, 254, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2767, 265, 5, 8, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2768, 223, 5, 8, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:14:55', NULL),
(2769, 268, 5, 9, 1, 5, 85.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2770, 260, 5, 9, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2771, 224, 5, 9, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2772, 270, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2773, 247, 5, 9, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2774, 239, 5, 9, 1, 5, 98.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2775, 221, 5, 9, 1, 5, 85.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2776, 261, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:22:58', NULL),
(2777, 230, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2778, 621, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2779, 251, 5, 9, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2780, 234, 5, 9, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2781, 253, 5, 9, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2782, 245, 5, 9, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2783, 250, 5, 9, 1, 5, 78.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2784, 249, 5, 9, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2785, 235, 5, 9, 1, 5, 96.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2786, 231, 5, 9, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2787, 229, 5, 9, 1, 5, 79.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2788, 227, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:22:59', NULL),
(2789, 259, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2790, 236, 5, 9, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2791, 257, 5, 9, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2792, 237, 5, 9, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2793, 264, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2794, 246, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2795, 243, 5, 9, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2796, 271, 5, 9, 1, 5, 88.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2797, 228, 5, 9, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2798, 622, 5, 9, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2799, 242, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2800, 252, 5, 9, 1, 5, 62.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2801, 266, 5, 9, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2802, 269, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2803, 244, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:00', NULL),
(2804, 240, 5, 9, 1, 5, 74.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2805, 623, 5, 9, 1, 5, 90.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2806, 233, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2807, 248, 5, 9, 1, 5, 91.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2808, 255, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2809, 624, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2810, 226, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2811, 256, 5, 9, 1, 5, 82.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2812, 254, 5, 9, 1, 5, 94.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2813, 265, 5, 9, 1, 5, 97.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2814, 223, 5, 9, 1, 5, 99.00, NULL, NULL, '2025-11-11 15:23:01', NULL),
(2815, 620, 6, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2816, 316, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2817, 618, 6, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2818, 326, 6, 4, 1, 5, 92.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2819, 614, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2820, 279, 6, 4, 1, 5, 78.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2821, 615, 6, 4, 1, 5, 78.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2822, 322, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2823, 305, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2824, 328, 6, 4, 1, 5, 56.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2825, 306, 6, 4, 1, 5, 76.00, NULL, NULL, '2025-11-11 16:28:15', NULL),
(2826, 297, 6, 4, 1, 5, 60.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2827, 333, 6, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2828, 311, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2829, 294, 6, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2830, 298, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2831, 308, 6, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2832, 278, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2833, 304, 6, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2834, 619, 6, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2835, 318, 6, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 16:28:16', NULL),
(2836, 287, 6, 4, 1, 5, 76.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2837, 315, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:17', '2025-11-11 17:18:11'),
(2838, 324, 6, 4, 1, 5, 74.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2839, 290, 6, 4, 1, 5, 78.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2840, 327, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2841, 296, 6, 4, 1, 5, 40.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2842, 281, 6, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2843, 299, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2844, 325, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2845, 307, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2846, 292, 6, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2847, 276, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2848, 300, 6, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 16:28:17', NULL),
(2849, 277, 6, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2850, 303, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2851, 319, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2852, 332, 6, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2853, 289, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2854, 272, 6, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2855, 301, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2856, 601, 6, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2857, 273, 6, 4, 1, 5, 88.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2858, 293, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2859, 313, 6, 4, 1, 5, 82.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2860, 284, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2861, 302, 6, 4, 1, 5, 82.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2862, 317, 6, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2863, 572, 6, 4, 1, 5, 78.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2864, 331, 6, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 16:28:18', NULL),
(2865, 613, 6, 4, 1, 5, 84.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2866, 282, 6, 4, 1, 5, 76.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2867, 291, 6, 4, 1, 5, 86.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2868, 612, 6, 4, 1, 5, 70.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2869, 314, 6, 4, 1, 5, 64.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2870, 280, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2871, 283, 6, 4, 1, 5, 72.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2872, 321, 6, 4, 1, 5, 90.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2873, 320, 6, 4, 1, 5, 94.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2874, 617, 6, 4, 1, 5, 82.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2875, 616, 6, 4, 1, 5, 82.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2876, 288, 6, 4, 1, 5, 60.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2877, 323, 6, 4, 1, 5, 80.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2878, 330, 6, 4, 1, 5, 98.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2879, 312, 6, 4, 1, 5, 76.00, NULL, NULL, '2025-11-11 16:28:19', NULL),
(2880, 620, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:12', NULL),
(2881, 316, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:12', NULL),
(2882, 618, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:12', NULL),
(2883, 326, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:12', NULL),
(2884, 614, 6, 3, NULL, 5, 90.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2885, 279, 6, 3, NULL, 5, 90.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2886, 615, 6, 3, NULL, 5, 90.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2887, 274, 6, 3, NULL, 5, 93.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2888, 322, 6, 3, NULL, 5, 90.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2889, 305, 6, 3, NULL, 5, 97.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2890, 328, 6, 3, NULL, 5, 74.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2891, 306, 6, 3, NULL, 5, 82.00, NULL, NULL, '2025-11-11 16:50:13', NULL),
(2892, 297, 6, 3, NULL, 5, 85.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2893, 333, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2894, 311, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2895, 294, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2896, 298, 6, 3, NULL, 5, 92.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2897, 308, 6, 3, NULL, 5, 93.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2898, 278, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2899, 304, 6, 3, NULL, 5, 88.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2900, 619, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2901, 318, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2902, 287, 6, 3, NULL, 5, 88.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2903, 315, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2904, 324, 6, 3, NULL, 5, 95.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2905, 290, 6, 3, NULL, 5, 88.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2906, 327, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2907, 296, 6, 3, NULL, 5, 67.00, NULL, NULL, '2025-11-11 16:50:14', NULL),
(2908, 281, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2909, 299, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2910, 325, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2911, 307, 6, 3, NULL, 5, 97.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2912, 292, 6, 3, NULL, 5, 95.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2913, 276, 6, 3, NULL, 5, 86.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2914, 300, 6, 3, NULL, 5, 88.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2915, 277, 6, 3, NULL, 5, 73.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2916, 303, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2917, 319, 6, 3, NULL, 5, 91.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2918, 332, 6, 3, NULL, 5, 97.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2919, 289, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2920, 272, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2921, 301, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2922, 601, 6, 3, NULL, 5, 80.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2923, 273, 6, 3, NULL, 5, 98.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2924, 293, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:15', NULL),
(2925, 313, 6, 3, NULL, 5, 93.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2926, 284, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2927, 302, 6, 3, NULL, 5, 92.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2928, 317, 6, 3, NULL, 5, 89.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2929, 572, 6, 3, NULL, 5, 95.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2930, 331, 6, 3, NULL, 5, 92.00, NULL, NULL, '2025-11-11 16:50:16', NULL),
(2931, 613, 6, 3, NULL, 5, 84.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2932, 282, 6, 3, NULL, 5, 72.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2933, 291, 6, 3, NULL, 5, 96.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2934, 612, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2935, 314, 6, 3, NULL, 5, 76.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2936, 280, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2937, 283, 6, 3, NULL, 5, 90.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2938, 321, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2939, 320, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2940, 617, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2941, 616, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:17', NULL);
INSERT INTO `class_results` (`id`, `student_id`, `class_id`, `subject_id`, `term_id`, `result_type_id`, `score`, `grade`, `remarks`, `created_at`, `updated_at`) VALUES
(2942, 288, 6, 3, NULL, 5, 85.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2943, 323, 6, 3, NULL, 5, 86.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2944, 330, 6, 3, NULL, 5, 99.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2945, 312, 6, 3, NULL, 5, 94.00, NULL, NULL, '2025-11-11 16:50:17', NULL),
(2946, 274, 6, 4, NULL, 5, 76.00, NULL, NULL, '2025-11-11 16:51:23', NULL),
(2947, 620, 6, 7, 1, 5, 83.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2948, 316, 6, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2949, 618, 6, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2950, 326, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2951, 614, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2952, 279, 6, 7, 1, 5, 80.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2953, 615, 6, 7, 1, 5, 80.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2954, 274, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2955, 322, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2956, 305, 6, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2957, 328, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2958, 306, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2959, 297, 6, 7, 1, 5, 76.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2960, 333, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2961, 311, 6, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 17:01:41', NULL),
(2962, 294, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2963, 298, 6, 7, 1, 5, 78.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2964, 308, 6, 7, 1, 5, 94.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2965, 278, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2966, 304, 6, 7, 1, 5, 84.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2967, 619, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2968, 318, 6, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 17:01:42', NULL),
(2969, 287, 6, 7, 1, 5, 82.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2970, 315, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2971, 324, 6, 7, 1, 5, 66.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2972, 290, 6, 7, 1, 5, 70.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2973, 327, 6, 7, 1, 5, 78.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2974, 296, 6, 7, 1, 5, 60.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2975, 281, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2976, 299, 6, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2977, 325, 6, 7, 1, 5, 80.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2978, 307, 6, 7, 1, 5, 82.00, NULL, NULL, '2025-11-11 17:01:43', NULL),
(2979, 292, 6, 7, 1, 5, 80.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2980, 276, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2981, 300, 6, 7, 1, 5, 76.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2982, 277, 6, 7, 1, 5, 66.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2983, 303, 6, 7, 1, 5, 99.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2984, 319, 6, 7, 1, 5, 74.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2985, 332, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2986, 289, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2987, 272, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2988, 301, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2989, 601, 6, 7, 1, 5, 64.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2990, 273, 6, 7, 1, 5, 90.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2991, 293, 6, 7, 1, 5, 82.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2992, 313, 6, 7, 1, 5, 93.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2993, 284, 6, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2994, 302, 6, 7, 1, 5, 74.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2995, 317, 6, 7, 1, 5, 92.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2996, 572, 6, 7, 1, 5, 80.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2997, 331, 6, 7, 1, 5, 76.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2998, 613, 6, 7, 1, 5, 84.00, NULL, NULL, '2025-11-11 17:01:44', NULL),
(2999, 282, 6, 7, 1, 5, 68.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3000, 291, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3001, 612, 6, 7, 1, 5, 78.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3002, 314, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3003, 280, 6, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3004, 283, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3005, 321, 6, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3006, 320, 6, 7, 1, 5, 88.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3007, 617, 6, 7, 1, 5, 70.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3008, 616, 6, 7, 1, 5, 70.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3009, 288, 6, 7, 1, 5, 78.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3010, 323, 6, 7, 1, 5, 86.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3011, 330, 6, 7, 1, 5, 96.00, NULL, NULL, '2025-11-11 17:01:45', NULL),
(3012, 312, 6, 7, 1, 5, 98.00, NULL, NULL, '2025-11-11 17:01:45', NULL);

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
(3, 459, 9, NULL, NULL, NULL, NULL, 'active'),
(4, 460, 9, NULL, NULL, NULL, NULL, 'active'),
(5, 461, 9, NULL, NULL, NULL, NULL, 'active'),
(6, 462, 9, NULL, NULL, NULL, NULL, 'active'),
(7, 463, 9, NULL, NULL, NULL, NULL, 'active'),
(8, 464, 9, NULL, NULL, NULL, NULL, 'active'),
(9, 465, 9, NULL, NULL, NULL, NULL, 'active'),
(10, 466, 9, NULL, NULL, NULL, NULL, 'active'),
(11, 467, 9, NULL, NULL, NULL, NULL, 'active'),
(12, 468, 9, NULL, NULL, NULL, NULL, 'active'),
(13, 469, 9, NULL, NULL, NULL, NULL, 'active'),
(14, 470, 9, NULL, NULL, NULL, NULL, 'active'),
(15, 471, 9, NULL, NULL, NULL, NULL, 'active'),
(16, 472, 9, NULL, NULL, NULL, NULL, 'active'),
(17, 473, 9, NULL, NULL, NULL, NULL, 'active'),
(18, 474, 9, NULL, NULL, NULL, NULL, 'active'),
(19, 475, 9, NULL, NULL, NULL, NULL, 'active'),
(20, 476, 9, NULL, NULL, NULL, NULL, 'active'),
(21, 477, 9, NULL, NULL, NULL, NULL, 'active'),
(22, 478, 9, NULL, NULL, NULL, NULL, 'active'),
(23, 479, 9, NULL, NULL, NULL, NULL, 'active'),
(24, 480, 9, NULL, NULL, NULL, NULL, 'active'),
(25, 481, 9, NULL, NULL, NULL, NULL, 'active'),
(26, 482, 9, NULL, NULL, NULL, NULL, 'active'),
(27, 483, 9, NULL, NULL, NULL, NULL, 'active'),
(28, 484, 9, NULL, NULL, NULL, NULL, 'active'),
(29, 485, 9, NULL, NULL, NULL, NULL, 'active'),
(30, 486, 9, NULL, NULL, NULL, NULL, 'active'),
(31, 487, 9, NULL, NULL, NULL, NULL, 'active'),
(32, 488, 9, NULL, NULL, NULL, NULL, 'active'),
(33, 489, 9, NULL, NULL, NULL, NULL, 'active'),
(34, 490, 9, NULL, NULL, NULL, NULL, 'active'),
(35, 491, 9, NULL, NULL, NULL, NULL, 'active'),
(36, 492, 9, NULL, NULL, NULL, NULL, 'active'),
(37, 493, 9, NULL, NULL, NULL, NULL, 'active'),
(38, 494, 9, NULL, NULL, NULL, NULL, 'active'),
(39, 495, 9, NULL, NULL, NULL, NULL, 'active'),
(40, 496, 9, NULL, NULL, NULL, NULL, 'active'),
(41, 497, 9, NULL, NULL, NULL, NULL, 'active'),
(42, 498, 9, NULL, NULL, NULL, NULL, 'active'),
(43, 499, 9, NULL, NULL, NULL, NULL, 'active'),
(44, 500, 9, NULL, NULL, NULL, NULL, 'active'),
(45, 501, 9, NULL, NULL, NULL, NULL, 'active'),
(46, 502, 9, NULL, NULL, NULL, NULL, 'active'),
(47, 503, 9, NULL, NULL, NULL, NULL, 'active'),
(48, 504, 9, NULL, NULL, NULL, NULL, 'active'),
(49, 505, 9, NULL, NULL, NULL, NULL, 'active'),
(50, 506, 9, NULL, NULL, NULL, NULL, 'active'),
(51, 507, 9, NULL, NULL, NULL, NULL, 'active'),
(52, 508, 9, NULL, NULL, NULL, NULL, 'active'),
(53, 509, 9, NULL, NULL, NULL, NULL, 'active'),
(54, 510, 9, NULL, NULL, NULL, NULL, 'active'),
(55, 511, 9, NULL, NULL, NULL, NULL, 'active'),
(56, 512, 9, NULL, NULL, NULL, NULL, 'active'),
(57, 513, 9, NULL, NULL, NULL, NULL, 'active'),
(58, 514, 9, NULL, NULL, NULL, NULL, 'active'),
(59, 515, 9, NULL, NULL, NULL, NULL, 'active'),
(60, 516, 9, NULL, NULL, NULL, NULL, 'active'),
(61, 517, 9, NULL, NULL, NULL, NULL, 'active'),
(62, 518, 9, NULL, NULL, NULL, NULL, 'active'),
(63, 519, 9, NULL, NULL, NULL, NULL, 'active'),
(64, 520, 9, NULL, NULL, NULL, NULL, 'active'),
(65, 521, 9, NULL, NULL, NULL, NULL, 'active'),
(66, 522, 9, NULL, NULL, NULL, NULL, 'active'),
(67, 523, 9, NULL, NULL, NULL, NULL, 'active'),
(68, 524, 10, NULL, NULL, NULL, NULL, 'active'),
(69, 525, 10, NULL, NULL, NULL, NULL, 'active'),
(70, 526, 10, NULL, NULL, NULL, NULL, 'active'),
(71, 527, 10, NULL, NULL, NULL, NULL, 'active'),
(72, 528, 10, NULL, NULL, NULL, NULL, 'active'),
(73, 529, 10, NULL, NULL, NULL, NULL, 'active'),
(74, 530, 10, NULL, NULL, NULL, NULL, 'active'),
(75, 531, 10, NULL, NULL, NULL, NULL, 'active'),
(76, 532, 10, NULL, NULL, NULL, NULL, 'active'),
(77, 533, 10, NULL, NULL, NULL, NULL, 'active'),
(78, 534, 10, NULL, NULL, NULL, NULL, 'active'),
(79, 535, 10, NULL, NULL, NULL, NULL, 'active'),
(80, 536, 10, NULL, NULL, NULL, NULL, 'active'),
(81, 537, 10, NULL, NULL, NULL, NULL, 'active'),
(82, 538, 10, NULL, NULL, NULL, NULL, 'active'),
(83, 539, 10, NULL, NULL, NULL, NULL, 'active'),
(84, 540, 10, NULL, NULL, NULL, NULL, 'active'),
(85, 541, 10, NULL, NULL, NULL, NULL, 'active'),
(86, 542, 10, NULL, NULL, NULL, NULL, 'active'),
(87, 543, 10, NULL, NULL, NULL, NULL, 'active'),
(88, 544, 10, NULL, NULL, NULL, NULL, 'active'),
(89, 545, 10, NULL, NULL, NULL, NULL, 'active'),
(90, 546, 10, NULL, NULL, NULL, NULL, 'active'),
(91, 547, 10, NULL, NULL, NULL, NULL, 'active'),
(92, 548, 10, NULL, NULL, NULL, NULL, 'active'),
(93, 549, 10, NULL, NULL, NULL, NULL, 'active'),
(94, 550, 10, NULL, NULL, NULL, NULL, 'active'),
(95, 551, 10, NULL, NULL, NULL, NULL, 'active'),
(96, 552, 10, NULL, NULL, NULL, NULL, 'active'),
(97, 553, 10, NULL, NULL, NULL, NULL, 'active'),
(98, 554, 10, NULL, NULL, NULL, NULL, 'active'),
(99, 555, 10, NULL, NULL, NULL, NULL, 'active'),
(100, 556, 10, NULL, NULL, NULL, NULL, 'active'),
(101, 557, 10, NULL, NULL, NULL, NULL, 'active'),
(102, 558, 10, NULL, NULL, NULL, NULL, 'active'),
(103, 559, 10, NULL, NULL, NULL, NULL, 'active'),
(104, 560, 10, NULL, NULL, NULL, NULL, 'active'),
(105, 561, 10, NULL, NULL, NULL, NULL, 'active'),
(106, 562, 10, NULL, NULL, NULL, NULL, 'active'),
(107, 563, 10, NULL, NULL, NULL, NULL, 'active'),
(108, 564, 10, NULL, NULL, NULL, NULL, 'active'),
(109, 565, 10, NULL, NULL, NULL, NULL, 'active'),
(110, 566, 10, NULL, NULL, NULL, NULL, 'active'),
(111, 567, 10, NULL, NULL, NULL, NULL, 'active'),
(112, 568, 10, NULL, NULL, NULL, NULL, 'active'),
(113, 569, 4, NULL, NULL, NULL, NULL, 'active'),
(114, 453, 8, NULL, NULL, NULL, NULL, 'active'),
(115, 453, 8, NULL, NULL, NULL, NULL, 'active'),
(116, 452, 8, NULL, NULL, NULL, NULL, 'active'),
(117, 452, 8, NULL, NULL, NULL, NULL, 'active'),
(118, 451, 8, NULL, NULL, NULL, NULL, 'active'),
(119, 451, 8, NULL, NULL, NULL, NULL, 'active'),
(120, 450, 8, NULL, NULL, NULL, NULL, 'active'),
(121, 450, 8, NULL, NULL, NULL, NULL, 'active'),
(122, 449, 8, NULL, NULL, NULL, NULL, 'active'),
(123, 449, 8, NULL, NULL, NULL, NULL, 'active'),
(124, 448, 8, NULL, NULL, NULL, NULL, 'active'),
(125, 448, 8, NULL, NULL, NULL, NULL, 'active'),
(126, 447, 8, NULL, NULL, NULL, NULL, 'active'),
(127, 446, 8, NULL, NULL, NULL, NULL, 'active'),
(128, 445, 8, NULL, NULL, NULL, NULL, 'active'),
(129, 444, 8, NULL, NULL, NULL, NULL, 'active'),
(130, 2, 9, NULL, NULL, NULL, NULL, 'active'),
(131, 33, 11, NULL, NULL, NULL, NULL, 'active'),
(132, 32, 11, NULL, NULL, NULL, NULL, 'active'),
(133, 31, 11, NULL, NULL, NULL, NULL, 'active'),
(134, 30, 11, NULL, NULL, NULL, NULL, 'active'),
(135, 29, 11, NULL, NULL, NULL, NULL, 'active'),
(136, 28, 11, NULL, NULL, NULL, NULL, 'active'),
(137, 27, 11, NULL, NULL, NULL, NULL, 'active'),
(138, 26, 11, NULL, NULL, NULL, NULL, 'active'),
(139, 25, 11, NULL, NULL, NULL, NULL, 'active'),
(140, 24, 11, NULL, NULL, NULL, NULL, 'active'),
(141, 43, 11, NULL, NULL, NULL, NULL, 'active'),
(142, 42, 11, NULL, NULL, NULL, NULL, 'active'),
(143, 41, 11, NULL, NULL, NULL, NULL, 'active'),
(144, 33, 11, NULL, NULL, NULL, NULL, 'active'),
(145, 32, 11, NULL, NULL, NULL, NULL, 'active'),
(146, 31, 11, NULL, NULL, NULL, NULL, 'active'),
(147, 30, 11, NULL, NULL, NULL, NULL, 'active'),
(148, 29, 11, NULL, NULL, NULL, NULL, 'active'),
(149, 28, 11, NULL, NULL, NULL, NULL, 'active'),
(150, 27, 11, NULL, NULL, NULL, NULL, 'active'),
(151, 26, 11, NULL, NULL, NULL, NULL, 'active'),
(152, 25, 11, NULL, NULL, NULL, NULL, 'active'),
(153, 24, 11, NULL, NULL, NULL, NULL, 'active'),
(154, 43, 11, NULL, NULL, NULL, NULL, 'active'),
(155, 42, 11, NULL, NULL, NULL, NULL, 'active'),
(156, 41, 11, NULL, NULL, NULL, NULL, 'active'),
(157, 40, 11, NULL, NULL, NULL, NULL, 'active'),
(158, 39, 11, NULL, NULL, NULL, NULL, 'active'),
(159, 38, 11, NULL, NULL, NULL, NULL, 'active'),
(160, 37, 11, NULL, NULL, NULL, NULL, 'active'),
(161, 36, 11, NULL, NULL, NULL, NULL, 'active'),
(162, 34, 11, NULL, NULL, NULL, NULL, 'active'),
(163, 35, 11, NULL, NULL, NULL, NULL, 'active'),
(164, 40, 11, NULL, NULL, NULL, NULL, 'active'),
(165, 39, 11, NULL, NULL, NULL, NULL, 'active'),
(166, 38, 11, NULL, NULL, NULL, NULL, 'active'),
(167, 37, 11, NULL, NULL, NULL, NULL, 'active'),
(168, 36, 11, NULL, NULL, NULL, NULL, 'active'),
(169, 34, 11, NULL, NULL, NULL, NULL, 'active'),
(170, 35, 11, NULL, NULL, NULL, NULL, 'active'),
(171, 13, 11, NULL, NULL, NULL, NULL, 'active'),
(172, 12, 11, NULL, NULL, NULL, NULL, 'active'),
(173, 10, 11, NULL, NULL, NULL, NULL, 'active'),
(174, 9, 11, NULL, NULL, NULL, NULL, 'active'),
(175, 8, 11, NULL, NULL, NULL, NULL, 'active'),
(176, 7, 11, NULL, NULL, NULL, NULL, 'active'),
(177, 6, 11, NULL, NULL, NULL, NULL, 'active'),
(178, 5, 11, NULL, NULL, NULL, NULL, 'active'),
(179, 4, 11, NULL, NULL, NULL, NULL, 'active'),
(180, 3, 11, NULL, NULL, NULL, NULL, 'active'),
(181, 23, 11, NULL, NULL, NULL, NULL, 'active'),
(182, 22, 11, NULL, NULL, NULL, NULL, 'active'),
(183, 21, 11, NULL, NULL, NULL, NULL, 'active'),
(184, 20, 11, NULL, NULL, NULL, NULL, 'active'),
(185, 19, 11, NULL, NULL, NULL, NULL, 'active'),
(186, 18, 11, NULL, NULL, NULL, NULL, 'active'),
(187, 17, 11, NULL, NULL, NULL, NULL, 'active'),
(188, 16, 11, NULL, NULL, NULL, NULL, 'active'),
(189, 15, 11, NULL, NULL, NULL, NULL, 'active'),
(190, 14, 11, NULL, NULL, NULL, NULL, 'active'),
(191, 11, 11, NULL, NULL, NULL, NULL, 'active'),
(192, 44, 11, NULL, NULL, NULL, NULL, 'active'),
(193, 45, 11, NULL, NULL, NULL, NULL, 'active'),
(194, 46, 11, NULL, NULL, NULL, NULL, 'active'),
(195, 47, 2, NULL, NULL, NULL, NULL, 'active'),
(196, 48, 2, NULL, NULL, NULL, NULL, 'active'),
(197, 49, 2, NULL, NULL, NULL, NULL, 'active'),
(198, 50, 2, NULL, NULL, NULL, NULL, 'active'),
(199, 51, 2, NULL, NULL, NULL, NULL, 'active'),
(200, 52, 2, NULL, NULL, NULL, NULL, 'active'),
(201, 53, 2, NULL, NULL, NULL, NULL, 'active'),
(202, 54, 2, NULL, NULL, NULL, NULL, 'active'),
(203, 55, 2, NULL, NULL, NULL, NULL, 'active'),
(204, 56, 2, NULL, NULL, NULL, NULL, 'active'),
(205, 57, 2, NULL, NULL, NULL, NULL, 'active'),
(206, 58, 2, NULL, NULL, NULL, NULL, 'active'),
(207, 59, 2, NULL, NULL, NULL, NULL, 'active'),
(208, 60, 2, NULL, NULL, NULL, NULL, 'active'),
(209, 61, 2, NULL, NULL, NULL, NULL, 'active'),
(210, 62, 2, NULL, NULL, NULL, NULL, 'active'),
(211, 63, 2, NULL, NULL, NULL, NULL, 'active'),
(212, 64, 2, NULL, NULL, NULL, NULL, 'active'),
(213, 65, 2, NULL, NULL, NULL, NULL, 'active'),
(214, 66, 2, NULL, NULL, NULL, NULL, 'active'),
(215, 67, 2, NULL, NULL, NULL, NULL, 'active'),
(216, 68, 2, NULL, NULL, NULL, NULL, 'active'),
(217, 69, 2, NULL, NULL, NULL, NULL, 'active'),
(218, 70, 3, NULL, NULL, NULL, NULL, 'active'),
(219, 71, 3, NULL, NULL, NULL, NULL, 'active'),
(220, 72, 3, NULL, NULL, NULL, NULL, 'active'),
(221, 73, 3, NULL, NULL, NULL, NULL, 'active'),
(222, 74, 3, NULL, NULL, NULL, NULL, 'active'),
(223, 75, 3, NULL, NULL, NULL, NULL, 'active'),
(224, 76, 3, NULL, NULL, NULL, NULL, 'active'),
(225, 77, 3, NULL, NULL, NULL, NULL, 'active'),
(226, 78, 3, NULL, NULL, NULL, NULL, 'active'),
(227, 79, 3, NULL, NULL, NULL, NULL, 'active'),
(228, 80, 3, NULL, NULL, NULL, NULL, 'active'),
(229, 81, 3, NULL, NULL, NULL, NULL, 'active'),
(230, 82, 3, NULL, NULL, NULL, NULL, 'active'),
(231, 83, 3, NULL, NULL, NULL, NULL, 'active'),
(232, 84, 3, NULL, NULL, NULL, NULL, 'active'),
(233, 85, 3, NULL, NULL, NULL, NULL, 'active'),
(234, 86, 3, NULL, NULL, NULL, NULL, 'active'),
(235, 87, 3, NULL, NULL, NULL, NULL, 'active'),
(236, 88, 3, NULL, NULL, NULL, NULL, 'active'),
(237, 89, 3, NULL, NULL, NULL, NULL, 'active'),
(238, 90, 3, NULL, NULL, NULL, NULL, 'active'),
(239, 91, 3, NULL, NULL, NULL, NULL, 'active'),
(240, 92, 3, NULL, NULL, NULL, NULL, 'active'),
(241, 93, 4, NULL, NULL, NULL, NULL, 'active'),
(242, 94, 4, NULL, NULL, NULL, NULL, 'active'),
(243, 95, 4, NULL, NULL, NULL, NULL, 'active'),
(244, 96, 4, NULL, NULL, NULL, NULL, 'active'),
(245, 97, 4, NULL, NULL, NULL, NULL, 'active'),
(246, 98, 4, NULL, NULL, NULL, NULL, 'active'),
(247, 99, 4, NULL, NULL, NULL, NULL, 'active'),
(248, 100, 4, NULL, NULL, NULL, NULL, 'active'),
(249, 101, 4, NULL, NULL, NULL, NULL, 'active'),
(250, 102, 4, NULL, NULL, NULL, NULL, 'active'),
(251, 103, 4, NULL, NULL, NULL, NULL, 'active'),
(252, 104, 4, NULL, NULL, NULL, NULL, 'active'),
(253, 105, 4, NULL, NULL, NULL, NULL, 'active'),
(254, 106, 4, NULL, NULL, NULL, NULL, 'active'),
(255, 107, 4, NULL, NULL, NULL, NULL, 'active'),
(256, 108, 4, NULL, NULL, NULL, NULL, 'active'),
(257, 109, 4, NULL, NULL, NULL, NULL, 'active'),
(258, 110, 4, NULL, NULL, NULL, NULL, 'active'),
(259, 111, 4, NULL, NULL, NULL, NULL, 'active'),
(260, 112, 4, NULL, NULL, NULL, NULL, 'active'),
(261, 113, 4, NULL, NULL, NULL, NULL, 'active'),
(262, 114, 4, NULL, NULL, NULL, NULL, 'active'),
(263, 115, 4, NULL, NULL, NULL, NULL, 'active'),
(264, 116, 4, NULL, NULL, NULL, NULL, 'active'),
(265, 117, 4, NULL, NULL, NULL, NULL, 'active'),
(266, 118, 4, NULL, NULL, NULL, NULL, 'active'),
(267, 119, 4, NULL, NULL, NULL, NULL, 'active'),
(268, 120, 4, NULL, NULL, NULL, NULL, 'active'),
(269, 121, 4, NULL, NULL, NULL, NULL, 'active'),
(270, 122, 4, NULL, NULL, NULL, NULL, 'active'),
(271, 123, 4, NULL, NULL, NULL, NULL, 'active'),
(272, 124, 4, NULL, NULL, NULL, NULL, 'active'),
(273, 125, 4, NULL, NULL, NULL, NULL, 'active'),
(274, 126, 4, NULL, NULL, NULL, NULL, 'active'),
(275, 127, 13, NULL, NULL, NULL, NULL, 'active'),
(276, 128, 13, NULL, NULL, NULL, NULL, 'active'),
(277, 129, 13, NULL, NULL, NULL, NULL, 'active'),
(278, 130, 13, NULL, NULL, NULL, NULL, 'active'),
(279, 131, 13, NULL, NULL, NULL, NULL, 'active'),
(280, 132, 13, NULL, NULL, NULL, NULL, 'active'),
(281, 133, 13, NULL, NULL, NULL, NULL, 'active'),
(282, 134, 13, NULL, NULL, NULL, NULL, 'active'),
(283, 135, 13, NULL, NULL, NULL, NULL, 'active'),
(284, 136, 13, NULL, NULL, NULL, NULL, 'active'),
(285, 137, 13, NULL, NULL, NULL, NULL, 'active'),
(286, 138, 13, NULL, NULL, NULL, NULL, 'active'),
(287, 139, 13, NULL, NULL, NULL, NULL, 'active'),
(288, 140, 13, NULL, NULL, NULL, NULL, 'active'),
(289, 141, 13, NULL, NULL, NULL, NULL, 'active'),
(290, 142, 13, NULL, NULL, NULL, NULL, 'active'),
(291, 143, 13, NULL, NULL, NULL, NULL, 'active'),
(292, 144, 13, NULL, NULL, NULL, NULL, 'active'),
(293, 145, 13, NULL, NULL, NULL, NULL, 'active'),
(294, 146, 13, NULL, NULL, NULL, NULL, 'active'),
(295, 147, 13, NULL, NULL, NULL, NULL, 'active'),
(296, 148, 13, NULL, NULL, NULL, NULL, 'active'),
(297, 149, 13, NULL, NULL, NULL, NULL, 'active'),
(298, 150, 13, NULL, NULL, NULL, NULL, 'active'),
(299, 151, 13, NULL, NULL, NULL, NULL, 'active'),
(300, 152, 13, NULL, NULL, NULL, NULL, 'active'),
(301, 153, 13, NULL, NULL, NULL, NULL, 'active'),
(302, 154, 13, NULL, NULL, NULL, NULL, 'active'),
(303, 155, 13, NULL, NULL, NULL, NULL, 'active'),
(304, 156, 13, NULL, NULL, NULL, NULL, 'active'),
(305, 157, 13, NULL, NULL, NULL, NULL, 'active'),
(306, 158, 13, NULL, NULL, NULL, NULL, 'active'),
(307, 159, 13, NULL, NULL, NULL, NULL, 'active'),
(308, 160, 13, NULL, NULL, NULL, NULL, 'active'),
(309, 161, 13, NULL, NULL, NULL, NULL, 'active'),
(310, 162, 13, NULL, NULL, NULL, NULL, 'active'),
(311, 163, 13, NULL, NULL, NULL, NULL, 'active'),
(312, 164, 13, NULL, NULL, NULL, NULL, 'active'),
(313, 165, 13, NULL, NULL, NULL, NULL, 'active'),
(314, 166, 13, NULL, NULL, NULL, NULL, 'active'),
(315, 167, 13, NULL, NULL, NULL, NULL, 'active'),
(316, 168, 13, NULL, NULL, NULL, NULL, 'active'),
(317, 169, 13, NULL, NULL, NULL, NULL, 'active'),
(318, 170, 13, NULL, NULL, NULL, NULL, 'active'),
(319, 171, 13, NULL, NULL, NULL, NULL, 'active'),
(320, 172, 13, NULL, NULL, NULL, NULL, 'active'),
(321, 173, 13, NULL, NULL, NULL, NULL, 'active'),
(322, 174, 13, NULL, NULL, NULL, NULL, 'active'),
(323, 175, 13, NULL, NULL, NULL, NULL, 'active'),
(324, 176, 13, NULL, NULL, NULL, NULL, 'active'),
(325, 177, 13, NULL, NULL, NULL, NULL, 'active'),
(326, 178, 13, NULL, NULL, NULL, NULL, 'active'),
(327, 179, 13, NULL, NULL, NULL, NULL, 'active'),
(328, 180, 13, NULL, NULL, NULL, NULL, 'active'),
(329, 181, 13, NULL, NULL, NULL, NULL, 'active'),
(330, 182, 13, NULL, NULL, NULL, NULL, 'active'),
(331, 183, 13, NULL, NULL, NULL, NULL, 'active'),
(332, 570, NULL, 13, NULL, NULL, NULL, 'active'),
(333, 185, 13, NULL, NULL, NULL, NULL, 'active'),
(334, 184, 13, NULL, NULL, NULL, NULL, 'active'),
(335, 186, 13, NULL, NULL, NULL, NULL, 'active'),
(336, 187, 13, NULL, NULL, NULL, NULL, 'active'),
(337, 188, 13, NULL, NULL, NULL, NULL, 'active'),
(338, 189, 13, NULL, NULL, NULL, NULL, 'active'),
(339, 190, 13, NULL, NULL, NULL, NULL, 'active'),
(340, 191, 13, NULL, NULL, NULL, NULL, 'active'),
(341, 192, 13, NULL, NULL, NULL, NULL, 'active'),
(342, 193, 13, NULL, NULL, NULL, NULL, 'active'),
(343, 194, 13, NULL, NULL, NULL, NULL, 'active'),
(344, 195, 13, NULL, NULL, NULL, NULL, 'active'),
(345, 196, 13, NULL, NULL, NULL, NULL, 'active'),
(346, 197, 13, NULL, NULL, NULL, NULL, 'active'),
(347, 198, 13, NULL, NULL, NULL, NULL, 'active'),
(348, 199, 13, NULL, NULL, NULL, NULL, 'active'),
(349, 200, 13, NULL, NULL, NULL, NULL, 'active'),
(350, 201, 13, NULL, NULL, NULL, NULL, 'active'),
(351, 202, 13, NULL, NULL, NULL, NULL, 'active'),
(352, 203, 13, NULL, NULL, NULL, NULL, 'active'),
(353, 204, 13, NULL, NULL, NULL, NULL, 'active'),
(354, 205, 13, NULL, NULL, NULL, NULL, 'active'),
(355, 206, 13, NULL, NULL, NULL, NULL, 'active'),
(356, 207, 13, NULL, NULL, NULL, NULL, 'active'),
(357, 208, 13, NULL, NULL, NULL, NULL, 'active'),
(358, 209, 13, NULL, NULL, NULL, NULL, 'active'),
(359, 210, 13, NULL, NULL, NULL, NULL, 'active'),
(360, 211, 13, NULL, NULL, NULL, NULL, 'active'),
(361, 212, 13, NULL, NULL, NULL, NULL, 'active'),
(362, 213, 13, NULL, NULL, NULL, NULL, 'active'),
(363, 214, 13, NULL, NULL, NULL, NULL, 'active'),
(364, 215, 13, NULL, NULL, NULL, NULL, 'active'),
(365, 216, 13, NULL, NULL, NULL, NULL, 'active'),
(366, 217, 13, NULL, NULL, NULL, NULL, 'active'),
(367, 218, 13, NULL, NULL, NULL, NULL, 'active'),
(368, 219, 13, NULL, NULL, NULL, NULL, 'active'),
(369, 220, 13, NULL, NULL, NULL, NULL, 'active'),
(370, 221, 5, NULL, NULL, NULL, NULL, 'active'),
(371, 222, 5, NULL, NULL, NULL, NULL, 'active'),
(372, 223, 5, NULL, NULL, NULL, NULL, 'active'),
(373, 224, 5, NULL, NULL, NULL, NULL, 'active'),
(374, 225, 5, NULL, NULL, NULL, NULL, 'active'),
(375, 226, 5, NULL, NULL, NULL, NULL, 'active'),
(376, 227, 5, NULL, NULL, NULL, NULL, 'active'),
(377, 228, 5, NULL, NULL, NULL, NULL, 'active'),
(378, 229, 5, NULL, NULL, NULL, NULL, 'active'),
(379, 230, 5, NULL, NULL, NULL, NULL, 'active'),
(380, 231, 5, NULL, NULL, NULL, NULL, 'active'),
(381, 232, 5, NULL, NULL, NULL, NULL, 'active'),
(382, 233, 5, NULL, NULL, NULL, NULL, 'active'),
(383, 234, 5, NULL, NULL, NULL, NULL, 'active'),
(384, 235, 5, NULL, NULL, NULL, NULL, 'active'),
(385, 236, 5, NULL, NULL, NULL, NULL, 'active'),
(386, 237, 5, NULL, NULL, NULL, NULL, 'active'),
(387, 238, 5, NULL, NULL, NULL, NULL, 'active'),
(388, 239, 5, NULL, NULL, NULL, NULL, 'active'),
(389, 240, 5, NULL, NULL, NULL, NULL, 'active'),
(390, 241, 5, NULL, NULL, NULL, NULL, 'active'),
(391, 242, 5, NULL, NULL, NULL, NULL, 'active'),
(392, 243, 5, NULL, NULL, NULL, NULL, 'active'),
(393, 244, 5, NULL, NULL, NULL, NULL, 'active'),
(394, 245, 5, NULL, NULL, NULL, NULL, 'active'),
(395, 246, 5, NULL, NULL, NULL, NULL, 'active'),
(396, 247, 5, NULL, NULL, NULL, NULL, 'active'),
(397, 248, 5, NULL, NULL, NULL, NULL, 'active'),
(398, 249, 5, NULL, NULL, NULL, NULL, 'active'),
(399, 250, 5, NULL, NULL, NULL, NULL, 'active'),
(400, 251, 5, NULL, NULL, NULL, NULL, 'active'),
(401, 252, 5, NULL, NULL, NULL, NULL, 'active'),
(402, 253, 5, NULL, NULL, NULL, NULL, 'active'),
(403, 254, 5, NULL, NULL, NULL, NULL, 'active'),
(404, 255, 5, NULL, NULL, NULL, NULL, 'active'),
(405, 256, 5, NULL, NULL, NULL, NULL, 'active'),
(406, 257, 5, NULL, NULL, NULL, NULL, 'active'),
(407, 258, 5, NULL, NULL, NULL, NULL, 'active'),
(408, 259, 5, NULL, NULL, NULL, NULL, 'active'),
(409, 260, 5, NULL, NULL, NULL, NULL, 'active'),
(410, 261, 5, NULL, NULL, NULL, NULL, 'active'),
(411, 262, 5, NULL, NULL, NULL, NULL, 'active'),
(412, 263, 5, NULL, NULL, NULL, NULL, 'active'),
(413, 264, 5, NULL, NULL, NULL, NULL, 'active'),
(414, 265, 5, NULL, NULL, NULL, NULL, 'active'),
(415, 266, 5, NULL, NULL, NULL, NULL, 'active'),
(416, 267, 5, NULL, NULL, NULL, NULL, 'active'),
(417, 268, 5, NULL, NULL, NULL, NULL, 'active'),
(418, 269, 5, NULL, NULL, NULL, NULL, 'active'),
(419, 270, 5, NULL, NULL, NULL, NULL, 'active'),
(420, 271, 5, NULL, NULL, NULL, NULL, 'active'),
(421, 272, 6, NULL, NULL, NULL, NULL, 'active'),
(422, 273, 6, NULL, NULL, NULL, NULL, 'active'),
(423, 274, 6, NULL, NULL, NULL, NULL, 'active'),
(424, 570, 13, NULL, NULL, NULL, NULL, 'active'),
(425, 571, NULL, 13, NULL, NULL, NULL, 'active'),
(426, 571, 13, NULL, NULL, NULL, NULL, 'active'),
(427, 276, 6, NULL, NULL, NULL, NULL, 'active'),
(428, 277, 6, NULL, NULL, NULL, NULL, 'active'),
(429, 278, 6, NULL, NULL, NULL, NULL, 'active'),
(430, 279, 6, NULL, NULL, NULL, NULL, 'active'),
(431, 280, 6, NULL, NULL, NULL, NULL, 'active'),
(432, 281, 6, NULL, NULL, NULL, NULL, 'active'),
(433, 282, 6, NULL, NULL, NULL, NULL, 'active'),
(434, 283, 6, NULL, NULL, NULL, NULL, 'active'),
(435, 284, 6, NULL, NULL, NULL, NULL, 'active'),
(436, 285, 6, NULL, NULL, NULL, NULL, 'active'),
(437, 286, 6, NULL, NULL, NULL, NULL, 'active'),
(438, 287, 6, NULL, NULL, NULL, NULL, 'active'),
(439, 288, 6, NULL, NULL, NULL, NULL, 'active'),
(440, 289, 6, NULL, NULL, NULL, NULL, 'active'),
(441, 290, 6, NULL, NULL, NULL, NULL, 'active'),
(442, 291, 6, NULL, NULL, NULL, NULL, 'active'),
(443, 292, 6, NULL, NULL, NULL, NULL, 'active'),
(444, 293, 6, NULL, NULL, NULL, NULL, 'active'),
(445, 294, 6, NULL, NULL, NULL, NULL, 'active'),
(446, 295, 6, NULL, NULL, NULL, NULL, 'active'),
(447, 296, 6, NULL, NULL, NULL, NULL, 'active'),
(448, 297, 6, NULL, NULL, NULL, NULL, 'active'),
(449, 299, 6, NULL, NULL, NULL, NULL, 'active'),
(450, 298, 6, NULL, NULL, NULL, NULL, 'active'),
(451, 300, 6, NULL, NULL, NULL, NULL, 'active'),
(452, 301, 6, NULL, NULL, NULL, NULL, 'active'),
(453, 302, 6, NULL, NULL, NULL, NULL, 'active'),
(454, 303, 6, NULL, NULL, NULL, NULL, 'active'),
(455, 304, 6, NULL, NULL, NULL, NULL, 'active'),
(456, 305, 6, NULL, NULL, NULL, NULL, 'active'),
(457, 306, 6, NULL, NULL, NULL, NULL, 'active'),
(458, 307, 6, NULL, NULL, NULL, NULL, 'active'),
(459, 308, 6, NULL, NULL, NULL, NULL, 'active'),
(460, 309, 6, NULL, NULL, NULL, NULL, 'active'),
(461, 310, 6, NULL, NULL, NULL, NULL, 'active'),
(462, 311, 6, NULL, NULL, NULL, NULL, 'active'),
(463, 312, 6, NULL, NULL, NULL, NULL, 'active'),
(464, 313, 6, NULL, NULL, NULL, NULL, 'active'),
(465, 314, 6, NULL, NULL, NULL, NULL, 'active'),
(466, 315, 6, NULL, NULL, NULL, NULL, 'active'),
(467, 316, 6, NULL, NULL, NULL, NULL, 'active'),
(468, 317, 6, NULL, NULL, NULL, NULL, 'active'),
(469, 318, 6, NULL, NULL, NULL, NULL, 'active'),
(470, 319, 6, NULL, NULL, NULL, NULL, 'active'),
(471, 320, 6, NULL, NULL, NULL, NULL, 'active'),
(472, 321, 6, NULL, NULL, NULL, NULL, 'active'),
(473, 322, 6, NULL, NULL, NULL, NULL, 'active'),
(474, 323, 6, NULL, NULL, NULL, NULL, 'active'),
(475, 324, 6, NULL, NULL, NULL, NULL, 'active'),
(476, 325, 6, NULL, NULL, NULL, NULL, 'active'),
(477, 572, 6, NULL, NULL, NULL, NULL, 'active'),
(478, 573, 13, 4, NULL, NULL, NULL, 'active'),
(479, 326, 6, NULL, NULL, NULL, NULL, 'active'),
(480, 327, 6, NULL, NULL, NULL, NULL, 'active'),
(481, 328, 6, NULL, NULL, NULL, NULL, 'active'),
(482, 329, 6, NULL, NULL, NULL, NULL, 'active'),
(483, 330, 6, NULL, NULL, NULL, NULL, 'active'),
(484, 331, 6, NULL, NULL, NULL, NULL, 'active'),
(485, 332, 6, NULL, NULL, NULL, NULL, 'active'),
(486, 333, 6, NULL, NULL, NULL, NULL, 'active'),
(487, 334, 6, NULL, NULL, NULL, NULL, 'active'),
(488, 335, 7, NULL, NULL, NULL, NULL, 'active'),
(489, 336, 7, NULL, NULL, NULL, NULL, 'active'),
(490, 337, 7, NULL, NULL, NULL, NULL, 'active'),
(491, 338, 7, NULL, NULL, NULL, NULL, 'active'),
(492, 339, 7, NULL, NULL, NULL, NULL, 'active'),
(493, 340, 7, NULL, NULL, NULL, NULL, 'active'),
(494, 341, 7, NULL, NULL, NULL, NULL, 'active'),
(495, 342, 7, NULL, NULL, NULL, NULL, 'active'),
(496, 343, 7, NULL, NULL, NULL, NULL, 'active'),
(497, 344, 7, NULL, NULL, NULL, NULL, 'active'),
(498, 345, 7, NULL, NULL, NULL, NULL, 'active'),
(499, 346, 7, NULL, NULL, NULL, NULL, 'active'),
(500, 347, 7, NULL, NULL, NULL, NULL, 'active'),
(501, 348, 7, NULL, NULL, NULL, NULL, 'active'),
(502, 349, 7, NULL, NULL, NULL, NULL, 'active'),
(503, 350, 7, NULL, NULL, NULL, NULL, 'active'),
(504, 351, 7, NULL, NULL, NULL, NULL, 'active'),
(505, 352, 7, NULL, NULL, NULL, NULL, 'active'),
(506, 353, 7, NULL, NULL, NULL, NULL, 'active'),
(507, 354, 7, NULL, NULL, NULL, NULL, 'active'),
(508, 355, 7, NULL, NULL, NULL, NULL, 'active'),
(509, 356, 7, NULL, NULL, NULL, NULL, 'active'),
(510, 357, 7, NULL, NULL, NULL, NULL, 'active'),
(511, 358, 7, NULL, NULL, NULL, NULL, 'active'),
(512, 359, 7, NULL, NULL, NULL, NULL, 'active'),
(513, 360, 7, NULL, NULL, NULL, NULL, 'active'),
(514, 361, 7, NULL, NULL, NULL, NULL, 'active'),
(515, 362, 7, NULL, NULL, NULL, NULL, 'active'),
(516, 363, 7, NULL, NULL, NULL, NULL, 'active'),
(517, 364, 7, NULL, NULL, NULL, NULL, 'active'),
(518, 365, 7, NULL, NULL, NULL, NULL, 'active'),
(519, 375, 7, NULL, NULL, NULL, NULL, 'active'),
(520, 374, 7, NULL, NULL, NULL, NULL, 'active'),
(521, 373, 7, NULL, NULL, NULL, NULL, 'active'),
(522, 372, 7, NULL, NULL, NULL, NULL, 'active'),
(523, 371, 7, NULL, NULL, NULL, NULL, 'active'),
(524, 370, 7, NULL, NULL, NULL, NULL, 'active'),
(525, 369, 7, NULL, NULL, NULL, NULL, 'active'),
(526, 368, 7, NULL, NULL, NULL, NULL, 'active'),
(527, 367, 7, NULL, NULL, NULL, NULL, 'active'),
(528, 366, 7, NULL, NULL, NULL, NULL, 'active'),
(529, 376, 7, NULL, NULL, NULL, NULL, 'active'),
(530, 377, 7, NULL, NULL, NULL, NULL, 'active'),
(531, 378, 7, NULL, NULL, NULL, NULL, 'active'),
(532, 379, 7, NULL, NULL, NULL, NULL, 'active'),
(533, 380, 7, NULL, NULL, NULL, NULL, 'active'),
(534, 381, 7, NULL, NULL, NULL, NULL, 'active'),
(535, 382, 7, NULL, NULL, NULL, NULL, 'active'),
(536, 383, 7, NULL, NULL, NULL, NULL, 'active'),
(537, 384, 7, NULL, NULL, NULL, NULL, 'active'),
(538, 385, 7, NULL, NULL, NULL, NULL, 'active'),
(539, 574, 7, NULL, NULL, NULL, NULL, 'active'),
(540, 386, 7, NULL, NULL, NULL, NULL, 'active'),
(541, 387, 7, NULL, NULL, NULL, NULL, 'active'),
(542, 388, 7, NULL, NULL, NULL, NULL, 'active'),
(543, 389, 7, NULL, NULL, NULL, NULL, 'active'),
(544, 390, 7, NULL, NULL, NULL, NULL, 'active'),
(545, 391, 7, NULL, NULL, NULL, NULL, 'active'),
(546, 392, 8, NULL, NULL, NULL, NULL, 'active'),
(547, 393, 8, NULL, NULL, NULL, NULL, 'active'),
(548, 394, 8, NULL, NULL, NULL, NULL, 'active'),
(549, 395, 8, NULL, NULL, NULL, NULL, 'active'),
(550, 396, 8, NULL, NULL, NULL, NULL, 'active'),
(551, 397, 8, NULL, NULL, NULL, NULL, 'active'),
(552, 398, 8, NULL, NULL, NULL, NULL, 'active'),
(553, 399, 8, NULL, NULL, NULL, NULL, 'active'),
(554, 400, 8, NULL, NULL, NULL, NULL, 'active'),
(555, 401, 8, NULL, NULL, NULL, NULL, 'active'),
(556, 402, 8, NULL, NULL, NULL, NULL, 'active'),
(557, 403, 8, NULL, NULL, NULL, NULL, 'active'),
(558, 404, 8, NULL, NULL, NULL, NULL, 'active'),
(559, 405, 8, NULL, NULL, NULL, NULL, 'active'),
(560, 406, 8, NULL, NULL, NULL, NULL, 'active'),
(561, 407, 8, NULL, NULL, NULL, NULL, 'active'),
(562, 408, 8, NULL, NULL, NULL, NULL, 'active'),
(563, 409, 8, NULL, NULL, NULL, NULL, 'active'),
(564, 410, 8, NULL, NULL, NULL, NULL, 'active'),
(565, 411, 8, NULL, NULL, NULL, NULL, 'active'),
(566, 412, 8, NULL, NULL, NULL, NULL, 'active'),
(567, 413, 8, NULL, NULL, NULL, NULL, 'active'),
(568, 414, 8, NULL, NULL, NULL, NULL, 'active'),
(569, 415, 8, NULL, NULL, NULL, NULL, 'active'),
(570, 416, 8, NULL, NULL, NULL, NULL, 'active'),
(571, 417, 8, NULL, NULL, NULL, NULL, 'active'),
(572, 418, 8, NULL, NULL, NULL, NULL, 'active'),
(573, 419, 8, NULL, NULL, NULL, NULL, 'active'),
(574, 420, 8, NULL, NULL, NULL, NULL, 'active'),
(575, 421, 8, NULL, NULL, NULL, NULL, 'active'),
(576, 422, 8, NULL, NULL, NULL, NULL, 'active'),
(577, 423, 8, NULL, NULL, NULL, NULL, 'active'),
(578, 424, 8, NULL, NULL, NULL, NULL, 'active'),
(579, 425, 8, NULL, NULL, NULL, NULL, 'active'),
(580, 426, 8, NULL, NULL, NULL, NULL, 'active'),
(581, 427, 8, NULL, NULL, NULL, NULL, 'active'),
(582, 428, 8, NULL, NULL, NULL, NULL, 'active'),
(583, 429, 8, NULL, NULL, NULL, NULL, 'active'),
(584, 430, 8, NULL, NULL, NULL, NULL, 'active'),
(585, 431, 8, NULL, NULL, NULL, NULL, 'active'),
(586, 432, 8, NULL, NULL, NULL, NULL, 'active'),
(587, 433, 8, NULL, NULL, NULL, NULL, 'active'),
(588, 434, 8, NULL, NULL, NULL, NULL, 'active'),
(589, 435, 8, NULL, NULL, NULL, NULL, 'active'),
(590, 436, 8, NULL, NULL, NULL, NULL, 'active'),
(591, 437, 8, NULL, NULL, NULL, NULL, 'active'),
(592, 438, 8, NULL, NULL, NULL, NULL, 'active'),
(593, 439, 8, NULL, NULL, NULL, NULL, 'active'),
(594, 440, 8, NULL, NULL, NULL, NULL, 'active'),
(595, 441, 8, NULL, NULL, NULL, NULL, 'active'),
(596, 442, 8, NULL, NULL, NULL, NULL, 'active'),
(597, 443, 8, NULL, NULL, NULL, NULL, 'active'),
(598, 575, 7, NULL, NULL, NULL, NULL, 'active'),
(599, 576, 8, NULL, NULL, NULL, NULL, 'active'),
(600, 577, 8, NULL, NULL, NULL, NULL, 'active'),
(601, 578, 4, NULL, NULL, NULL, NULL, 'active'),
(602, 578, 9, NULL, NULL, NULL, NULL, 'active'),
(603, 579, 9, NULL, NULL, NULL, NULL, 'active'),
(604, 580, 9, NULL, NULL, NULL, NULL, 'active'),
(605, 581, 9, NULL, NULL, NULL, NULL, 'active'),
(606, 582, 9, NULL, NULL, NULL, NULL, 'active'),
(607, 583, 9, NULL, NULL, NULL, NULL, 'active'),
(608, 584, 9, NULL, NULL, NULL, NULL, 'active'),
(609, 579, 9, NULL, NULL, NULL, NULL, 'active'),
(610, 580, 9, NULL, NULL, NULL, NULL, 'active'),
(611, 581, 9, NULL, NULL, NULL, NULL, 'active'),
(612, 582, 9, NULL, NULL, NULL, NULL, 'active'),
(613, 583, 9, NULL, NULL, NULL, NULL, 'active'),
(614, 584, 9, NULL, NULL, NULL, NULL, 'active'),
(615, 585, 13, NULL, NULL, NULL, NULL, 'active'),
(616, 585, 13, NULL, NULL, NULL, NULL, 'active'),
(617, 586, 2, NULL, NULL, NULL, NULL, 'active'),
(618, 587, 9, NULL, NULL, NULL, NULL, 'active'),
(619, 587, 9, NULL, NULL, NULL, NULL, 'active'),
(620, 588, 13, 13, NULL, NULL, NULL, 'active'),
(621, 589, 13, 13, NULL, NULL, NULL, 'active'),
(622, 590, 9, NULL, NULL, NULL, NULL, 'active'),
(624, 592, 8, NULL, NULL, NULL, NULL, 'active'),
(625, 593, 4, NULL, NULL, NULL, 1, 'active'),
(626, 594, 2, NULL, NULL, NULL, NULL, 'active'),
(627, 595, 8, NULL, NULL, NULL, NULL, 'active'),
(628, 596, 2, NULL, NULL, NULL, NULL, 'active'),
(629, 597, 2, NULL, NULL, NULL, NULL, 'active'),
(630, 598, 2, NULL, NULL, NULL, NULL, 'active'),
(631, 599, 2, NULL, NULL, NULL, NULL, 'active'),
(632, 600, 2, NULL, NULL, NULL, NULL, 'active'),
(633, 601, 6, NULL, NULL, NULL, NULL, 'active'),
(634, 602, 8, NULL, NULL, NULL, NULL, 'active'),
(636, 604, 10, NULL, NULL, NULL, NULL, 'active'),
(637, 605, 9, NULL, NULL, NULL, NULL, 'active'),
(638, 606, 9, NULL, NULL, NULL, NULL, 'active'),
(639, 607, 13, NULL, NULL, NULL, NULL, 'active'),
(640, 608, 13, NULL, NULL, NULL, NULL, 'active'),
(641, 609, 7, NULL, NULL, NULL, NULL, 'active'),
(642, 610, 7, NULL, NULL, NULL, NULL, 'active'),
(643, 611, 7, NULL, NULL, NULL, NULL, 'active'),
(644, 612, 6, NULL, NULL, NULL, NULL, 'active'),
(645, 613, 6, NULL, NULL, NULL, NULL, 'active'),
(646, 614, 6, NULL, NULL, NULL, NULL, 'active'),
(647, 615, 6, NULL, NULL, NULL, NULL, 'active'),
(648, 616, 6, NULL, NULL, NULL, NULL, 'active'),
(649, 617, 6, NULL, NULL, NULL, NULL, 'active'),
(650, 618, 6, NULL, NULL, NULL, NULL, 'active'),
(651, 619, 6, NULL, NULL, NULL, NULL, 'active'),
(652, 620, 6, NULL, NULL, NULL, NULL, 'active'),
(653, 621, 5, NULL, NULL, NULL, NULL, 'active'),
(654, 622, 5, NULL, NULL, NULL, NULL, 'active'),
(655, 623, 5, NULL, NULL, NULL, NULL, 'active'),
(656, 624, 5, NULL, NULL, NULL, NULL, 'active'),
(657, 625, 4, NULL, NULL, NULL, NULL, 'active'),
(658, 626, 4, NULL, NULL, NULL, NULL, 'active'),
(659, 627, 4, NULL, NULL, NULL, NULL, 'active'),
(660, 628, 2, NULL, NULL, NULL, NULL, 'active'),
(661, 629, 8, NULL, NULL, NULL, NULL, 'active'),
(662, 630, 8, NULL, NULL, NULL, NULL, 'active'),
(663, 631, 10, NULL, NULL, NULL, NULL, 'active'),
(664, 632, 10, NULL, NULL, NULL, NULL, 'active');

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
(2, 1, 'NAIRAH MUWAGA', 'MUHAMMAD', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_2_1758761591183_qo3w1r.jpg', '2025-08-18 07:11:19', '2025-09-25 00:53:11', NULL),
(3, 1, 'NANYANGE', 'YUSURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:47:12', NULL, NULL),
(4, 1, 'NAIGAGA', 'JALIA ', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:48:28', NULL, NULL),
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
(15, 1, 'ASIMWE', 'RAZAKA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:07:52', NULL, NULL),
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
(45, 1, 'MENYA', 'ABDUL-RAHIIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:34:44', NULL, NULL),
(46, 1, 'NABUTANDA', 'RANIA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:35:32', NULL, NULL),
(47, 1, 'NAMUWAYA', 'SHATURA', '', 'F', '0000-00-00', '', '', '', '', '2025-08-18 10:40:22', '2025-09-24 12:23:44', NULL),
(48, 1, 'NAKIRANDA', 'RAHUMA', '', 'F', '0000-00-00', '', '', '', '', '2025-08-18 09:27:59', '2025-09-24 12:23:25', NULL),
(49, 1, 'SHAMSHA  MUBIRU', 'YUSUF', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:28:56', NULL, NULL),
(50, 1, 'MUHSIN', 'ABDULLAH MUKUNGU', 'MUKUNGU', 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:30:13', NULL, NULL),
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
(66, 1, 'AALYAH', 'HAMZA', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_66_1758700914116_a9bloc.jpg', '2025-08-18 09:34:36', '2025-09-25 05:02:42', NULL),
(67, 1, 'HAMZA MUHAMMAD', 'MWASE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:36:31', NULL, NULL),
(68, 1, 'MUKISA', 'RASHIQ', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:37:12', NULL, NULL),
(69, 1, 'DUMBA', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:37:46', NULL, NULL),
(70, 1, 'MATENDE', 'SHURAIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_70_1761173901777_d31zc3.jpg', '2025-08-18 09:42:28', '2025-10-22 22:58:21', NULL),
(71, 1, 'KIBIRIGE', 'AKRAM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_71_1761173886966_g7mhi0.jpg', '2025-08-18 09:43:05', '2025-10-22 22:58:07', NULL),
(72, 1, 'NAMUWAYA', 'SUMAYA UMAR', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_72_1761173911628_yq4b52.jpg', '2025-08-18 09:44:23', '2025-10-22 22:58:31', NULL),
(73, 1, 'MUYIIMA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_73_1761173908294_jw8iew.jpg', '2025-08-18 09:45:53', '2025-10-22 22:58:28', NULL),
(74, 1, 'NAMUWAYA', 'SAUYA', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_74_1761173917389_btr5vd.jpg', '2025-08-18 09:46:32', '2025-10-22 22:58:37', NULL),
(75, 1, 'ISABIRYE', 'HUZAIR', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_75_1761173876558_l7010a.jpg', '2025-08-18 09:47:11', '2025-10-22 22:57:56', NULL),
(76, 1, 'MULINDA', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_76_1761173905178_8e9rhn.jpg', '2025-08-18 09:47:48', '2025-10-22 22:58:25', NULL),
(77, 1, 'MAGUMBA', 'AKIRAM JOWAD', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_77_1761173898513_8hrkvj.jpg', '2025-08-18 09:48:38', '2025-10-22 22:58:18', NULL),
(78, 1, 'BIDI', 'SAIDA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_78_1761173865172_1eardk.jpg', '2025-08-18 09:49:12', '2025-10-22 22:57:45', NULL),
(79, 1, 'ZIWA', 'RAUSHAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_79_1761173934217_nowpd3.jpg', '2025-08-18 09:49:53', '2025-10-22 22:58:54', NULL),
(80, 1, 'SSALI', 'RASHID MUBARAKA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 09:50:41', NULL, NULL),
(81, 1, 'DHAKABA', 'SHABAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_81_1761173869217_wt7t24.jpg', '2025-08-18 09:51:25', '2025-10-22 22:57:49', NULL),
(82, 1, 'KASADHA', 'HUSINA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_82_1761173879784_h5ijcr.jpg', '2025-08-18 09:52:08', '2025-10-22 22:57:59', NULL),
(83, 1, 'YAHAYA', 'ISA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_83_1761173930831_372goy.jpg', '2025-08-18 09:53:39', '2025-10-22 22:58:50', NULL),
(84, 1, 'KATENDE', 'YASIR', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_84_1761173883824_nbbyv3.jpg', '2025-08-18 09:54:11', '2025-10-22 22:58:03', NULL),
(85, 1, 'BAMWAGALE', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_85_1761173861707_jysisx.jpg', '2025-08-18 09:54:59', '2025-10-22 22:57:41', NULL),
(86, 1, 'SHURAIM', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_86_1761173923621_l2z34w.jpg', '2025-08-18 09:55:31', '2025-10-22 22:58:43', NULL),
(87, 1, 'LWANTALE', 'SHUMI', NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/students/person_87_1761173895651_tcxkip.jpg', '2025-08-18 09:56:11', '2025-10-22 22:58:15', NULL),
(88, 1, 'ABDUL-RAHMAN', 'RAMADHAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_88_1761173920269_grnpgw.jpg', '2025-08-18 09:56:54', '2025-10-22 22:58:40', NULL),
(89, 1, 'MUBARA', 'ABDUL-SWABUR', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_89_1761173927409_rh0y80.jpg', '2025-08-18 09:58:00', '2025-10-22 22:58:47', NULL),
(90, 1, 'KINTU', 'SAD JUNIOR', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_90_1761173892346_dighvo.jpg', '2025-08-18 09:58:36', '2025-10-22 22:58:12', NULL),
(91, 1, 'AYEBALE', 'ASHLYN', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_91_1761173858223_n6coa0.jpg', '2025-08-18 09:59:22', '2025-10-22 22:57:38', NULL),
(92, 1, 'MAYANJA', 'IDRIS', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_92_1761173872818_aczf7i.jpg', '2025-08-18 10:00:21', '2025-10-22 22:57:53', NULL),
(93, 1, 'NAMUJUZI H', 'TASNEEM', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_93_1761174376784_7rydtz.jpg', '2025-08-18 10:02:20', '2025-10-22 23:06:16', NULL),
(94, 1, 'KIRANDA', 'AZAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_94_1761174315805_xurxd8.jpg', '2025-08-18 10:03:02', '2025-10-22 23:05:15', NULL),
(95, 1, 'KAGOYA', 'RAHUMA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_95_1761174303695_emqjmv.jpg', '2025-08-18 10:03:49', '2025-10-22 23:05:03', NULL),
(96, 1, 'NAKAMANYA', 'LUKAYYAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_96_1761174335641_ym8o9f.jpg', '2025-08-18 10:04:49', '2025-10-22 23:05:35', NULL),
(97, 1, 'SHURAYM', 'ZAID', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_97_1761174367120_me62c2.jpg', '2025-08-18 10:05:36', '2025-10-22 23:06:07', NULL),
(98, 1, 'KAWUMA', 'SHATRAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_98_1761174312337_37jojg.jpg', '2025-08-18 10:06:20', '2025-10-22 23:05:12', NULL),
(99, 1, 'MAYANJA', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_99_1761174329249_6xoekr.jpg', '2025-08-18 10:07:19', '2025-10-22 23:05:29', NULL),
(100, 1, 'NANGOBI', 'HAMZAH', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_100_1761174354070_b7xwrb.jpg', '2025-08-18 10:07:56', '2025-10-22 23:05:54', NULL),
(101, 1, 'KUMUGONZA', 'KHADIJJA', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_101_1761174319770_xhm9vw.jpg', '2025-08-18 10:09:11', '2025-10-22 23:07:40', NULL),
(102, 1, 'SWALLAHUDIN', 'BUN UMAR MENYA', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_102_1761174370277_4nmyds.jpg', '2025-08-18 10:10:26', '2025-10-22 23:06:10', NULL),
(103, 1, 'UMAR', 'MENYA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:10:26', NULL, NULL),
(104, 1, 'NAMUGABO', 'HAIRAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:11', NULL, NULL),
(105, 1, 'MUGABO', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:15:50', NULL, NULL),
(106, 1, 'RAYAN', 'TAIKA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_106_1761174373490_iledjc.jpg', '2025-08-18 10:16:26', '2025-10-22 23:06:13', NULL),
(107, 1, 'KATABA', 'TASHIL', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_107_1761174307272_ubnsg3.jpg', '2025-08-18 10:17:19', '2025-10-22 23:05:07', NULL),
(108, 1, 'GULUME', 'HADAD', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_108_1761174292630_ex2rey.jpg', '2025-08-18 10:18:20', '2025-10-22 23:04:52', NULL),
(109, 1, 'BABIRYE', 'SHAUFA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_109_1761174280414_46cuwi.jpg', '2025-08-18 10:22:40', '2025-10-22 23:04:42', NULL),
(110, 1, 'NAKUEIRA', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_110_1761174300485_x01ou4.jpg', '2025-08-18 10:24:13', '2025-10-22 23:05:00', NULL),
(111, 1, 'KIBUTTO', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:25:27', NULL, NULL),
(112, 1, 'MUNUULO AFRAH', 'NANKYA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_112_1761174325983_v1t81s.jpg', '2025-08-18 10:26:19', '2025-10-22 23:05:26', NULL),
(113, 1, 'GASSEMBA', 'BASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:27:14', NULL, NULL),
(114, 1, 'SHAMIRAH', 'ABDALLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:28:01', NULL, NULL),
(115, 1, 'FAUZAN', 'KASAKYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:29:04', NULL, NULL),
(116, 1, 'NAMPALA', 'MUSA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_116_1761174341904_l5sw66.jpg', '2025-08-18 10:30:04', '2025-10-22 23:05:42', NULL),
(117, 1, 'NANJIYA', 'TAIBA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_117_1761174357071_i5g8je.jpg', '2025-08-18 10:30:40', '2025-10-22 23:05:57', NULL),
(118, 1, 'NDYEKU', 'RASHID', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_118_1761174363837_1jdpwo.jpg', '2025-08-18 10:31:35', '2025-10-22 23:06:03', NULL),
(119, 1, 'NAKISIGE', 'MWAJJUMA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_119_1761174338803_9spqix.jpg', '2025-08-18 10:32:34', '2025-10-22 23:05:38', NULL),
(120, 1, 'NAMUGAYA', 'SHAMIRAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_120_1761174347624_lr4bk3.jpg', '2025-08-18 10:33:27', '2025-10-22 23:05:47', NULL),
(121, 1, 'MAGUMBA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_121_1761174322658_59kj32.jpg', '2025-08-18 10:34:03', '2025-10-22 23:05:22', NULL),
(122, 1, 'UTHUMAN', 'BAASIL', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_122_1761174277368_m8k57t.jpg', '2025-08-18 10:34:39', '2025-10-22 23:08:14', NULL),
(123, 1, 'NAQIYYAH', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_123_1761174360521_kotld9.jpg', '2025-08-18 10:36:01', '2025-10-22 23:06:00', NULL),
(124, 1, 'MUZALE', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_124_1761174332591_iwprrt.jpg', '2025-08-18 10:36:44', '2025-10-22 23:05:32', NULL),
(125, 1, 'HIBATULAH', 'MUHAMMAD', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_125_1761174297410_w488r0.jpg', '2025-08-18 10:37:37', '2025-10-22 23:06:49', NULL),
(126, 1, 'GULOOBA', 'JAMAL', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_126_1761174289413_78g9c4.jpg', '2025-08-18 10:38:55', '2025-10-22 23:04:49', NULL),
(127, 1, 'NAFULA', 'PATIENCE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 10:39:30', NULL, NULL),
(128, 1, 'MAGOOLA', 'BASHIRI', '', 'male', '0000-00-00', '', '', 'IGANGA', '/uploads/students/person_128_1759292106066_rrxm75.jpg', '2025-08-18 10:42:23', '2025-10-01 04:15:06', NULL),
(129, 1, 'ZAHARA ABDALLAH', 'NAKIBUULE', '', 'female', '0000-00-00', '', '', 'KAMPALA', '/uploads/students/person_129_1759280739108_740p22.jpg', '2025-08-18 10:46:15', '2025-10-01 01:05:39', NULL),
(130, 1, 'ZAINAB ABDALLAH', 'NAMUGENYI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_130_1759280740503_tudwab.jpg', '2025-08-18 10:47:38', '2025-10-01 01:05:40', NULL),
(131, 1, 'JUMBA', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_131_1759288349290_nji1dc.jpg', '2025-08-18 10:48:22', '2025-10-01 03:12:29', NULL),
(132, 1, 'RAYAN', 'RAMADHAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_132_1759410296267_383dyr.jpg', '2025-08-18 10:49:08', '2025-10-02 13:04:56', NULL),
(133, 1, 'ARAFAT', 'KIGENYI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_133_1759782452301_1v9oy3.jpg', '2025-08-18 10:49:53', '2025-10-06 20:27:32', NULL),
(134, 1, 'RUKINDU', 'ASHIRAF MUSA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_134_1759292456479_apmq6r.jpg', '2025-08-18 10:50:40', '2025-10-01 04:20:56', NULL),
(135, 1, 'BUWEMBO', 'MUDATHIR', '', 'male', '0000-00-00', '', '', 'MUKONO', '/uploads/students/person_135_1759286223905_e383pk.jpg', '2025-08-18 10:52:10', '2025-10-01 02:37:03', NULL),
(136, 1, 'NSUBUGA', 'ABDUL-AZIZI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_136_1759292119528_mpvcne.jpg', '2025-08-18 10:53:02', '2025-10-01 04:15:19', NULL),
(137, 1, 'KASEKENDE', 'ABDUL-RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_137_1759299934364_rotd9j.jpg', '2025-08-18 10:54:40', '2025-10-01 06:25:34', NULL),
(138, 1, 'LUSWATA', 'MUHAMMAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_138_1759288368119_5ef2bn.jpg', '2025-08-18 10:55:58', '2025-10-01 03:12:48', NULL),
(139, 1, 'BWANIKA', 'RIDHIWANI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_139_1759286227008_x15x19.jpg', '2025-08-18 10:56:49', '2025-10-01 02:37:07', NULL),
(140, 1, 'ABUBAKAR', 'SWIDIQ', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_140_1759299947004_g0b09l.jpg', '2025-08-18 10:58:47', '2025-10-01 06:25:47', NULL),
(141, 1, 'KIRUNDA', 'ISMAEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_141_1759299936889_ig5aof.jpg', '2025-08-18 10:59:32', '2025-10-01 06:25:36', NULL),
(142, 1, 'NYANJA', 'NOORDEEN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_142_1759292539434_3u12se.jpg', '2025-08-18 11:00:24', '2025-10-01 04:22:19', NULL),
(143, 1, 'MUHAMMAD ALI', 'SSERUBOGO', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_143_1759292461915_07hgpw.jpg', '2025-08-18 11:01:29', '2025-10-01 04:21:02', NULL),
(144, 1, 'NYANZI', 'ABDUL SWABUR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_144_1759286217961_rbn717.jpg', '2025-08-18 11:02:18', '2025-10-01 02:38:08', NULL),
(145, 1, 'KATEGA', 'AYUB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_145_1759284810386_x3u8t8.jpg', '2025-08-18 11:03:24', '2025-10-01 02:13:30', NULL),
(146, 1, 'SONKO', 'SHARAF KIGANDA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_146_1759292464210_u9zdiu.jpg', '2025-08-18 11:04:24', '2025-10-01 04:21:04', NULL),
(147, 1, 'KATUSIIME', 'FAHIIMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_147_1759280721292_f5om05.jpg', '2025-08-18 11:05:18', '2025-10-01 01:05:21', NULL),
(148, 1, 'SEGUJJA', 'HUSSEIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_148_1759284789458_w4w1l2.jpg', '2025-08-18 11:06:56', '2025-10-01 02:13:09', NULL),
(149, 1, 'SSEMWANGA', 'RAYAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_149_1759292454068_tpnb7k.jpg', '2025-08-18 11:07:53', '2025-10-01 04:20:54', NULL),
(150, 1, 'MUKOSE', 'TWAHIR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_150_1759292117860_vt3mgr.jpg', '2025-08-18 11:09:10', '2025-10-01 04:15:17', NULL),
(151, 1, 'ABDUL SHAKUR', 'SWALEH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_151_1759299513269_eslv72.jpg', '2025-08-18 11:10:03', '2025-10-01 06:18:33', NULL),
(152, 1, 'MULANGIRA', 'ABDUL RAHMAN', '', 'male', '0000-00-00', '', '', '', '', '2025-08-18 11:11:04', '2025-09-30 19:43:16', NULL),
(153, 1, 'WANDERA', 'MUSTAPHA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_153_1759292630905_u1rs18.jpg', '2025-08-18 11:12:37', '2025-10-01 04:23:50', NULL),
(154, 1, 'NABABENGA', 'HABIBAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_154_1759280722700_kni3h1.jpg', '2025-08-18 11:14:20', '2025-10-01 01:05:22', NULL),
(155, 1, 'ATWA-U', 'MWASE', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_155_1759782584431_blsjbj.jpg', '2025-08-18 11:15:12', '2025-10-06 20:29:45', NULL),
(156, 1, 'WAWAYANGA', 'ABDUL HAIRI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_156_1759292634083_8o3qac.jpg', '2025-08-18 11:16:14', '2025-10-01 04:23:54', NULL),
(157, 1, 'KALEMA', 'FADHIL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_157_1759286237603_aow2hn.jpg', '2025-08-18 11:17:04', '2025-10-01 02:37:17', NULL),
(158, 1, 'MUYOMBA', 'ANWAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_158_1759284792325_u875fl.jpg', '2025-08-18 11:18:59', '2025-10-01 02:13:12', NULL),
(159, 1, 'BALE', 'ABDUL-SHAKUR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_159_1759284794850_s3frpc.jpg', '2025-08-18 11:20:23', '2025-10-01 02:13:14', NULL),
(160, 1, 'BYARUHANGA', 'NASIIB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_160_1759286231342_2jez1f.jpg', '2025-08-18 11:21:20', '2025-10-01 02:37:11', NULL),
(161, 1, 'MUBIRU', 'AZHAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_161_1759286221553_dcwhmz.jpg', '2025-08-18 11:22:09', '2025-10-01 02:37:01', NULL),
(162, 1, 'LUQMAN', 'KAYONDO', '', 'male', '0000-00-00', '', '', '', '', '2025-08-18 11:22:54', '2025-09-30 19:40:50', NULL),
(163, 1, 'SSEMAKULA', 'SHUKRAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:23:41', NULL, NULL),
(164, 1, 'SSENOGA', 'MAHAWISH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_164_1759280732875_pqgnqw.jpg', '2025-08-18 11:24:37', '2025-10-01 01:05:32', NULL),
(165, 1, 'WALUGEMBE', 'HAITHAM ABDUL KARIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_165_1759292627844_ob1e09.jpg', '2025-08-18 11:25:58', '2025-10-01 04:23:47', NULL),
(166, 1, 'SHADIAH', 'BINTI ZAIDI', '', 'female', '0000-00-00', '', '', '', '', '2025-08-18 11:26:56', '2025-09-30 20:00:22', NULL),
(167, 1, 'KALUNGI', 'UKASHA UMAR', '', 'male', '0000-00-00', '', '', '', '', '2025-08-18 11:27:50', '2025-09-30 19:34:30', NULL),
(168, 1, 'ASIMWE', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_168_1759281060578_nm2uiq.jpg', '2025-08-18 11:28:51', '2025-10-01 01:11:00', NULL),
(169, 1, 'HASSAN', 'QASSIM WASSWA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_169_1759286241107_rhgxhq.jpg', '2025-08-18 11:29:49', '2025-10-01 02:37:21', NULL),
(170, 1, 'SSEKADU', 'HAMAM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_170_1759284799142_i7e67b.jpg', '2025-08-18 11:30:40', '2025-10-01 02:13:19', NULL),
(171, 1, 'BUKENYA', 'ABDUL GHAFAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_171_1759286208182_f8gxpm.jpg', '2025-08-18 11:32:55', '2025-10-01 02:36:48', NULL),
(172, 1, 'LUKWAGO', 'SUDAIS', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_172_1759292121518_2pb1wm.jpg', '2025-08-18 11:33:53', '2025-10-01 04:15:21', NULL),
(173, 1, 'KANAKULYA', 'RAJAB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_173_1759288352038_6g2cvs.jpg', '2025-08-18 11:34:44', '2025-10-01 03:12:32', NULL),
(174, 1, 'NAIGAGA', 'HAJARAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_174_1759280723905_nemyy4.jpg', '2025-08-18 11:35:24', '2025-10-01 01:05:23', NULL),
(175, 1, 'LWANGA', 'UKASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 11:36:13', NULL, NULL),
(176, 1, 'TAUFIC', 'LUKOMWA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_176_1759288364477_rvylhu.jpg', '2025-08-18 11:37:20', '2025-10-01 03:12:44', NULL),
(177, 1, 'ABDUL AZIZI', 'SAIF LA WAYA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_177_1759291497097_5ajfox.jpg', '2025-08-18 11:38:41', '2025-10-01 04:04:57', NULL),
(178, 1, 'NANGOBI', 'SUMMAYAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_178_1759280736781_aeb3u4.jpg', '2025-08-18 11:39:39', '2025-10-01 01:05:36', NULL),
(179, 1, 'WASOKO', 'EDRISA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_179_1759284796536_km7u5a.jpg', '2025-08-18 11:40:36', '2025-10-01 02:13:16', NULL),
(180, 1, 'HAMIDAH', 'QASSIM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_180_1759410372697_1l494f.jpg', '2025-08-18 11:41:40', '2025-10-02 13:06:32', NULL),
(181, 1, 'ABDUL AZIZ', 'MUYIIMA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_181_1759291473987_yrcch4.jpg', '2025-08-18 11:42:29', '2025-10-01 04:04:49', NULL),
(182, 1, 'UMAR', 'MUSA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_182_1759292720336_p3uiki.jpg', '2025-08-18 11:43:10', '2025-10-01 04:25:20', NULL),
(183, 1, 'THURAYYA', 'MBAZIIRA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_183_1759280737834_yakr4e.jpg', '2025-08-18 11:44:09', '2025-10-01 01:05:37', NULL),
(184, 1, 'RAYAN', 'KAGABA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_184_1759299949843_9vqw6a.jpg', '2025-08-18 11:44:45', '2025-10-01 06:25:49', NULL),
(185, 1, 'MUBIRU', 'MUSTAFA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_185_1759292112529_1meivz.jpg', '2025-08-18 11:48:43', '2025-10-01 04:15:12', NULL),
(186, 1, 'MISBAHU', 'ASHIRAF', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_186_1759292109322_jo363f.jpg', '2025-08-18 11:49:26', '2025-10-01 04:15:09', NULL),
(187, 1, 'ABDUL NASWIR MUHAMMAD', 'NGOBI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_187_1759286214258_052db7.jpg', '2025-08-18 11:50:19', '2025-10-01 02:36:54', NULL),
(188, 1, 'ABDUL MALIK', 'MUHAMMAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_188_1759291368641_gry1oa.jpg', '2025-08-18 11:51:29', '2025-10-01 04:02:52', NULL),
(189, 1, 'FADHIL', 'HUZAIFAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_189_1759293068313_fz44wp.jpg', '2025-08-18 11:52:12', '2025-10-01 04:31:08', NULL),
(190, 1, 'FADHIL', 'HUBAIBU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_190_1759293157586_i2v0hh.jpg', '2025-08-18 11:52:54', '2025-10-01 04:32:37', NULL),
(191, 1, 'FADHIL', 'UWAIS', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_191_1759293029066_j5fget.jpg', '2025-08-18 11:53:41', '2025-10-01 04:30:29', NULL),
(192, 1, 'ABDURAHMAN HASSAN', 'WASSWA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_192_1759284801760_z0xneo.jpg', '2025-08-18 11:54:47', '2025-10-01 02:13:21', NULL),
(193, 1, 'KANYIKE', 'MUHAMMAD YASIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_193_1759288354669_yf3me0.jpg', '2025-08-18 11:55:38', '2025-10-01 03:12:34', NULL),
(194, 1, 'NAKATE', 'AFUWA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_194_1759410371781_75nc97.jpg', '2025-08-18 11:56:25', '2025-10-02 13:06:11', NULL),
(195, 1, 'ZAITUNI', 'NAISAMULA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_195_1759280741632_1t1t5r.jpg', '2025-08-18 11:58:37', '2025-10-01 01:05:41', NULL),
(196, 1, 'MUYOMBA', 'UMAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_196_1759286233467_w8yp9a.jpg', '2025-08-18 11:59:24', '2025-10-01 02:37:13', NULL),
(197, 1, 'KAWOOYA', 'UMAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_197_1759292752689_oixnff.jpg', '2025-08-18 12:00:15', '2025-10-01 04:25:52', NULL),
(198, 1, 'ABDUL RAHMAN SHURAIM', 'WAFULA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_198_1759291706993_o99gql.jpg', '2025-08-18 12:01:05', '2025-10-01 04:08:27', NULL),
(199, 1, 'KAZIBWE', 'ISMAEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_199_1759288358259_g9g5wu.jpg', '2025-08-18 12:01:45', '2025-10-01 03:12:38', NULL),
(200, 1, 'BASHIRA', 'ABDUL KARIM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_200_1759280720113_c1z1mg.jpg', '2025-08-18 12:02:32', '2025-10-01 01:05:20', NULL),
(201, 1, 'IQLAS MOHAMED', 'MUHAMMUD', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_201_1759280730172_jmdp3s.jpg', '2025-08-18 12:03:46', '2025-10-01 01:05:30', NULL),
(202, 1, 'IDRIS', 'MOHAMED MUHAMMUD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_202_1759285522327_1z9kgd.jpg', '2025-08-18 12:04:33', '2025-10-01 02:25:22', NULL),
(203, 1, 'HIBATULLAH', 'ABAS', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_203_1759280727097_v93zrd.jpg', '2025-08-18 12:05:35', '2025-10-01 01:05:27', NULL),
(204, 1, 'HAIRAT', 'NASSUNA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_204_1759280717949_3u8w3b.jpg', '2025-08-18 12:06:19', '2025-10-01 01:05:17', NULL),
(205, 1, 'NSIMBI', 'NAJIB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_205_1759299939935_r4qgju.jpg', '2025-08-18 12:06:54', '2025-10-01 06:25:39', NULL),
(206, 1, 'TIMUNTU', 'ABDUL-RAZAK', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_206_1759299943414_s0hnse.jpg', '2025-08-18 12:07:37', '2025-10-01 06:25:43', NULL),
(207, 1, 'ABDUL-AZIZI', 'ZIZINGA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_207_1760021421858_1s7lt1.jpg', '2025-08-18 12:08:47', '2025-10-09 14:50:22', NULL),
(208, 1, 'WILDAN', 'TWAIB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_208_1759292636171_b8q8wh.jpg', '2025-08-18 12:09:31', '2025-10-01 04:23:56', NULL),
(209, 1, 'MUGUNDA', 'YUSUF', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_209_1759292114882_jffdx1.jpg', '2025-08-18 12:10:10', '2025-10-01 04:15:14', NULL),
(210, 1, 'HASNAT', 'UTHUMAN', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_210_1759280725218_ilpvx0.jpg', '2025-08-18 12:11:10', '2025-10-01 01:05:25', NULL),
(211, 1, 'SHAKIB', 'MUGANGA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_211_1759299931035_voekh3.jpg', '2025-08-18 12:11:58', '2025-10-01 06:25:31', NULL),
(212, 1, 'MUSOBYA', 'SHAFIE ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_212_1759292458548_7784ip.jpg', '2025-08-18 12:13:02', '2025-10-01 04:20:58', NULL),
(213, 1, 'NAKANTU', 'HAFIDHWA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_213_1759280734276_5lqkor.jpg', '2025-08-18 12:13:53', '2025-10-01 01:05:34', NULL),
(214, 1, 'NAKANTU', 'HUNAISA', '', 'female', '0000-00-00', '', '', '', '', '2025-08-18 12:14:37', '2025-09-30 19:45:31', NULL),
(215, 1, 'JAMILA', 'JUMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_215_1759280731544_308ro2.jpg', '2025-08-18 12:15:50', '2025-10-01 01:05:31', NULL),
(216, 1, 'RAHMA', 'FADHIL', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_216_1759280735464_1v42gz.jpg', '2025-08-18 12:16:38', '2025-10-01 01:05:35', NULL),
(217, 1, 'KIIRA', 'MUHAAMAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_217_1759288361787_27f7v7.jpg', '2025-08-18 12:17:22', '2025-10-01 03:12:41', NULL),
(218, 1, 'AAYAT', 'UTHMAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 12:18:03', NULL, NULL),
(219, 1, 'QAYIM', 'UTHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_219_1759299953399_1oviws.jpg', '2025-08-18 12:18:50', '2025-10-01 06:25:53', NULL),
(220, 1, 'ZAMZAM', 'NAKALEMBE', '', 'female', '0000-00-00', '', '', '', '', '2025-08-18 12:19:37', '2025-09-30 19:57:08', NULL),
(221, 1, 'BASHIR', 'ABDUL HAFIDHI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_221_1759286211904_t3caex.jpg', '2025-08-18 12:20:29', '2025-10-01 02:36:51', NULL),
(222, 1, 'ABDUL RAHMAN', 'DAMUZUNGU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_222_1761172539590_lfjova.jpg', '2025-08-18 13:19:57', '2025-10-22 22:35:42', NULL),
(223, 1, 'MUKISA', 'SUDAIS', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:21:02', NULL, NULL),
(224, 1, 'RAHIYYAH', 'ZAID', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_224_1761173564553_bji8zl.jpg', '2025-08-18 13:22:33', '2025-10-22 22:52:44', NULL),
(225, 1, 'SULTAN', 'ALI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_225_1761173581603_tp5zn0.jpg', '2025-08-18 13:23:25', '2025-10-22 22:53:01', NULL),
(226, 1, 'NAMWENA', 'RAHMA NAMYALO', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:17:55', NULL, NULL),
(227, 1, 'MPAULO', 'SWALIK', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_227_1761173069012_moepx1.jpg', '2025-08-18 13:18:42', '2025-10-22 22:44:30', NULL),
(228, 1, 'ERIASI', 'KAWUKA SUDAISI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_228_1761172797608_ycnqmu.jpg', '2025-08-18 13:19:37', '2025-10-22 22:39:57', NULL),
(229, 1, 'KYOTAITE', 'RAJAB', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_229_1761172806431_llx0m4.jpg', '2025-08-18 13:20:23', '2025-10-22 22:40:06', NULL),
(230, 1, 'UTHUMAN', 'KALISA', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_230_1761173587981_xxp0ma.jpg', '2025-08-18 13:21:05', '2025-10-22 22:53:08', NULL),
(231, 1, 'USAM', 'FARID', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_231_1761173584616_djt3xi.jpg', '2025-08-18 13:21:44', '2025-10-22 22:53:04', NULL),
(232, 1, 'ZIRABA', 'JUMA GASEMBA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_232_1761173529325_r406p2.jpg', '2025-08-18 13:22:32', '2025-10-22 22:52:09', NULL),
(233, 1, 'SEBACHWA', 'SHARIF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:23:23', NULL, NULL),
(234, 1, 'KAGOYA', 'SHUKRAN ALI', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_234_1761172783567_0bwjef.jpg', '2025-08-18 13:24:16', '2025-10-22 22:39:43', NULL),
(235, 1, 'BIDI', 'HADIJJAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_235_1761172765269_rtks0f.jpg', '2025-08-18 13:24:58', '2025-10-22 22:39:25', NULL),
(236, 1, 'NTALO', 'JAWUHALI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_236_1761173557860_ftt5ck.jpg', '2025-08-18 13:25:42', '2025-10-22 22:52:38', NULL),
(237, 1, 'ARIAN', 'MUHAMAAD', '', '', '0000-00-00', '', '', '', '/uploads/students/person_237_1761172756819_cqs3lk.jpg', '2025-08-18 13:26:19', '2025-10-22 22:39:16', NULL),
(238, 1, 'SSERUNJOJI', 'MUHAMMAD', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_238_1761173578071_6cvbtz.jpg', '2025-08-18 13:27:35', '2025-10-22 22:52:58', NULL),
(239, 1, 'NAKIYINJI', 'RAHUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:28:17', NULL, NULL),
(240, 1, 'NAIGAGA', 'BUSHIRA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_240_1761173203998_ylpk0e.jpg', '2025-08-18 13:29:06', '2025-10-22 22:46:45', NULL),
(241, 1, 'NAMUYANGU', 'SHUKRAN', '', 'F', '0000-00-00', '', '', '', '', '2025-08-18 13:29:53', '2025-10-17 19:02:47', NULL),
(242, 1, 'KAMPI', 'ANISHA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:30:30', NULL, NULL),
(243, 1, 'NAMUSUSWA', 'RASHIM', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_243_1761173541014_ukcthm.jpg', '2025-08-18 13:31:31', '2025-10-22 22:52:21', NULL),
(244, 1, 'KALEMBE', 'NUSULA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_244_1761172790186_vvxrf5.jpg', '2025-08-18 13:35:26', '2025-10-22 22:39:50', NULL),
(245, 1, 'NAMATENDE', 'SHATURAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_245_1761173533104_u7fune.jpg', '2025-08-18 13:17:55', '2025-10-22 22:52:13', NULL),
(246, 1, 'MENYA', 'HASHIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_246_1761172809651_kkapb6.jpg', '2025-08-18 13:18:49', '2025-10-22 22:40:09', NULL),
(247, 1, 'NAM', 'NOEL', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_247_1761173319091_zohm4w.jpg', '2025-08-18 13:19:41', '2025-10-22 22:48:40', NULL),
(248, 1, 'KAKAIRE', 'BUKARI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_248_1761172786870_hrerel.jpg', '2025-08-18 13:20:26', '2025-10-22 22:39:47', NULL),
(249, 1, 'NAIGAGA', 'SHUNURAH', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_249_1761173233103_qjsmzm.jpg', '2025-08-18 13:21:23', '2025-10-22 22:47:14', NULL),
(250, 1, 'MUKUBYA', 'HISHAM', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_250_1761173173655_xpnnn6.jpg', '2025-08-18 13:22:12', '2025-10-22 22:46:15', NULL),
(251, 1, 'JIBRIL', 'HILAL', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_251_1761172780181_wba3mk.jpg', '2025-08-18 13:23:03', '2025-10-22 22:39:40', NULL),
(252, 1, 'AZEDI .A.', 'GANIYU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_252_1761172760615_l6d0f8.jpg', '2025-08-18 13:24:27', '2025-10-22 22:42:42', NULL),
(253, 1, 'KISIGE', 'SHAHID', '', 'male', '0000-00-00', '', '', '', '', '2025-08-18 13:26:07', '2025-10-17 19:02:11', NULL),
(254, 1, 'NTUUYO', 'HANIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_254_1761173561195_e6kdvn.jpg', '2025-08-18 13:26:56', '2025-10-22 22:52:41', NULL),
(255, 1, 'NAMPEERA', 'WALDA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_255_1761173536084_lx9opk.jpg', '2025-08-18 13:27:53', '2025-10-22 22:52:16', NULL),
(256, 1, 'SHAFIE', 'SIRAJ', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_256_1761173574618_hqglcg.jpg', '2025-08-18 13:28:38', '2025-10-22 22:52:54', NULL),
(257, 1, 'MUGOOWA', 'TAHIA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_257_1761173089414_ntsz10.jpg', '2025-08-18 13:29:23', '2025-10-22 22:45:03', NULL),
(258, 1, 'NDAADA', 'MUHAMMAD', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_258_1761173551838_kiu0nq.jpg', '2025-08-18 13:30:16', '2025-10-22 22:52:32', NULL),
(259, 1, 'NAMWASE', 'SHUKRUT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:31:08', NULL, NULL),
(260, 1, 'KANTONO', 'MARIAM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_260_1761172794228_107s2y.jpg', '2025-08-18 13:31:49', '2025-10-22 22:39:54', NULL),
(261, 1, 'AKISM BWANA', 'ABDUL-RAHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_261_1761172844963_obw3dm.jpg', '2025-08-18 13:32:31', '2025-10-22 22:40:46', NULL),
(262, 1, 'ISIKO', 'DAUDA HYTHAM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_262_1761172776623_bfg8os.jpg', '2025-08-18 13:33:35', '2025-10-22 22:39:36', NULL),
(263, 1, 'SIRAJ', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:34:24', NULL, NULL),
(264, 1, 'NAKATO', 'SHIFRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:35:04', NULL, NULL),
(265, 1, 'SARAH MUHAMMAD', 'NAMWAMI', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_265_1761173571246_lmt3kw.jpg', '2025-08-18 13:36:01', '2025-10-22 22:52:51', NULL),
(266, 1, 'NAQIYYU', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_266_1761173548527_dq03yf.jpg', '2025-08-18 13:36:43', '2025-10-22 22:52:28', NULL),
(267, 1, 'NGOBI', 'SHAMRAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_267_1761173554758_jgbd93.jpg', '2025-08-18 13:37:21', '2025-10-22 22:52:34', NULL),
(268, 1, 'BABIRYE', 'HAIRAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:38:00', NULL, NULL),
(269, 1, 'BASEKE', 'ABDUL-MAJID', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_269_1761172946637_7ai2nj.jpg', '2025-08-18 13:38:45', '2025-10-22 22:42:27', NULL),
(270, 1, 'MUHAMMAD', 'SHARIF MPINDI', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_270_1761173121895_iti6nq.jpg', '2025-08-18 13:39:43', '2025-10-22 22:45:23', NULL),
(271, 1, 'BUTHAINA', 'BASEF', NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/students/person_271_1761172773118_yhr944.jpg', '2025-08-18 13:40:25', '2025-10-22 22:39:33', NULL),
(272, 1, 'BIYINZIKA', 'PIAUS', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_272_1761172769094_nq7zot.jpg', '2025-08-18 13:41:11', '2025-10-22 22:39:29', NULL),
(273, 1, 'ZZIWA', 'RABIBA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_273_1760743432265_noknbz.jpg', '2025-08-18 13:42:42', '2025-10-17 23:23:52', NULL),
(274, 1, 'KASADHA', 'RAIHAN', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_274_1760741876368_uvasy1.jpg', '2025-08-18 13:44:44', '2025-10-17 22:57:56', NULL),
(275, 1, 'KAGUBIRU', 'ABDUL WARITH', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_275_1760741873549_wy67nt.jpg', '2025-08-18 13:45:26', '2025-10-17 22:57:53', NULL),
(276, 1, 'WANDERA', 'ABDUL RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:46:10', NULL, NULL),
(277, 1, 'MENYA', 'ISMA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_277_1760742718338_1xwhjh.jpg', '2025-08-18 13:46:51', '2025-10-17 23:11:59', NULL),
(278, 1, 'NANYANZI', 'LEILA', '', 'female', '0000-00-00', '', '', '', '', '2025-08-18 13:47:34', '2025-10-09 23:44:50', NULL),
(279, 1, 'ABDUL', 'BAAR ISA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_279_1760741860804_rjordl.jpg', '2025-08-18 13:48:14', '2025-10-17 22:57:40', NULL),
(280, 1, 'SEWANYANA', 'ABDUL RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_280_1760743205758_ayv4hv.jpg', '2025-08-18 13:49:01', '2025-10-17 23:20:06', NULL),
(281, 1, 'KIZZA', 'SWALEH', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_281_1760742491048_182i0w.jpg', '2025-08-18 13:49:42', '2025-10-17 23:08:11', NULL),
(282, 1, 'TAQIYUDIN', 'HASSAN', NULL, NULL, NULL, NULL, NULL, NULL, '/uploads/students/person_282_1760743394815_sqa186.jpg', '2025-08-18 13:50:25', '2025-10-17 23:23:14', NULL),
(283, 1, 'NABAGALA', 'SHARIFAH ABUBAR', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:51:27', NULL, NULL),
(284, 1, 'NASEJJE', 'SWALIHAT', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_284_1760743057177_cy8rl3.jpg', '2025-08-18 13:52:38', '2025-10-17 23:17:37', NULL),
(285, 1, 'MUWAYI', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_285_1760743038467_jw5guv.jpg', '2025-08-18 13:53:30', '2025-10-17 23:17:18', NULL),
(286, 1, 'APOLOTI', 'BARIAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:54:15', NULL, NULL),
(287, 1, 'WAIGONGOLO', 'UTHUMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 13:55:17', NULL, NULL),
(288, 1, 'ASHURAH', 'FAHIMAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_288_1760741862301_sc59ax.jpg', '2025-08-18 13:56:04', '2025-10-17 22:57:42', NULL),
(289, 1, 'ABDUL-QAWIYU', 'WAKO', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_289_1760741936871_8oiyce.jpg', '2025-08-18 13:56:48', '2025-10-17 22:58:58', NULL),
(290, 1, 'NURIAT', 'NANSAMBA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_290_1760743055003_cb32zm.jpg', '2025-08-18 13:57:49', '2025-10-17 23:17:35', NULL),
(291, 1, 'ABDALLAH', 'HABIBU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_291_1760741856578_r3zuwo.jpg', '2025-08-18 13:58:44', '2025-10-17 22:57:36', NULL),
(292, 1, 'NAKAGOLO', 'SHATURAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_292_1760743092615_2fxkq1.jpg', '2025-08-18 13:59:36', '2025-10-17 23:18:13', NULL),
(293, 1, 'KIWANUKA', 'IBRAHIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_293_1760741884844_kyd60f.jpg', '2025-08-18 14:00:23', '2025-10-17 22:58:04', NULL),
(294, 1, 'NABUKERA', 'RAUFA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_294_1760743043946_m94i9m.jpg', '2025-08-18 14:01:07', '2025-10-17 23:17:24', NULL),
(295, 1, 'WASWA', 'AQAMAL', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_295_1760743404820_utp9un.jpg', '2025-08-18 14:01:50', '2025-10-17 23:23:24', NULL),
(296, 1, 'SENGOYE', 'KATO', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_296_1760741880356_iohtih.jpg', '2025-08-18 14:02:28', '2025-10-17 22:58:00', NULL),
(297, 1, 'MUSENZE', 'HANANI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_297_1760743026026_wtsgg3.jpg', '2025-08-18 14:03:09', '2025-10-17 23:17:06', NULL),
(298, 1, 'WAFULA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_298_1760743402372_v0t1ks.jpg', '2025-08-18 14:04:08', '2025-10-17 23:23:22', NULL),
(299, 1, 'NALUBEGA', 'ATIMA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_299_1760743048160_amlgwf.jpg', '2025-08-18 14:05:01', '2025-10-17 23:17:28', NULL),
(300, 1, 'MANGOOLE', 'HATIMU', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_300_1760743014741_ysw1j6.jpg', '2025-08-18 14:05:47', '2025-10-17 23:16:54', NULL),
(301, 1, 'OTHIENO', 'JOHNSTEVEN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_301_1760743062677_q9pc2r.jpg', '2025-08-18 14:06:44', '2025-10-17 23:17:42', NULL),
(302, 1, 'KATIIKI', 'RAHMA', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_302_1760741879020_gfte8t.jpg', '2025-08-18 14:07:21', '2025-10-17 22:57:59', NULL),
(303, 1, 'OBO', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_303_1760743059430_tot0vw.jpg', '2025-08-18 14:21:28', '2025-10-17 23:17:39', NULL),
(304, 1, 'ABDUL-SHAKUR', 'MALINZI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_304_1760741887681_e956bj.jpg', '2025-08-18 14:23:01', '2025-10-17 22:58:07', NULL),
(305, 1, 'DAKHABA', 'BURUHAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_305_1760741867753_5do2h4.jpg', '2025-08-18 14:24:15', '2025-10-17 22:57:47', NULL),
(306, 1, 'BALELE', 'ABDUL-MAJID', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_306_1760741864291_ntlhl4.jpg', '2025-08-18 14:25:04', '2025-10-17 22:57:44', NULL),
(307, 1, 'MUWAYA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_307_1760743036664_ftgt75.jpg', '2025-08-18 14:26:09', '2025-10-17 23:17:16', NULL),
(308, 1, 'MUGEYI', 'HISHAM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_308_1760742750118_457h21.jpg', '2025-08-18 14:27:06', '2025-10-17 23:12:30', NULL),
(309, 1, 'MUTYABA', 'AWATH', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_309_1760743032147_z2nakc.jpg', '2025-08-18 14:27:55', '2025-10-17 23:17:13', NULL),
(310, 1, 'OTUMA', 'JANAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:28:47', NULL, NULL),
(311, 1, 'ZIYAD', 'KASAKYA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:30:54', NULL, NULL),
(312, 1, 'MUTAGOBWA', 'AHMED JUMA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_312_1760743028876_806kf5.jpg', '2025-08-18 14:31:47', '2025-10-17 23:17:08', NULL),
(313, 1, 'HUNAISA', 'YUSUF', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_313_1760741982280_2hrmze.jpg', '2025-08-18 14:32:33', '2025-10-17 22:59:43', NULL),
(314, 1, 'MULINYA', 'RAYAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_314_1760743019310_mcz7kx.jpg', '2025-08-18 14:33:35', '2025-10-17 23:16:59', NULL),
(315, 1, 'KISIGE', 'SHURAIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_315_1760741882852_6yxmfk.jpg', '2025-08-18 14:34:19', '2025-10-17 22:58:02', NULL),
(316, 1, 'GAALI', 'FARAHAT', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_316_1760741871010_nvszxo.jpg', '2025-08-18 14:35:10', '2025-10-17 22:57:51', NULL),
(317, 1, 'NANGOBI', 'AALIYA', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_317_1760743052828_2ucwrc.jpg', '2025-08-18 14:36:01', '2025-10-17 23:17:32', NULL),
(318, 1, 'KIMERA', 'RAYD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_318_1760742253846_ioy2z2.jpg', '2025-08-18 14:38:35', '2025-11-11 16:00:33', NULL),
(319, 1, 'MUGOWA', 'FAHAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_319_1760742771369_qgfhs6.jpg', '2025-08-18 14:39:57', '2025-10-17 23:13:03', NULL),
(320, 1, 'UTHUMAN', 'MINSHAWI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_320_1760743485389_yv7rda.jpg', '2025-08-18 14:41:02', '2025-10-17 23:24:59', NULL),
(321, 1, 'NALUZZE', 'THUWAIBAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_321_1760743114477_1xngpr.jpg', '2025-08-18 14:42:07', '2025-10-17 23:18:35', NULL),
(322, 1, 'SSENYONJO', 'TAUFIQ', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_322_1760743397368_pi2f7i.jpg', '2025-08-18 14:43:19', '2025-10-17 23:23:17', NULL);
INSERT INTO `people` (`id`, `school_id`, `first_name`, `last_name`, `other_name`, `gender`, `date_of_birth`, `phone`, `email`, `address`, `photo_url`, `created_at`, `updated_at`, `deleted_at`) VALUES
(323, 1, 'SHARIFA', 'ABDUL-HAMIDU', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_323_1760741858703_6ko3pu.jpg', '2025-08-18 14:44:29', '2025-10-17 22:57:38', NULL),
(324, 1, 'KASADHA', 'YASIN YAKUB', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_324_1760741877730_hek1y7.jpg', '2025-08-18 14:45:56', '2025-10-17 22:57:57', NULL),
(325, 1, 'NAMAGANDA', 'FITRA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_325_1760741869301_n6maqg.jpg', '2025-08-18 14:47:09', '2025-10-17 22:57:49', NULL),
(326, 1, 'NAMBI', 'HAWA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_326_1760743050502_mvbv6n.jpg', '2025-08-18 14:48:05', '2025-10-17 23:17:30', NULL),
(327, 1, 'ABDUL-KARIM', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_327_1760741874977_gm4bcq.jpg', '2025-08-18 14:49:00', '2025-10-17 22:57:54', NULL),
(328, 1, 'NABANDA', 'HADIJJAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_328_1760743041062_1y0u71.jpg', '2025-08-18 14:50:00', '2025-10-17 23:17:21', NULL),
(329, 1, 'MAGUMBA', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_329_1760741886172_p0kvqz.jpg', '2025-08-18 14:50:50', '2025-10-17 22:58:06', NULL),
(330, 1, 'KYOLABA', 'FATUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:51:30', NULL, NULL),
(331, 1, 'KANSIIME', 'YASMINE', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_331_1760742291415_s5bkjh.jpg', '2025-08-18 14:53:00', '2025-10-17 23:04:52', NULL),
(332, 1, 'MUNURO', 'SHABAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_332_1760743023169_k76gn1.jpg', '2025-08-18 14:53:39', '2025-10-17 23:17:03', NULL),
(333, 1, 'KATERAGA', 'MUGAGA ISMAEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_333_1760742325734_fg608w.jpg', '2025-08-18 14:54:43', '2025-10-17 23:05:26', NULL),
(334, 1, 'MUKISA', 'ABDUL-RAZAK', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_334_1760743016849_8qfyve.jpg', '2025-08-18 14:55:29', '2025-10-17 23:16:56', NULL),
(335, 1, 'OLANYA', 'HAMZA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 14:56:16', NULL, NULL),
(336, 1, 'NAMATENDE', 'AISHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_336_1759409146144_ahpdh3.jpg', '2025-08-18 14:57:56', '2025-10-02 12:56:29', NULL),
(337, 1, 'AMIRAH', 'HUSSNAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_337_1759408233202_fekabf.jpg', '2025-08-18 14:59:00', '2025-10-02 12:31:40', NULL),
(338, 1, 'MUTESI', 'RAHMAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_338_1759408688111_kmrsyf.jpg', '2025-08-18 14:59:57', '2025-10-09 21:22:34', NULL),
(339, 1, 'NANGOBI', 'FARIHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_339_1759409170144_9eimlg.jpg', '2025-08-18 15:02:10', '2025-10-02 12:57:49', NULL),
(340, 1, 'KATENDE', 'ABDUL-RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_340_1759408661825_prr3rm.jpg', '2025-08-18 15:03:08', '2025-10-02 12:52:09', NULL),
(341, 1, 'WAISWA', 'HASSAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_341_1759409272350_8ohvva.jpg', '2025-08-18 15:04:37', '2025-10-02 12:47:52', NULL),
(342, 1, 'KATO', 'HUSSEIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_342_1759408664036_xiybjz.jpg', '2025-08-18 15:05:51', '2025-10-02 12:52:18', NULL),
(343, 1, 'KINTU', 'MEDI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 15:06:48', NULL, NULL),
(344, 1, 'KAKAIRE', 'UKASHA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_344_1759408653336_3d1j4k.jpg', '2025-08-18 15:07:59', '2025-10-02 12:51:39', NULL),
(345, 1, 'AHMED', 'MUDATHIR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_345_1759408229775_z5r4we.jpg', '2025-08-18 15:09:34', '2025-10-02 12:31:27', NULL),
(346, 1, 'MUTUBA', 'IMRAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_346_1759408690334_m12jf3.jpg', '2025-08-18 15:10:30', '2025-10-02 12:55:01', NULL),
(347, 1, 'KONERA', 'HUSNAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_347_1759408670420_z0q8a4.jpg', '2025-08-18 15:11:30', '2025-10-02 12:53:05', NULL),
(348, 1, 'KISUYI', 'HUZAIRU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_348_1759408667301_v7ycp3.jpg', '2025-08-18 15:12:37', '2025-10-02 12:52:53', NULL),
(349, 1, 'YAHAYA', 'MUCHAINA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_349_1759409275298_a27j02.jpg', '2025-08-18 21:20:40', '2025-10-02 12:59:44', NULL),
(350, 1, 'MPAULO', 'SHABAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_350_1759408679264_oxthsd.jpg', '2025-08-18 21:21:34', '2025-10-02 12:53:44', NULL),
(351, 1, 'SEBUGANDA', 'SHURAIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_351_1759409186005_43tdj2.jpg', '2025-08-18 21:22:43', '2025-10-02 12:58:32', NULL),
(352, 1, 'HANIPH', 'QURAISH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_352_1759408881740_pdsibr.jpg', '2025-08-18 21:23:45', '2025-10-02 12:51:05', NULL),
(353, 1, 'MUSASIZI', 'AQIEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_353_1759408236856_h643eh.jpg', '2025-08-18 21:24:59', '2025-10-02 12:54:25', NULL),
(354, 1, 'ASIMA', 'FATIHA  FARID', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_354_1759408243726_zew13c.jpg', '2025-08-18 21:26:11', '2025-10-02 12:48:56', NULL),
(355, 1, 'KAKOOZA', 'HUZAIR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_355_1759408655555_7patul.jpg', '2025-08-18 21:27:06', '2025-10-02 12:51:53', NULL),
(356, 1, 'GASEMBA', 'AZED', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_356_1759408646596_3sohnz.jpg', '2025-08-18 21:27:55', '2025-10-02 12:50:42', NULL),
(357, 1, 'NAKISUYI  FAHMAT', 'FAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_357_1759408256487_witv40.jpg', '2025-08-18 21:29:03', '2025-10-02 12:55:37', NULL),
(358, 1, 'ANISHA', 'MUTESI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_358_1759408684763_4b5pbz.jpg', '2025-08-18 21:30:03', '2025-10-02 12:38:04', NULL),
(359, 1, 'BAMULANZEKI', 'SALIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_359_1759408835743_c3kra4.jpg', '2025-08-18 21:30:59', '2025-10-02 12:49:30', NULL),
(360, 1, 'RAHMA', 'NAKAGOLO', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_360_1759409131610_td22b1.jpg', '2025-08-18 21:31:51', '2025-10-02 12:58:17', NULL),
(361, 1, 'WANGUBO', 'RAYAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:32:47', NULL, NULL),
(362, 1, 'NAMPALA', 'RAHMA  MINJA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_362_1759409150238_6zmzhq.jpg', '2025-08-18 21:34:06', '2025-10-02 12:56:54', NULL),
(363, 1, 'NAMUWAYA', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_363_1759409157904_8cfgeq.jpg', '2025-08-18 21:34:58', '2025-10-02 12:57:24', NULL),
(364, 1, 'NALUWAGULA', 'NOOR', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_364_1759409135833_z9498t.jpg', '2025-08-18 21:35:59', '2025-10-02 12:55:54', NULL),
(365, 1, 'SOOMA', 'ASHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_365_1759409180839_cvn8iv.jpg', '2025-08-18 21:36:59', '2025-10-02 12:58:48', NULL),
(366, 1, 'NANGIRA', 'ABDUL-AYAT', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_366_1759409163913_f5dosh.jpg', '2025-08-18 21:38:15', '2025-10-02 12:57:35', NULL),
(367, 1, 'TIBAGA', 'NUSUFA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_367_1759409196840_4n95eb.jpg', '2025-08-18 21:39:32', '2025-10-02 12:59:10', NULL),
(368, 1, 'NAMPALA', 'YUSUF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:41:17', NULL, NULL),
(369, 1, 'KYEYUNE', 'HALIMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:46:21', NULL, NULL),
(370, 1, 'KIGUNDU', 'SHAFIK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 21:47:32', NULL, NULL),
(371, 1, 'BINT YUSUF', 'ASHIBA  NANTABO', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_371_1759408239603_deo7x3.jpg', '2025-08-18 21:48:37', '2025-10-02 12:50:18', NULL),
(372, 1, 'NASSALI', 'FARIHYA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_372_1759409174646_260x2c.jpg', '2025-08-18 21:50:10', '2025-10-02 12:58:04', NULL),
(373, 1, 'ABUBAKALI', 'SWIDIQ', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_373_1759408226055_5x69hb.jpg', '2025-08-18 21:51:37', '2025-10-02 12:30:26', NULL),
(374, 1, 'MUSTAFA', 'PAVEZ', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_374_1759408955598_qgr5sy.jpg', '2025-08-18 21:52:21', '2025-10-02 12:54:37', NULL),
(375, 1, 'SUDAIS', 'ABDUL-RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_375_1759409190170_sv6b6z.jpg', '2025-08-18 21:53:09', '2025-10-02 12:58:59', NULL),
(376, 1, 'BAMULANZEKI', 'RAMADHAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_376_1759408251794_e9etne.jpg', '2025-08-18 21:54:10', '2025-10-02 12:49:20', NULL),
(377, 1, 'ASIIMWE', 'FAHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_377_1759408242137_jpcoh1.jpg', '2025-08-18 21:54:49', '2025-10-02 12:48:43', NULL),
(378, 1, 'NAKIBINGE', 'IBRA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_378_1759408961387_3iwq5g.jpg', '2025-08-18 21:55:59', '2025-10-02 12:55:26', NULL),
(379, 1, 'UTHMAN', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_379_1759409202484_mqcljg.jpg', '2025-08-18 21:56:50', '2025-10-02 12:59:23', NULL),
(380, 1, 'BIKADHO', 'ADAM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_380_1759408253971_og6gi9.jpg', '2025-08-18 21:58:32', '2025-10-02 12:49:55', NULL),
(381, 1, 'MWASE', 'SUDAIS', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_381_1759408694176_b20k7k.jpg', '2025-08-18 21:59:21', '2025-10-02 12:55:12', NULL),
(382, 1, 'MONDO', 'HASSAN  RAHUL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_382_1759408676108_18jgp7.jpg', '2025-08-18 22:00:17', '2025-10-02 12:53:31', NULL),
(383, 1, 'MUHSIN', 'ABDUL-KARIM  NSAMBA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_383_1759408681553_0eqs4u.jpg', '2025-08-18 22:01:37', '2025-10-02 12:54:12', NULL),
(384, 1, 'AISHA', 'NAKIMULI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_384_1759408830185_wf802t.jpg', '2025-08-18 22:02:33', '2025-10-09 21:21:37', NULL),
(385, 1, 'NAMAGANDA', 'RAUDHAT', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_385_1759409141280_21g5fj.jpg', '2025-08-18 22:03:27', '2025-10-02 12:56:10', NULL),
(386, 1, 'WAIRA', 'MUSWABU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_386_1759409266913_vbw8mh.jpg', '2025-08-18 22:04:22', '2025-10-02 12:59:35', NULL),
(387, 1, 'EMETAYI', 'ABDUL-RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:06:56', NULL, NULL),
(388, 1, 'BAKAKI', 'SWABAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_388_1759408249117_jcm204.jpg', '2025-08-18 22:07:43', '2025-10-02 12:49:10', NULL),
(389, 1, 'GOOBI', 'ABASI  HANAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_389_1759408650195_m1kwws.jpg', '2025-08-18 22:08:43', '2025-10-02 12:50:55', NULL),
(390, 1, 'NAMULONDO', 'ZAINAB  RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_390_1759409152549_dbz1w5.jpg', '2025-08-18 22:09:31', '2025-10-02 12:57:07', NULL),
(391, 1, 'HASSANAT', 'KANSIIME', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_391_1759408658710_p5z00j.jpg', '2025-08-18 22:10:13', '2025-10-02 12:51:17', NULL),
(392, 1, 'MATENDE', 'ABDUL-RAUF', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_392_1759408672723_fy3i17.jpg', '2025-08-18 22:11:28', '2025-10-02 12:53:19', NULL),
(393, 1, 'BUKENYA', 'HASSAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_393_1759250767350_4kl2ml.jpg', '2025-08-18 22:13:16', '2025-09-30 16:50:06', NULL),
(394, 1, 'MUHAMMAD', 'ISA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_394_1758728289251_w9hyaw.jpg', '2025-08-18 22:17:35', '2025-09-24 15:38:09', NULL),
(395, 1, 'MUDATHIR', 'IBRAHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_395_1758728222058_7s7y1s.jpg', '2025-08-18 22:18:21', '2025-09-24 15:37:14', NULL),
(396, 1, 'KAKAIRE', 'IMRAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_396_1759250777853_bu8u2x.jpg', '2025-08-18 22:19:18', '2025-09-30 16:51:53', NULL),
(397, 1, 'BALELE', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_397_1758727876397_tw0366.jpg', '2025-08-18 22:20:32', '2025-09-24 15:31:18', NULL),
(398, 1, 'MUNOBWA', 'ABDUL-SWABAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_398_1759250763894_7urho0.jpg', '2025-08-18 22:21:31', '2025-09-30 16:54:14', NULL),
(399, 1, 'MULONDO', 'ISHAM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_399_1758728417036_nxtcs5.jpg', '2025-08-18 22:22:23', '2025-09-24 15:40:17', NULL),
(400, 1, 'SULAIMAN', 'SAIF', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_400_1758728876072_z9dyuu.jpg', '2025-08-18 22:23:11', '2025-09-24 15:47:56', NULL),
(401, 1, 'BABIRYE', 'HABIBA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_401_1758731351988_nwrxc1.jpg', '2025-08-18 22:24:17', '2025-09-30 16:49:32', NULL),
(402, 1, 'NAKIYEMBA', 'SHIFRA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_402_1758728642536_9l5mrt.jpg', '2025-08-18 22:25:07', '2025-09-24 15:44:03', NULL),
(403, 1, 'WAVAMUNO', 'ATWIB', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_403_1758728992884_a0wytx.jpg', '2025-08-18 22:26:07', '2025-09-24 15:49:54', NULL),
(404, 1, 'NAMUSUUBO', 'SHAHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_404_1759410548390_7fs4dj.jpg', '2025-08-18 22:27:53', '2025-10-02 13:09:08', NULL),
(405, 1, 'TIBWABYA', 'RASHIDAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_405_1758728933701_sxnfzq.jpg', '2025-08-18 22:29:06', '2025-09-24 15:48:54', NULL),
(406, 1, 'LUWANGULA', 'JUMA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_406_1759410689978_zp2pr0.jpg', '2025-08-18 22:32:03', '2025-10-02 13:11:48', NULL),
(407, 1, 'NABIRYO', 'FAQIHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_407_1758728474681_dogbhi.jpg', '2025-08-18 22:33:08', '2025-09-24 15:41:15', NULL),
(408, 1, 'NAMPALA', 'SHURAIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_408_1758728733241_3janik.jpg', '2025-08-18 22:34:01', '2025-09-24 15:45:33', NULL),
(409, 1, 'WALUSANSA', 'ISA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_409_1759250787559_zbhs0v.jpg', '2025-08-18 22:34:49', '2025-09-30 16:58:42', NULL),
(410, 1, 'MUSISI', 'RAMISH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:35:36', NULL, NULL),
(411, 1, 'HINDU', 'ABDULLAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_411_1758731238439_6i6qy9.jpg', '2025-08-18 22:36:20', '2025-09-30 16:50:54', NULL),
(412, 1, 'ZAINAB', 'ABDULLAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_412_1758729023978_hdy4dd.jpg', '2025-08-18 22:38:18', '2025-09-24 15:50:24', NULL),
(413, 1, 'MUKOSE', 'AHMED', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_413_1758728378377_w3ikzn.jpg', '2025-08-18 22:40:34', '2025-09-24 15:39:39', NULL),
(414, 1, 'KYONJO', 'MUSA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_414_1758728094383_ee780h.jpg', '2025-08-18 22:41:41', '2025-09-30 16:52:39', NULL),
(415, 1, 'KIYIMBA', 'RAYAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_415_1759250780832_lwzhrc.jpg', '2025-08-18 22:42:29', '2025-09-30 16:48:45', NULL),
(416, 1, 'KULUTUBI', 'GAMUSI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_416_1759250863366_xfzb6g.jpg', '2025-08-18 22:43:37', '2025-09-30 16:49:02', NULL),
(417, 1, 'NAKIDOODO', 'SULTANA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_417_1758728543507_fhf8j1.jpg', '2025-08-18 22:44:52', '2025-09-24 15:42:24', NULL),
(418, 1, 'SADALA', 'ISA  GASEMBA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_418_1759250784012_f698kx.jpg', '2025-08-18 22:45:56', '2025-09-30 16:56:26', NULL),
(419, 1, 'DIDI', 'HUSSEIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_419_1758727912070_qcklx2.jpg', '2025-08-18 22:46:58', '2025-09-30 16:50:15', NULL),
(420, 1, 'NOWAL', 'ABDULLAH', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_420_1758731021402_9a9b4r.jpg', '2025-08-18 22:47:47', '2025-09-24 16:23:42', NULL),
(421, 1, 'NANDEGHO', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_421_1758728778482_m9la4t.jpg', '2025-08-18 22:48:39', '2025-09-24 15:46:19', NULL),
(422, 1, 'KIBUYE', 'ABUTHAARI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_422_1759249753924_rcvztd.jpg', '2025-08-18 22:49:40', '2025-09-30 16:29:41', NULL),
(423, 1, 'SIKYAGATEMA', 'KAUTHARA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_423_1758730961006_xm5pkq.jpg', '2025-08-18 22:50:37', '2025-09-30 16:57:45', NULL),
(424, 1, 'ISMAEL', 'AZED', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_424_1759410661539_4taejc.jpg', '2025-08-18 22:51:23', '2025-10-02 13:11:01', NULL),
(425, 1, 'HAMISI', 'MUGOYA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_425_1759250771209_rurj13.jpg', '2025-08-18 22:52:13', '2025-09-30 16:51:14', NULL),
(426, 1, 'MUGOYA', 'ABDULLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:53:04', NULL, NULL),
(427, 1, 'TAGEJJA', 'TAKIYYU', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_427_1758728899350_zrxr60.jpg', '2025-08-18 22:54:07', '2025-09-30 16:58:21', NULL),
(428, 1, 'SEMAKULA', 'RAJASHI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:55:04', NULL, NULL),
(429, 1, 'SSENYOGA', 'ABDALLAH  RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 22:56:06', NULL, NULL),
(430, 1, 'KISUYI', 'ABDUL-RAHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_430_1758728062770_kkt7f9.jpg', '2025-08-18 22:56:55', '2025-09-24 15:34:23', NULL),
(431, 1, 'SSENOGA', 'MUNFIQ', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_431_1758728849148_afdzet.jpg', '2025-08-18 22:58:07', '2025-09-24 15:47:30', NULL),
(432, 1, 'BIWEMBA', 'RAJAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_432_1758731178206_kiqldo.jpg', '2025-08-18 22:59:07', '2025-09-30 16:49:52', NULL),
(433, 1, 'JALIRUDEEN', 'ASIMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_433_1758728017130_te9n67.jpg', '2025-08-18 23:00:05', '2025-09-30 16:51:43', NULL),
(434, 1, 'RAUDHAH', 'ZZIWA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_434_1758728809468_3w0zf5.jpg', '2025-08-18 23:00:47', '2025-09-24 15:46:50', NULL),
(435, 1, 'IHLAM', 'ISMAEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_435_1758727942005_685vki.jpg', '2025-08-18 23:01:44', '2025-09-24 15:32:23', NULL),
(436, 1, 'NAMATA', 'MUNTAHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_436_1758728667004_tfu4ll.jpg', '2025-08-18 23:02:39', '2025-09-24 15:44:28', NULL),
(437, 1, 'NAKIMBUGWE', 'HANIFA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_437_1758728573423_rbb894.jpg', '2025-08-18 23:03:39', '2025-09-24 15:42:54', NULL),
(438, 1, 'NAMBOGWE', 'AISHA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_438_1758728700520_d5s9fk.jpg', '2025-08-18 23:04:42', '2025-09-24 15:45:01', NULL),
(439, 1, 'MWOGEZA', 'ASHRAF', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:05:29', NULL, NULL),
(440, 1, 'MASTULA', 'MARIAM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_440_1758728187555_qbckvi.jpg', '2025-08-18 23:06:25', '2025-09-30 16:53:09', NULL),
(441, 1, 'AMASE', 'NUSFAT', '', 'female', '0000-00-00', '', '', '', '', '2025-08-18 23:07:18', '2025-09-24 11:06:15', NULL),
(442, 1, 'MAGEZI', 'SHAFIQ', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_442_1758728146413_batk16.jpg', '2025-08-18 23:08:07', '2025-09-30 16:52:55', NULL),
(443, 1, 'NATABI', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_443_1759250760561_n6095e.jpg', '2025-08-18 23:08:58', '2025-09-30 16:57:18', NULL),
(444, 1, 'NAKINYANZI', 'MARIAM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_444_1758728611038_34vi3q.jpg', '2025-08-18 23:10:04', '2025-09-24 15:43:32', NULL),
(445, 1, 'MATSAD', 'HAITHAM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_445_1758728256258_52im4v.jpg', '2025-08-18 23:11:12', '2025-09-24 15:37:48', NULL),
(446, 1, 'NGOOBI', 'HAARITH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_446_1759250774427_c1trng.jpg', '2025-08-18 23:11:58', '2025-09-30 16:56:41', NULL),
(447, 1, 'MUSINGO', 'FIRDAUS', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_447_1758731078928_3mbtr9.jpg', '2025-08-18 23:12:46', '2025-09-24 16:24:39', NULL),
(448, 1, 'UKASHA', 'RAMADHAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_448_1758728965886_qmajfy.jpg', '2025-08-18 23:13:29', '2025-09-24 15:49:26', NULL),
(449, 1, 'KAMBA', 'NASSER  DUMBA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:14:25', NULL, NULL),
(450, 1, 'KHAIRAT', 'ABDALLAH  NANKISA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:15:14', NULL, NULL),
(451, 1, 'NABILYE', 'ZAINAB', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:15:59', NULL, NULL),
(452, 1, 'ZULFA', 'ABDALLAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:16:50', NULL, NULL),
(453, 1, 'MUKISA', 'RASHID', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_453_1758728327641_zhi3hb.jpg', '2025-08-18 23:17:39', '2025-09-24 15:38:59', NULL),
(454, 1, 'KIZITO', 'UKASHA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-18 23:18:25', NULL, NULL),
(458, NULL, 'NAMWASE', 'SWALIHAT', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_458_1758761605393_dbrw7q.jpg', '2025-08-19 00:24:52', '2025-09-25 00:53:25', NULL),
(459, NULL, 'NAMWASE', 'SWALIHAT', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:25:35', NULL, NULL),
(460, NULL, 'HASSAN', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_460_1759783863786_ohu7g5.jpg', '2025-08-19 00:42:51', '2025-10-06 20:51:03', NULL),
(461, NULL, 'IDRIS', 'NKOOBE', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_461_1758733170635_2tlwda.jpg', '2025-08-19 01:09:57', '2025-09-24 16:59:31', NULL),
(462, NULL, 'MUWAYA', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_462_1758731470010_61ep9k.jpg', '2025-08-19 02:02:30', '2025-09-24 16:31:10', NULL),
(463, NULL, 'MUWAYA', 'ABUBAKAR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:02:35', NULL, NULL),
(464, 1, 'MATOVU', 'NASSER', '', 'Male', '2000-03-14', '+256789554049', 'Luyiganasser@gmail.com', '', '', '2025-08-19 02:05:00', NULL, NULL),
(465, 1, 'MATOVU', 'NASSER', '', 'Male', '2000-03-14', '+256789554049', 'Luyiganasser@gmail.com', '', '', '2025-08-19 02:05:01', NULL, NULL),
(466, NULL, 'GASEMBA', 'ABDALLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:25:37', NULL, NULL),
(467, NULL, 'GASEMBA', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_467_1760039434686_ybl2re.jpg', '2025-08-19 03:25:42', '2025-10-09 19:50:34', NULL),
(468, NULL, 'GASEMBA', 'ABDALLAH', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:25:51', NULL, NULL),
(469, NULL, 'IWUMBWE', 'FARAHAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_469_1759783866833_364fpc.jpg', '2025-08-19 03:28:29', '2025-10-06 20:51:06', NULL),
(470, NULL, 'ABDUL-MUTWALIB', 'GUUYA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_470_1760039632739_2uqie4.jpg', '2025-08-19 03:30:15', '2025-10-09 19:53:52', NULL),
(471, NULL, 'ISA', 'MUSOBYA', 'KIIZA', 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:32:40', NULL, NULL),
(472, NULL, 'ISA', 'MUSOBYA KIIZA', 'KIIZA', 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_472_1760039446552_ow88aq.jpg', '2025-08-19 03:35:43', '2025-10-09 19:50:46', NULL),
(473, NULL, 'KINTU', 'NAJIB', '', 'male', '0000-00-00', '', '', '', '', '2025-08-19 03:36:56', '2025-10-02 10:38:42', NULL),
(474, NULL, 'KABAALE', 'HAJJI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:38:54', NULL, NULL),
(475, NULL, 'MUTESI', 'RANIA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_475_1758761798872_011r2l.jpg', '2025-08-19 03:40:05', '2025-09-25 00:56:38', NULL),
(476, NULL, 'NANKISANDA', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_476_1758761611828_gicsyk.jpg', '2025-08-19 03:41:02', '2025-09-25 00:53:31', NULL),
(477, NULL, 'IBRAHIIM', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_477_1760039420176_77qcb5.jpg', '2025-08-19 03:42:32', '2025-10-09 19:50:20', NULL),
(478, NULL, 'KONGOLA', 'SULAIMAN  SABAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:43:49', NULL, NULL),
(479, NULL, 'ABDUL-RAZAK', 'AHMED', '', 'male', '0000-00-00', '', '', '', '', '2025-08-19 03:44:41', '2025-10-02 10:33:54', NULL),
(480, NULL, 'NANGOBI', 'RAUDHAT', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_480_1758761365667_r6lpj5.jpg', '2025-08-19 03:45:43', '2025-09-25 00:49:25', NULL),
(481, NULL, 'GASEMBA', 'ALI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_481_1760039429021_poolld.jpg', '2025-08-19 03:46:33', '2025-10-09 19:50:29', NULL),
(482, NULL, 'TALKAZA', 'INAAYA  SALIM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_482_1758761635334_yalw1e.jpg', '2025-08-19 03:47:27', '2025-09-25 00:53:55', NULL),
(483, NULL, 'SENGENDO', 'FAIZAL', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:49:53', NULL, NULL),
(484, NULL, 'LWANGA', 'BANULI', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:51:01', NULL, NULL),
(485, NULL, 'KASADHA', 'FAJIRDIIN FAHMAI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_485_1760039440182_d81yv3.jpg', '2025-08-19 03:53:25', '2025-10-09 19:50:40', NULL),
(486, NULL, 'ABDUL-BASIT', 'UKASHA', '', 'male', '0000-00-00', '', '', '', '', '2025-08-19 03:54:27', '2025-09-30 17:12:34', NULL),
(487, NULL, 'NANGOBI', 'HANAD  RASHAK', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:55:21', NULL, NULL),
(488, NULL, 'SSEMBATYA', 'ABDUL-RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_488_1759783881605_xr62cf.jpg', '2025-08-19 03:56:40', '2025-10-06 20:51:21', NULL),
(489, NULL, 'SSONZI', 'HARUNA', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_489_1759783884696_mmjsg9.jpg', '2025-08-19 03:57:52', '2025-10-06 20:51:24', NULL),
(490, NULL, 'NINSIIMA', 'MARIAM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_490_1758761804422_0wr3zg.jpg', '2025-08-19 03:58:53', '2025-09-25 01:01:57', NULL),
(491, NULL, 'NINSIIMA', 'MARIAM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:59:02', NULL, NULL),
(492, NULL, 'NINSIIMA', 'MARIAM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:59:36', NULL, NULL),
(493, NULL, 'NTONGO', 'MARIAM  ABDALLAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_493_1758761398276_a8jk25.jpg', '2025-08-19 04:01:28', '2025-09-25 00:49:58', NULL),
(494, NULL, 'ISOTA', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_494_1758733207297_3dwro2.jpg', '2025-08-19 04:02:25', '2025-09-24 17:00:07', NULL),
(495, NULL, 'MUTEBI', 'FARHAN', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_495_1759783860473_z84uqf.jpg', '2025-08-19 04:03:53', '2025-10-06 20:51:00', NULL),
(496, NULL, 'UKASHA', 'WANDERA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_496_1758732620843_8b1y54.jpg', '2025-08-19 04:05:15', '2025-09-30 17:12:01', NULL),
(497, NULL, 'MAGANDA', 'MUHSIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_497_1759783876507_084drl.jpg', '2025-08-19 04:06:00', '2025-10-06 20:51:16', NULL),
(498, NULL, 'NAMAKIKA', 'RAHMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_498_1758759489593_ladpch.jpg', '2025-08-19 04:06:47', '2025-09-25 00:18:09', NULL),
(499, NULL, 'NDYEKU', 'JABELI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_499_1758731387220_mkxd36.jpg', '2025-08-19 04:07:38', '2025-09-24 16:29:48', NULL),
(500, NULL, 'MUHUMUZA', 'BASHIIR', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 04:08:22', NULL, NULL),
(501, NULL, 'KIRABIRA', 'MAHAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_501_1758733005762_84l516.jpg', '2025-08-19 04:09:13', '2025-09-24 16:56:46', NULL),
(502, NULL, 'NALO', 'IBRAHIIM   MUHAMMAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_502_1758731425454_cyq1c3.jpg', '2025-08-19 04:09:59', '2025-09-24 16:30:26', NULL),
(503, NULL, 'RAYAN', 'ABDUL-KARIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_503_1758731511933_yd5wf9.jpg', '2025-08-19 04:10:49', '2025-09-24 16:31:52', NULL),
(504, NULL, 'ONANYANGO', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_504_1758741628457_rrvjwv.jpg', '2025-08-19 04:11:35', '2025-09-24 19:20:29', NULL),
(505, NULL, 'MUDOOLA', 'SAID', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_505_1759783878513_gjgd3i.jpg', '2025-08-19 04:12:31', '2025-10-06 20:51:18', NULL),
(506, NULL, 'NAKALEMA', 'AISHA', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_506_1758761584068_xzn2q8.jpg', '2025-08-19 04:13:20', '2025-09-25 00:53:04', NULL),
(507, NULL, 'AYEMBE', 'YAHAYA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_507_1758732502491_h5dpnu.jpg', '2025-08-19 04:14:05', '2025-09-24 16:50:11', NULL),
(508, NULL, 'ABDUL QAHALU', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_508_1758732463726_svv7wf.jpg', '2025-08-19 04:14:55', '2025-10-02 10:54:28', NULL),
(509, NULL, 'ABDUL-RAHMAN  MUSA', 'ISA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_509_1758741147587_roegoh.jpg', '2025-08-19 04:15:52', '2025-09-24 19:12:29', NULL),
(510, NULL, 'RAHMAH', 'JALIRUDIIN', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_510_1758761598084_t51za4.jpg', '2025-08-19 04:16:41', '2025-09-25 00:53:18', NULL),
(511, NULL, 'DHABULIWO', 'HASHIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_511_1758732769284_7rryfj.jpg', '2025-08-19 04:17:23', '2025-10-17 22:02:26', NULL),
(512, NULL, 'BASHIIRAH', 'UTHMAN', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_512_1758762229464_lolkem.jpg', '2025-08-19 04:18:40', '2025-09-25 01:04:22', NULL),
(513, NULL, 'ABDUL-WAHAB', 'MUHSIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_513_1760039433637_b9pe01.jpg', '2025-08-19 04:19:39', '2025-10-09 19:55:24', NULL),
(514, NULL, 'YOUSEF', 'AL-MUSALAMY', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_514_1758732616841_q0ndgh.jpg', '2025-08-19 04:20:44', '2025-09-24 16:50:16', NULL),
(515, NULL, 'KAKOOZA', 'ISMAEL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_515_1758731249661_p3lmuc.jpg', '2025-08-19 04:21:38', '2025-09-24 16:27:45', NULL),
(516, NULL, 'KIYAGA', 'RAUF', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_516_1758731291516_wiiu2h.jpg', '2025-08-19 04:22:24', '2025-09-24 16:28:12', NULL),
(517, NULL, 'MPATA', 'IDRISS', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_517_1758762379306_v146cf.jpg', '2025-08-19 04:23:05', '2025-09-25 01:06:33', NULL),
(518, NULL, 'TUSIIME', 'ZAINAB', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_518_1758761749320_a8pbg7.jpg', '2025-08-19 04:24:12', '2025-09-25 00:55:50', NULL),
(519, NULL, 'MONDO', 'SHAKUL', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_519_1758733046257_096q6q.jpg', '2025-08-19 04:24:56', '2025-09-24 16:57:27', NULL),
(520, NULL, 'NANTEZA', 'SWABURA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_520_1758761379298_gb7nge.jpg', '2025-08-19 04:25:50', '2025-09-25 00:49:39', NULL),
(521, NULL, 'GOOBI', 'KHIDHIR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_521_1758732612887_8hu1kt.jpg', '2025-08-19 04:27:09', '2025-09-24 16:50:12', NULL),
(522, NULL, 'MAGANDA', 'BADIRUDIIN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_522_1759783873606_yhg391.jpg', '2025-08-19 04:27:56', '2025-10-06 20:51:13', NULL),
(523, NULL, 'KIIRYA', 'JUMA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_523_1758731324675_7scoio.jpg', '2025-08-19 04:28:45', '2025-09-24 16:28:45', NULL),
(524, NULL, 'KALINISE', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_524_1759783869817_tef9yk.jpg', '2025-08-19 04:30:01', '2025-10-06 20:51:09', NULL),
(525, NULL, 'MUKISA', 'RAHIM', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_525_1760039449744_00r2mh.jpg', '2025-08-19 04:30:48', '2025-10-09 19:50:49', NULL),
(526, NULL, 'FALUWA  BINT', 'YUSUF', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_526_1758761619332_wxa6fe.jpg', '2025-08-19 04:32:44', '2025-09-25 00:53:39', NULL),
(527, NULL, 'NANGOBI', 'SHAFUKA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_527_1758770547636_8o9p2h.jpg', '2025-08-19 04:35:30', '2025-10-17 23:52:34', NULL),
(528, NULL, 'NAKISUUYI', 'ASMA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_528_1758770524799_heg62u.jpg', '2025-08-19 04:36:13', '2025-09-25 03:50:31', NULL),
(529, NULL, 'HUDA', 'MUBARAK', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_529_1758769810394_xw5z4h.jpg', '2025-08-19 04:36:52', '2025-09-25 03:44:41', NULL),
(530, NULL, 'NAKUNGU', 'MARIAM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_530_1758770537911_a0rnsc.jpg', '2025-08-19 04:37:36', '2025-09-25 03:50:43', NULL),
(531, NULL, 'GULUME', 'HAMZAH', '', 'male', '0000-00-00', '', '', '', '', '2025-08-19 04:38:17', '2025-09-25 04:30:28', NULL),
(532, NULL, 'SABANO', 'FARIIDA  MODONDO', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_532_1758770572139_jmv8zt.jpg', '2025-08-19 04:39:39', '2025-09-25 03:52:17', NULL),
(533, NULL, 'NABULUMBA', 'NAHIYAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_533_1758770144581_mr80w3.jpg', '2025-08-19 04:40:59', '2025-10-17 23:51:14', NULL),
(534, NULL, 'ABDUL-KARIIM', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_534_1758774573205_ivuwv7.jpg', '2025-08-19 04:41:49', '2025-09-25 04:29:51', NULL),
(535, NULL, 'MATEEKA', 'SHURAIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_535_1758731742456_79xxix.jpg', '2025-08-19 04:42:48', '2025-09-24 16:35:43', NULL),
(536, NULL, 'NAWEMBA', 'SINAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_536_1759406861779_3ulj2s.jpg', '2025-08-19 04:43:40', '2025-10-02 12:08:25', NULL),
(537, NULL, 'SHAINAH', 'MUSASIZI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_537_1758770586656_0p0m43.jpg', '2025-08-19 04:44:28', '2025-09-25 03:52:29', NULL),
(538, NULL, 'AFEEFAH', 'MUSASIZI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_538_1758769802019_ezlra1.jpg', '2025-08-19 04:45:32', '2025-09-25 03:44:02', NULL),
(539, NULL, 'KAZIBA', 'ABDUL-RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_539_1758769819353_9ru650.jpg', '2025-08-19 04:47:13', '2025-09-25 03:46:06', NULL),
(540, NULL, 'KAUMA', 'SHATURAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 04:48:05', NULL, NULL),
(541, NULL, 'MUTESI', 'SUMAYA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_541_1758769837301_6pd3b2.jpg', '2025-08-19 04:49:11', '2025-09-25 03:49:23', NULL),
(542, NULL, 'ABDUL-HAIL', 'MUKUYE', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_542_1758772787463_0rnxfs.jpg', '2025-08-19 04:52:12', '2025-09-25 04:10:27', NULL),
(543, NULL, 'NAKALANZI', 'SOPHIE', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 04:57:57', NULL, NULL),
(544, NULL, 'KIJAMBU', 'MAITHARAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_544_1759406858864_tj5r3h.jpg', '2025-08-19 04:59:37', '2025-10-02 12:08:49', NULL),
(545, NULL, 'MUKASA', 'ABDUL-RAZAK', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_545_1758772080216_0yuavx.jpg', '2025-08-19 05:02:01', '2025-09-25 03:48:23', NULL),
(546, NULL, 'MUKASA', 'ABDUL-RAZAK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 05:02:12', NULL, NULL),
(547, NULL, 'MUMBEJJA', 'SHAMIRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 05:03:37', NULL, NULL),
(548, NULL, 'KAMYA', 'HAMIS', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_548_1758741776231_rxug6j.jpg', '2025-08-19 05:07:00', '2025-09-24 19:22:57', NULL),
(549, NULL, 'KYAZZE', 'IBRAHIIM', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_549_1758731634195_9fj6b4.jpg', '2025-08-19 05:07:52', '2025-09-24 16:33:55', NULL),
(550, NULL, 'MUNABA', 'HAJARA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_550_1758769827895_8fwrpt.jpg', '2025-08-19 05:09:41', '2025-09-25 03:49:07', NULL),
(551, NULL, 'MUDOOLA', 'RAYAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_551_1758731801655_7gt65c.jpg', '2025-08-19 05:10:52', '2025-09-24 16:36:42', NULL),
(552, NULL, 'NSUBUGA', 'ARAFAT', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_552_1758770561134_z2zks2.jpg', '2025-08-19 05:11:39', '2025-09-25 03:52:03', NULL),
(553, NULL, 'NAMBALILWA', 'SHIFRAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_553_1758770188043_70r6os.jpg', '2025-08-19 05:12:42', '2025-09-25 03:51:20', NULL),
(554, NULL, 'UMMUSULAIMU', 'KANTONO', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_554_1758770611536_yewckh.jpg', '2025-08-19 05:14:13', '2025-10-17 23:51:48', NULL),
(555, NULL, 'CHRITIAN', 'SHADRAK', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 05:15:33', NULL, NULL),
(556, NULL, 'MAGANDA', 'MUSTAFA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_556_1758731664411_fs7x4u.jpg', '2025-08-19 05:16:21', '2025-09-24 16:34:53', NULL),
(557, NULL, 'UTHMAN', 'MUKASA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_557_1758773012973_x641gf.jpg', '2025-08-19 05:17:09', '2025-09-25 04:07:03', NULL),
(558, NULL, 'MAGANDA', 'MUSTAFA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 05:18:31', NULL, NULL),
(559, NULL, 'AUZAA-E', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_559_1758731573123_0cot6h.jpg', '2025-08-19 05:19:28', '2025-09-24 16:32:54', NULL),
(560, NULL, 'MAYENGO', 'ABDUL-RAHMAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_560_1758731768509_fovq8g.jpg', '2025-08-19 05:20:27', '2025-09-24 16:36:09', NULL),
(561, NULL, 'DHABULIWO', 'SHAFIK', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_561_1758731602422_fhzzkg.jpg', '2025-08-19 05:21:33', '2025-09-24 16:33:23', NULL),
(562, NULL, 'NAMATENDE', 'MWASIT', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_562_1758770176209_ssy26y.jpg', '2025-08-19 05:25:42', '2025-09-25 03:51:08', NULL),
(563, NULL, 'ZIYANA', 'BINT  RAMADHAN  WANYANZE', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_563_1758770598618_mf3xzj.jpg', '2025-08-19 05:27:38', '2025-09-25 03:53:19', NULL),
(564, NULL, 'SSENYOJO', 'ABDALLAH', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_564_1758773006574_32xwtw.jpg', '2025-08-19 05:28:44', '2025-09-25 04:07:24', NULL),
(565, NULL, 'NTAMBI', 'IMRAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_565_1758773207378_0mp31t.jpg', '2025-08-19 05:29:46', '2025-09-25 04:07:55', NULL),
(566, NULL, 'SOPHIA', 'MUTESI', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_566_1758770830564_2voimi.jpg', '2025-08-19 05:30:50', '2025-09-25 03:52:43', NULL),
(567, NULL, 'ASMAH', 'NANTONGO', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_567_1759793545225_h37fq8.jpg', '2025-08-19 05:31:48', '2025-10-06 23:32:25', NULL),
(568, NULL, 'NAMUGABO', 'JAUHARAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_568_1758770198777_gegdfk.jpg', '2025-08-19 05:32:45', '2025-10-17 23:49:32', NULL),
(569, NULL, 'NABUNYA', 'MARIAM', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_569_1758770155443_9xiicb.jpg', '2025-08-19 05:33:31', '2025-09-25 03:50:02', NULL),
(570, NULL, 'MUYINDA', 'BADRDEEN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_570_1758770132691_z8ydtl.jpg', '2025-08-19 05:34:25', '2025-09-25 04:32:10', NULL),
(571, NULL, 'ABAS', 'JUMA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_571_1758769792258_lk6lxh.jpg', '2025-08-19 05:35:24', '2025-09-25 03:43:47', NULL),
(572, NULL, 'naser', 'kawa', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:20:53', NULL, NULL),
(573, NULL, 'AKSAM', 'NGAYIRE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:45:15', NULL, NULL),
(574, NULL, 'AKSAM', 'NGAYIRE', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:01:30', NULL, NULL),
(575, NULL, 'CLOCK', 'ROSHAN', '', 'M', '0000-00-00', '', '', '', '/uploads/students/person_575_1760741866201_wbdm1q.jpg', '2025-08-19 04:11:12', '2025-10-17 22:57:46', NULL),
(576, NULL, 'AKSAM', 'NGAYIRE LUGOMWA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_576_1760040036182_yccyzn.jpg', '2025-08-19 04:15:52', '2025-10-09 20:00:36', NULL),
(577, NULL, 'JAMADAH', 'BAKAKI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_577_1759408246415_9xgwrq.jpg', '2025-08-19 07:10:09', '2025-10-02 12:51:29', NULL),
(578, NULL, 'KHAIRAT ABDALLAH', 'NANKISA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:23:52', NULL, NULL),
(579, NULL, 'KHAIRAT ABDALLAH', 'NANKISA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_579_1759250757086_wtfb4c.jpg', '2025-08-19 07:26:57', '2025-09-30 16:52:04', NULL),
(580, NULL, 'NABILYE', 'ZAINAB', '', 'F', '0000-00-00', '', '', '', '/uploads/students/person_580_1758731126125_qsllt6.jpg', '2025-08-19 07:27:37', '2025-09-24 16:25:26', NULL),
(581, NULL, 'KIBUDE', 'IMRAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:34:17', NULL, NULL),
(582, NULL, 'KIBUDE', 'IMRAN', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_582_1758762506016_ne6ugh.jpg', '2025-08-19 07:36:11', '2025-09-25 01:08:40', NULL),
(583, NULL, 'WAIRA', 'ARYAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:36:48', NULL, NULL),
(584, NULL, 'ALIYYU', 'ABUBAKAR', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_584_1758732732227_5hei6l.jpg', '2025-08-19 07:37:30', '2025-09-24 16:52:13', NULL),
(585, NULL, 'MUMBEJJA', 'SOPHIA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:38:10', NULL, NULL),
(586, NULL, 'NUHA', 'BASEF', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_586_1758761385512_pfaoku.jpg', '2025-08-19 07:38:49', '2025-09-25 00:49:45', NULL),
(587, NULL, 'FRAIHA', 'BINT MUHAMMAD', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:39:29', NULL, NULL),
(588, NULL, 'SHADAD', 'TILIBUZA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:49:29', NULL, NULL),
(589, NULL, 'MARIAM', 'NAKAZIBA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-08-19 11:39:42', NULL, NULL),
(590, NULL, 'FRAIHA', 'BINT MUHAMMAD', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_590_1760039425700_b8n0mz.jpg', '2025-08-19 12:01:11', '2025-10-09 19:50:25', NULL),
(591, NULL, 'TILIBUZA', 'SHADAD', '', 'male', '0000-00-00', '', '', '', '/uploads/students/person_591_1759292467751_ik6i1m.jpg', '2025-08-19 12:24:11', '2025-10-01 04:21:07', NULL),
(592, NULL, 'TILIBUZA', 'SHADAD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 12:24:23', NULL, NULL),
(593, NULL, 'ABDUL RAZAK', 'AHMED', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-08-19 06:49:52', NULL, NULL),
(595, NULL, 'NASSIM', 'ARAFAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_595_1758731288841_opcul7.jpg', '2025-08-19 10:52:10', '2025-09-24 16:28:09', NULL),
(596, NULL, 'mudaa', 'asma', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:09:15', NULL, NULL),
(597, NULL, 'AALYAH', 'HAMZA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:20:47', NULL, NULL),
(598, NULL, 'NAKABAMBWE', 'SUMMAYAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_598_1759251340403_ycur6b.jpg', '2025-09-24 17:42:38', '2025-09-30 16:55:41', NULL),
(599, NULL, 'BAKAKI', 'HASHIM', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:46:52', NULL, NULL),
(600, NULL, 'KYAKUTEMA', 'HADIJJA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:47:55', NULL, NULL),
(601, NULL, 'HAMDAN', 'TASNEEM', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:49:24', NULL, NULL),
(602, NULL, 'HAWA', 'HASSAN', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:50:22', NULL, NULL),
(603, NULL, 'MUNIRA', 'BASEFF', '', 'female', '0000-00-00', '', '', '', '', '2025-09-24 11:54:11', '2025-09-24 11:55:44', NULL),
(604, NULL, 'NAKABAMBWE', 'RAHUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:56:52', NULL, NULL),
(605, NULL, 'ZULFA', 'ABDALLAH', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_605_1758726128818_gj61lj.jpg', '2025-09-24 15:00:47', '2025-09-24 16:30:13', NULL),
(607, NULL, 'NADIA', 'MASITULA HITLA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_607_1758770165452_nvwmah.jpg', '2025-09-24 18:39:54', '2025-10-17 23:50:10', NULL),
(608, NULL, 'MADINAH', 'NAMUZUNGU', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_608_1758761392244_90h52m.jpg', '2025-09-24 18:41:24', '2025-09-25 00:49:52', NULL),
(609, NULL, 'NANJIYA', 'TAUBAH TAIBU', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_609_1758761946820_dkrhvs.jpg', '2025-09-24 23:51:18', '2025-09-25 00:59:21', NULL),
(610, NULL, 'SHUKRAN', 'SSEMAKULA', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_610_1760020949639_bciwuz.jpg', '2025-10-01 01:08:01', '2025-10-09 14:42:30', NULL),
(611, NULL, 'AAYAT', 'UTHMAN', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_611_1760020942546_6bjtc5.jpg', '2025-10-01 05:26:52', '2025-10-09 14:42:23', NULL),
(612, NULL, 'MASOLO', 'RASHID', '', 'male', '0000-00-00', '', '', '', '/uploads/students/1759793020602-Masolo.jpg', '2025-10-06 23:23:40', '2025-10-06 23:24:22', NULL),
(613, NULL, 'KIRUNDA', 'UKASHA', '', 'male', '0000-00-00', '', '', '', '/uploads/students/1759793136755-Kirunda ukasha.jpg', '2025-10-06 23:25:36', '2025-10-06 23:27:51', NULL),
(614, NULL, 'MUSENE', 'HAFIDHI', '', 'male', '0000-00-00', '', '', '', '/uploads/students/1759793189845-Musene.jpg', '2025-10-06 23:26:29', '2025-10-06 23:27:13', NULL),
(615, NULL, 'NAKATO', 'SHFRAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_615_1760743046255_kjrvie.jpg', '2025-10-09 23:49:00', '2025-10-17 23:17:26', NULL),
(616, NULL, 'REGEAH', 'SHARIF', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_616_1760743164472_dvn7pn.jpg', '2025-10-09 23:50:14', '2025-10-17 23:19:34', NULL),
(617, NULL, 'SHARIFA', 'ABDUL HAMID', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:51:18', NULL, NULL),
(618, NULL, 'SSEWANYANA', 'ABDUL RAHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:52:38', NULL, NULL),
(619, NULL, 'HUSNAH', 'UTHMAN', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_619_1760741872334_twgz1g.jpg', '2025-10-09 23:53:23', '2025-10-17 23:00:27', NULL),
(620, NULL, 'HUSNAH', 'UTHMAN', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:53:34', NULL, NULL),
(621, NULL, 'ABDUL KARIM', 'ABDALLAH', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:54:28', NULL, NULL),
(622, NULL, 'ABDUL RAHMAN YUSUFU', 'DIDI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:55:19', NULL, NULL),
(623, NULL, 'KATO', 'AAHIL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:56:00', NULL, NULL),
(624, NULL, 'KYORABA', 'FATUMAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_624_1761172802746_nk4els.jpg', '2025-10-17 14:38:37', '2025-10-22 22:40:02', NULL),
(625, NULL, 'NAMUKWAYA', 'RANIAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-17 14:39:12', NULL, NULL),
(626, NULL, 'NAMWASE', 'SHUKRAN', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_626_1761173544341_9o4jlm.jpg', '2025-10-17 14:40:05', '2025-10-22 22:52:24', NULL),
(627, NULL, 'RUKAYYA', 'SSEBADUKA ABAS', '', 'female', '0000-00-00', '', '', '', '/uploads/students/person_627_1761173567873_olkckz.jpg', '2025-10-17 14:40:46', '2025-10-22 22:54:00', NULL),
(628, NULL, 'NANGIYA', 'SHAMIRAH', NULL, 'F', NULL, NULL, NULL, NULL, '/uploads/students/person_628_1761174351024_5cw87e.jpg', '2025-10-17 15:38:57', '2025-10-22 23:05:51', NULL),
(629, NULL, 'NANGIYA', 'SHAMIRAH', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-17 15:39:00', NULL, NULL),
(630, NULL, 'YUSUF FAUZAN', 'DIDI', NULL, 'M', NULL, NULL, NULL, NULL, '/uploads/students/person_630_1761174286229_s0fdfu.jpg', '2025-10-17 15:40:09', '2025-10-22 23:04:46', NULL),
(631, NULL, 'NAMUGANZA', 'FATUMA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-17 17:38:41', NULL, NULL),
(632, NULL, 'NAMUWAYA', 'AMINA', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:14:01', NULL, NULL),
(633, NULL, 'ZAINAB', 'BINT ISMAEL', NULL, 'F', NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:15:22', NULL, NULL);
INSERT INTO `people` (`id`, `school_id`, `first_name`, `last_name`, `other_name`, `gender`, `date_of_birth`, `phone`, `email`, `address`, `photo_url`, `created_at`, `updated_at`, `deleted_at`) VALUES
(634, NULL, 'MWANJA', 'UTHMAN', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:56:45', NULL, NULL),
(635, NULL, 'ABUBAKAR', 'MAGANDA', NULL, 'M', NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:57:42', NULL, NULL);

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
  `deadline` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `result_types`
--

INSERT INTO `result_types` (`id`, `school_id`, `name`, `code`, `description`, `weight`, `deadline`, `status`, `created_at`, `updated_at`) VALUES
(2, 1, 'mid term', 'MOT', NULL, 40.00, '2025-10-25 11:41:00', 'active', '2025-10-02 11:41:29', NULL),
(5, 1, 'END OF TERM', 'EOT', NULL, 60.00, NULL, 'active', '2025-10-22 22:25:50', NULL);

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

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `school_id`, `person_id`, `staff_no`, `position`, `hire_date`, `status`) VALUES
(1, 1, 464, '1', 'ICT TEACHER', '2025-08-19', 'active');

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
(1, 1, 1, NULL, NULL, '2025/0001', NULL, '2025-08-18', 'active', NULL, '2025-08-18 07:43:48', NULL, '2025-08-19 00:20:02'),
(2, 1, 2, NULL, NULL, '2025/0002', NULL, '2025-08-18', 'active', NULL, '2025-08-18 07:11:19', '2025-09-25 00:20:24', NULL),
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
(47, 1, 47, NULL, NULL, '2025/0047', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:40:22', '2025-09-24 12:23:44', NULL),
(48, 1, 48, NULL, NULL, '2025/0048', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:27:59', '2025-09-24 12:23:25', NULL),
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
(66, 1, 66, NULL, NULL, '2025/0066', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:34:36', '2025-09-25 05:02:42', NULL),
(67, 1, 67, NULL, NULL, '2025/0067', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:36:31', NULL, NULL),
(68, 1, 68, NULL, NULL, '2025/0068', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:37:12', NULL, NULL),
(69, 1, 69, NULL, NULL, '2025/0069', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:37:47', NULL, NULL),
(70, 1, 70, NULL, NULL, '2025/0070', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:42:28', NULL, NULL),
(71, 1, 71, NULL, NULL, '2025/0071', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:43:05', NULL, NULL),
(72, 1, 72, NULL, NULL, '2025/0072', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:44:23', NULL, NULL),
(73, 1, 73, NULL, NULL, '2025/0073', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:45:53', NULL, NULL),
(74, 1, 74, NULL, NULL, '2025/0074', NULL, '2025-08-18', 'active', NULL, '2025-08-18 09:46:32', '2025-10-17 19:07:11', NULL),
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
(100, 1, 100, NULL, NULL, '2025/0100', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:07:56', '2025-10-17 19:05:18', NULL),
(101, 1, 101, NULL, NULL, '2025/0101', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:09:11', '2025-10-22 23:07:40', NULL),
(102, 1, 102, NULL, NULL, '2025/0102', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:10:26', '2025-10-17 19:06:18', NULL),
(103, 1, 104, NULL, NULL, '2025/0103', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:11', NULL, NULL),
(104, 1, 105, NULL, NULL, '2025/0104', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:15:50', NULL, NULL),
(105, 1, 106, NULL, NULL, '2025/0105', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:16:26', NULL, NULL),
(106, 1, 107, NULL, NULL, '2025/0106', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:17:19', NULL, NULL),
(107, 1, 108, NULL, NULL, '2025/0107', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:18:20', NULL, NULL),
(108, 1, 109, NULL, NULL, '2025/0108', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:22:40', NULL, NULL),
(109, 1, 110, NULL, NULL, '2025/0109', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:24:13', NULL, NULL),
(110, 1, 111, NULL, NULL, '2025/0110', NULL, '2025-08-18', 'dropped_out', NULL, '2025-08-18 10:25:27', NULL, NULL),
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
(121, 1, 122, NULL, NULL, '2025/0121', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:34:39', '2025-10-22 23:08:14', NULL),
(122, 1, 123, NULL, NULL, '2025/0122', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:36:02', NULL, NULL),
(123, 1, 124, NULL, NULL, '2025/0123', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:36:44', NULL, NULL),
(124, 1, 125, NULL, NULL, '2025/0124', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:37:37', '2025-10-22 23:06:49', NULL),
(125, 1, 126, NULL, NULL, '2025/0125', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:38:55', NULL, NULL),
(126, 1, 127, NULL, NULL, '2025/0126', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:39:30', NULL, NULL),
(127, 1, 128, NULL, NULL, '2025/0127', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:42:23', '2025-09-30 19:41:28', NULL),
(128, 1, 129, NULL, NULL, '2025/0128', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:46:16', '2025-09-30 19:56:33', NULL),
(129, 1, 130, NULL, NULL, '2025/0129', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:47:38', '2025-09-30 19:56:45', NULL),
(130, 1, 131, NULL, NULL, '2025/0130', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:48:22', '2025-09-30 19:33:53', NULL),
(131, 1, 132, NULL, NULL, '2025/0131', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:49:08', '2025-09-30 19:49:49', NULL),
(132, 1, 133, NULL, NULL, '2025/0132', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:49:53', '2025-09-30 19:25:48', NULL),
(133, 1, 134, NULL, NULL, '2025/0133', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:50:40', '2025-09-30 19:50:32', NULL),
(134, 1, 135, NULL, NULL, '2025/0134', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:52:10', '2025-09-30 19:29:39', NULL),
(135, 1, 136, NULL, NULL, '2025/0135', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:53:02', '2025-09-30 19:47:59', NULL),
(136, 1, 137, NULL, NULL, '2025/0136', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:54:40', '2025-09-30 19:36:25', NULL),
(137, 1, 138, NULL, NULL, '2025/0137', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:55:58', '2025-09-30 19:41:04', NULL),
(138, 1, 139, NULL, NULL, '2025/0138', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:56:49', '2025-09-30 19:29:30', NULL),
(139, 1, 140, NULL, NULL, '2025/0139', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:58:47', '2025-09-30 19:24:55', NULL),
(140, 1, 141, NULL, NULL, '2025/0140', NULL, '2025-08-18', 'active', NULL, '2025-08-18 10:59:32', '2025-09-30 19:40:24', NULL),
(141, 1, 142, NULL, NULL, '2025/0141', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:00:24', '2025-09-30 19:48:11', NULL),
(142, 1, 143, NULL, NULL, '2025/0142', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:01:29', '2025-09-30 20:33:48', NULL),
(143, 1, 144, NULL, NULL, '2025/0143', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:02:18', '2025-10-01 02:38:08', NULL),
(144, 1, 145, NULL, NULL, '2025/0144', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:03:24', '2025-09-30 19:36:43', NULL),
(145, 1, 146, NULL, NULL, '2025/0145', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:04:24', '2025-09-30 19:52:59', NULL),
(146, 1, 147, NULL, NULL, '2025/0146', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:05:18', '2025-09-30 20:33:27', NULL),
(147, 1, 148, NULL, NULL, '2025/0147', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:06:56', '2025-09-30 19:52:11', NULL),
(148, 1, 149, NULL, NULL, '2025/0148', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:07:53', '2025-09-30 19:53:29', NULL),
(149, 1, 150, NULL, NULL, '2025/0149', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:09:10', '2025-09-30 19:42:56', NULL),
(150, 1, 151, NULL, NULL, '2025/0150', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:10:03', '2025-09-30 19:24:01', NULL),
(151, 1, 152, NULL, NULL, '2025/0151', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:11:04', '2025-09-30 19:43:16', NULL),
(152, 1, 153, NULL, NULL, '2025/0152', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:12:37', '2025-09-30 19:55:50', NULL),
(153, 1, 154, NULL, NULL, '2025/0153', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:14:20', '2025-09-30 19:44:34', NULL),
(154, 1, 155, NULL, NULL, '2025/0154', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:15:12', '2025-09-30 19:26:22', NULL),
(155, 1, 156, NULL, NULL, '2025/0155', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:16:14', '2025-09-30 19:56:05', NULL),
(156, 1, 157, NULL, NULL, '2025/0156', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:17:04', '2025-09-30 19:34:11', NULL),
(157, 1, 158, NULL, NULL, '2025/0157', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:18:59', '2025-09-30 19:44:00', NULL),
(158, 1, 159, NULL, NULL, '2025/0158', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:20:23', '2025-09-30 23:43:36', NULL),
(159, 1, 160, NULL, NULL, '2025/0159', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:21:20', '2025-09-30 19:29:52', NULL),
(160, 1, 161, NULL, NULL, '2025/0160', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:22:10', '2025-09-30 19:41:53', NULL),
(161, 1, 162, NULL, NULL, '2025/0161', NULL, '2025-08-18', 'at_home', NULL, '2025-08-18 11:22:54', '2025-09-30 19:40:50', NULL),
(162, 1, 163, NULL, NULL, '2025/0162', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:23:41', NULL, '2025-10-01 01:09:32'),
(163, 1, 164, NULL, NULL, '2025/0163', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:24:37', '2025-09-30 19:54:10', NULL),
(164, 1, 165, NULL, NULL, '2025/0164', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:25:58', '2025-09-30 19:55:30', NULL),
(165, 1, 166, NULL, NULL, '2025/0165', NULL, '2025-08-18', 'at_home', NULL, '2025-08-18 11:26:56', '2025-09-30 20:00:22', NULL),
(166, 1, 167, NULL, NULL, '2025/0166', NULL, '2025-08-18', 'dropped_out', NULL, '2025-08-18 11:27:50', '2025-09-30 19:34:30', NULL),
(167, 1, 168, NULL, NULL, '2025/0167', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:28:51', '2025-10-01 01:10:06', NULL),
(168, 1, 169, NULL, NULL, '2025/0168', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:29:49', '2025-09-30 19:32:31', NULL),
(169, 1, 170, NULL, NULL, '2025/0169', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:30:41', '2025-09-30 19:53:19', NULL),
(170, 1, 171, NULL, NULL, '2025/0170', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:32:55', '2025-09-30 19:30:12', NULL),
(171, 1, 172, NULL, NULL, '2025/0171', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:33:53', '2025-09-30 19:40:38', NULL),
(172, 1, 173, NULL, NULL, '2025/0172', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:34:44', '2025-09-30 19:34:47', NULL),
(173, 1, 174, NULL, NULL, '2025/0173', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:35:24', '2025-09-30 19:44:59', NULL),
(174, 1, 175, NULL, NULL, '2025/0174', NULL, '2025-08-18', 'dropped_out', NULL, '2025-08-18 11:36:13', NULL, NULL),
(175, 1, 176, NULL, NULL, '2025/0175', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:37:20', '2025-09-30 19:54:24', NULL),
(176, 1, 177, NULL, NULL, '2025/0176', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:38:41', '2025-09-30 19:22:02', NULL),
(177, 1, 178, NULL, NULL, '2025/0177', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:39:39', '2025-09-30 19:46:34', NULL),
(178, 1, 179, NULL, NULL, '2025/0178', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:40:36', '2025-09-24 16:29:04', NULL),
(179, 1, 180, NULL, NULL, '2025/0179', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:41:40', '2025-10-02 13:06:32', NULL),
(180, 1, 181, NULL, NULL, '2025/0180', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:42:30', '2025-09-30 19:21:14', NULL),
(181, 1, 182, NULL, NULL, '2025/0181', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:43:10', '2025-09-30 19:55:17', NULL),
(182, 1, 183, NULL, NULL, '2025/0182', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:44:09', '2025-09-30 19:54:36', NULL),
(183, 1, 184, NULL, NULL, '2025/0183', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:44:45', '2025-09-30 19:49:21', NULL),
(184, 1, 185, NULL, NULL, '2025/0184', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:48:43', '2025-09-30 19:42:10', NULL),
(185, 1, 186, NULL, NULL, '2025/0185', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:49:26', '2025-09-30 19:41:41', NULL),
(186, 1, 187, NULL, NULL, '2025/0186', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:50:19', '2025-09-30 19:23:26', NULL),
(187, 1, 188, NULL, NULL, '2025/0187', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:51:29', '2025-09-30 19:22:18', NULL),
(188, 1, 189, NULL, NULL, '2025/0188', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:52:12', '2025-09-30 19:30:55', NULL),
(189, 1, 190, NULL, NULL, '2025/0189', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:52:54', '2025-09-30 19:30:41', NULL),
(190, 1, 191, NULL, NULL, '2025/0190', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:53:41', '2025-09-30 19:31:15', NULL),
(191, 1, 192, NULL, NULL, '2025/0191', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:54:47', '2025-09-30 19:24:30', NULL),
(192, 1, 193, NULL, NULL, '2025/0192', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:55:38', '2025-09-30 19:36:03', NULL),
(193, 1, 194, NULL, NULL, '2025/0193', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:56:25', '2025-09-30 20:00:35', NULL),
(194, 1, 195, NULL, NULL, '2025/0194', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:58:37', '2025-09-30 19:56:59', NULL),
(195, 1, 196, NULL, NULL, '2025/0195', NULL, '2025-08-18', 'active', NULL, '2025-08-18 11:59:24', '2025-09-30 19:44:14', NULL),
(196, 1, 197, NULL, NULL, '2025/0196', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:00:15', '2025-09-30 19:37:53', NULL),
(197, 1, 198, NULL, NULL, '2025/0197', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:01:05', '2025-09-30 19:23:40', NULL),
(198, 1, 199, NULL, NULL, '2025/0198', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:01:45', '2025-09-30 19:39:08', NULL),
(199, 1, 200, NULL, NULL, '2025/0199', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:02:32', '2025-09-30 19:27:20', NULL),
(200, 1, 201, NULL, NULL, '2025/0200', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:03:46', '2025-10-01 01:04:30', NULL),
(201, 1, 202, NULL, NULL, '2025/0201', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:04:33', '2025-09-30 19:33:05', NULL),
(202, 1, 203, NULL, NULL, '2025/0202', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:05:35', '2025-09-30 19:32:50', NULL),
(203, 1, 204, NULL, NULL, '2025/0203', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:06:19', '2025-09-30 19:31:38', NULL),
(204, 1, 205, NULL, NULL, '2025/0204', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:06:54', '2025-09-30 19:47:46', NULL),
(205, 1, 206, NULL, NULL, '2025/0205', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:07:37', '2025-09-30 19:55:02', NULL),
(206, 1, 207, NULL, NULL, '2025/0206', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:08:47', '2025-09-30 19:24:12', NULL),
(207, 1, 208, NULL, NULL, '2025/0207', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:09:31', '2025-09-30 19:56:21', NULL),
(208, 1, 209, NULL, NULL, '2025/0208', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:10:10', '2025-09-30 19:42:27', NULL),
(209, 1, 210, NULL, NULL, '2025/0209', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:11:10', '2025-09-30 19:32:17', NULL),
(210, 1, 211, NULL, NULL, '2025/0210', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:11:58', '2025-09-30 19:52:46', NULL),
(211, 1, 212, NULL, NULL, '2025/0211', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:13:02', '2025-10-01 04:16:01', NULL),
(212, 1, 213, NULL, NULL, '2025/0212', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:13:53', '2025-09-30 20:34:17', NULL),
(213, 1, 214, NULL, NULL, '2025/0213', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:14:37', '2025-09-30 19:45:31', NULL),
(214, 1, 215, NULL, NULL, '2025/0214', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:15:50', '2025-09-30 19:33:42', NULL),
(215, 1, 216, NULL, NULL, '2025/0215', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:16:38', '2025-09-30 19:49:05', NULL),
(216, 1, 217, NULL, NULL, '2025/0216', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:17:22', '2025-09-30 19:40:13', NULL),
(217, 1, 218, NULL, NULL, '2025/0217', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:18:04', NULL, '2025-09-24 11:21:27'),
(218, 1, 219, NULL, NULL, '2025/0218', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:18:50', '2025-09-30 19:48:53', NULL),
(219, 1, 220, NULL, NULL, '2025/0219', NULL, '2025-08-18', 'at_home', NULL, '2025-08-18 12:19:37', '2025-09-30 19:57:08', NULL),
(220, 1, 221, NULL, NULL, '2025/0220', NULL, '2025-08-18', 'active', NULL, '2025-08-18 12:20:29', '2025-09-30 23:44:25', NULL),
(221, 1, 222, NULL, NULL, '2025/0221', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:57', '2025-10-22 22:35:42', NULL),
(222, 1, 223, NULL, NULL, '2025/0222', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:02', NULL, NULL),
(223, 1, 224, NULL, NULL, '2025/0223', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:33', NULL, NULL),
(224, 1, 225, NULL, NULL, '2025/0224', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:25', NULL, NULL),
(225, 1, 226, NULL, NULL, '2025/0225', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:17:55', NULL, NULL),
(226, 1, 227, NULL, NULL, '2025/0226', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:18:42', '2025-10-22 22:44:30', NULL),
(227, 1, 228, NULL, NULL, '2025/0227', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:37', NULL, NULL),
(228, 1, 229, NULL, NULL, '2025/0228', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:20:23', NULL, NULL),
(229, 1, 230, NULL, NULL, '2025/0229', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:05', '2025-10-17 19:04:16', NULL),
(230, 1, 231, NULL, NULL, '2025/0230', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:44', NULL, NULL),
(231, 1, 232, NULL, NULL, '2025/0231', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:32', NULL, NULL),
(232, 1, 233, NULL, NULL, '2025/0232', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:23', NULL, NULL),
(233, 1, 234, NULL, NULL, '2025/0233', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:16', NULL, NULL),
(234, 1, 235, NULL, NULL, '2025/0234', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:58', NULL, NULL),
(235, 1, 236, NULL, NULL, '2025/0235', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:25:42', NULL, NULL),
(236, 1, 237, NULL, NULL, '2025/0236', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:19', '2025-10-17 21:48:21', NULL),
(237, 1, 238, NULL, NULL, '2025/0237', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:27:35', '2025-10-17 19:03:24', NULL),
(238, 1, 239, NULL, NULL, '2025/0238', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:28:17', NULL, NULL),
(239, 1, 240, NULL, NULL, '2025/0239', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:06', '2025-10-22 22:46:45', NULL),
(240, 1, 241, NULL, NULL, '2025/0240', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:53', '2025-10-17 19:02:47', NULL),
(241, 1, 242, NULL, NULL, '2025/0241', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:30:30', NULL, NULL),
(242, 1, 243, NULL, NULL, '2025/0242', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:31', '2025-10-17 21:49:23', NULL),
(243, 1, 244, NULL, NULL, '2025/0243', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:35:26', NULL, NULL),
(244, 1, 245, NULL, NULL, '2025/0244', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:17:55', NULL, NULL),
(245, 1, 246, NULL, NULL, '2025/0245', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:18:49', NULL, NULL),
(246, 1, 247, NULL, NULL, '2025/0246', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:19:41', '2025-10-22 22:48:40', NULL),
(247, 1, 248, NULL, NULL, '2025/0247', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:20:26', NULL, NULL),
(248, 1, 249, NULL, NULL, '2025/0248', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:21:23', '2025-10-22 22:47:14', NULL),
(249, 1, 250, NULL, NULL, '2025/0249', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:22:12', '2025-10-22 22:46:15', NULL),
(250, 1, 251, NULL, NULL, '2025/0250', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:23:03', NULL, NULL),
(251, 1, 252, NULL, NULL, '2025/0251', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:24:27', '2025-10-22 22:42:42', NULL),
(252, 1, 253, NULL, NULL, '2025/0252', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:07', '2025-10-17 19:02:12', NULL),
(253, 1, 254, NULL, NULL, '2025/0253', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:26:56', NULL, NULL),
(254, 1, 255, NULL, NULL, '2025/0254', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:27:53', NULL, NULL),
(255, 1, 256, NULL, NULL, '2025/0255', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:28:38', NULL, NULL),
(256, 1, 257, NULL, NULL, '2025/0256', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:29:23', '2025-10-22 22:45:03', NULL),
(257, 1, 258, NULL, NULL, '2025/0257', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:30:16', '2025-10-17 21:48:47', NULL),
(258, 1, 259, NULL, NULL, '2025/0258', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:08', NULL, '2025-10-22 22:53:36'),
(259, 1, 260, NULL, NULL, '2025/0259', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:31:49', NULL, NULL),
(260, 1, 261, NULL, NULL, '2025/0260', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:32:31', '2025-10-22 22:40:46', NULL),
(261, 1, 262, NULL, NULL, '2025/0261', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:33:35', NULL, NULL),
(262, 1, 263, NULL, NULL, '2025/0262', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:34:24', NULL, NULL),
(263, 1, 264, NULL, NULL, '2025/0263', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:35:04', NULL, NULL),
(264, 1, 265, NULL, NULL, '2025/0264', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:36:01', NULL, NULL),
(265, 1, 266, NULL, NULL, '2025/0265', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:36:43', NULL, NULL),
(266, 1, 267, NULL, NULL, '2025/0266', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:37:21', NULL, NULL),
(267, 1, 268, NULL, NULL, '2025/0267', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:38:00', NULL, NULL),
(268, 1, 269, NULL, NULL, '2025/0268', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:38:45', '2025-10-22 22:42:27', NULL),
(269, 1, 270, NULL, NULL, '2025/0269', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:39:43', '2025-10-22 22:45:23', NULL),
(270, 1, 271, NULL, NULL, '2025/0270', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:40:26', NULL, NULL),
(271, 1, 272, NULL, NULL, '2025/0271', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:41:11', '2025-10-17 21:47:16', NULL),
(272, 1, 273, NULL, NULL, '2025/0272', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:42:42', '2025-10-17 23:23:52', NULL),
(273, 1, 274, NULL, NULL, '2025/0273', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:44:44', '2025-10-09 23:40:10', NULL),
(274, 1, 275, NULL, NULL, '2025/0274', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:45:26', NULL, NULL),
(275, 1, 276, NULL, NULL, '2025/0275', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:46:10', NULL, NULL),
(276, 1, 277, NULL, NULL, '2025/0276', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:46:51', '2025-10-17 23:11:59', NULL),
(277, 1, 278, NULL, NULL, '2025/0277', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:47:34', '2025-10-09 23:44:50', NULL),
(278, 1, 279, NULL, NULL, '2025/0278', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:48:14', '2025-10-09 23:46:07', NULL),
(279, 1, 280, NULL, NULL, '2025/0279', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:49:01', '2025-10-17 23:20:06', NULL),
(280, 1, 281, NULL, NULL, '2025/0280', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:49:42', NULL, NULL),
(281, 1, 282, NULL, NULL, '2025/0281', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:50:25', NULL, NULL),
(282, 1, 283, NULL, NULL, '2025/0282', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:51:27', NULL, NULL),
(283, 1, 284, NULL, NULL, '2025/0283', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:52:38', NULL, NULL),
(284, 1, 285, NULL, NULL, '2025/0284', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:53:30', NULL, NULL),
(285, 1, 286, NULL, NULL, '2025/0285', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:54:15', NULL, '2025-10-17 22:59:08'),
(286, 1, 287, NULL, NULL, '2025/0286', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:55:17', NULL, '2025-10-17 23:33:30'),
(287, 1, 288, NULL, NULL, '2025/0287', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:56:04', '2025-10-09 23:47:53', NULL),
(288, 1, 289, NULL, NULL, '2025/0288', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:56:48', '2025-10-17 22:58:58', NULL),
(289, 1, 290, NULL, NULL, '2025/0289', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:57:49', NULL, NULL),
(290, 1, 291, NULL, NULL, '2025/0290', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:58:44', '2025-10-09 23:45:56', NULL),
(291, 1, 292, NULL, NULL, '2025/0291', NULL, '2025-08-18', 'active', NULL, '2025-08-18 13:59:36', '2025-10-17 23:18:13', NULL),
(292, 1, 293, NULL, NULL, '2025/0292', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:00:23', NULL, NULL),
(293, 1, 294, NULL, NULL, '2025/0293', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:01:07', '2025-10-09 23:43:15', NULL),
(294, 1, 295, NULL, NULL, '2025/0294', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:01:50', NULL, NULL),
(295, 1, 296, NULL, NULL, '2025/0295', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:02:28', NULL, NULL),
(296, 1, 297, NULL, NULL, '2025/0296', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:03:09', NULL, NULL),
(297, 1, 298, NULL, NULL, '2025/0297', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:04:08', NULL, NULL),
(298, 1, 299, NULL, NULL, '2025/0298', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:05:01', NULL, NULL),
(299, 1, 300, NULL, NULL, '2025/0299', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:05:47', NULL, NULL),
(300, 1, 301, NULL, NULL, '2025/0300', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:06:44', NULL, NULL),
(301, 1, 302, NULL, NULL, '2025/0301', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:07:21', '2025-10-09 23:40:39', NULL),
(302, 1, 303, NULL, NULL, '2025/0302', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:21:28', NULL, NULL),
(303, 1, 304, NULL, NULL, '2025/0303', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:23:01', '2025-10-09 23:47:39', NULL),
(304, 1, 305, NULL, NULL, '2025/0304', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:24:15', NULL, NULL),
(305, 1, 306, NULL, NULL, '2025/0305', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:25:04', NULL, NULL),
(306, 1, 307, NULL, NULL, '2025/0306', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:26:09', NULL, NULL),
(307, 1, 308, NULL, NULL, '2025/0307', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:27:06', '2025-10-17 23:12:30', NULL),
(308, 1, 309, NULL, NULL, '2025/0308', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:27:55', NULL, NULL),
(309, 1, 310, NULL, NULL, '2025/0309', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:28:47', NULL, '2025-10-17 23:33:14'),
(310, 1, 311, NULL, NULL, '2025/0310', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:30:54', NULL, '2025-10-17 23:33:23'),
(311, 1, 312, NULL, NULL, '2025/0311', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:31:47', NULL, NULL),
(312, 1, 313, NULL, NULL, '2025/0312', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:32:33', '2025-10-17 22:59:43', NULL),
(313, 1, 314, NULL, NULL, '2025/0313', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:33:35', NULL, NULL),
(314, 1, 315, NULL, NULL, '2025/0314', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:34:19', NULL, NULL),
(315, 1, 316, NULL, NULL, '2025/0315', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:35:10', '2025-10-17 13:16:31', NULL),
(316, 1, 317, NULL, NULL, '2025/0316', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:36:01', '2025-10-17 21:50:54', NULL),
(317, 1, 318, NULL, NULL, '2025/0317', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:38:35', '2025-11-11 16:00:33', NULL),
(318, 1, 319, NULL, NULL, '2025/0318', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:39:57', '2025-10-17 23:13:03', NULL),
(319, 1, 320, NULL, NULL, '2025/0319', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:41:02', '2025-10-17 23:24:59', NULL),
(320, 1, 321, NULL, NULL, '2025/0320', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:42:07', '2025-10-17 23:18:35', NULL),
(321, 1, 322, NULL, NULL, '2025/0321', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:43:19', NULL, NULL),
(322, 1, 323, NULL, NULL, '2025/0322', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:44:29', NULL, NULL),
(323, 1, 324, NULL, NULL, '2025/0323', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:45:57', NULL, NULL),
(324, 1, 325, NULL, NULL, '2025/0324', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:47:09', NULL, NULL),
(325, 1, 326, NULL, NULL, '2025/0325', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:48:05', NULL, NULL),
(326, 1, 327, NULL, NULL, '2025/0326', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:49:00', '2025-10-09 23:46:42', NULL),
(327, 1, 328, NULL, NULL, '2025/0327', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:50:00', NULL, NULL),
(328, 1, 329, NULL, NULL, '2025/0328', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:50:50', NULL, NULL),
(329, 1, 330, NULL, NULL, '2025/0329', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:51:30', NULL, '2025-10-17 23:32:44'),
(330, 1, 331, NULL, NULL, '2025/0330', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:53:00', '2025-10-17 23:04:52', NULL),
(331, 1, 332, NULL, NULL, '2025/0331', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:53:39', NULL, NULL),
(332, 1, 333, NULL, NULL, '2025/0332', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:54:43', '2025-10-17 23:05:26', NULL),
(333, 1, 334, NULL, NULL, '2025/0333', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:55:29', NULL, NULL),
(334, 1, 335, NULL, NULL, '2025/0334', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:56:16', NULL, NULL),
(335, 1, 336, NULL, NULL, '2025/0335', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:57:56', '2025-10-02 12:56:29', NULL),
(336, 1, 337, NULL, NULL, '2025/0336', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:59:00', '2025-10-02 12:31:40', NULL),
(337, 1, 338, NULL, NULL, '2025/0337', NULL, '2025-08-18', 'active', NULL, '2025-08-18 14:59:57', '2025-10-09 21:22:34', NULL),
(338, 1, 339, NULL, NULL, '2025/0338', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:02:10', '2025-10-02 12:57:49', NULL),
(339, 1, 340, NULL, NULL, '2025/0339', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:03:08', '2025-10-02 12:52:09', NULL),
(340, 1, 341, NULL, NULL, '2025/0340', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:04:37', NULL, NULL),
(341, 1, 342, NULL, NULL, '2025/0341', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:05:51', '2025-10-02 12:52:18', NULL),
(342, 1, 343, NULL, NULL, '2025/0342', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:06:48', NULL, NULL),
(343, 1, 344, NULL, NULL, '2025/0343', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:07:59', '2025-10-02 12:51:39', NULL),
(344, 1, 345, NULL, NULL, '2025/0344', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:09:35', '2025-10-02 12:31:27', NULL),
(345, 1, 346, NULL, NULL, '2025/0345', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:10:30', '2025-10-02 12:55:01', NULL),
(346, 1, 347, NULL, NULL, '2025/0346', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:11:30', '2025-10-02 12:53:05', NULL),
(347, 1, 348, NULL, NULL, '2025/0347', NULL, '2025-08-18', 'active', NULL, '2025-08-18 15:12:37', '2025-10-02 12:52:53', NULL),
(348, 1, 349, NULL, NULL, '2025/0348', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:20:40', '2025-10-02 12:59:45', NULL),
(349, 1, 350, NULL, NULL, '2025/0349', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:21:34', '2025-10-02 12:53:44', NULL),
(350, 1, 351, NULL, NULL, '2025/0350', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:22:43', '2025-10-02 12:58:32', NULL),
(351, 1, 352, NULL, NULL, '2025/0351', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:23:45', '2025-10-02 12:51:05', NULL),
(352, 1, 353, NULL, NULL, '2025/0352', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:24:59', '2025-10-02 12:54:25', NULL),
(353, 1, 354, NULL, NULL, '2025/0353', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:26:11', '2025-10-02 12:48:56', NULL),
(354, 1, 355, NULL, NULL, '2025/0354', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:27:06', '2025-10-02 12:51:53', NULL),
(355, 1, 356, NULL, NULL, '2025/0355', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:27:55', '2025-10-02 12:50:43', NULL),
(356, 1, 357, NULL, NULL, '2025/0356', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:29:03', '2025-10-02 12:55:37', NULL),
(357, 1, 358, NULL, NULL, '2025/0357', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:30:03', '2025-10-02 12:31:54', NULL),
(358, 1, 359, NULL, NULL, '2025/0358', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:30:59', '2025-10-02 12:49:30', NULL),
(359, 1, 360, NULL, NULL, '2025/0359', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:31:51', '2025-10-02 12:58:17', NULL),
(360, 1, 361, NULL, NULL, '2025/0360', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:32:47', NULL, NULL),
(361, 1, 362, NULL, NULL, '2025/0361', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:34:07', '2025-10-02 12:56:54', NULL),
(362, 1, 363, NULL, NULL, '2025/0362', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:34:58', '2025-10-02 12:57:24', NULL),
(363, 1, 364, NULL, NULL, '2025/0363', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:35:59', '2025-10-02 12:55:54', NULL),
(364, 1, 365, NULL, NULL, '2025/0364', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:36:59', '2025-10-02 12:58:48', NULL),
(365, 1, 366, NULL, NULL, '2025/0365', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:38:15', '2025-10-02 12:57:35', NULL),
(366, 1, 367, NULL, NULL, '2025/0366', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:39:32', '2025-10-02 12:59:10', NULL),
(367, 1, 368, NULL, NULL, '2025/0367', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:41:17', NULL, NULL),
(368, 1, 369, NULL, NULL, '2025/0368', NULL, '2025-08-18', 'dropped_out', NULL, '2025-08-18 21:46:21', NULL, NULL),
(369, 1, 370, NULL, NULL, '2025/0369', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:47:32', NULL, NULL),
(370, 1, 371, NULL, NULL, '2025/0370', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:48:37', '2025-10-02 12:50:18', NULL),
(371, 1, 372, NULL, NULL, '2025/0371', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:50:10', '2025-10-02 12:58:04', NULL),
(372, 1, 373, NULL, NULL, '2025/0372', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:51:37', '2025-10-02 12:26:07', NULL),
(373, 1, 374, NULL, NULL, '2025/0373', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:52:21', '2025-10-02 12:54:37', NULL),
(374, 1, 375, NULL, NULL, '2025/0374', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:53:09', '2025-10-02 12:58:59', NULL),
(375, 1, 376, NULL, NULL, '2025/0375', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:54:10', '2025-10-02 12:49:20', NULL),
(376, 1, 377, NULL, NULL, '2025/0376', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:54:49', '2025-10-02 12:48:43', NULL),
(377, 1, 378, NULL, NULL, '2025/0377', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:55:59', '2025-10-02 12:55:26', NULL),
(378, 1, 379, NULL, NULL, '2025/0378', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:56:50', '2025-10-02 12:59:23', NULL),
(379, 1, 380, NULL, NULL, '2025/0379', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:58:32', '2025-10-02 12:49:55', NULL),
(380, 1, 381, NULL, NULL, '2025/0380', NULL, '2025-08-18', 'active', NULL, '2025-08-18 21:59:21', '2025-10-02 12:55:12', NULL),
(381, 1, 382, NULL, NULL, '2025/0381', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:00:17', '2025-10-02 12:53:31', NULL),
(382, 1, 383, NULL, NULL, '2025/0382', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:01:37', '2025-10-02 12:54:12', NULL),
(383, 1, 384, NULL, NULL, '2025/0383', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:02:33', '2025-10-09 21:21:37', NULL),
(384, 1, 385, NULL, NULL, '2025/0384', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:03:27', '2025-10-02 12:56:10', NULL),
(385, 1, 386, NULL, NULL, '2025/0385', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:04:22', '2025-10-02 12:59:35', NULL),
(386, 1, 387, NULL, NULL, '2025/0386', NULL, '2025-08-19', 'dropped_out', NULL, '2025-08-18 22:06:56', NULL, NULL),
(387, 1, 388, NULL, NULL, '2025/0387', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:07:43', '2025-10-02 12:49:10', NULL),
(388, 1, 389, NULL, NULL, '2025/0388', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:08:43', '2025-10-02 12:50:55', NULL),
(389, 1, 390, NULL, NULL, '2025/0389', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:09:31', '2025-10-02 12:57:07', NULL),
(390, 1, 391, NULL, NULL, '2025/0390', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:10:13', '2025-10-02 12:51:17', NULL),
(391, 1, 392, NULL, NULL, '2025/0391', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:11:28', '2025-10-02 12:53:19', NULL),
(392, 1, 393, NULL, NULL, '2025/0392', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:13:16', '2025-09-30 16:50:06', NULL),
(393, 1, 394, NULL, NULL, '2025/0393', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:17:35', '2025-09-24 15:38:09', NULL),
(394, 1, 395, NULL, NULL, '2025/0394', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:18:22', '2025-09-24 15:37:14', NULL),
(395, 1, 396, NULL, NULL, '2025/0395', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:19:18', '2025-09-30 16:51:53', NULL),
(396, 1, 397, NULL, NULL, '2025/0396', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:20:32', '2025-09-24 15:31:18', NULL),
(397, 1, 398, NULL, NULL, '2025/0397', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:21:31', '2025-09-30 16:54:14', NULL),
(398, 1, 399, NULL, NULL, '2025/0398', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:22:23', '2025-09-24 15:40:17', NULL),
(399, 1, 400, NULL, NULL, '2025/0399', NULL, '2025-08-19', 'dropped_out', NULL, '2025-08-18 22:23:11', '2025-09-24 15:47:56', NULL),
(400, 1, 401, NULL, NULL, '2025/0400', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:24:17', '2025-09-30 16:49:32', NULL),
(401, 1, 402, NULL, NULL, '2025/0401', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:25:07', '2025-09-24 15:44:03', NULL),
(402, 1, 403, NULL, NULL, '2025/0402', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:26:07', '2025-09-24 15:49:54', NULL),
(403, 1, 404, NULL, NULL, '2025/0403', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:27:53', '2025-09-24 15:46:01', NULL),
(404, 1, 405, NULL, NULL, '2025/0404', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:29:06', '2025-09-24 15:48:54', NULL),
(405, 1, 406, NULL, NULL, '2025/0405', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:32:03', '2025-10-02 13:11:48', NULL),
(406, 1, 407, NULL, NULL, '2025/0406', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:33:08', '2025-09-24 15:41:15', NULL),
(407, 1, 408, NULL, NULL, '2025/0407', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:34:01', '2025-09-24 15:45:33', NULL),
(408, 1, 409, NULL, NULL, '2025/0408', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:34:49', '2025-09-30 16:58:42', NULL),
(409, 1, 410, NULL, NULL, '2025/0409', NULL, '2025-08-19', 'dropped_out', NULL, '2025-08-18 22:35:36', NULL, NULL),
(410, 1, 411, NULL, NULL, '2025/0410', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:36:20', '2025-09-30 16:50:54', NULL),
(411, 1, 412, NULL, NULL, '2025/0411', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:38:18', '2025-09-24 15:50:24', NULL),
(412, 1, 413, NULL, NULL, '2025/0412', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:40:34', '2025-09-24 15:39:39', NULL),
(413, 1, 414, NULL, NULL, '2025/0413', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:41:41', '2025-09-30 16:52:39', NULL),
(414, 1, 415, NULL, NULL, '2025/0414', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:42:29', '2025-09-30 16:48:45', NULL),
(415, 1, 416, NULL, NULL, '2025/0415', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:43:38', '2025-09-30 16:49:02', NULL),
(416, 1, 417, NULL, NULL, '2025/0416', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:44:52', '2025-09-24 15:42:24', NULL),
(417, 1, 418, NULL, NULL, '2025/0417', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:45:56', '2025-09-30 16:56:26', NULL),
(418, 1, 419, NULL, NULL, '2025/0418', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:46:58', '2025-09-30 16:50:15', NULL),
(419, 1, 420, NULL, NULL, '2025/0419', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:47:47', '2025-09-24 16:23:42', NULL),
(420, 1, 421, NULL, NULL, '2025/0420', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:48:39', '2025-09-24 15:46:19', NULL),
(421, 1, 422, NULL, NULL, '2025/0421', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:49:40', '2025-09-30 16:29:41', NULL),
(422, 1, 423, NULL, NULL, '2025/0422', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:50:37', '2025-09-30 16:57:45', NULL);
INSERT INTO `students` (`id`, `school_id`, `person_id`, `class_id`, `theology_class_id`, `admission_no`, `village_id`, `admission_date`, `status`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(423, 1, 424, NULL, NULL, '2025/0423', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:51:23', '2025-09-30 16:51:27', NULL),
(424, 1, 425, NULL, NULL, '2025/0424', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:52:13', '2025-09-30 16:51:14', NULL),
(425, 1, 426, NULL, NULL, '2025/0425', NULL, '2025-08-19', 'at_home', NULL, '2025-08-18 22:53:04', NULL, NULL),
(426, 1, 427, NULL, NULL, '2025/0426', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:54:07', '2025-09-30 16:58:21', NULL),
(427, 1, 428, NULL, NULL, '2025/0427', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:55:04', NULL, NULL),
(428, 1, 429, NULL, NULL, '2025/0428', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:56:06', NULL, NULL),
(429, 1, 430, NULL, NULL, '2025/0429', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:56:55', '2025-09-24 15:34:23', NULL),
(430, 1, 431, NULL, NULL, '2025/0430', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:58:07', '2025-09-24 15:47:30', NULL),
(431, 1, 432, NULL, NULL, '2025/0431', NULL, '2025-08-19', 'active', NULL, '2025-08-18 22:59:07', '2025-09-30 16:49:52', NULL),
(432, 1, 433, NULL, NULL, '2025/0432', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:00:05', '2025-09-30 16:51:43', NULL),
(433, 1, 434, NULL, NULL, '2025/0433', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:00:47', '2025-09-24 15:46:50', NULL),
(434, 1, 435, NULL, NULL, '2025/0434', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:01:44', '2025-09-24 15:32:23', NULL),
(435, 1, 436, NULL, NULL, '2025/0435', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:02:39', '2025-09-24 15:44:28', NULL),
(436, 1, 437, NULL, NULL, '2025/0436', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:03:39', '2025-09-24 15:42:54', NULL),
(437, 1, 438, NULL, NULL, '2025/0437', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:04:42', '2025-09-24 15:45:01', NULL),
(438, 1, 439, NULL, NULL, '2025/0438', NULL, '2025-08-19', 'dropped_out', NULL, '2025-08-18 23:05:29', NULL, NULL),
(439, 1, 440, NULL, NULL, '2025/0439', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:06:25', '2025-09-30 16:53:09', NULL),
(440, 1, 441, NULL, NULL, '2025/0440', NULL, '2025-08-19', 'dropped_out', NULL, '2025-08-18 23:07:18', '2025-09-24 11:06:15', NULL),
(441, 1, 442, NULL, NULL, '2025/0441', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:08:08', '2025-09-30 16:52:55', NULL),
(442, 1, 443, NULL, NULL, '2025/0442', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:08:58', '2025-09-30 16:57:18', NULL),
(443, 1, 444, NULL, NULL, '2025/0443', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:10:05', '2025-09-24 15:43:32', NULL),
(444, 1, 445, NULL, NULL, '2025/0444', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:11:12', '2025-09-24 15:37:48', NULL),
(445, 1, 446, NULL, NULL, '2025/0445', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:11:58', '2025-09-30 16:56:41', NULL),
(446, 1, 447, NULL, NULL, '2025/0446', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:12:46', '2025-09-24 16:24:39', NULL),
(447, 1, 448, NULL, NULL, '2025/0447', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:13:29', '2025-09-24 15:49:26', NULL),
(448, 1, 449, NULL, NULL, '2025/0448', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:14:25', NULL, '2025-08-19 07:17:47'),
(449, 1, 450, NULL, NULL, '2025/0449', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:15:14', NULL, '2025-08-19 07:19:18'),
(450, 1, 451, NULL, NULL, '2025/0450', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:15:59', NULL, '2025-08-19 07:18:05'),
(451, 1, 452, NULL, NULL, '2025/0451', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:16:50', NULL, '2025-08-19 07:21:01'),
(452, 1, 453, NULL, NULL, '2025/0452', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:17:39', '2025-09-24 15:38:59', NULL),
(453, 1, 454, NULL, NULL, '2025/0453', NULL, '2025-08-19', 'active', NULL, '2025-08-18 23:18:25', NULL, '2025-08-19 07:21:40'),
(457, NULL, 458, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 00:24:53', '2025-09-25 00:25:01', NULL),
(458, NULL, 459, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:25:35', NULL, '2025-08-19 00:26:31'),
(459, NULL, 460, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 00:42:51', '2025-10-02 10:35:43', NULL),
(460, NULL, 461, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 01:09:57', '2025-09-24 16:59:31', NULL),
(461, NULL, 462, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 02:02:31', '2025-09-24 16:31:10', NULL),
(462, NULL, 463, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:02:35', NULL, '2025-08-19 02:03:06'),
(463, NULL, 466, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:25:37', NULL, '2025-08-19 03:27:03'),
(464, NULL, 467, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:25:42', '2025-09-24 16:53:26', '2025-10-17 17:56:39'),
(465, NULL, 468, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:25:51', NULL, '2025-08-19 03:26:55'),
(466, NULL, 469, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:28:29', '2025-10-02 10:37:42', NULL),
(467, NULL, 470, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:30:15', '2025-09-30 17:12:43', NULL),
(468, NULL, 471, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:32:40', NULL, '2025-08-19 03:34:34'),
(469, NULL, 472, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:35:43', NULL, NULL),
(470, NULL, 473, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:36:56', '2025-10-02 10:38:42', NULL),
(471, NULL, 474, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 03:38:54', NULL, NULL),
(472, NULL, 475, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:40:05', '2025-09-25 00:51:36', NULL),
(473, NULL, 476, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:41:02', '2025-09-25 00:28:32', NULL),
(474, NULL, 477, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:42:32', '2025-10-06 20:53:35', NULL),
(475, NULL, 478, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 03:43:49', NULL, NULL),
(476, NULL, 479, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:44:41', '2025-10-02 10:33:54', NULL),
(477, NULL, 480, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:45:43', NULL, NULL),
(478, NULL, 481, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:46:33', '2025-10-02 10:34:44', NULL),
(479, NULL, 482, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:47:27', '2025-09-25 00:34:26', NULL),
(480, NULL, 483, NULL, NULL, NULL, NULL, NULL, 'on_leave', NULL, '2025-08-19 03:49:53', NULL, NULL),
(481, NULL, 484, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 03:51:01', NULL, NULL),
(482, NULL, 485, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:53:25', '2025-10-02 10:38:30', NULL),
(483, NULL, 486, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:54:27', '2025-09-30 17:12:34', NULL),
(484, NULL, 487, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 03:55:21', NULL, NULL),
(485, NULL, 488, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:56:40', NULL, NULL),
(486, NULL, 489, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:57:52', NULL, NULL),
(487, NULL, 490, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 03:58:53', '2025-09-25 01:01:57', NULL),
(488, NULL, 491, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:59:02', NULL, '2025-08-19 04:00:21'),
(489, NULL, 492, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:59:36', NULL, '2025-08-19 04:00:13'),
(490, NULL, 493, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:01:28', '2025-09-25 00:44:03', NULL),
(491, NULL, 494, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:02:25', '2025-09-24 17:00:08', NULL),
(492, NULL, 495, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:03:58', NULL, NULL),
(493, NULL, 496, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:05:15', '2025-09-30 17:12:01', NULL),
(494, NULL, 497, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:06:00', '2025-10-02 10:40:34', NULL),
(495, NULL, 498, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:06:47', '2025-09-25 00:08:06', NULL),
(496, NULL, 499, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:07:38', '2025-09-24 16:29:48', NULL),
(497, NULL, 500, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 04:08:23', NULL, NULL),
(498, NULL, 501, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:09:13', '2025-09-24 16:56:46', NULL),
(499, NULL, 502, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:09:59', '2025-09-24 16:30:26', NULL),
(500, NULL, 503, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:10:49', '2025-09-24 16:31:53', NULL),
(501, NULL, 504, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:11:36', '2025-09-24 19:20:29', NULL),
(502, NULL, 505, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:12:31', NULL, NULL),
(503, NULL, 506, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:13:20', NULL, NULL),
(504, NULL, 507, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:14:05', '2025-09-24 16:50:11', NULL),
(505, NULL, 508, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:14:55', '2025-10-02 10:54:28', NULL),
(506, NULL, 509, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:15:52', '2025-09-24 19:12:29', NULL),
(507, NULL, 510, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:16:41', '2025-09-25 00:26:17', NULL),
(508, NULL, 511, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:17:23', '2025-10-17 22:02:26', NULL),
(509, NULL, 512, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:18:40', '2025-09-25 01:04:22', NULL),
(510, NULL, 513, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 04:19:39', '2025-10-09 19:55:24', NULL),
(511, NULL, 514, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:20:44', NULL, NULL),
(512, NULL, 515, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:21:38', '2025-09-24 16:27:45', NULL),
(513, NULL, 516, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:22:24', '2025-09-24 16:28:12', NULL),
(514, NULL, 517, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:23:05', '2025-09-25 01:06:33', NULL),
(515, NULL, 518, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:24:13', '2025-09-25 00:47:07', NULL),
(516, NULL, 519, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:24:56', '2025-09-24 16:57:27', NULL),
(517, NULL, 520, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:25:50', '2025-09-25 00:37:14', NULL),
(518, NULL, 521, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:27:09', '2025-09-24 16:42:28', NULL),
(519, NULL, 522, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:27:56', '2025-10-02 10:40:22', NULL),
(520, NULL, 523, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:28:45', '2025-09-24 16:28:45', NULL),
(521, NULL, 524, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:30:01', '2025-10-02 10:38:09', NULL),
(522, NULL, 525, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:30:48', NULL, NULL),
(523, NULL, 526, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:32:44', '2025-09-25 00:30:16', NULL),
(524, NULL, 527, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:35:30', '2025-10-17 23:52:34', NULL),
(525, NULL, 528, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:36:13', '2025-09-25 03:50:31', NULL),
(526, NULL, 529, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:36:52', '2025-09-25 03:44:41', NULL),
(527, NULL, 530, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:37:36', '2025-09-25 03:50:43', NULL),
(528, NULL, 531, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:38:17', '2025-09-25 04:30:28', NULL),
(529, NULL, 532, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:39:39', '2025-09-25 03:52:17', NULL),
(530, NULL, 533, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:40:59', '2025-10-17 23:51:15', NULL),
(531, NULL, 534, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:41:50', '2025-09-25 04:29:51', NULL),
(532, NULL, 535, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:42:48', '2025-09-24 16:35:43', NULL),
(533, NULL, 536, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:43:40', '2025-10-02 12:08:25', NULL),
(534, NULL, 537, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:44:28', '2025-09-25 03:52:29', NULL),
(535, NULL, 538, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:45:32', '2025-09-25 03:44:02', NULL),
(536, NULL, 539, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:47:13', '2025-09-25 03:46:06', NULL),
(537, NULL, 540, NULL, NULL, NULL, NULL, NULL, 'suspended', NULL, '2025-08-19 04:48:05', NULL, NULL),
(538, NULL, 541, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:49:11', '2025-09-25 03:49:23', NULL),
(539, NULL, 542, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:52:12', '2025-09-25 04:10:27', NULL),
(540, NULL, 543, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 04:57:57', NULL, NULL),
(541, NULL, 544, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:59:37', '2025-10-02 12:08:49', NULL),
(542, NULL, 545, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:02:01', '2025-09-25 03:48:23', NULL),
(543, NULL, 546, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 05:02:12', NULL, '2025-08-19 05:02:37'),
(544, NULL, 547, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 05:03:37', NULL, NULL),
(545, NULL, 548, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:07:00', '2025-09-24 19:22:57', NULL),
(546, NULL, 549, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:07:52', '2025-09-24 16:33:55', NULL),
(547, NULL, 550, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:09:41', '2025-09-25 03:49:07', NULL),
(548, NULL, 551, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:10:52', '2025-09-24 16:36:42', NULL),
(549, NULL, 552, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:11:39', '2025-09-25 03:52:03', NULL),
(550, NULL, 553, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:12:42', '2025-09-25 03:51:20', NULL),
(551, NULL, 554, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:14:13', '2025-10-17 23:51:48', NULL),
(552, NULL, 555, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 05:15:33', NULL, NULL),
(553, NULL, 556, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:16:21', '2025-09-24 16:34:53', NULL),
(554, NULL, 557, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:17:10', '2025-09-25 04:07:03', NULL),
(555, NULL, 558, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:18:31', NULL, '2025-09-24 16:35:05'),
(556, NULL, 559, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:19:28', '2025-09-24 16:32:54', NULL),
(557, NULL, 560, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:20:27', '2025-09-24 16:36:09', NULL),
(558, NULL, 561, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:21:33', '2025-09-24 16:33:23', NULL),
(559, NULL, 562, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:25:42', '2025-09-25 03:51:08', NULL),
(560, NULL, 563, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:27:38', '2025-09-25 03:53:19', NULL),
(561, NULL, 564, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:28:44', '2025-09-25 04:07:24', NULL),
(562, NULL, 565, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:29:46', '2025-09-25 04:07:55', NULL),
(563, NULL, 566, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:30:50', '2025-09-25 03:52:43', NULL),
(564, NULL, 567, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:31:48', '2025-09-25 03:44:15', NULL),
(565, NULL, 568, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:32:45', '2025-10-17 23:49:33', NULL),
(566, NULL, 569, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:33:31', '2025-09-25 03:50:02', NULL),
(567, NULL, 570, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:34:25', '2025-09-25 04:32:10', NULL),
(568, NULL, 571, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 05:35:24', '2025-09-25 03:43:47', NULL),
(569, NULL, 572, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 00:20:53', NULL, '2025-08-19 00:21:54'),
(570, NULL, 573, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:45:15', NULL, '2025-08-19 02:59:49'),
(571, NULL, 574, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 03:01:30', NULL, '2025-08-19 04:11:40'),
(572, NULL, 575, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:11:12', '2025-10-17 21:50:09', NULL),
(573, NULL, 576, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 04:15:52', '2025-10-02 13:03:19', NULL),
(574, NULL, 577, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:10:09', '2025-10-02 12:51:29', NULL),
(575, NULL, 578, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:23:52', NULL, '2025-08-19 07:26:10'),
(576, NULL, 579, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:26:57', '2025-09-30 16:52:04', NULL),
(577, NULL, 580, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:27:38', '2025-09-24 16:25:26', NULL),
(578, NULL, 581, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:34:17', NULL, '2025-08-19 07:35:04'),
(579, NULL, 582, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:36:11', '2025-09-25 01:08:40', NULL),
(580, NULL, 583, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 07:36:48', NULL, NULL),
(581, NULL, 584, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:37:30', '2025-09-24 16:52:13', NULL),
(582, NULL, 585, NULL, NULL, NULL, NULL, NULL, 'dropped_out', NULL, '2025-08-19 07:38:10', NULL, NULL),
(583, NULL, 586, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 07:38:49', '2025-09-25 00:39:25', NULL),
(584, NULL, 587, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 07:39:29', NULL, '2025-08-19 11:42:25'),
(585, NULL, 588, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 02:49:30', NULL, '2025-08-19 11:42:01'),
(586, NULL, 589, NULL, NULL, NULL, NULL, NULL, 'inactive', NULL, '2025-08-19 11:39:43', NULL, '2025-08-19 05:54:53'),
(587, NULL, 590, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 12:01:11', '2025-10-02 10:34:30', NULL),
(588, NULL, 591, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 12:24:11', '2025-09-30 19:54:49', NULL),
(589, NULL, 592, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 12:24:23', NULL, '2025-08-19 12:25:02'),
(590, NULL, 593, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 06:49:52', NULL, '2025-08-19 06:55:26'),
(592, NULL, 595, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-08-19 10:52:10', '2025-09-24 16:28:09', NULL),
(593, NULL, 596, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:09:15', NULL, '2025-09-24 11:10:03'),
(594, NULL, 597, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-24 11:20:47', NULL, '2025-09-24 11:22:09'),
(595, NULL, 598, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 17:42:38', '2025-09-30 16:55:41', NULL),
(596, NULL, 599, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:46:52', NULL, NULL),
(597, NULL, 600, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:47:55', NULL, NULL),
(598, NULL, 601, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:49:25', NULL, NULL),
(599, NULL, 602, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:50:22', NULL, NULL),
(600, NULL, 603, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:54:11', '2025-09-24 11:55:44', NULL),
(601, NULL, 604, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 11:56:52', NULL, NULL),
(602, NULL, 605, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 15:00:47', '2025-09-24 16:30:13', NULL),
(604, NULL, 607, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 18:39:54', '2025-10-17 23:50:10', NULL),
(605, NULL, 608, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 18:41:24', '2025-09-25 00:41:47', NULL),
(606, NULL, 609, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-09-24 23:51:18', '2025-09-25 00:59:21', NULL),
(607, NULL, 610, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-01 01:08:01', '2025-10-01 01:08:59', NULL),
(608, NULL, 611, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-01 05:26:53', '2025-10-01 05:27:57', NULL),
(609, NULL, 612, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-06 23:23:40', '2025-10-06 23:24:22', NULL),
(610, NULL, 613, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-06 23:25:36', '2025-10-06 23:27:51', NULL),
(611, NULL, 614, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-06 23:26:29', '2025-10-06 23:27:13', NULL),
(612, NULL, 615, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-09 23:49:00', NULL, NULL),
(613, NULL, 616, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-09 23:50:14', '2025-10-17 23:19:34', NULL),
(614, NULL, 617, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:51:18', NULL, '2025-10-17 23:20:54'),
(615, NULL, 618, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:52:38', NULL, '2025-10-17 23:20:28'),
(616, NULL, 619, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-09 23:53:23', '2025-10-17 23:00:27', NULL),
(617, NULL, 620, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:53:34', NULL, '2025-10-17 23:00:09'),
(618, NULL, 621, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-09 23:54:28', NULL, '2025-10-17 22:58:36'),
(619, NULL, 622, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-09 23:55:19', NULL, NULL),
(620, NULL, 623, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-09 23:56:00', NULL, NULL),
(621, NULL, 624, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 14:38:37', NULL, NULL),
(622, NULL, 625, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 14:39:12', NULL, NULL),
(623, NULL, 626, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 14:40:05', NULL, NULL),
(624, NULL, 627, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 14:40:46', '2025-10-22 22:54:00', NULL),
(625, NULL, 628, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 15:38:57', NULL, NULL),
(626, NULL, 629, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 15:39:00', NULL, '2025-10-17 15:40:46'),
(627, NULL, 630, NULL, NULL, NULL, NULL, NULL, 'active', NULL, '2025-10-17 15:40:09', NULL, NULL),
(628, NULL, 631, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 17:38:41', NULL, NULL),
(629, NULL, 632, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:14:01', NULL, NULL),
(630, NULL, 633, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:15:22', NULL, NULL),
(631, NULL, 634, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:56:45', NULL, NULL),
(632, NULL, 635, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-17 20:57:42', NULL, NULL);

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

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `school_id`, `name`, `code`, `subject_type`) VALUES
(1, 1, 'Science', 'SCI', 'core'),
(2, 1, 'Social studies', 'SST', 'core'),
(3, 1, 'Mathematics', 'MTC', 'core'),
(4, 1, 'English', 'ENG', 'core'),
(6, 1, 'Information and communication technology', 'ICT', 'core'),
(7, 1, 'LITERACY 1', 'LIT 1', 'core'),
(8, 1, 'LITERACY 2', 'LIT 2', 'core'),
(9, 1, 'ISLAMIC RELIGIOUS EDUCATION', 'IRE', 'core'),
(10, 1, 'LANG', 'LA', 'core'),
(11, 1, 'S.D', 'SD', 'core'),
(12, 1, 'READ', 'RD', 'core'),
(14, 1, 'NUMBERS', 'NUM', 'core'),
(15, 1, 'HABITS', 'HB', 'core'),
(16, 1, 'HEALTH', 'HELT', 'core'),
(17, 1, 'LANG 1', 'LA', 'core'),
(18, 1, 'LANG 2', 'LA', 'core'),
(19, 1, 'ISLAMIC RELIGIOUS EDUCATION', 'IRE', 'elective');

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_attendance`
--

CREATE TABLE `tahfiz_attendance` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `status` enum('present','absent','late','excused') DEFAULT 'present',
  `remarks` text DEFAULT NULL,
  `recorded_by` bigint(20) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_books`
--

CREATE TABLE `tahfiz_books` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `total_units` int(11) DEFAULT NULL,
  `unit_type` varchar(50) DEFAULT 'verse',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_evaluations`
--

CREATE TABLE `tahfiz_evaluations` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `evaluator_id` bigint(20) NOT NULL,
  `type` enum('monthly','termly','annual','special') DEFAULT 'monthly',
  `retention_score` decimal(5,2) DEFAULT NULL,
  `tajweed_score` decimal(5,2) DEFAULT NULL,
  `voice_score` decimal(5,2) DEFAULT NULL,
  `discipline_score` decimal(5,2) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `evaluated_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_groups`
--

CREATE TABLE `tahfiz_groups` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `teacher_id` bigint(20) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_group_members`
--

CREATE TABLE `tahfiz_group_members` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(30) DEFAULT 'member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_migration_log`
--

CREATE TABLE `tahfiz_migration_log` (
  `id` bigint(20) NOT NULL,
  `event_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tahfiz_migration_log`
--

INSERT INTO `tahfiz_migration_log` (`id`, `event_time`, `message`) VALUES
(1, '2025-10-07 00:17:46', 'Tahfiz module: created tahfiz_books (stores Qur\'an, Yassarna, Tuhfa, etc.)'),
(2, '2025-10-07 00:17:46', 'Tahfiz module: created tahfiz_groups (halaqat) and tahfiz_group_members (group assignments)'),
(3, '2025-10-07 00:17:46', 'Tahfiz module: created tahfiz_plans and tahfiz_records (memorization plans & daily records)'),
(4, '2025-10-07 00:17:46', 'Tahfiz module: updated tahfiz_plans and tahfiz_records to optionally reference book_id and group_id'),
(5, '2025-10-07 00:17:46', 'Tahfiz module: all changes added without removing existing tables or data. You can view human-friendly log in tahfiz_migration_log table.'),
(6, '2025-10-07 00:17:46', 'Tahfiz module created as part of the main schema. Tables: tahfiz_books, tahfiz_groups, tahfiz_group_members, tahfiz_plans (updated), tahfiz_records (updated).');

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_plans`
--

CREATE TABLE `tahfiz_plans` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `book_id` bigint(20) DEFAULT NULL,
  `teacher_id` bigint(20) NOT NULL,
  `class_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `stream_id` bigint(20) DEFAULT NULL,
  `assigned_date` date NOT NULL,
  `portion_text` varchar(255) NOT NULL,
  `portion_unit` varchar(50) DEFAULT 'verse',
  `expected_length` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL CHECK (`type` in ('tilawa','hifz','muraja','other')),
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_portions`
--

CREATE TABLE `tahfiz_portions` (
  `id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `portion_name` varchar(100) NOT NULL,
  `surah_name` varchar(100) DEFAULT NULL,
  `ayah_from` int(11) DEFAULT NULL,
  `ayah_to` int(11) DEFAULT NULL,
  `juz_number` int(11) DEFAULT NULL,
  `page_from` int(11) DEFAULT NULL,
  `page_to` int(11) DEFAULT NULL,
  `status` enum('pending','in_progress','completed','skipped','review') DEFAULT 'pending',
  `difficulty_level` enum('easy','medium','hard') DEFAULT 'medium',
  `estimated_days` int(11) DEFAULT 1,
  `notes` text DEFAULT NULL,
  `assigned_at` datetime DEFAULT current_timestamp(),
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `reviewed_by` bigint(20) DEFAULT NULL,
  `verified_by` bigint(20) DEFAULT NULL,
  `verification_status` enum('unverified','verified','rejected') DEFAULT 'unverified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tahfiz_records`
--

CREATE TABLE `tahfiz_records` (
  `id` bigint(20) NOT NULL,
  `school_id` bigint(20) NOT NULL,
  `plan_id` bigint(20) NOT NULL,
  `student_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `presented` tinyint(1) DEFAULT 0,
  `presented_length` int(11) DEFAULT 0,
  `retention_score` decimal(5,2) DEFAULT NULL,
  `mark` decimal(5,2) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `recorded_by` bigint(20) DEFAULT NULL,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
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

--
-- Dumping data for table `terms`
--

INSERT INTO `terms` (`id`, `school_id`, `academic_year_id`, `name`, `start_date`, `end_date`, `status`) VALUES
(1, 1, 1, 'Term III', '2025-09-15', '2025-12-05', 'scheduled');

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
-- Indexes for table `tahfiz_attendance`
--
ALTER TABLE `tahfiz_attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_books`
--
ALTER TABLE `tahfiz_books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_evaluations`
--
ALTER TABLE `tahfiz_evaluations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_groups`
--
ALTER TABLE `tahfiz_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_group_members`
--
ALTER TABLE `tahfiz_group_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_group_student` (`group_id`,`student_id`);

--
-- Indexes for table `tahfiz_migration_log`
--
ALTER TABLE `tahfiz_migration_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_plans`
--
ALTER TABLE `tahfiz_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_school_date` (`school_id`,`assigned_date`),
  ADD KEY `idx_teacher` (`teacher_id`);

--
-- Indexes for table `tahfiz_portions`
--
ALTER TABLE `tahfiz_portions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tahfiz_records`
--
ALTER TABLE `tahfiz_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_school_student` (`school_id`,`student_id`),
  ADD KEY `idx_plan` (`plan_id`);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1354;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3013;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=665;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=636;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=633;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `tahfiz_attendance`
--
ALTER TABLE `tahfiz_attendance`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_books`
--
ALTER TABLE `tahfiz_books`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_evaluations`
--
ALTER TABLE `tahfiz_evaluations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_groups`
--
ALTER TABLE `tahfiz_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_group_members`
--
ALTER TABLE `tahfiz_group_members`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_migration_log`
--
ALTER TABLE `tahfiz_migration_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tahfiz_plans`
--
ALTER TABLE `tahfiz_plans`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_portions`
--
ALTER TABLE `tahfiz_portions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tahfiz_records`
--
ALTER TABLE `tahfiz_records`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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

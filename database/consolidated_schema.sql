-- ============================================
-- DRAIS CONSOLIDATED DATABASE SCHEMA
-- Version: 3.0 - Production Ready Multi-Tenant School Management System
-- MySQL 8.0+ Compatible
-- ============================================

DROP DATABASE IF EXISTS drais_school;
CREATE DATABASE drais_school CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE drais_school;

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================
-- 1. UTILITY & CONFIGURATION TABLES
-- ============================================

-- Comprehensive audit logging for all system activities
CREATE TABLE audit_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  actor_user_id BIGINT DEFAULT NULL,
  action VARCHAR(100) NOT NULL,
  entity_type VARCHAR(100) NOT NULL,
  entity_id BIGINT DEFAULT NULL,
  changes_json JSON DEFAULT NULL,
  ip VARCHAR(64) DEFAULT NULL,
  user_agent VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_school_id (school_id),
  INDEX idx_actor_user (actor_user_id),
  INDEX idx_action (action),
  INDEX idx_entity (entity_type, entity_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='System-wide audit trail';

-- Security settings per school
CREATE TABLE security_settings (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  setting_key VARCHAR(100) NOT NULL,
  setting_value TEXT,
  data_type ENUM('string','integer','boolean','json') DEFAULT 'string',
  description TEXT,
  is_editable BOOLEAN DEFAULT TRUE,
  updated_by BIGINT DEFAULT NULL,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_school_setting (school_id, setting_key),
  INDEX idx_school_id (school_id),
  INDEX idx_setting_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Security configuration per school';

-- Document types reference
CREATE TABLE document_types (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(60) NOT NULL UNIQUE,
  label VARCHAR(120) NOT NULL,
  
  INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Document type definitions';

-- ============================================
-- 2. GEOGRAPHY STRUCTURE (UGANDA ADMINISTRATIVE)
-- ============================================

CREATE TABLE districts (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL UNIQUE,
  school_id BIGINT DEFAULT 1,
  
  INDEX idx_name (name),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Districts in Uganda';

CREATE TABLE counties (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  district_id BIGINT NOT NULL,
  name VARCHAR(150) NOT NULL,
  school_id BIGINT DEFAULT 1,
  
  INDEX idx_district (district_id),
  INDEX idx_name (name),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Counties within districts';

CREATE TABLE subcounties (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  county_id BIGINT NOT NULL,
  name VARCHAR(150) NOT NULL,
  school_id BIGINT DEFAULT 1,
  
  INDEX idx_county (county_id),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Subcounties within counties';

CREATE TABLE parishes (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  subcounty_id BIGINT NOT NULL,
  name VARCHAR(150) NOT NULL,
  school_id BIGINT DEFAULT 1,
  
  INDEX idx_subcounty (subcounty_id),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Parishes within subcounties';

CREATE TABLE villages (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  parish_id BIGINT NOT NULL,
  name VARCHAR(150) NOT NULL,
  school_id BIGINT DEFAULT 1,
  
  INDEX idx_parish (parish_id),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Villages within parishes';

-- ============================================
-- 3. MULTI-TENANCY STRUCTURE
-- ============================================

-- Schools - Main tenant entities
CREATE TABLE schools (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(150) NOT NULL,
  legal_name VARCHAR(200) DEFAULT NULL,
  short_code VARCHAR(50) DEFAULT NULL,
  email VARCHAR(150) DEFAULT NULL,
  phone VARCHAR(30) DEFAULT NULL,
  currency VARCHAR(10) DEFAULT 'UGX',
  address TEXT DEFAULT NULL,
  logo_url VARCHAR(255) DEFAULT NULL,
  status ENUM('active','inactive','suspended') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_short_code (short_code),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Multi-tenant school definitions';

-- School branches
CREATE TABLE branches (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  name VARCHAR(150) NOT NULL,
  phone VARCHAR(30) DEFAULT NULL,
  email VARCHAR(150) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='School branch locations';

-- ============================================
-- 4. RBAC SYSTEM (Roles, Permissions)
-- ============================================

-- Role definitions with hierarchy
CREATE TABLE roles (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  description TEXT,
  is_system_role BOOLEAN DEFAULT FALSE,
  hierarchy_level INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  UNIQUE KEY unique_school_role (school_id, name),
  UNIQUE KEY unique_school_slug (school_id, slug),
  INDEX idx_school_id (school_id),
  INDEX idx_slug (slug),
  INDEX idx_hierarchy (hierarchy_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Role definitions with hierarchy';

-- Granular permission system
CREATE TABLE permissions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  module VARCHAR(100) NOT NULL,
  action VARCHAR(100) NOT NULL,
  resource VARCHAR(100) DEFAULT '*',
  description TEXT,
  is_system_permission BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_permission (module, action, resource),
  INDEX idx_module (module),
  INDEX idx_action (action),
  INDEX idx_resource (resource)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Granular permission definitions';

-- Role-permission mapping
CREATE TABLE role_permissions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  role_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  granted BOOLEAN DEFAULT TRUE,
  granted_by BIGINT DEFAULT NULL,
  granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_role_permission (role_id, permission_id),
  INDEX idx_role_id (role_id),
  INDEX idx_permission_id (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Role-permission assignments';

-- ============================================
-- 5. PEOPLE & USER MANAGEMENT
-- ============================================

-- People information (base entity)
CREATE TABLE people (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  other_name VARCHAR(100) DEFAULT NULL,
  gender VARCHAR(15) DEFAULT NULL,
  date_of_birth DATE DEFAULT NULL,
  phone VARCHAR(30) DEFAULT NULL,
  email VARCHAR(150) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  photo_url VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_id (school_id),
  INDEX idx_name (first_name, last_name),
  INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='People information';

-- Enterprise user authentication
CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  person_id BIGINT DEFAULT NULL,
  role VARCHAR(50) DEFAULT 'staff',
  username VARCHAR(100) UNIQUE NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(30) DEFAULT NULL,
  password_hash VARCHAR(255) NOT NULL,
  status ENUM('active','inactive','pending','suspended','locked') DEFAULT 'active',
  last_login TIMESTAMP NULL,
  login_attempts INT DEFAULT 0,
  locked_until TIMESTAMP NULL,
  two_factor_enabled BOOLEAN DEFAULT FALSE,
  two_factor_secret VARCHAR(32) NULL,
  biometric_enabled BOOLEAN DEFAULT FALSE,
  biometric_key TEXT NULL,
  passcode_hash TEXT NULL,
  password_reset_token VARCHAR(64) NULL,
  password_reset_expires TIMESTAMP NULL,
  email_verified BOOLEAN DEFAULT FALSE,
  email_verification_token VARCHAR(64) NULL,
  profile_photo VARCHAR(255) DEFAULT NULL,
  preferences JSON DEFAULT NULL,
  last_activity TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_id (school_id),
  INDEX idx_person_id (person_id),
  INDEX idx_email (email),
  INDEX idx_username (username),
  INDEX idx_status (status),
  INDEX idx_role (role),
  INDEX idx_last_login (last_login),
  INDEX idx_reset_token (password_reset_token),
  INDEX idx_verification_token (email_verification_token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Enterprise user authentication';

-- User-person relationships
CREATE TABLE user_people (
  user_id BIGINT NOT NULL,
  person_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, person_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User-person relationships';

-- User session management
CREATE TABLE user_sessions (
  id VARCHAR(128) PRIMARY KEY,
  user_id BIGINT NOT NULL,
  school_id BIGINT DEFAULT NULL,
  device_id VARCHAR(128) DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  device_fingerprint VARCHAR(64) DEFAULT NULL,
  login_method ENUM('password','biometric','2fa','sso') DEFAULT 'password',
  token_hash VARCHAR(255) NOT NULL,
  refresh_token_hash VARCHAR(255) DEFAULT NULL,
  expires_at TIMESTAMP NOT NULL,
  refresh_expires_at TIMESTAMP DEFAULT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_user_id (user_id),
  INDEX idx_token_hash (token_hash),
  INDEX idx_expires_at (expires_at),
  INDEX idx_is_active (is_active),
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User session tracking';

-- Biometric authentication support
CREATE TABLE user_biometric_credentials (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  credential_id VARCHAR(255) NOT NULL UNIQUE,
  public_key TEXT NOT NULL,
  credential_type ENUM('passkey','fingerprint','face','voice') DEFAULT 'passkey',
  device_name VARCHAR(100) DEFAULT NULL,
  device_info JSON DEFAULT NULL,
  counter BIGINT DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  last_used_at TIMESTAMP NULL,
  registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_user_id (user_id),
  INDEX idx_credential_id (credential_id),
  INDEX idx_credential_type (credential_type),
  INDEX idx_last_used (last_used_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Biometric credentials for WebAuthn';

-- Authentication logging
CREATE TABLE auth_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  user_id BIGINT DEFAULT NULL,
  session_id VARCHAR(128) DEFAULT NULL,
  action ENUM(
    'login_success','login_failed','logout','password_change',
    'password_reset_request','password_reset_success','biometric_setup',
    'biometric_login','biometric_failed','2fa_setup','2fa_verify_success',
    '2fa_verify_failed','account_locked','account_unlocked',
    'permission_denied','role_changed','email_verified'
  ) NOT NULL,
  ip_address VARCHAR(45),
  user_agent TEXT,
  device_fingerprint VARCHAR(64) DEFAULT NULL,
  location_data JSON DEFAULT NULL,
  additional_data JSON DEFAULT NULL,
  risk_score INT DEFAULT 0,
  status ENUM('success','failed','blocked','pending') DEFAULT 'success',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_school_id (school_id),
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_ip_address (ip_address),
  INDEX idx_created_at (created_at),
  INDEX idx_status (status),
  INDEX idx_risk_score (risk_score),
  INDEX idx_session_id (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Authentication event logging';

-- ============================================
-- 6. ACADEMIC STRUCTURE
-- ============================================

-- Academic years
CREATE TABLE academic_years (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(20) NOT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'active',
  
  INDEX idx_school_status (school_id, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Academic year definitions';

-- Terms within academic years
CREATE TABLE terms (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  academic_year_id BIGINT NOT NULL,
  name VARCHAR(20) NOT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'scheduled',
  
  INDEX idx_school_year (school_id, academic_year_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Academic terms';

-- Classes/Grades
CREATE TABLE classes (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(50) NOT NULL,
  curriculum_id INT DEFAULT NULL,
  class_level INT DEFAULT NULL,
  head_teacher_id BIGINT DEFAULT NULL,
  
  INDEX idx_school_id (school_id),
  INDEX idx_curriculum (curriculum_id),
  INDEX idx_head_teacher (head_teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Class/Grade definitions';

-- Streams within classes
CREATE TABLE streams (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  name VARCHAR(50) NOT NULL,
  
  INDEX idx_school_class (school_id, class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Class streams';

-- Subjects
CREATE TABLE subjects (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(120) NOT NULL,
  code VARCHAR(20) DEFAULT NULL,
  subject_type VARCHAR(20) DEFAULT 'core',
  
  INDEX idx_school_type (school_id, subject_type),
  INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Subject definitions';

-- Class-subject assignments
CREATE TABLE class_subjects (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  teacher_id BIGINT DEFAULT NULL,
  
  INDEX idx_school_class (school_id, class_id),
  INDEX idx_subject_teacher (subject_id, teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Class-subject teacher assignments';

-- ============================================
-- 7. STUDENT MANAGEMENT
-- ============================================

-- Students
CREATE TABLE students (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  person_id BIGINT NOT NULL,
  admission_no VARCHAR(50) UNIQUE,
  village_id BIGINT DEFAULT NULL,
  admission_date DATE DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'active',
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_status (school_id, status),
  INDEX idx_admission_no (admission_no),
  INDEX idx_admission_date (admission_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student records';

-- Student enrollments
CREATE TABLE enrollments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  theology_class_id BIGINT DEFAULT NULL,
  stream_id BIGINT DEFAULT NULL,
  academic_year_id BIGINT DEFAULT NULL,
  term_id BIGINT DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'active',
  
  INDEX idx_school_student (school_id, student_id),
  INDEX idx_class_year (class_id, academic_year_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student class enrollments';

-- Student attendance tracking
CREATE TABLE student_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  class_id BIGINT DEFAULT NULL,
  date DATE NOT NULL,
  status ENUM('present', 'absent', 'late', 'excused', 'not_marked') DEFAULT 'not_marked',
  notes TEXT DEFAULT NULL,
  time_in TIME DEFAULT NULL,
  time_out TIME DEFAULT NULL,
  method VARCHAR(20) DEFAULT 'manual',
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_late BOOLEAN GENERATED ALWAYS AS (
    CASE 
      WHEN time_in > '08:30:00' AND status = 'present' THEN TRUE 
      ELSE FALSE 
    END
  ) STORED,
  
  UNIQUE KEY unique_student_date (student_id, date),
  INDEX idx_school_date (school_id, date),
  INDEX idx_status (status),
  INDEX idx_marked_by (marked_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student attendance tracking';

-- Student biometric credentials
CREATE TABLE student_fingerprints (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL UNIQUE,
  method VARCHAR(50) NOT NULL DEFAULT 'passkey',
  credential_id VARCHAR(255) NOT NULL,
  public_key TEXT NOT NULL,
  device_info JSON DEFAULT NULL,
  quality_score INT DEFAULT 0,
  counter BIGINT DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_used_at TIMESTAMP DEFAULT NULL,
  
  INDEX idx_student (student_id),
  INDEX idx_credential (credential_id),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student biometric credentials';

-- ============================================
-- 8. STAFF MANAGEMENT
-- ============================================

-- Staff records
CREATE TABLE staff (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  person_id BIGINT NOT NULL,
  staff_no VARCHAR(50) UNIQUE DEFAULT NULL,
  department_id BIGINT DEFAULT NULL,
  position VARCHAR(100) DEFAULT NULL,
  employment_type ENUM('permanent','contract','volunteer','part-time') DEFAULT 'permanent',
  qualification VARCHAR(255) DEFAULT NULL,
  experience_years INT DEFAULT 0,
  hire_date DATE DEFAULT NULL,
  salary DECIMAL(14,2) DEFAULT NULL,
  bank_name VARCHAR(150) DEFAULT NULL,
  bank_account_no VARCHAR(100) DEFAULT NULL,
  nssf_no VARCHAR(100) DEFAULT NULL,
  tin_no VARCHAR(100) DEFAULT NULL,
  status ENUM('active','inactive','terminated','on_leave') DEFAULT 'active',
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_status (school_id, status),
  INDEX idx_position (position),
  INDEX idx_department (department_id),
  INDEX idx_staff_department (department_id, status),
  INDEX idx_employment_type (employment_type, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Staff records';

-- Staff attendance
CREATE TABLE staff_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  staff_id BIGINT NOT NULL,
  date DATE NOT NULL,
  status ENUM('present','absent','late','excused','on_leave') DEFAULT 'present',
  notes TEXT DEFAULT NULL,
  time_in TIME DEFAULT NULL,
  time_out TIME DEFAULT NULL,
  method VARCHAR(20) DEFAULT 'manual',
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_staff_date (staff_id, date),
  INDEX idx_school_date (school_id, date),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Staff attendance tracking';

-- Departments
CREATE TABLE departments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(120) NOT NULL,
  head_staff_id BIGINT DEFAULT NULL,
  description TEXT DEFAULT NULL,
  budget DECIMAL(14,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_id (school_id),
  INDEX idx_head_staff (head_staff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Department definitions';

-- ============================================
-- 9. ENHANCED TIMETABLE MODULE
-- ============================================

-- Main timetable with recurring support
CREATE TABLE timetable (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  teacher_id BIGINT NOT NULL,
  
  -- Scheduling Information
  lesson_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  day_of_week TINYINT NOT NULL, -- 1=Monday, 7=Sunday
  
  -- Location & Resources
  room VARCHAR(50) DEFAULT NULL,
  venue VARCHAR(100) DEFAULT NULL,
  required_resources TEXT DEFAULT NULL,
  
  -- Lesson Details
  lesson_title VARCHAR(200) DEFAULT NULL,
  lesson_description TEXT DEFAULT NULL,
  lesson_type ENUM('regular', 'revision', 'exam', 'practical', 'field_trip', 'makeup', 'extra') DEFAULT 'regular',
  
  -- Status & Tracking
  status ENUM('scheduled', 'ongoing', 'completed', 'cancelled', 'postponed', 'rescheduled') DEFAULT 'scheduled',
  attendance_taken TINYINT(1) DEFAULT 0,
  
  -- Recurrence Support
  is_recurring TINYINT(1) DEFAULT 0,
  recurrence ENUM('none', 'weekly', 'biweekly') DEFAULT 'none',
  recurrence_pattern ENUM('daily', 'weekly', 'monthly', 'custom') DEFAULT NULL,
  recurrence_end_date DATE DEFAULT NULL,
  recurrence_interval INT DEFAULT 1,
  recurrence_days VARCHAR(20) DEFAULT NULL,
  parent_timetable_id BIGINT DEFAULT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  exception_id BIGINT DEFAULT NULL,
  
  -- Metadata
  notes TEXT DEFAULT NULL,
  created_by BIGINT DEFAULT NULL,
  updated_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  -- Indexes for performance
  INDEX idx_school_class_date (school_id, class_id, lesson_date),
  INDEX idx_teacher_date (teacher_id, lesson_date),
  INDEX idx_subject_date (subject_id, lesson_date),
  INDEX idx_status (status),
  INDEX idx_recurring (is_recurring, parent_timetable_id),
  INDEX idx_day_time (day_of_week, start_time),
  INDEX idx_updated (updated_at),
  INDEX idx_recurrence (recurrence, start_date, end_date),
  INDEX idx_recurring_dates (school_id, recurrence, start_date, end_date, day_of_week),
  
  -- Constraints
  CONSTRAINT chk_day_of_week CHECK (day_of_week BETWEEN 1 AND 7),
  CONSTRAINT chk_time_order CHECK (start_time < end_time),
  CONSTRAINT chk_recurrence_interval CHECK (recurrence_interval > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Enhanced timetable with recurring support';

-- Timetable exceptions for recurring classes
CREATE TABLE timetable_exceptions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  timetable_id BIGINT NOT NULL,
  exception_date DATE NOT NULL,
  exception_type ENUM('skip', 'reschedule', 'modify') DEFAULT 'skip',
  
  -- For rescheduled classes
  new_date DATE DEFAULT NULL,
  new_start_time TIME DEFAULT NULL,
  new_end_time TIME DEFAULT NULL,
  new_room VARCHAR(50) DEFAULT NULL,
  new_venue VARCHAR(100) DEFAULT NULL,
  
  -- For modified classes
  modified_title VARCHAR(200) DEFAULT NULL,
  modified_description TEXT DEFAULT NULL,
  modified_lesson_type ENUM('regular', 'revision', 'exam', 'practical', 'field_trip', 'makeup', 'extra') DEFAULT NULL,
  
  reason VARCHAR(255) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_timetable_date (timetable_id, exception_date),
  INDEX idx_school_date (school_id, exception_date),
  UNIQUE KEY unique_timetable_exception (timetable_id, exception_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Exceptions for recurring timetable entries';

-- ...existing code for timetable templates, notifications, etc...

-- ============================================
-- 10. EXAMINATIONS & ASSESSMENTS
-- ============================================

-- Exam definitions
CREATE TABLE exams (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  term_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  exam_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  duration INT NOT NULL,
  max_marks INT NOT NULL,
  pass_marks INT NOT NULL,
  grading_scheme_id BIGINT DEFAULT NULL,
  
  INDEX idx_exam_class (school_id, term_id, class_id, subject_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Exam definitions';

-- Exam results
CREATE TABLE results (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  exam_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  obtained_marks INT DEFAULT NULL,
  grade VARCHAR(2) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  
  INDEX idx_result_student (school_id, exam_id, student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student exam results';

-- Report cards
CREATE TABLE report_cards (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  academic_year_id BIGINT NOT NULL,
  total_marks INT DEFAULT 0,
  average_marks DECIMAL(5,2) DEFAULT 0.00,
  grade VARCHAR(2) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  
  INDEX idx_report_card_student (school_id, student_id, term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student report cards';

-- ============================================
-- 11. FINANCIAL MANAGEMENT
-- ============================================

-- Financial wallets
CREATE TABLE wallets (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  branch_id BIGINT DEFAULT NULL,
  name VARCHAR(80) NOT NULL,
  method VARCHAR(40) NOT NULL,
  currency VARCHAR(10) DEFAULT 'UGX',
  opening_balance DECIMAL(14,2) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_school_branch (school_id, branch_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Financial wallets';

-- Financial categories
CREATE TABLE finance_categories (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  type VARCHAR(20) NOT NULL,
  name VARCHAR(120) NOT NULL,
  
  INDEX idx_school_type (school_id, type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Financial transaction categories';

-- Financial ledger
CREATE TABLE ledger (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  wallet_id BIGINT NOT NULL,
  category_id BIGINT NOT NULL,
  tx_type VARCHAR(10) NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  reference VARCHAR(120) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  student_id BIGINT DEFAULT NULL,
  staff_id BIGINT DEFAULT NULL,
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_school_wallet (school_id, wallet_id),
  INDEX idx_tx_type (tx_type),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Financial transaction ledger';

-- Fee structures
CREATE TABLE fee_structures (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  item VARCHAR(120) NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  
  INDEX idx_school_class_term (school_id, class_id, term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Fee structure definitions';

-- Student fee items
CREATE TABLE student_fee_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  item VARCHAR(120) NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  discount DECIMAL(14,2) DEFAULT 0,
  paid DECIMAL(14,2) DEFAULT 0,
  balance DECIMAL(14,2) GENERATED ALWAYS AS (amount - discount - paid) STORED,
  
  INDEX idx_school_student_term (school_id, student_id, term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Student fee assignments';

-- Fee payments
CREATE TABLE fee_payments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  wallet_id BIGINT NOT NULL,
  amount DECIMAL(14,2) NOT NULL,
  method VARCHAR(30) DEFAULT NULL,
  paid_by VARCHAR(150) DEFAULT NULL,
  payer_contact VARCHAR(50) DEFAULT NULL,
  reference VARCHAR(120) DEFAULT NULL,
  receipt_no VARCHAR(40) DEFAULT NULL,
  ledger_id BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_school_student (school_id, student_id),
  INDEX idx_created_at (created_at),
  INDEX idx_fee_payments_school (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Fee payment records';

-- ============================================
-- 12. TAHFIZ MODULE
-- ============================================

-- Tahfiz books
CREATE TABLE tahfiz_books (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  title VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  total_units INT DEFAULT NULL,
  unit_type VARCHAR(50) DEFAULT 'verse',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tahfiz books';

-- Tahfiz groups
CREATE TABLE tahfiz_groups (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(100) NOT NULL,
  teacher_id BIGINT NOT NULL,
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_school_teacher (school_id, teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tahfiz study groups';

-- Tahfiz group members
CREATE TABLE tahfiz_group_members (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  group_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  role VARCHAR(30) DEFAULT 'member',
  
  UNIQUE KEY uniq_group_student (group_id, student_id),
  INDEX idx_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Tahfiz group memberships';

-- ============================================
-- 13. DOCUMENT MANAGEMENT
-- ============================================

-- Documents
CREATE TABLE documents (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  owner_type VARCHAR(30) NOT NULL,
  owner_id BIGINT NOT NULL,
  document_type_id BIGINT NOT NULL,
  file_name VARCHAR(200) NOT NULL,
  file_url VARCHAR(255) NOT NULL,
  mime_type VARCHAR(100) DEFAULT NULL,
  file_size BIGINT DEFAULT NULL,
  issued_by VARCHAR(150) DEFAULT NULL,
  issue_date DATE DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  uploaded_by BIGINT DEFAULT NULL,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  INDEX idx_school_owner (school_id, owner_type, owner_id),
  INDEX idx_document_type (document_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Document storage';

-- ============================================
-- 14. INSERT DEFAULT DATA
-- ============================================

-- Insert system roles
INSERT INTO roles (school_id, name, slug, description, is_system_role, hierarchy_level) VALUES
(NULL, 'Super Administrator', 'superadmin', 'System-wide administrator with full access', TRUE, 0),
(NULL, 'School Administrator', 'admin', 'School-level administrator', TRUE, 1),
(NULL, 'Teacher', 'teacher', 'Teaching staff with class management access', TRUE, 2),
(NULL, 'Finance Manager', 'finance', 'Financial operations and reporting', TRUE, 2),
(NULL, 'Staff', 'staff', 'General school staff', TRUE, 3),
(NULL, 'Student', 'student', 'Student with limited access', TRUE, 4),
(NULL, 'Parent/Guardian', 'parent', 'Parent/Guardian with student-related access', TRUE, 4)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Insert core permissions
INSERT INTO permissions (module, action, resource, description, is_system_permission) VALUES
-- User Management
('users', 'view', '*', 'View user accounts', TRUE),
('users', 'create', '*', 'Create new user accounts', TRUE),
('users', 'edit', '*', 'Edit user accounts', TRUE),
('users', 'delete', '*', 'Delete user accounts', TRUE),
('users', 'reset_password', '*', 'Reset user passwords', TRUE),

-- Academic Management
('academics', 'view', '*', 'View academic data', TRUE),
('academics', 'create', '*', 'Create academic records', TRUE),
('academics', 'edit', '*', 'Edit academic records', TRUE),
('academics', 'delete', '*', 'Delete academic records', TRUE),

-- Student Management
('students', 'view', '*', 'View student information', TRUE),
('students', 'create', '*', 'Register new students', TRUE),
('students', 'edit', '*', 'Edit student information', TRUE),
('students', 'delete', '*', 'Remove students', TRUE),

-- Timetable Management
('timetable', 'view', '*', 'View timetable', TRUE),
('timetable', 'create', '*', 'Create timetable entries', TRUE),
('timetable', 'edit', '*', 'Edit timetable entries', TRUE),
('timetable', 'delete', '*', 'Delete timetable entries', TRUE),

-- Finance Management
('finance', 'view', '*', 'View financial data', TRUE),
('finance', 'create', '*', 'Create financial records', TRUE),
('finance', 'edit', '*', 'Edit financial records', TRUE),
('finance', 'delete', '*', 'Delete financial records', TRUE),

-- Reports
('reports', 'view', '*', 'View reports', TRUE),
('reports', 'export', '*', 'Export reports', TRUE),

-- System Administration
('system', 'settings', '*', 'Manage system settings', TRUE),
('system', 'backup', '*', 'Perform system backups', TRUE),
('system', 'logs', '*', 'View system logs', TRUE)

ON DUPLICATE KEY UPDATE description=VALUES(description);

-- Insert document types
INSERT INTO document_types (code, label) VALUES
('national_id','National ID'),
('passport_photo','Passport Photo'),
('full_photo','Full Photo'),
('birth_certificate','Birth Certificate'),
('transfer_letter','Transfer Letter'),
('other','Other')
ON DUPLICATE KEY UPDATE label=VALUES(label);

-- Insert default security settings
INSERT INTO security_settings (school_id, setting_key, setting_value, data_type, description, is_editable) VALUES
(NULL, 'password_min_length', '8', 'integer', 'Minimum password length', TRUE),
(NULL, 'password_require_uppercase', 'true', 'boolean', 'Require uppercase letters in passwords', TRUE),
(NULL, 'password_require_lowercase', 'true', 'boolean', 'Require lowercase letters in passwords', TRUE),
(NULL, 'password_require_numbers', 'true', 'boolean', 'Require numbers in passwords', TRUE),
(NULL, 'login_max_attempts', '5', 'integer', 'Maximum failed login attempts before lockout', TRUE),
(NULL, 'login_lockout_duration', '15', 'integer', 'Account lockout duration in minutes', TRUE),
(NULL, 'session_timeout', '480', 'integer', 'Session timeout in minutes', TRUE),
(NULL, 'biometric_enabled', 'true', 'boolean', 'Enable biometric authentication', TRUE)
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

-- ============================================
-- 15. CREATE VIEWS FOR COMMON QUERIES
-- ============================================

-- User permissions view for easy access control
CREATE OR REPLACE VIEW user_permissions_view AS
SELECT DISTINCT
    u.id as user_id,
    u.email,
    u.username,
    u.role as default_role,
    p.module,
    p.action,
    p.resource,
    u.school_id
FROM users u
LEFT JOIN permissions p ON 1=1  -- Simplified for initial setup
WHERE u.status = 'active' AND u.deleted_at IS NULL;

-- Active sessions view for monitoring
CREATE OR REPLACE VIEW active_sessions_view AS
SELECT 
    s.id as session_id,
    u.id as user_id,
    u.email,
    u.username,
    s.ip_address,
    s.login_method,
    s.updated_at as last_activity,
    s.expires_at,
    s.school_id
FROM user_sessions s
JOIN users u ON s.user_id = u.id
WHERE s.is_active = TRUE 
AND s.expires_at > NOW()
AND u.status = 'active';

-- ============================================
-- 16. RE-ENABLE FOREIGN KEY CHECKS
-- ============================================

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- EXECUTION COMPLETED SUCCESSFULLY
-- ============================================

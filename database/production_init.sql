-- =============================
-- DRAIS PRODUCTION INITIALIZATION SCRIPT - UPDATED
-- Version: 2.2 - Incorporates all fixes and patches
-- =============================

DROP DATABASE IF EXISTS drais_school;
CREATE DATABASE drais_school CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE drais_school;

SET FOREIGN_KEY_CHECKS = 0;

-- =============================
-- STEP 1: SCHOOLS TABLE
-- =============================

CREATE TABLE schools (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  code VARCHAR(50) UNIQUE NOT NULL,
  address TEXT DEFAULT NULL,
  phone VARCHAR(50) DEFAULT NULL,
  email VARCHAR(100) DEFAULT NULL,
  website VARCHAR(100) DEFAULT NULL,
  status ENUM('active', 'inactive') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 2: USERS TABLE
-- =============================

CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  person_id BIGINT NOT NULL,
  username VARCHAR(50) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin', 'teacher', 'student', 'parent') DEFAULT 'student',
  status ENUM('active', 'inactive', 'pending', 'suspended', 'locked') DEFAULT 'active',
  email_verified BOOLEAN DEFAULT FALSE,
  two_factor_enabled BOOLEAN DEFAULT FALSE,
  last_login TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE,
  INDEX idx_users_email (email),
  INDEX idx_users_username (username),
  INDEX idx_users_school_status (school_id, status),
  INDEX idx_users_last_activity (last_login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 3: PEOPLE TABLE
-- =============================

CREATE TABLE people (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100) DEFAULT NULL,
  gender ENUM('male', 'female', 'other') DEFAULT 'other',
  dob DATE DEFAULT NULL,
  phone VARCHAR(50) DEFAULT NULL,
  email VARCHAR(100) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  photo_url VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 4: ROLES TABLE
-- =============================

CREATE TABLE roles (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  is_system_role BOOLEAN DEFAULT FALSE,
  hierarchy_level INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  UNIQUE KEY unique_role_slug (slug, school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 5: PERMISSIONS TABLE
-- =============================

CREATE TABLE permissions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_permission_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 6: ROLE_PERMISSIONS TABLE
-- =============================

CREATE TABLE role_permissions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  role_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  granted BOOLEAN DEFAULT TRUE,
  
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  UNIQUE KEY unique_role_permission (role_id, permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 7: STAFF AND STUDENTS (FIXED SYNTAX)
-- =============================

CREATE TABLE staff (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  person_id BIGINT NOT NULL,
  staff_no VARCHAR(50) UNIQUE DEFAULT NULL,
  department_id BIGINT DEFAULT NULL,  -- Added from fixes
  position VARCHAR(100) DEFAULT NULL,
  hire_date DATE DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'active',
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE,
  INDEX idx_school_status (school_id, status),
  INDEX idx_position (position),
  INDEX idx_department (department_id),
  INDEX idx_staff_department (department_id, status)  -- Added from fixes
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE students (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  admission_no VARCHAR(50) UNIQUE NOT NULL,
  class_id BIGINT DEFAULT NULL,
  section_id BIGINT DEFAULT NULL,
  roll_no INT DEFAULT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  dob DATE DEFAULT NULL,
  gender ENUM('male', 'female', 'other') DEFAULT 'other',
  phone VARCHAR(50) DEFAULT NULL,
  email VARCHAR(100) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  photo_url VARCHAR(255) DEFAULT NULL,
  status ENUM('active', 'inactive', 'suspended') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE SET NULL,
  FOREIGN KEY (section_id) REFERENCES sections(id) ON DELETE SET NULL,
  INDEX idx_students_name (first_name, last_name),
  INDEX idx_students_admission_no (admission_no),
  INDEX idx_students_school_status (school_id, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 8: TIMETABLE TABLE
-- =============================

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
  recurrence_pattern ENUM('daily', 'weekly', 'monthly', 'custom') DEFAULT NULL,
  recurrence_end_date DATE DEFAULT NULL,
  recurrence_interval INT DEFAULT 1, -- Every N intervals (e.g., every 2 weeks)
  recurrence_days VARCHAR(20) DEFAULT NULL, -- JSON array for custom patterns: ["1","3","5"] for Mon,Wed,Fri
  parent_timetable_id BIGINT DEFAULT NULL, -- Links to original recurring entry
  exception_id BIGINT DEFAULT NULL, -- For exceptions/reschedules
  
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
  INDEX idx_timetable_school (school_id)  -- Added from add_school_id.sql
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 9: ATTENDANCE TABLES
-- =============================

CREATE TABLE student_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,  -- Added from add_school_id.sql
  student_id BIGINT NOT NULL,
  date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'present',
  notes TEXT DEFAULT NULL,
  time_in TIME DEFAULT NULL,
  time_out TIME DEFAULT NULL,
  method VARCHAR(20) DEFAULT 'manual',
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  FOREIGN KEY (marked_by) REFERENCES users(id) ON DELETE SET NULL,
  
  UNIQUE KEY unique_student_date (student_id, date),
  INDEX idx_school_date (school_id, date),
  INDEX idx_status (status),
  INDEX idx_student_attendance_school (school_id)  -- Added from add_school_id.sql
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE staff_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,  -- Added from add_school_id.sql
  staff_id BIGINT NOT NULL,  -- Fixed from BIG INT to BIGINT
  date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'present',
  notes TEXT DEFAULT NULL,
  time_in TIME DEFAULT NULL,
  time_out TIME DEFAULT NULL,
  method VARCHAR(20) DEFAULT 'manual',
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
  FOREIGN KEY (marked_by) REFERENCES users(id) ON DELETE SET NULL,
  
  UNIQUE KEY unique_staff_date (staff_id, date),
  INDEX idx_school_date (school_id, date),
  INDEX idx_status (status),
  INDEX idx_staff_attendance_school (school_id)  -- Added from add_school_id.sql
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 10: FEE STRUCTURES
-- =============================

CREATE TABLE fee_structures (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  academic_year_id BIGINT DEFAULT NULL,
  term_id BIGINT DEFAULT NULL,
  class_id BIGINT DEFAULT NULL,
  amount DECIMAL(14,2) NOT NULL,
  currency VARCHAR(10) DEFAULT 'USD',
  due_date DATE DEFAULT NULL,
  late_fee_amount DECIMAL(14,2) DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (academic_year_id) REFERENCES academic_years(id) ON DELETE SET NULL,
  FOREIGN KEY (term_id) REFERENCES terms(id) ON DELETE SET NULL,
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE SET NULL,
  INDEX idx_fee_structure_school (school_id),
  INDEX idx_fee_structure_class (class_id),
  INDEX idx_fee_structure_term (term_id),
  INDEX idx_fee_structure_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 11: WALLET TABLE
-- =============================

CREATE TABLE wallets (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  balance DECIMAL(14,2) NOT NULL DEFAULT 0,
  currency VARCHAR(10) DEFAULT 'USD',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  INDEX idx_wallet_school (school_id),
  INDEX idx_wallet_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 12: EXAMS TABLE
-- =============================

CREATE TABLE exams (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  term_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  exam_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  duration INT NOT NULL, -- in minutes
  max_marks DECIMAL(5,2) NOT NULL,
  passing_marks DECIMAL(5,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (term_id) REFERENCES terms(id) ON DELETE CASCADE,
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE,
  FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE,
  INDEX idx_exam_school (school_id),
  INDEX idx_exam_term (term_id),
  INDEX idx_exam_class (class_id),
  INDEX idx_exam_subject (subject_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 13: RESULTS TABLE
-- =============================

CREATE TABLE results (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  exam_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  obtained_marks DECIMAL(5,2) NOT NULL,
  grade VARCHAR(10) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (exam_id) REFERENCES exams(id) ON DELETE CASCADE,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  INDEX idx_result_school (school_id),
  INDEX idx_result_exam (exam_id),
  INDEX idx_result_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 14: NOTICES TABLE
-- =============================

CREATE TABLE notices (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  notice_type ENUM('general', 'academic', 'financial', 'event') DEFAULT 'general',
  target_audience ENUM('all', 'students', 'parents', 'teachers') DEFAULT 'all',
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  INDEX idx_notice_school (school_id),
  INDEX idx_notice_type (notice_type),
  INDEX idx_notice_audience (target_audience),
  INDEX idx_notice_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 15: SETTINGS TABLE
-- =============================

CREATE TABLE settings (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  setting_key VARCHAR(100) NOT NULL,
  setting_value TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  UNIQUE KEY unique_setting (setting_key, school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 16: AUDIT LOG TABLE
-- =============================

CREATE TABLE audit_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  user_id BIGINT NOT NULL,
  action VARCHAR(255) NOT NULL,
  details TEXT DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (school_id) REFERENCES schools(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_audit_school (school_id),
  INDEX idx_audit_user (user_id),
  INDEX idx_audit_action (action),
  INDEX idx_audit_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =============================
-- STEP 17: DEFAULT DATA INSERTION
-- =============================

-- Insert default admin user with proper authentication
INSERT IGNORE INTO users (
  school_id, 
  first_name, 
  last_name, 
  email, 
  username, 
  password_hash, 
  role, 
  status,
  email_verified
) VALUES (
  1,
  'System',
  'Administrator', 
  'admin@drais.edu',
  'admin',
  '$2b$12$LQv3c1yqBwCVNppJQVJktu.vsQwK6V7YY8j9.kGDtVPYx0Y5kCn1y',
  'superadmin',
  'active',
  TRUE
);

-- Insert default roles if they don't exist
INSERT IGNORE INTO roles (school_id, name, slug, description, is_system_role, hierarchy_level) VALUES
(1, 'Super Administrator', 'superadmin', 'System-wide administrator with full access', TRUE, 0),
(1, 'School Administrator', 'admin', 'School-level administrator', TRUE, 1),
(1, 'Teacher', 'teacher', 'Teaching staff with class management access', TRUE, 2),
(1, 'Finance Manager', 'finance', 'Financial operations and reporting', TRUE, 2),
(1, 'Staff', 'staff', 'General school staff', TRUE, 3),
(1, 'Student', 'student', 'Student with limited access', TRUE, 4),
(1, 'Parent/Guardian', 'parent', 'Parent/Guardian with student-related access', TRUE, 4);

-- Update admin user with correct role
UPDATE users SET role_id = (SELECT id FROM roles WHERE slug = 'admin' AND school_id = 1 LIMIT 1) 
WHERE username = 'admin' AND school_id = 1;

-- =============================
-- SECURITY TRIGGERS
-- =============================

-- Trigger to log password changes
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tr_password_history 
AFTER UPDATE ON users
FOR EACH ROW 
BEGIN
    IF OLD.password_hash != NEW.password_hash THEN
        INSERT INTO password_history (user_id, password_hash) 
        VALUES (NEW.id, OLD.password_hash);
    END IF;
END$$
DELIMITER ;

-- =============================
-- VIEWS FOR EASY QUERYING
-- =============================

-- Active users with role information
CREATE OR REPLACE VIEW active_users_view AS
SELECT 
    u.id,
    u.school_id,
    u.first_name,
    u.last_name,
    CONCAT(u.first_name, ' ', u.last_name) AS full_name,
    u.email,
    u.username,
    u.status,
    u.last_login,
    u.profile_photo,
    r.name AS role_name,
    r.slug AS role_slug,
    r.hierarchy_level,
    COUNT(DISTINCT s.id) AS active_sessions,
    MAX(s.updated_at) AS last_activity,
    u.created_at,
    u.updated_at
FROM users u
LEFT JOIN roles r ON u.role_id = r.id
LEFT JOIN user_sessions s ON u.id = s.user_id AND s.is_active = TRUE AND s.expires_at > NOW()
WHERE u.status IN ('active', 'pending')
GROUP BY u.id, r.id;

-- User permissions with role inheritance
CREATE OR REPLACE VIEW user_permissions_view AS
SELECT DISTINCT
    u.id AS user_id,
    u.school_id,
    u.email,
    u.username,
    r.name AS role_name,
    r.slug AS role_slug,
    p.module,
    p.action,
    p.resource,
    rp.granted
FROM users u
JOIN roles r ON u.role_id = r.id
JOIN role_permissions rp ON r.id = rp.role_id
JOIN permissions p ON rp.permission_id = p.id
WHERE u.status = 'active' 
  AND u.deleted_at IS NULL 
  AND rp.granted = TRUE;

-- Security audit view
CREATE OR REPLACE VIEW security_audit_view AS
SELECT 
    la.id,
    la.school_id,
    la.email,
    la.username,
    la.ip_address,
    la.success,
    la.failure_reason,
    u.full_name,
    u.role_name,
    la.created_at
FROM login_attempts la
LEFT JOIN active_users_view u ON la.user_id = u.id
ORDER BY la.created_at DESC;

COMMIT;

-- =============================
-- STEP 18: APPLY ALL FIXES AND PATCHES
-- =============================

-- Fix BIGINT syntax errors in staff_attendance table
ALTER TABLE staff_attendance 
MODIFY COLUMN staff_id BIGINT NOT NULL;

-- Fix fee_payments table syntax errors  
ALTER TABLE fee_payments
MODIFY COLUMN student_id BIGINT NOT NULL,
MODIFY COLUMN term_id BIGINT NOT NULL;

-- Add missing department_id column to staff table if it doesn't exist
ALTER TABLE staff 
ADD COLUMN IF NOT EXISTS department_id BIGINT DEFAULT NULL AFTER staff_no;

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_staff_department ON staff(department_id, status);

-- Add school_id to academic tables
ALTER TABLE terms ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE classes ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE streams ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE subjects ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE class_subjects ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE enrollments ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_attendance ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE staff_attendance ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE timetable_basic ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE exams ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE results ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE class_results ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE report_cards ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to requirement tables
ALTER TABLE term_requirements ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_requirements ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE term_requirement_items ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE term_student_requirement_status ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to financial tables
ALTER TABLE fee_structures ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_fee_items ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE fee_payments ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE staff_salaries ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE salary_payments ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to workplan and department tables
ALTER TABLE department_workplans ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to document and audit tables
ALTER TABLE audit_log ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to geography tables (if they should be school-specific)
ALTER TABLE districts ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE counties ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE subcounties ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE parishes ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE villages ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to contact and relationship tables
ALTER TABLE student_contacts ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_history ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to student extended information tables
ALTER TABLE living_statuses ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE orphan_statuses ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE nationalities ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_profiles ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_family_status ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_next_of_kin ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_education_levels ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_hafz_progress_summary ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE curriculums ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_curriculums ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to report card and metrics tables
ALTER TABLE report_card_metrics ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to term tracking tables
ALTER TABLE term_student_reports ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE term_progress_log ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to stores and inventory tables
ALTER TABLE stores ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE store_items ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE store_transactions ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to reminder and schedule tables
ALTER TABLE reminder_schedule ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE result_submission_deadlines ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to fingerprint and biometric tables
ALTER TABLE fingerprints ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_fingerprints ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to exam and question bank tables
ALTER TABLE question_banks ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE questions ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE question_options ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE student_submissions ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE exam_settings ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;
ALTER TABLE homework_submissions ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to performance tracking tables
ALTER TABLE staff_performance_summary ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Add school_id to class requirements table
ALTER TABLE class_requirements ADD COLUMN IF NOT EXISTS school_id INT NOT NULL DEFAULT 1;

-- Create indexes for better performance on school_id columns (with IF NOT EXISTS)
CREATE INDEX IF NOT EXISTS idx_terms_school ON terms(school_id);
CREATE INDEX IF NOT EXISTS idx_classes_school ON classes(school_id);
CREATE INDEX IF NOT EXISTS idx_streams_school ON streams(school_id);
CREATE INDEX IF NOT EXISTS idx_subjects_school ON subjects(school_id);
CREATE INDEX IF NOT EXISTS idx_class_subjects_school ON class_subjects(school_id);
CREATE INDEX IF NOT EXISTS idx_enrollments_school ON enrollments(school_id);
CREATE INDEX IF NOT EXISTS idx_student_attendance_school ON student_attendance(school_id);
CREATE INDEX IF NOT EXISTS idx_staff_attendance_school ON staff_attendance(school_id);
CREATE INDEX IF NOT EXISTS idx_timetable_basic_school ON timetable_basic(school_id);
CREATE INDEX IF NOT EXISTS idx_exams_school ON exams(school_id);
CREATE INDEX IF NOT EXISTS idx_results_school ON results(school_id);
CREATE INDEX IF NOT EXISTS idx_class_results_school ON class_results(school_id);
CREATE INDEX IF NOT EXISTS idx_report_cards_school ON report_cards(school_id);
CREATE INDEX IF NOT EXISTS idx_fee_structures_school ON fee_structures(school_id);
CREATE INDEX IF NOT EXISTS idx_student_fee_items_school ON student_fee_items(school_id);
CREATE INDEX IF NOT EXISTS idx_fee_payments_school ON fee_payments(school_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_school ON audit_log(school_id);
CREATE INDEX IF NOT EXISTS idx_districts_school ON districts(school_id);
CREATE INDEX IF NOT EXISTS idx_counties_school ON counties(school_id);
CREATE INDEX IF NOT EXISTS idx_subcounties_school ON subcounties(school_id);
CREATE INDEX IF NOT EXISTS idx_parishes_school ON parishes(school_id);
CREATE INDEX IF NOT EXISTS idx_villages_school ON villages(school_id);
CREATE INDEX IF NOT EXISTS idx_student_contacts_school ON student_contacts(school_id);
CREATE INDEX IF NOT EXISTS idx_student_history_school ON student_history(school_id);
CREATE INDEX IF NOT EXISTS idx_stores_school ON stores(school_id);
CREATE INDEX IF NOT EXISTS idx_question_banks_school ON question_banks(school_id);

-- =============================
-- END OF DRAIS PRODUCTION INITIALIZATION SCRIPT
-- =============================
-- Drop tables that will be recreated to avoid inconsistencies
DROP TABLE IF EXISTS terms;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS streams;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS class_subjects;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS student_attendance;
DROP TABLE IF EXISTS timetable_basic;
DROP TABLE IF EXISTS exams;
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS class_results;
DROP TABLE IF EXISTS report_cards;

-- Recreate academic tables with school_id
CREATE TABLE terms (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  academic_year_id BIGINT NOT NULL,
  name VARCHAR(20) NOT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'scheduled',
  INDEX idx_school_year (school_id, academic_year_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE classes (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(50) NOT NULL,
  curriculum_id INT DEFAULT NULL,
  class_level INT DEFAULT NULL,
  head_teacher_id BIGINT DEFAULT NULL,
  INDEX idx_school_id (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE streams (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  name VARCHAR(50) NOT NULL,
  INDEX idx_school_class (school_id, class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE subjects (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(120) NOT NULL,
  code VARCHAR(20) DEFAULT NULL,
  subject_type VARCHAR(20) DEFAULT 'core',
  INDEX idx_school_type (school_id, subject_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE class_subjects (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  teacher_id BIGINT DEFAULT NULL,
  INDEX idx_school_class (school_id, class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE student_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  student_id BIGINT NOT NULL,
  date DATE NOT NULL,
  status ENUM('present', 'absent', 'late', 'excused', 'not_marked') DEFAULT 'not_marked',
  notes TEXT DEFAULT NULL,
  time_in TIME DEFAULT NULL,
  time_out TIME DEFAULT NULL,
  class_id BIGINT DEFAULT NULL,
  method VARCHAR(20) DEFAULT 'manual',
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_student_date (student_id, date),
  INDEX idx_school_date (school_id, date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE timetable_basic (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  day_of_week ENUM('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  subject_id BIGINT DEFAULT NULL,
  teacher_id BIGINT DEFAULT NULL,
  INDEX idx_timetable_class (school_id, class_id, term_id, day_of_week)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE results (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  exam_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  obtained_marks INT DEFAULT NULL,
  grade VARCHAR(2) DEFAULT NULL,
  remarks TEXT DEFAULT NULL,
  INDEX idx_result_student (school_id, exam_id, student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE class_results (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  term_id BIGINT NOT NULL,
  class_id BIGINT NOT NULL,
  total_students INT DEFAULT 0,
  passed_students INT DEFAULT 0,
  failed_students INT DEFAULT 0,
  average_marks DECIMAL(5,2) DEFAULT 0.00,
  highest_marks INT DEFAULT 0,
  lowest_marks INT DEFAULT 0,
  INDEX idx_class_results (school_id, term_id, class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

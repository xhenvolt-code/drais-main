-- Additional indexes for better attendance query performance
CREATE INDEX idx_student_attendance_date_class ON student_attendance(date, class_id);
CREATE INDEX idx_student_attendance_student_date ON student_attendance(student_id, date);
CREATE INDEX idx_enrollments_class_status ON enrollments(class_id, status);

-- Update student_attendance table to ensure proper time tracking
ALTER TABLE student_attendance 
MODIFY COLUMN time_in TIME DEFAULT NULL,
MODIFY COLUMN time_out TIME DEFAULT NULL,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Add a computed column for better attendance status tracking
ALTER TABLE student_attendance 
ADD COLUMN is_late BOOLEAN GENERATED ALWAYS AS (
  CASE 
    WHEN time_in > '08:30:00' AND status = 'present' THEN TRUE 
    ELSE FALSE 
  END
) STORED;

-- Additional performance indexes
CREATE INDEX idx_student_performance_rank ON student_performance_summary(school_id, class_id, overall_average DESC);
CREATE INDEX idx_fee_balance ON student_performance_summary(school_id, fee_balance DESC);
CREATE INDEX idx_results_student_term ON results(student_id, exam_id);
CREATE INDEX idx_class_results_performance ON class_results(student_id, term_id, score DESC);
CREATE INDEX idx_fee_payments_date ON fee_payments(created_at, student_id);

-- Enhanced staff table for comprehensive staff management
ALTER TABLE staff 
ADD COLUMN IF NOT EXISTS branch_id BIGINT DEFAULT 1 AFTER school_id,
ADD COLUMN IF NOT EXISTS department_id BIGINT DEFAULT NULL AFTER staff_no,
ADD COLUMN IF NOT EXISTS role_id BIGINT DEFAULT NULL AFTER department_id,
ADD COLUMN IF NOT EXISTS employment_type ENUM('permanent','contract','volunteer','part-time') DEFAULT 'permanent' AFTER position,
ADD COLUMN IF NOT EXISTS qualification VARCHAR(255) DEFAULT NULL AFTER employment_type,
ADD COLUMN IF NOT EXISTS experience_years INT DEFAULT 0 AFTER qualification,
ADD COLUMN IF NOT EXISTS salary DECIMAL(14,2) DEFAULT NULL AFTER hire_date,
ADD COLUMN IF NOT EXISTS bank_name VARCHAR(150) DEFAULT NULL AFTER salary,
ADD COLUMN IF NOT EXISTS bank_account_no VARCHAR(100) DEFAULT NULL AFTER bank_name,
ADD COLUMN IF NOT EXISTS nssf_no VARCHAR(100) DEFAULT NULL AFTER bank_account_no,
ADD COLUMN IF NOT EXISTS tin_no VARCHAR(100) DEFAULT NULL AFTER nssf_no,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER status,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Modify staff status to use ENUM
ALTER TABLE staff 
MODIFY COLUMN status ENUM('active','inactive','terminated','on_leave') DEFAULT 'active';

-- Modify hire_date to be DATE type
ALTER TABLE staff 
MODIFY COLUMN hire_date DATE DEFAULT NULL;

-- Create staff_user_accounts mapping table
CREATE TABLE IF NOT EXISTS staff_user_accounts (
  staff_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (staff_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Enhanced staff_attendance table
ALTER TABLE staff_attendance 
MODIFY COLUMN date DATE NOT NULL,
MODIFY COLUMN status ENUM('present','absent','late','excused','on_leave') DEFAULT 'present',
ADD COLUMN IF NOT EXISTS time_in TIME DEFAULT NULL AFTER notes,
ADD COLUMN IF NOT EXISTS time_out TIME DEFAULT NULL AFTER time_in,
ADD COLUMN IF NOT EXISTS method VARCHAR(20) DEFAULT 'manual' AFTER time_out,
ADD COLUMN IF NOT EXISTS marked_by BIGINT DEFAULT NULL AFTER method,
ADD COLUMN IF NOT EXISTS marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER marked_by,
ADD UNIQUE KEY IF NOT EXISTS unique_staff_date (staff_id, date);

-- Staff qualifications table for education/certifications
CREATE TABLE IF NOT EXISTS staff_qualifications (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  staff_id BIGINT NOT NULL,
  qualification_name VARCHAR(255) NOT NULL,
  institution VARCHAR(255) DEFAULT NULL,
  year_completed VARCHAR(10) DEFAULT NULL,
  certificate_url VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Performance indexes for staff operations
CREATE INDEX IF NOT EXISTS idx_staff_department ON staff(department_id, status);
CREATE INDEX IF NOT EXISTS idx_staff_role ON staff(role_id, status);
CREATE INDEX IF NOT EXISTS idx_staff_employment_type ON staff(employment_type, status);
CREATE INDEX IF NOT EXISTS idx_staff_qualifications_staff ON staff_qualifications(staff_id);

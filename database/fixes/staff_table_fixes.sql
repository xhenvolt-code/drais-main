-- Apply syntax fixes that are already correctly defined

-- Drop and recreate tables to avoid inconsistencies
DROP TABLE IF EXISTS staff_attendance;
DROP TABLE IF EXISTS fee_payments;

-- Recreate staff_attendance table with correct syntax
CREATE TABLE staff_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  staff_id BIGINT NOT NULL,
  date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'present',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Recreate fee_payments table with correct syntax
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add missing department_id column to staff table if it doesn't exist
ALTER TABLE staff 
ADD COLUMN IF NOT EXISTS department_id BIGINT DEFAULT NULL AFTER staff_no;

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_staff_department ON staff(department_id, status);

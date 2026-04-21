-- =============================
-- Migration: 005_tahfiz_results_support.sql
-- Purpose: Enable Tahfiz results using existing class_results table
-- Date: 2025-11-15
-- =============================

USE drais_school;

-- Step 1: Update subjects table to support 'tahfiz' subject type
-- Modify the subject_type column to include 'tahfiz' option
ALTER TABLE subjects 
MODIFY COLUMN subject_type VARCHAR(20) DEFAULT 'core'
COMMENT 'Subject type: core, elective, tahfiz, extra';

-- Step 2: Add index for better query performance
ALTER TABLE subjects
ADD INDEX IF NOT EXISTS idx_subject_type (subject_type);

-- Step 3: Ensure class_results table has proper indexes for Tahfiz queries
ALTER TABLE class_results
ADD INDEX IF NOT EXISTS idx_subject_term (subject_id, term_id),
ADD INDEX IF NOT EXISTS idx_student_subject (student_id, subject_id),
ADD INDEX IF NOT EXISTS idx_class_term_subject (class_id, term_id, subject_id);

-- Step 4: Insert sample Tahfiz subjects if they don't exist
-- These are common Tahfiz evaluation areas
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Hifdh (Memorization)', 'TFZ-HIFDH', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-HIFDH'
);

INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Muraja (Revision)', 'TFZ-MRJA', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-MRJA'
);

INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Tajweed (Recitation Rules)', 'TFZ-TJW', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-TJW'
);

INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Saut/Voice (Voice Quality)', 'TFZ-SAUT', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-SAUT'
);

INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Swalaat (Prayer)', 'TFZ-SWLT', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-SWLT'
);

INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Adab (Discipline & Conduct)', 'TFZ-ADAB', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-ADAB'
);

-- Step 5: Insert sample result types for Tahfiz if they don't exist
INSERT INTO result_types (school_id, name, code, description, weight, status)
SELECT 1, 'Tahfiz Daily Assessment', 'TFZ-DAILY', 'Daily Tahfiz performance evaluation', 0.20, 'active'
WHERE NOT EXISTS (
  SELECT 1 FROM result_types WHERE code = 'TFZ-DAILY'
);

INSERT INTO result_types (school_id, name, code, description, weight, status)
SELECT 1, 'Tahfiz Weekly Test', 'TFZ-WKLY', 'Weekly Tahfiz memorization test', 0.30, 'active'
WHERE NOT EXISTS (
  SELECT 1 FROM result_types WHERE code = 'TFZ-WKLY'
);

INSERT INTO result_types (school_id, name, code, description, weight, status)
SELECT 1, 'Tahfiz Monthly Evaluation', 'TFZ-MNTH', 'Monthly comprehensive Tahfiz evaluation', 0.25, 'active'
WHERE NOT EXISTS (
  SELECT 1 FROM result_types WHERE code = 'TFZ-MNTH'
);

INSERT INTO result_types (school_id, name, code, description, weight, status)
SELECT 1, 'Tahfiz Term Exam', 'TFZ-TERM', 'End of term Tahfiz examination', 0.25, 'active'
WHERE NOT EXISTS (
  SELECT 1 FROM result_types WHERE code = 'TFZ-TERM'
);

-- Step 6: Create a view for easy Tahfiz results retrieval
CREATE OR REPLACE VIEW v_tahfiz_results AS
SELECT 
  cr.id,
  cr.student_id,
  cr.class_id,
  cr.subject_id,
  cr.term_id,
  cr.result_type_id,
  cr.score,
  cr.grade,
  cr.remarks,
  cr.created_at,
  cr.updated_at,
  s.admission_no,
  CONCAT(p.first_name, ' ', p.last_name) as student_name,
  p.first_name,
  p.last_name,
  subj.name as subject_name,
  subj.code as subject_code,
  c.name as class_name,
  t.name as term_name,
  rt.name as result_type_name,
  rt.weight as result_type_weight,
  ay.name as academic_year
FROM class_results cr
INNER JOIN students s ON cr.student_id = s.id
INNER JOIN people p ON s.person_id = p.id
INNER JOIN subjects subj ON cr.subject_id = subj.id
LEFT JOIN classes c ON cr.class_id = c.id
LEFT JOIN terms t ON cr.term_id = t.id
LEFT JOIN result_types rt ON cr.result_type_id = rt.id
LEFT JOIN academic_years ay ON t.academic_year_id = ay.id
WHERE subj.subject_type = 'tahfiz'
ORDER BY cr.created_at DESC;

-- Step 7: Create stored procedure for bulk Tahfiz result insertion (optional)
DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS sp_insert_tahfiz_result(
  IN p_student_id BIGINT,
  IN p_class_id BIGINT,
  IN p_subject_id BIGINT,
  IN p_term_id BIGINT,
  IN p_result_type_id BIGINT,
  IN p_score DECIMAL(5,2),
  IN p_grade VARCHAR(10),
  IN p_remarks TEXT,
  OUT p_result_id BIGINT,
  OUT p_error_message VARCHAR(255)
)
BEGIN
  DECLARE v_subject_type VARCHAR(20);
  DECLARE v_enrollment_count INT;
  DECLARE v_existing_count INT;
  
  -- Initialize output parameters
  SET p_result_id = NULL;
  SET p_error_message = NULL;
  
  -- Verify subject is tahfiz type
  SELECT subject_type INTO v_subject_type 
  FROM subjects 
  WHERE id = p_subject_id;
  
  IF v_subject_type IS NULL THEN
    SET p_error_message = 'Subject not found';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subject not found';
  END IF;
  
  IF v_subject_type != 'tahfiz' THEN
    SET p_error_message = 'Subject is not a Tahfiz subject';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subject is not a Tahfiz subject';
  END IF;
  
  -- Verify student enrollment
  SELECT COUNT(*) INTO v_enrollment_count
  FROM enrollments
  WHERE student_id = p_student_id 
    AND class_id = p_class_id 
    AND status = 'active';
  
  IF v_enrollment_count = 0 THEN
    SET p_error_message = 'Student not enrolled in this class';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student not enrolled in this class';
  END IF;
  
  -- Check for duplicate
  SELECT COUNT(*) INTO v_existing_count
  FROM class_results
  WHERE student_id = p_student_id
    AND class_id = p_class_id
    AND subject_id = p_subject_id
    AND (term_id = p_term_id OR (term_id IS NULL AND p_term_id IS NULL))
    AND result_type_id = p_result_type_id;
  
  IF v_existing_count > 0 THEN
    SET p_error_message = 'Result already exists';
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Result already exists for this student, subject, and term';
  END IF;
  
  -- Auto-calculate grade if not provided
  IF p_grade IS NULL AND p_score IS NOT NULL THEN
    SET p_grade = CASE
      WHEN p_score >= 90 THEN 'A+'
      WHEN p_score >= 80 THEN 'A'
      WHEN p_score >= 70 THEN 'B'
      WHEN p_score >= 60 THEN 'C'
      WHEN p_score >= 50 THEN 'D'
      ELSE 'F'
    END;
  END IF;
  
  -- Insert the result
  INSERT INTO class_results (
    student_id, class_id, subject_id, term_id, result_type_id,
    score, grade, remarks, created_at, updated_at
  ) VALUES (
    p_student_id, p_class_id, p_subject_id, p_term_id, p_result_type_id,
    p_score, p_grade, p_remarks, NOW(), NOW()
  );
  
  SET p_result_id = LAST_INSERT_ID();
END$$

DELIMITER ;

-- Step 8: Add migration log entry
INSERT INTO tahfiz_migration_log (message) VALUES
('Migration 005: Added Tahfiz results support using class_results table'),
('Migration 005: Modified subjects.subject_type to support tahfiz type'),
('Migration 005: Added indexes for optimized Tahfiz results queries'),
('Migration 005: Created sample Tahfiz subjects (Hifdh, Muraja, Tajweed, Saut, Swalaat, Adab)'),
('Migration 005: Created sample Tahfiz result types (Daily, Weekly, Monthly, Term)'),
('Migration 005: Created v_tahfiz_results view for simplified querying'),
('Migration 005: Created sp_insert_tahfiz_result stored procedure for validated insertions');

-- =============================
-- Migration completed successfully
-- =============================

/* 
USAGE NOTES:

1. The class_results table is now used for Tahfiz results
2. Filter Tahfiz results by joining subjects WHERE subject_type = 'tahfiz'
3. Use the v_tahfiz_results view for simplified queries
4. Use sp_insert_tahfiz_result for validated insertions

Example queries:

-- Get all Tahfiz results for a student
SELECT * FROM v_tahfiz_results WHERE student_id = 1;

-- Get Tahfiz results for a specific term
SELECT * FROM v_tahfiz_results WHERE term_id = 1;

-- Get Tahfiz results for a specific class
SELECT * FROM v_tahfiz_results WHERE class_id = 1;

-- Insert a Tahfiz result with validation
CALL sp_insert_tahfiz_result(
  1,    -- student_id
  1,    -- class_id  
  1,    -- subject_id (must be tahfiz type)
  1,    -- term_id
  1,    -- result_type_id
  85.5, -- score
  'A',  -- grade (can be NULL for auto-calculation)
  'Excellent progress in memorization',  -- remarks
  @result_id,
  @error_msg
);

SELECT @result_id, @error_msg;
*/

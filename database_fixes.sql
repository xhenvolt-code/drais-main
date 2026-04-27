-- ============================================
-- DRAIS Database Fixes for TiDB Cloud
-- ============================================
-- This script addresses multiple database issues:
-- 1. Missing admission numbers (NGS/sequential/year format)
-- 2. Soft-deleted learners appearing in reports
-- 3. Academic results without year attachment
-- 4. 2026 results needing academic year assignment

-- ============================================
-- 1. Fix Missing Admission Numbers
-- ============================================

-- First, identify students without proper admission numbers
SELECT '=== STUDENTS MISSING ADMISSION NUMBERS ===' AS info;
SELECT 
  s.id,
  s.school_id,
  p.first_name,
  p.last_name,
  s.admission_no,
  s.admission_date,
  s.created_at
FROM students s
LEFT JOIN people p ON s.person_id = p.id
WHERE (s.admission_no IS NULL 
       OR s.admission_no = '' 
       OR s.admission_no NOT REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$')
  AND s.deleted_at IS NULL
ORDER BY s.school_id, p.first_name, p.last_name;

-- Generate admission numbers for students missing them
-- Format: NGS/sequential/year (where year is admission year or current year)

-- Create a procedure to generate admission numbers
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS generate_admission_numbers()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE student_id BIGINT;
  DECLARE school_id BIGINT;
  DECLARE admission_year VARCHAR(4);
  DECLARE next_number INT;
  DECLARE new_admission_no VARCHAR(50);
  
  DECLARE student_cursor CURSOR FOR 
    SELECT s.id, s.school_id, COALESCE(YEAR(s.admission_date), YEAR(CURRENT_DATE), '2026') as year
    FROM students s
    LEFT JOIN people p ON s.person_id = p.id
    WHERE (s.admission_no IS NULL OR s.admission_no = '' OR s.admission_no NOT REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$')
      AND s.deleted_at IS NULL
    ORDER BY s.school_id, s.created_at;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  
  OPEN student_cursor;
  
  read_loop: LOOP
    FETCH student_cursor INTO student_id, school_id, admission_year;
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    -- Get next sequential number for this school and year
    SELECT COALESCE(MAX(CAST(SUBSTRING(admission_no, 5, LOCATE('/', admission_no, 5) - 5) AS UNSIGNED)), 0) + 1
    INTO next_number
    FROM students 
    WHERE school_id = school_id 
      AND admission_no LIKE 'NGS/%/' + admission_year
      AND deleted_at IS NULL;
    
    -- Generate new admission number
    SET new_admission_no = CONCAT('NGS/', next_number, '/', admission_year);
    
    -- Update student record
    UPDATE students 
    SET admission_no = new_admission_no,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = student_id;
    
    SELECT CONCAT('Generated admission number: ', new_admission_no, ' for student ID: ', student_id) AS result;
    
  END LOOP;
  
  CLOSE student_cursor;
END //
DELIMITER ;

-- Run the procedure to generate admission numbers
CALL generate_admission_numbers();

-- Drop the procedure after use
DROP PROCEDURE IF EXISTS generate_admission_numbers;

-- Verify the admission numbers were generated
SELECT '=== VERIFICATION: ADMISSION NUMBERS GENERATED ===' AS info;
SELECT 
  COUNT(*) as students_updated,
  COUNT(CASE WHEN admission_no REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$' THEN 1 END) as proper_format
FROM students 
WHERE deleted_at IS NULL;

-- ============================================
-- 2. Fix Soft-Deleted Learners in Reports
-- ============================================

-- Identify soft-deleted learners that still have results
SELECT '=== SOFT-DELETED LEARNERS WITH RESULTS ===' AS info;
SELECT 
  s.id,
  s.admission_no,
  p.first_name,
  p.last_name,
  s.deleted_at,
  COUNT(cr.id) as result_count
FROM students s
LEFT JOIN people p ON s.person_id = p.id
LEFT JOIN class_results cr ON s.id = cr.student_id AND cr.deleted_at IS NULL
WHERE s.deleted_at IS NOT NULL
  AND cr.id IS NOT NULL
GROUP BY s.id, s.admission_no, p.first_name, p.last_name, s.deleted_at
ORDER BY s.deleted_at DESC;

-- Option 1: Remove results for soft-deleted students (recommended)
-- This ensures soft-deleted students don't appear in any reports
UPDATE class_results cr
JOIN students s ON cr.student_id = s.id
SET cr.deleted_at = CURRENT_TIMESTAMP,
    cr.updated_at = CURRENT_TIMESTAMP
WHERE s.deleted_at IS NOT NULL
  AND cr.deleted_at IS NULL;

-- Option 2: Alternative - Create a view that excludes soft-deleted students
-- This can be used by report queries
CREATE OR REPLACE VIEW v_active_students_results AS
SELECT 
  cr.*,
  s.admission_no,
  p.first_name,
  p.last_name,
  c.name AS class_name,
  sub.name AS subject_name
FROM class_results cr
JOIN students s ON cr.student_id = s.id
JOIN people p ON s.person_id = p.id
LEFT JOIN classes c ON cr.class_id = c.id
LEFT JOIN subjects sub ON cr.subject_id = sub.id
WHERE s.deleted_at IS NULL
  AND cr.deleted_at IS NULL;

-- Verify soft-deleted students no longer have active results
SELECT '=== VERIFICATION: SOFT-DELETED STUDENTS RESULTS REMOVED ===' AS info;
SELECT 
  COUNT(*) as deleted_students_with_results
FROM students s
JOIN class_results cr ON s.id = cr.student_id
WHERE s.deleted_at IS NOT NULL
  AND cr.deleted_at IS NULL;

-- ============================================
-- 3. Check Academic Results Year Attachment
-- ============================================

-- Check class_results table structure
SELECT '=== CLASS RESULTS TABLE STRUCTURE ===' AS info;
DESCRIBE class_results;

-- Check if academic_year_id column exists
SET @has_academic_year = (
  SELECT COUNT(*) 
  FROM INFORMATION_SCHEMA.COLUMNS 
  WHERE TABLE_SCHEMA = DATABASE() 
    AND TABLE_NAME = 'class_results' 
    AND COLUMN_NAME = 'academic_year_id'
);

SELECT IF(@has_academic_year > 0, 'academic_year_id column exists', 'academic_year_id column missing') AS year_column_status;

-- If academic_year_id doesn't exist, add it
SET @sql = IF(@has_academic_year = 0, 
  'ALTER TABLE class_results ADD COLUMN academic_year_id BIGINT AFTER term_id, ADD INDEX idx_academic_year (academic_year_id)',
  'SELECT "academic_year_id column already exists"');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Check results without academic year
SELECT '=== RESULTS WITHOUT ACADEMIC YEAR ===' AS info;
SELECT 
  COUNT(*) as count,
  MIN(cr.created_at) as oldest,
  MAX(cr.created_at) as newest
FROM class_results cr
WHERE cr.academic_year_id IS NULL 
  AND cr.deleted_at IS NULL;

-- ============================================
-- 4. Fix 2026 Results Without Academic Year
-- ============================================

-- Find 2026 results that need academic year assignment
SELECT '=== 2026 RESULTS NEEDING ACADEMIC YEAR ===' AS info;
SELECT 
  COUNT(*) as count_2026_results,
  MIN(cr.created_at) as oldest_2026,
  MAX(cr.created_at) as newest_2026
FROM class_results cr
WHERE cr.academic_year_id IS NULL
  AND cr.created_at LIKE '2026%'
  AND cr.deleted_at IS NULL;

-- Get or create 2026 academic year
INSERT IGNORE INTO academic_years (school_id, name, start_date, end_date, status, created_at)
SELECT DISTINCT school_id, '2026', '2026-01-01', '2026-12-31', 'active', NOW()
FROM class_results cr
WHERE cr.academic_year_id IS NULL
  AND cr.created_at LIKE '2026%'
  AND cr.deleted_at IS NULL
  AND NOT EXISTS (
    SELECT 1 FROM academic_years ay 
    WHERE ay.school_id = cr.school_id AND ay.name = '2026'
  );

-- Update 2026 results with academic year
UPDATE class_results cr
JOIN academic_years ay ON cr.school_id = ay.school_id AND ay.name = '2026'
SET cr.academic_year_id = ay.id,
    cr.updated_at = CURRENT_TIMESTAMP
WHERE cr.academic_year_id IS NULL
  AND cr.created_at LIKE '2026%'
  AND cr.deleted_at IS NULL;

-- Verify the update
SELECT '=== VERIFICATION: 2026 RESULTS UPDATED ===' AS info;
SELECT 
  COUNT(*) as updated_count
FROM class_results cr
WHERE cr.academic_year_id IS NOT NULL
  AND cr.created_at LIKE '2026%'
  AND cr.deleted_at IS NULL;

-- ============================================
-- 5. Create Comprehensive Report Views
-- ============================================

-- Create a view for reports that automatically filters soft-deleted students
-- and includes proper academic year information
CREATE OR REPLACE VIEW v_class_reports AS
SELECT 
  cr.id,
  cr.student_id,
  cr.school_id,
  cr.class_id,
  cr.subject_id,
  cr.term_id,
  cr.academic_year_id,
  cr.score,
  cr.grade,
  cr.remarks,
  cr.created_at,
  cr.updated_at,
  s.admission_no,
  p.first_name,
  p.last_name,
  p.gender,
  c.name AS class_name,
  sub.name AS subject_name,
  sub.code AS subject_code,
  t.name AS term_name,
  ay.name AS academic_year_name,
  -- Teacher initials for reports
  (SELECT CONCAT(UPPER(LEFT(p2.first_name, 1)), UPPER(LEFT(p2.last_name, 1)))
   FROM class_subjects cs2
   JOIN staff st ON cs2.teacher_id = st.id
   JOIN people p2 ON st.person_id = p2.id
   WHERE cs2.class_id = cr.class_id 
     AND cs2.subject_id = cr.subject_id 
     AND cs2.school_id = cr.school_id
     AND st.deleted_at IS NULL
   LIMIT 1) AS teacher_initials
FROM class_results cr
JOIN students s ON cr.student_id = s.id
JOIN people p ON s.person_id = p.id
JOIN classes c ON cr.class_id = c.id
JOIN subjects sub ON cr.subject_id = sub.id
LEFT JOIN terms t ON cr.term_id = t.id
LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
WHERE s.deleted_at IS NULL
  AND cr.deleted_at IS NULL
  AND c.deleted_at IS NULL
  AND sub.deleted_at IS NULL;

-- ============================================
-- 6. Final Verification Reports
-- ============================================

-- Summary of all fixes applied
SELECT '=== FINAL VERIFICATION SUMMARY ===' AS info;

-- Admission numbers
SELECT 
  'Admission Numbers' as category,
  COUNT(*) as total_students,
  COUNT(CASE WHEN admission_no REGEXP '^[A-Z]+/[0-9]+/[0-9]{4}$' THEN 1 END) as proper_format,
  COUNT(CASE WHEN admission_no IS NULL OR admission_no = '' THEN 1 END) as missing_numbers
FROM students 
WHERE deleted_at IS NULL;

-- Soft-deleted students in results
SELECT 
  'Soft-Deleted Students' as category,
  COUNT(*) as total_deleted_students,
  COUNT(CASE WHEN cr.id IS NOT NULL THEN 1 END) as still_have_results
FROM students s
LEFT JOIN class_results cr ON s.id = cr.student_id AND cr.deleted_at IS NULL
WHERE s.deleted_at IS NOT NULL;

-- Academic year attachment
SELECT 
  'Academic Years' as category,
  COUNT(*) as total_results,
  COUNT(CASE WHEN academic_year_id IS NOT NULL THEN 1 END) as have_academic_year,
  COUNT(CASE WHEN academic_year_id IS NULL THEN 1 END) as missing_academic_year
FROM class_results 
WHERE deleted_at IS NULL;

-- 2026 specific results
SELECT 
  '2026 Results' as category,
  COUNT(*) as total_2026_results,
  COUNT(CASE WHEN academic_year_id IS NOT NULL THEN 1 END) as have_academic_year
FROM class_results 
WHERE created_at LIKE '2026%'
  AND deleted_at IS NULL;

-- Teacher assignments
SELECT 
  'Teacher Assignments' as category,
  COUNT(*) as total_assignments,
  COUNT(DISTINCT teacher_id) as teachers_assigned,
  COUNT(CASE WHEN teacher_id IS NULL THEN 1 END) as unassigned
FROM class_subjects 
WHERE deleted_at IS NULL OR deleted_at IS NULL;

-- ============================================
-- 7. API Endpoint Recommendations
-- ============================================

-- Show recommended query patterns for API endpoints
SELECT '=== RECOMMENDED API QUERY PATTERNS ===' AS info;

SELECT '-- For student results (excludes soft-deleted)' AS recommendation;
SELECT 'SELECT * FROM v_class_reports WHERE school_id = ? AND academic_year_id = ? AND term_id = ?' AS query_pattern;

SELECT '-- For teacher assignments' AS recommendation;
SELECT 'SELECT cs.*, p.first_name, p.last_name FROM class_subjects cs JOIN staff s ON cs.teacher_id = s.id JOIN people p ON s.person_id = p.id WHERE cs.school_id = ? AND s.deleted_at IS NULL' AS query_pattern;

SELECT '-- For student lists (excludes soft-deleted)' AS recommendation;
SELECT 'SELECT s.*, p.first_name, p.last_name FROM students s JOIN people p ON s.person_id = p.id WHERE s.school_id = ? AND s.deleted_at IS NULL' AS query_pattern;

-- Success message
SELECT '=== ALL DATABASE FIXES COMPLETED SUCCESSFULLY ===' AS info;
SELECT NOW() AS completion_timestamp;

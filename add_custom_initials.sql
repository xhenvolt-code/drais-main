-- ============================================
-- Add Custom Teacher Initials Functionality
-- ============================================
-- This adds the ability to have editable teacher initials for reports
-- that are specific to each class-subject combination

-- Add custom initials column to class_subjects table
ALTER TABLE class_subjects 
ADD COLUMN IF NOT EXISTS custom_initials VARCHAR(10) DEFAULT NULL 
COMMENT 'Custom editable initials for reports, overrides auto-generated initials';

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_custom_initials ON class_subjects(custom_initials);

-- Create a view that prioritizes custom initials over auto-generated ones
CREATE OR REPLACE VIEW v_class_subjects_with_initials AS
SELECT 
  cs.id,
  cs.school_id,
  cs.class_id,
  cs.subject_id,
  cs.teacher_id,
  cs.custom_initials,
  c.name AS class_name,
  sub.name AS subject_name,
  sub.code AS subject_code,
  -- Use custom initials if available, otherwise generate from teacher name
  COALESCE(
    cs.custom_initials,
    CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))
  ) AS display_initials,
  p.first_name AS teacher_first_name,
  p.last_name AS teacher_last_name,
  CONCAT(p.first_name, ' ', p.last_name) AS teacher_full_name,
  s.position AS teacher_position
FROM class_subjects cs
LEFT JOIN staff s ON cs.teacher_id = s.id
LEFT JOIN people p ON s.person_id = p.id
LEFT JOIN classes c ON cs.class_id = c.id
LEFT JOIN subjects sub ON cs.subject_id = sub.id
WHERE cs.deleted_at IS NULL
  AND (s.deleted_at IS NULL OR s.deleted_at IS NULL)
  AND c.deleted_at IS NULL
  AND sub.deleted_at IS NULL;

-- Update the main class reports view to use custom initials
DROP VIEW IF EXISTS v_class_reports;
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
  -- Use custom initials from class_subjects if available
  COALESCE(
    cs.custom_initials,
    CONCAT(UPPER(LEFT(p2.first_name, 1)), UPPER(LEFT(p2.last_name, 1)))
  ) AS teacher_initials,
  cs.teacher_id,
  cs.id AS class_subject_id
FROM class_results cr
JOIN students s ON cr.student_id = s.id
JOIN people p ON s.person_id = p.id
JOIN classes c ON cr.class_id = c.id
JOIN subjects sub ON cr.subject_id = sub.id
LEFT JOIN terms t ON cr.term_id = t.id
LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
LEFT JOIN class_subjects cs ON cr.class_id = cs.class_id 
  AND cr.subject_id = cs.subject_id 
  AND cr.school_id = cs.school_id
LEFT JOIN staff st ON cs.teacher_id = st.id
LEFT JOIN people p2 ON st.person_id = p2.id
WHERE s.deleted_at IS NULL
  AND cr.deleted_at IS NULL
  AND c.deleted_at IS NULL
  AND sub.deleted_at IS NULL;

-- Show current state of class_subjects with initials
SELECT '=== CURRENT CLASS-SUBJECT ASSIGNMENTS ===' AS info;
SELECT 
  cs.id,
  c.name AS class_name,
  sub.name AS subject_name,
  cs.custom_initials AS custom_initials,
  CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
  CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1))) AS auto_initials
FROM class_subjects cs
LEFT JOIN classes c ON cs.class_id = c.id
LEFT JOIN subjects sub ON cs.subject_id = sub.id
LEFT JOIN staff s ON cs.teacher_id = s.id
LEFT JOIN people p ON s.person_id = p.id
WHERE cs.deleted_at IS NULL
ORDER BY c.name, sub.name;

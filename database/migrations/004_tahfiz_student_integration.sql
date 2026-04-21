-- Enhanced Tahfiz Student Integration Schema
-- Version: 1.0.1
-- Date: 2024-12-20

-- Add auto-enrollment tracking to students table
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS tahfiz_enrolled TINYINT(1) DEFAULT 0 AFTER status,
ADD COLUMN IF NOT EXISTS tahfiz_enrollment_date TIMESTAMP NULL DEFAULT NULL AFTER tahfiz_enrolled;

-- Enhance tahfiz_group_members with more detailed tracking
ALTER TABLE tahfiz_group_members 
ADD COLUMN IF NOT EXISTS auto_enrolled TINYINT(1) DEFAULT 0 AFTER role,
ADD COLUMN IF NOT EXISTS enrollment_notes TEXT DEFAULT NULL AFTER auto_enrolled,
ADD COLUMN IF NOT EXISTS status ENUM('active','inactive','graduated','transferred') DEFAULT 'active' AFTER enrollment_notes;

-- Create index for better performance on Tahfiz student queries
CREATE INDEX IF NOT EXISTS idx_students_tahfiz ON students(school_id, tahfiz_enrolled, status);
CREATE INDEX IF NOT EXISTS idx_tahfiz_group_members_status ON tahfiz_group_members(student_id, status);

-- Enhanced tahfiz_portions table for better progress tracking
ALTER TABLE tahfiz_portions 
ADD COLUMN IF NOT EXISTS auto_generated TINYINT(1) DEFAULT 0 AFTER verification_status,
ADD COLUMN IF NOT EXISTS source VARCHAR(50) DEFAULT 'manual' AFTER auto_generated COMMENT 'manual, wizard, import, api';

-- Create view for comprehensive Tahfiz student data
CREATE OR REPLACE VIEW tahfiz_students_view AS
SELECT 
  s.id as student_id,
  s.admission_no,
  s.status as student_status,
  s.tahfiz_enrolled,
  s.tahfiz_enrollment_date,
  CONCAT(p.first_name, ' ', p.last_name, COALESCE(CONCAT(' ', p.other_name), '')) as full_name,
  p.first_name,
  p.last_name,
  p.other_name,
  p.gender,
  p.photo_url,
  c.name as class_name,
  tc.name as theology_class_name,
  tg.id as group_id,
  tg.name as group_name,
  tgm.status as group_status,
  tgm.auto_enrolled,
  CONCAT(tp.first_name, ' ', tp.last_name) as teacher_name,
  COUNT(DISTINCT tpo.id) as total_portions,
  COUNT(DISTINCT CASE WHEN tpo.status = 'completed' THEN tpo.id END) as completed_portions,
  COUNT(DISTINCT tr.id) as total_records,
  AVG(tr.retention_score) as avg_retention_score,
  AVG(tr.mark) as avg_marks,
  COUNT(DISTINCT ta.id) as attendance_records,
  COUNT(DISTINCT CASE WHEN ta.status = 'present' THEN ta.id END) as present_days,
  CASE 
    WHEN COUNT(DISTINCT ta.id) > 0 
    THEN ROUND((COUNT(DISTINCT CASE WHEN ta.status = 'present' THEN ta.id END) * 100.0) / COUNT(DISTINCT ta.id), 1)
    ELSE 0 
  END as attendance_rate
FROM students s
JOIN people p ON s.person_id = p.id
LEFT JOIN enrollments e ON s.id = e.student_id AND e.status = 'active'
LEFT JOIN classes c ON e.class_id = c.id
LEFT JOIN classes tc ON e.theology_class_id = tc.id
LEFT JOIN tahfiz_group_members tgm ON s.id = tgm.student_id AND tgm.status = 'active'
LEFT JOIN tahfiz_groups tg ON tgm.group_id = tg.id
LEFT JOIN staff st ON tg.teacher_id = st.id
LEFT JOIN people tp ON st.person_id = tp.id
LEFT JOIN tahfiz_portions tpo ON s.id = tpo.student_id
LEFT JOIN tahfiz_records tr ON s.id = tr.student_id
LEFT JOIN tahfiz_attendance ta ON s.id = ta.student_id
WHERE s.tahfiz_enrolled = 1
GROUP BY s.id, s.admission_no, s.status, s.tahfiz_enrolled, s.tahfiz_enrollment_date,
         p.first_name, p.last_name, p.other_name, p.gender, p.photo_url,
         c.name, tc.name, tg.id, tg.name, tgm.status, tgm.auto_enrolled,
         tp.first_name, tp.last_name
ORDER BY p.first_name ASC, p.last_name ASC;

-- Create trigger to automatically set tahfiz_enrolled flag when student joins a group
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS trigger_tahfiz_enrollment
AFTER INSERT ON tahfiz_group_members
FOR EACH ROW
BEGIN
  UPDATE students 
  SET tahfiz_enrolled = 1, 
      tahfiz_enrollment_date = COALESCE(tahfiz_enrollment_date, CURRENT_TIMESTAMP)
  WHERE id = NEW.student_id;
END$$
DELIMITER ;

-- Log the migration
INSERT INTO audit_log (action, entity_type, entity_id, changes_json) VALUES
('tahfiz_student_integration_complete', 'system', 1, JSON_OBJECT(
  'enhancements', JSON_ARRAY('auto_enrollment_tracking', 'performance_indexes', 'comprehensive_view', 'enrollment_trigger'),
  'tables_modified', JSON_ARRAY('students', 'tahfiz_group_members', 'tahfiz_portions'),
  'views_created', JSON_ARRAY('tahfiz_students_view'),
  'triggers_created', JSON_ARRAY('trigger_tahfiz_enrollment'),
  'version', '1.0.1'
));

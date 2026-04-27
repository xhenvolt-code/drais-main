-- ============================================
-- Editable Initials System Tables
-- ============================================
-- Support for persistent, editable, class-wide synchronized initials

-- Ensure custom_initials column exists in class_subjects
-- (may already exist from add_custom_initials.sql)
ALTER TABLE class_subjects 
ADD COLUMN IF NOT EXISTS custom_initials VARCHAR(10) DEFAULT NULL 
COMMENT 'Custom editable initials for reports, overrides auto-generated initials';

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_custom_initials ON class_subjects(custom_initials);

-- Create audit table for initials edits
CREATE TABLE IF NOT EXISTS initials_edit_history (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  school_id BIGINT NOT NULL COMMENT 'Multi-tenant isolation',
  previous_initials VARCHAR(10) NULL,
  new_initials VARCHAR(10) NOT NULL,
  changed_by BIGINT NOT NULL COMMENT 'User ID who made the change',
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_class_subject (class_id, subject_id),
  INDEX idx_school (school_id),
  INDEX idx_timestamp (changed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='Audit trail for initials edits';

-- Create view for easy retrieval of current initials with teacher info
CREATE OR REPLACE VIEW v_class_initials_current AS
SELECT 
  cs.id,
  cs.class_id,
  cs.subject_id,
  cs.teacher_id,
  cs.custom_initials,
  sub.name AS subject_name,
  sub.code AS subject_code,
  CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1))) AS auto_generated_initials,
  COALESCE(cs.custom_initials, CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))) AS display_initials,
  CONCAT(p.first_name, ' ', p.last_name) AS teacher_full_name,
  p.first_name,
  p.last_name
FROM class_subjects cs
LEFT JOIN subjects sub ON cs.subject_id = sub.id
LEFT JOIN staff s ON cs.teacher_id = s.id
LEFT JOIN people p ON s.person_id = p.id;

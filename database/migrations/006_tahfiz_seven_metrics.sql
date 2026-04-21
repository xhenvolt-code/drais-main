-- =============================
-- Migration: 006_tahfiz_seven_metrics.sql
-- Purpose: Create 7 Tahfiz metric subjects for class_results table
-- Date: 2025-01-26
-- Requirements: Map Tahfiz metrics (Retention, Tajweed, Voice, Discipline, Portions, Attendance, Overall)
--               to subjects table with subject_type='tahfiz'
-- =============================

USE drais_school;

-- Ensure subject_type column supports 'tahfiz'
ALTER TABLE subjects 
MODIFY COLUMN subject_type VARCHAR(20) DEFAULT 'core'
COMMENT 'Subject type: core, elective, tahfiz, extra';

-- Add index for tahfiz filtering
ALTER TABLE subjects
ADD INDEX IF NOT EXISTS idx_subject_type (subject_type);

-- =============================
-- Insert 7 Tahfiz Metric Subjects
-- =============================

-- 1. Retention Score (Hifdh/Memorization)
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Retention Score', 'TFZ-RET', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-RET'
);

-- 2. Tajweed Score (Recitation Rules)
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Tajweed Score', 'TFZ-TJW', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-TJW'
);

-- 3. Voice & Pronunciation
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Voice & Pronunciation', 'TFZ-VCE', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-VCE'
);

-- 4. Discipline & Conduct
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Discipline & Conduct', 'TFZ-DSC', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-DSC'
);

-- 5. Portions Completed
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Portions Completed', 'TFZ-PRT', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-PRT'
);

-- 6. Attendance Rate
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Attendance Rate', 'TFZ-ATT', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-ATT'
);

-- 7. Overall Performance
INSERT INTO subjects (school_id, name, code, subject_type) 
SELECT 1, 'Overall Performance', 'TFZ-OVR', 'tahfiz'
WHERE NOT EXISTS (
  SELECT 1 FROM subjects WHERE code = 'TFZ-OVR'
);

-- =============================
-- Verification Query
-- =============================
-- Run this to verify all 7 tahfiz subjects exist:
-- SELECT id, name, code, subject_type FROM subjects WHERE subject_type = 'tahfiz' ORDER BY code;

-- =============================
-- Notes
-- =============================
-- Each Tahfiz metric is now a subject in the subjects table.
-- Results are stored in class_results table with subject_id pointing to these tahfiz subjects.
-- Frontend filters by WHERE subject_type='tahfiz' to display only Tahfiz metrics.
-- Grade calculation: A+ (≥90), A (≥80), B (≥70), C (≥60), D (≥50), F (<50)
-- Scores range: 0-100 for all metrics except Portions (can use custom format like "5/30")

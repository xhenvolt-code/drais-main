-- ============================================================================
-- Migration: Add unique constraint and indexes to class_subjects
-- Purpose: Ensure data integrity for the Teacher-Class-Subject Assignment Engine
-- Created: 2026-04-28
-- ============================================================================

-- 0. Safety: Remove potential duplicate class_subject assignments
--    Keep the highest-ID record per (class_id, subject_id) pair.
--    This cleanup is idempotent and safe to run multiple times.
DELETE cs1 FROM class_subjects cs1
INNER JOIN class_subjects cs2
  ON cs1.class_id = cs2.class_id
 AND cs1.subject_id = cs2.subject_id
 AND cs1.id < cs2.id;

-- 1. Add UNIQUE constraint on (class_id, subject_id) to prevent duplicate assignments
--    Ensures each subject can only have one teacher per class
ALTER TABLE class_subjects
ADD UNIQUE INDEX uq_class_subject (class_id, subject_id);

-- 2. Add index on teacher_id for faster teacher workload queries
ALTER TABLE class_subjects
ADD INDEX idx_teacher_id (teacher_id);

-- 3. Verify indexes
SELECT INDEX_NAME, COLUMN_NAME, NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_NAME = 'class_subjects'
  AND TABLE_SCHEMA = DATABASE()
  AND INDEX_NAME IN ('uq_class_subject', 'idx_teacher_id', 'idx_school_class', 'idx_subject_teacher');

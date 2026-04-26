-- ============================================================================
-- Migration: Subject Duplicate Prevention & Case-Insensitive Constraint
-- Date: 2026-04-26
-- Purpose: Prevent case-insensitive duplicate subjects within a school
-- ============================================================================

-- Step 1: Add a generated column for normalized (LOWER) subject name
-- This is used for case-insensitive uniqueness enforcement
ALTER TABLE subjects 
ADD COLUMN name_lower VARCHAR(120) GENERATED ALWAYS AS (LOWER(name)) STORED;

-- Step 2: Create a unique index on (school_id, name_lower, deleted_at)
-- This ensures no two active subjects in the same school with same name (case-insensitive)
-- Soft-deleted records (deleted_at IS NOT NULL) don't participate in the uniqueness constraint
ALTER TABLE subjects
ADD UNIQUE KEY `unique_school_subject_ci` (
  `school_id`,
  `name_lower`,
  `deleted_at`
);

-- Step 3: Add an index for faster subject lookup by name
ALTER TABLE subjects
ADD INDEX `idx_school_name_lower` (
  `school_id`,
  `name_lower`
);

-- Step 4: Document the new constraints in a comment
ALTER TABLE subjects
COMMENT='Subjects are school-scoped. Duplicate check uses LOWER(name) for case-insensitive comparison. The unique constraint (school_id, name_lower, deleted_at) prevents case-insensitive duplicates within active subjects of a school. Soft-deleted records don''t participate in the constraint.';

-- ============================================================================
-- Verification Queries
-- ============================================================================

-- Query 1: Check for any remaining case-insensitive duplicates
SELECT 
  sch.name as school_name,
  LOWER(s.name) as lowercase_name,
  COUNT(*) as count,
  GROUP_CONCAT(CONCAT(s.id, ' (', s.name, ')')) as records
FROM subjects s
LEFT JOIN schools sch ON s.school_id = sch.id
WHERE s.deleted_at IS NULL
GROUP BY s.school_id, LOWER(s.name)
HAVING count > 1;

-- Query 2: Verify subjects are properly scoped by school
SELECT 
  sch.name as school_name,
  COUNT(*) as total_subjects,
  COUNT(DISTINCT LOWER(s.name)) as unique_subject_names
FROM subjects s
LEFT JOIN schools sch ON s.school_id = sch.id
WHERE s.deleted_at IS NULL
GROUP BY s.school_id
ORDER BY sch.name;

-- Query 3: Show sample of subjects by school
SELECT 
  sch.name as school_name,
  s.id,
  s.name,
  s.code,
  s.subject_type,
  s.academic_type
FROM subjects s
LEFT JOIN schools sch ON s.school_id = sch.id
WHERE s.deleted_at IS NULL
ORDER BY sch.name, s.name
LIMIT 50;

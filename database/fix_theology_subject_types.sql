-- ============================================================================
-- CRITICAL: Fix Theology Subject Classification
-- ============================================================================
-- This script ensures all theology-related subjects have proper subject_type
-- classification so they appear in theology result views.
--
-- Run this before rendering Arabic reports to fix theology results loading.
-- ============================================================================

-- Step 1: Identify theology-related subjects by name pattern
-- This will help admin see which subjects are detected as theology
SELECT 
  id,
  school_id,
  name,
  subject_type,
  CASE 
    WHEN LOWER(name) LIKE '%quran%' THEN 'theology'
    WHEN LOWER(name) LIKE '%fiqh%' THEN 'theology'
    WHEN LOWER(name) LIKE '%tawhid%' THEN 'theology'
    WHEN LOWER(name) LIKE '%hadith%' THEN 'theology'
    WHEN LOWER(name) LIKE '%akhlaq%' THEN 'theology'
    WHEN LOWER(name) LIKE '%islamic%' THEN 'theology'
    WHEN LOWER(name) LIKE '%tajweed%' THEN 'theology'
    WHEN LOWER(name) LIKE '%sirah%' THEN 'theology'
    ELSE subject_type
  END AS detected_type
FROM subjects
WHERE 
  subject_type IS NULL 
  OR subject_type = 'core'
  OR LOWER(name) LIKE '%quran%'
  OR LOWER(name) LIKE '%fiqh%'
  OR LOWER(name) LIKE '%tawhid%'
  OR LOWER(name) LIKE '%hadith%'
  OR LOWER(name) LIKE '%akhlaq%'
  OR LOWER(name) LIKE '%islamic%'
ORDER BY school_id, name;

-- Step 2: Update all theology subjects to have correct subject_type
-- THIS IS THE FIX:
UPDATE subjects
SET subject_type = 'theology'
WHERE 
  LOWER(name) LIKE '%quran%'
  OR LOWER(name) LIKE '%fiqh%'
  OR LOWER(name) LIKE '%tawhid%'
  OR LOWER(name) LIKE '%hadith%'
  OR LOWER(name) LIKE '%akhlaq%'
  OR LOWER(name) LIKE '%islamic%'
  OR LOWER(name) LIKE '%tajweed%'
  OR LOWER(name) LIKE '%sirah%'
  OR LOWER(name) LIKE '%theology%'
  OR LOWER(name) LIKE '%religion%';

-- Step 3: Verify the fix worked
SELECT 
  school_id,
  subject_type,
  COUNT(*) as count
FROM subjects
GROUP BY school_id, subject_type
ORDER BY school_id, subject_type;

-- Step 4: Check results for theology subjects are now visible
SELECT 
  cr.id as result_id,
  sub.name as subject_name,
  sub.subject_type,
  p.first_name,
  p.last_name,
  cr.score
FROM class_results cr
JOIN subjects sub ON sub.id = cr.subject_id
JOIN students s ON s.id = cr.student_id
JOIN people p ON p.id = s.person_id
WHERE sub.subject_type = 'theology'
LIMIT 20;

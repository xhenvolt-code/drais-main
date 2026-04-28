-- ============================================
-- Insert Albayan Teacher Initials
-- ============================================
-- This script inserts all teacher initials for Albayan Quran Memorization Center
-- Based on subject allocations provided by the school

-- Set school context (Albayan = school_id 8002)
SET @albayan_school_id = 8002;

-- Baby Class Initials
UPDATE class_subjects cs
SET cs.custom_initials = 'I.R'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'BABY CLASS'
    AND UPPER(TRIM(s.name)) IN ('NUMBERS', 'LANGUAGE', 'WRITING', 'READING')
);

UPDATE class_subjects cs
SET cs.custom_initials = 'K.L'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'BABY CLASS'
    AND UPPER(TRIM(s.name)) = 'SOCIAL DEVELOPMENT'
);

UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'BABY CLASS'
    AND UPPER(TRIM(s.name)) = 'HEALTH HABITS'
);

-- Top Class Initials
UPDATE class_subjects cs
SET cs.custom_initials = 'K.B'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'TOP CLASS'
    AND UPPER(TRIM(s.name)) IN ('NUMBERS', 'LANGUAGE', 'WRITING')
);

UPDATE class_subjects cs
SET cs.custom_initials = 'K.L'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'TOP CLASS'
    AND UPPER(TRIM(s.name)) = 'SOCIAL DEVELOPMENT'
);

UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'TOP CLASS'
    AND UPPER(TRIM(s.name)) = 'HEALTH HABITS'
);

-- Middle Class Initials
UPDATE class_subjects cs
SET cs.custom_initials = 'K.L'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'MIDDLE CLASS'
    AND UPPER(TRIM(s.name)) IN ('NUMBERS', 'LANGUAGE', 'WRITING')
);

UPDATE class_subjects cs
SET cs.custom_initials = 'I.R'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'MIDDLE CLASS'
    AND UPPER(TRIM(s.name)) = 'READING'
);

UPDATE class_subjects cs
SET cs.custom_initials = 'K.L'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'MIDDLE CLASS'
    AND UPPER(TRIM(s.name)) = 'SOCIAL DEVELOPMENT'
);

UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'MIDDLE CLASS'
    AND UPPER(TRIM(s.name)) = 'HEALTH HABITS'
);

-- Primary 1, 2, 3: Mathematics
UPDATE class_subjects cs
SET cs.custom_initials = 'M.S'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY ONE', 'PRIMARY TWO', 'PRIMARY THREE')
    AND UPPER(TRIM(s.name)) = 'MATHEMATICS'
);

-- Primary 1, 2, 3: English
UPDATE class_subjects cs
SET cs.custom_initials = 'N.Z'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY ONE', 'PRIMARY TWO', 'PRIMARY THREE')
    AND UPPER(TRIM(s.name)) = 'ENGLISH'
);

-- Primary 3: ICT
UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY THREE'
    AND UPPER(TRIM(s.name)) = 'ICT'
);

-- Primary 1, 2, 3: Literacy I
UPDATE class_subjects cs
SET cs.custom_initials = 'K.Z'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY ONE', 'PRIMARY TWO', 'PRIMARY THREE')
    AND UPPER(TRIM(s.name)) = 'LITERACY I'
);

-- Primary 1, 2, 3: Literacy II
UPDATE class_subjects cs
SET cs.custom_initials = 'N.V'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY ONE', 'PRIMARY TWO', 'PRIMARY THREE')
    AND UPPER(TRIM(s.name)) = 'LITERACY II'
);

-- Primary 4, 5: Mathematics
UPDATE class_subjects cs
SET cs.custom_initials = 'M.H'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY FOUR', 'PRIMARY FIVE')
    AND UPPER(TRIM(s.name)) = 'MATHEMATICS'
);

-- Primary 4, 5: English
UPDATE class_subjects cs
SET cs.custom_initials = 'S.A'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY FOUR', 'PRIMARY FIVE')
    AND UPPER(TRIM(s.name)) = 'ENGLISH'
);

-- Primary 4, 5: Science
UPDATE class_subjects cs
SET cs.custom_initials = 'N.P'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY FOUR', 'PRIMARY FIVE')
    AND UPPER(TRIM(s.name)) = 'SCIENCE'
);

-- Primary 4, 5: Social Studies
UPDATE class_subjects cs
SET cs.custom_initials = 'K.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY FOUR', 'PRIMARY FIVE')
    AND UPPER(TRIM(s.name)) = 'SOCIAL STUDIES'
);

-- Primary 4, 5: ICT
UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) IN ('PRIMARY FOUR', 'PRIMARY FIVE')
    AND UPPER(TRIM(s.name)) = 'ICT'
);

-- Primary 6: Mathematics
UPDATE class_subjects cs
SET cs.custom_initials = 'O.H'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY SIX'
    AND UPPER(TRIM(s.name)) = 'MATHEMATICS'
);

-- Primary 6: English
UPDATE class_subjects cs
SET cs.custom_initials = 'W.A'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY SIX'
    AND UPPER(TRIM(s.name)) = 'ENGLISH'
);

-- Primary 6: Science
UPDATE class_subjects cs
SET cs.custom_initials = 'F.S'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY SIX'
    AND UPPER(TRIM(s.name)) = 'SCIENCE'
);

-- Primary 6: Social Studies
UPDATE class_subjects cs
SET cs.custom_initials = 'O.S'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY SIX'
    AND UPPER(TRIM(s.name)) = 'SOCIAL STUDIES'
);

-- Primary 6: ICT
UPDATE class_subjects cs
SET cs.custom_initials = 'N.M'
WHERE cs.id IN (
  SELECT cs.id FROM class_subjects cs
  JOIN classes c ON cs.class_id = c.id
  JOIN subjects s ON cs.subject_id = s.id
  WHERE c.school_id = @albayan_school_id 
    AND UPPER(TRIM(c.name)) = 'PRIMARY SIX'
    AND UPPER(TRIM(s.name)) = 'ICT'
);

-- Verify the insertions
SELECT '=== ALBAYAN TEACHER INITIALS - VERIFICATION ===' AS info;
SELECT 
  c.name AS class_name,
  s.name AS subject_name,
  cs.custom_initials,
  COALESCE(cs.custom_initials, CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1)))) AS display_initials
FROM class_subjects cs
JOIN classes c ON cs.class_id = c.id
JOIN subjects s ON cs.subject_id = s.id
LEFT JOIN staff st ON cs.teacher_id = st.id
LEFT JOIN people p ON st.person_id = p.id
WHERE c.school_id = @albayan_school_id
ORDER BY c.name, s.name;

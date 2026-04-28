-- ============================================
-- Create and Populate Albayan Teacher Initials
-- ============================================
-- This script creates class_subjects assignments and sets custom initials
-- for Albayan Quran Memorization Center

SET @albayan_school_id = 8002;

-- Helper to get class_id by name
SET @baby_class_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'BABY CLASS' LIMIT 1);
SET @middle_class_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'MIDDLE CLASS' LIMIT 1);
SET @top_class_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'TOP CLASS' LIMIT 1);
SET @primary_one_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY ONE' LIMIT 1);
SET @primary_two_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY TWO' LIMIT 1);
SET @primary_three_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY THREE' LIMIT 1);
SET @primary_four_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY FOUR' LIMIT 1);
SET @primary_five_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY FIVE' LIMIT 1);
SET @primary_six_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY SIX' LIMIT 1);

-- Helper to get subject_id by name
SET @numbers_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'NUMBERS' LIMIT 1);
SET @lang_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'LANG' LIMIT 1);
SET @writing_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'WRITING' LIMIT 1);
SET @reading_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'READING' LIMIT 1);
SET @social_dev_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'S.D' LIMIT 1);
SET @health_habits_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) IN ('HEALTH HABITS', 'HABITS', 'HEALTH') LIMIT 1);
SET @mathematics_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'MATHEMATICS' LIMIT 1);
SET @english_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'ENGLISH' LIMIT 1);
SET @ict_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) LIKE '%ICT%' LIMIT 1);
SET @literacy_one_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'LITERACY 1' LIMIT 1);
SET @literacy_two_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'LITERACY 2' LIMIT 1);
SET @science_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'SCIENCE' LIMIT 1);
SET @social_studies_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'SOCIAL STUDIES' LIMIT 1);

-- Verify all IDs are found
SELECT 'Class IDs:' as info;
SELECT CONCAT('Baby: ', @baby_class_id, ', Middle: ', @middle_class_id, ', Top: ', @top_class_id) as classes;
SELECT CONCAT('P1: ', @primary_one_id, ', P2: ', @primary_two_id, ', P3: ', @primary_three_id) as classes;
SELECT CONCAT('P4: ', @primary_four_id, ', P5: ', @primary_five_id, ', P6: ', @primary_six_id) as classes;

SELECT 'Subject IDs:' as info;
SELECT CONCAT('Numbers: ', @numbers_id, ', Lang: ', @lang_id, ', Writing: ', @writing_id) as subjects;
SELECT CONCAT('Math: ', @mathematics_id, ', English: ', @english_id, ', Science: ', @science_id) as subjects;

-- Create class_subjects with custom initials for Baby Class
-- Baby Class: Numbers, Lang, Writing => I.R | Reading => I.R | S.D => K.L | Health Habits => N.M
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@baby_class_id, @numbers_id, NULL, 'I.R'),
  (@baby_class_id, @lang_id, NULL, 'I.R'),
  (@baby_class_id, @writing_id, NULL, 'I.R'),
  (@baby_class_id, @reading_id, NULL, 'I.R'),
  (@baby_class_id, @social_dev_id, NULL, 'K.L'),
  (@baby_class_id, @health_habits_id, NULL, 'N.M');

-- Create class_subjects with custom initials for Top Class
-- Top Class: Numbers, Lang, Writing => K.B | S.D => K.L | Health Habits => N.M
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@top_class_id, @numbers_id, NULL, 'K.B'),
  (@top_class_id, @lang_id, NULL, 'K.B'),
  (@top_class_id, @writing_id, NULL, 'K.B'),
  (@top_class_id, @social_dev_id, NULL, 'K.L'),
  (@top_class_id, @health_habits_id, NULL, 'N.M');

-- Create class_subjects with custom initials for Middle Class
-- Middle Class: Numbers, Lang, Writing => K.L | Reading => I.R | S.D => K.L | Health Habits => N.M
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@middle_class_id, @numbers_id, NULL, 'K.L'),
  (@middle_class_id, @lang_id, NULL, 'K.L'),
  (@middle_class_id, @writing_id, NULL, 'K.L'),
  (@middle_class_id, @reading_id, NULL, 'I.R'),
  (@middle_class_id, @social_dev_id, NULL, 'K.L'),
  (@middle_class_id, @health_habits_id, NULL, 'N.M');

-- Primary 1, 2, 3: Mathematics => M.S | English => N.Z | Literacy 1 => K.Z | Literacy 2 => N.V
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@primary_one_id, @mathematics_id, NULL, 'M.S'),
  (@primary_one_id, @english_id, NULL, 'N.Z'),
  (@primary_one_id, @literacy_one_id, NULL, 'K.Z'),
  (@primary_one_id, @literacy_two_id, NULL, 'N.V'),
  
  (@primary_two_id, @mathematics_id, NULL, 'M.S'),
  (@primary_two_id, @english_id, NULL, 'N.Z'),
  (@primary_two_id, @literacy_one_id, NULL, 'K.Z'),
  (@primary_two_id, @literacy_two_id, NULL, 'N.V'),
  
  (@primary_three_id, @mathematics_id, NULL, 'M.S'),
  (@primary_three_id, @english_id, NULL, 'N.Z'),
  (@primary_three_id, @ict_id, NULL, 'N.M'),
  (@primary_three_id, @literacy_one_id, NULL, 'K.Z'),
  (@primary_three_id, @literacy_two_id, NULL, 'N.V');

-- Primary 4, 5: Mathematics => M.H | English => S.A | Science => N.P | Social Studies => K.M | ICT => N.M
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@primary_four_id, @mathematics_id, NULL, 'M.H'),
  (@primary_four_id, @english_id, NULL, 'S.A'),
  (@primary_four_id, @science_id, NULL, 'N.P'),
  (@primary_four_id, @social_studies_id, NULL, 'K.M'),
  (@primary_four_id, @ict_id, NULL, 'N.M'),
  
  (@primary_five_id, @mathematics_id, NULL, 'M.H'),
  (@primary_five_id, @english_id, NULL, 'S.A'),
  (@primary_five_id, @science_id, NULL, 'N.P'),
  (@primary_five_id, @social_studies_id, NULL, 'K.M'),
  (@primary_five_id, @ict_id, NULL, 'N.M');

-- Primary 6: Mathematics => O.H | English => W.A | Science => F.S | Social Studies => O.S | ICT => N.M
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@primary_six_id, @mathematics_id, NULL, 'O.H'),
  (@primary_six_id, @english_id, NULL, 'W.A'),
  (@primary_six_id, @science_id, NULL, 'F.S'),
  (@primary_six_id, @social_studies_id, NULL, 'O.S'),
  (@primary_six_id, @ict_id, NULL, 'N.M');

-- Verification: Display all created entries with custom initials
SELECT '=== ALBAYAN TEACHER INITIALS - FINAL VERIFICATION ===' AS result;
SELECT 
  c.name AS class_name,
  s.name AS subject_name,
  cs.custom_initials
FROM class_subjects cs
JOIN classes c ON cs.class_id = c.id
JOIN subjects s ON cs.subject_id = s.id
WHERE c.school_id = @albayan_school_id
  AND cs.custom_initials IS NOT NULL
ORDER BY c.name, s.name;

-- Summary statistics
SELECT 
  COUNT(*) as 'Total Mappings Created',
  COUNT(DISTINCT class_id) as 'Classes Assigned'
FROM class_subjects cs
WHERE cs.custom_initials IS NOT NULL;

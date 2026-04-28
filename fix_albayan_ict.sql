-- Fix missing ICT assignments for Albayan
SET @albayan_school_id = 8002;

SET @primary_three_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY THREE' LIMIT 1);
SET @primary_four_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY FOUR' LIMIT 1);
SET @primary_five_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY FIVE' LIMIT 1);
SET @primary_six_id = (SELECT id FROM classes WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) = 'PRIMARY SIX' LIMIT 1);

SET @ict_id = (SELECT id FROM subjects WHERE school_id = @albayan_school_id AND UPPER(TRIM(name)) LIKE '%ICT%' LIMIT 1);

-- Insert missing ICT entries
INSERT IGNORE INTO class_subjects (class_id, subject_id, teacher_id, custom_initials)
VALUES
  (@primary_three_id, @ict_id, NULL, 'N.M'),
  (@primary_four_id, @ict_id, NULL, 'N.M'),
  (@primary_five_id, @ict_id, NULL, 'N.M'),
  (@primary_six_id, @ict_id, NULL, 'N.M');

-- Verification
SELECT 'Fixed ICT assignments' AS status;
SELECT c.name AS class, s.name AS subject, cs.custom_initials FROM class_subjects cs
JOIN classes c ON cs.class_id = c.id
JOIN subjects s ON cs.subject_id = s.id
WHERE c.school_id = @albayan_school_id AND s.name LIKE '%ICT%'
ORDER BY c.name;

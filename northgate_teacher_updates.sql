-- ============================================
-- Northgate School Teacher Subject Allocation Updates
-- ============================================
-- This script updates teacher subject allocations for Northgate school
-- based on the provided teacher assignments

-- First, let's find the Northgate school ID
SET @northgate_school_id = (SELECT id FROM schools WHERE name LIKE '%Northgate%' OR short_code LIKE '%northgate%' LIMIT 1);

-- Display the school ID we're working with
SELECT @northgate_school_id AS 'Northgate School ID';

-- ============================================
-- Teacher Subject Allocations
-- ============================================

-- 1. Apio Esther - Mathematics for Primary One and Primary Two
-- Find or create teacher Apio Esther
SET @esther_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Apio' AND p.last_name = 'Esther' LIMIT 1);
SET @esther_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @esther_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Create teacher if not exists
INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Apio', 'Esther', NOW());
SET @esther_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Apio' AND p.last_name = 'Esther' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @esther_person_id, 'Teacher', 'active', NOW());
SET @esther_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @esther_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Mathematics assignments for Primary One and Primary Two
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary One', 'Primary Two') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Mathematics'
SET cs.teacher_id = @esther_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 2. Asekenye Grace - Literacy II for Primary One, English for Primary One and Primary Three
SET @grace_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Asekenye' AND p.last_name = 'Grace' LIMIT 1);
SET @grace_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @grace_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Asekenye', 'Grace', NOW());
SET @grace_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Asekenye' AND p.last_name = 'Grace' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @grace_person_id, 'Teacher', 'active', NOW());
SET @grace_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @grace_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Literacy II for Primary One
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary One' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Literacy II'
SET cs.teacher_id = @grace_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update English for Primary One and Primary Three
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary One', 'Primary Three') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'English'
SET cs.teacher_id = @grace_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 3. Ikomera Christine - Literacy I Primary One and Primary Two, RE for Primary Two
SET @christine_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Ikomera' AND p.last_name = 'Christine' LIMIT 1);
SET @christine_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @christine_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Ikomera', 'Christine', NOW());
SET @christine_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Ikomera' AND p.last_name = 'Christine' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @christine_person_id, 'Teacher', 'active', NOW());
SET @christine_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @christine_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Literacy I for Primary One and Primary Two
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary One', 'Primary Two') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Literacy I'
SET cs.teacher_id = @christine_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Religious Education for Primary Two
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary Two' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Religious Education'
SET cs.teacher_id = @christine_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 4. Awor Topista - English (Primary Five, Primary Two), Literacy II Primary Three, RE Primary One
SET @topista_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Awor' AND p.last_name = 'Topista' LIMIT 1);
SET @topista_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @topista_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Awor', 'Topista', NOW());
SET @topista_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Awor' AND p.last_name = 'Topista' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @topista_person_id, 'Teacher', 'active', NOW());
SET @topista_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @topista_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update English for Primary Five and Primary Two
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Five', 'Primary Two') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'English'
SET cs.teacher_id = @topista_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Literacy II for Primary Three
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary Three' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Literacy II'
SET cs.teacher_id = @topista_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Religious Education for Primary One
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary One' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Religious Education'
SET cs.teacher_id = @topista_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 5. Bakyaire Charles - Literacy I Primary Three, Social Studies Primary Four and Primary Six
SET @charles_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Bakyaire' AND p.last_name = 'Charles' LIMIT 1);
SET @charles_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @charles_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Bakyaire', 'Charles', NOW());
SET @charles_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Bakyaire' AND p.last_name = 'Charles' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @charles_person_id, 'Teacher', 'active', NOW());
SET @charles_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @charles_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Literacy I for Primary Three
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary Three' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Literacy I'
SET cs.teacher_id = @charles_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Social Studies for Primary Four and Primary Six
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Four', 'Primary Six') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Social Studies'
SET cs.teacher_id = @charles_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 6. Wafula John Jackson - Science Primary Four, Primary Five, Primary Seven
SET @john_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'John' AND p.last_name = 'Jackson' LIMIT 1);
SET @john_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @john_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('John', 'Jackson', NOW());
SET @john_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'John' AND p.last_name = 'Jackson' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @john_person_id, 'Teacher', 'active', NOW());
SET @john_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @john_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Science for Primary Four, Primary Five, Primary Seven
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Four', 'Primary Five', 'Primary Seven') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Science'
SET cs.teacher_id = @john_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 7. Epenyu Abraham - Social Studies Primary Five and Primary Seven, Science Primary Six
SET @abraham_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Epenyu' AND p.last_name = 'Abraham' LIMIT 1);
SET @abraham_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @abraham_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Epenyu', 'Abraham', NOW());
SET @abraham_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Epenyu' AND p.last_name = 'Abraham' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @abraham_person_id, 'Teacher', 'active', NOW());
SET @abraham_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @abraham_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Social Studies for Primary Five and Primary Seven
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Five', 'Primary Seven') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Social Studies'
SET cs.teacher_id = @abraham_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Science for Primary Six
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary Six' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Science'
SET cs.teacher_id = @abraham_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 8. Ekaru Emmanuel - RE Primary Three, Mathematics Primary Five and Primary Three
SET @emmanuel_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Ekaru' AND p.last_name = 'Emmanuel' LIMIT 1);
SET @emmanuel_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @emmanuel_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Ekaru', 'Emmanuel', NOW());
SET @emmanuel_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Ekaru' AND p.last_name = 'Emmanuel' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @emmanuel_person_id, 'Teacher', 'active', NOW());
SET @emmanuel_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @emmanuel_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Religious Education for Primary Three
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name = 'Primary Three' AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Religious Education'
SET cs.teacher_id = @emmanuel_staff_id
WHERE cs.school_id = @northgate_school_id;

-- Update Mathematics for Primary Five and Primary Three
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Five', 'Primary Three') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Mathematics'
SET cs.teacher_id = @emmanuel_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 9. Egau Gerald - Mathematics Primary Four, Primary Six and Primary Seven
SET @gerald_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Egau' AND p.last_name = 'Gerald' LIMIT 1);
SET @gerald_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @gerald_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Egau', 'Gerald', NOW());
SET @gerald_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Egau' AND p.last_name = 'Gerald' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @gerald_person_id, 'Teacher', 'active', NOW());
SET @gerald_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @gerald_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update Mathematics for Primary Four, Primary Six and Primary Seven
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Four', 'Primary Six', 'Primary Seven') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'Mathematics'
SET cs.teacher_id = @gerald_staff_id
WHERE cs.school_id = @northgate_school_id;

-- 10. Emeru Joel - English Primary Four, Primary Six and Primary Seven
SET @joel_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Emeru' AND p.last_name = 'Joel' LIMIT 1);
SET @joel_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @joel_person_id AND s.school_id = @northgate_school_id LIMIT 1);

INSERT IGNORE INTO people (first_name, last_name, created_at) VALUES ('Emeru', 'Joel', NOW());
SET @joel_person_id = (SELECT p.id FROM people p WHERE p.first_name = 'Emeru' AND p.last_name = 'Joel' LIMIT 1);
INSERT IGNORE INTO staff (school_id, person_id, position, status, created_at) VALUES (@northgate_school_id, @joel_person_id, 'Teacher', 'active', NOW());
SET @joel_staff_id = (SELECT s.id FROM staff s WHERE s.person_id = @joel_person_id AND s.school_id = @northgate_school_id LIMIT 1);

-- Update English for Primary Four, Primary Six and Primary Seven
UPDATE class_subjects cs 
JOIN classes c ON cs.class_id = c.id AND c.name IN ('Primary Four', 'Primary Six', 'Primary Seven') AND c.school_id = @northgate_school_id
JOIN subjects s ON cs.subject_id = s.id AND s.name = 'English'
SET cs.teacher_id = @joel_staff_id
WHERE cs.school_id = @northgate_school_id;

-- ============================================
-- Verification Report
-- ============================================

-- Show all updated teacher assignments for Northgate
SELECT 
  p.first_name,
  p.last_name,
  c.name AS class_name,
  sub.name AS subject_name,
  'Teacher' AS role
FROM class_subjects cs
JOIN staff s ON cs.teacher_id = s.id
JOIN people p ON s.person_id = p.id
JOIN classes c ON cs.class_id = c.id
JOIN subjects sub ON cs.subject_id = sub.id
WHERE cs.school_id = @northgate_school_id 
  AND cs.teacher_id IS NOT NULL
  AND s.deleted_at IS NULL
ORDER BY p.last_name, p.first_name, c.name, sub.name;

-- Count total assignments
SELECT 
  COUNT(*) AS total_assignments,
  COUNT(DISTINCT cs.teacher_id) AS total_teachers,
  COUNT(DISTINCT cs.class_id) AS total_classes,
  COUNT(DISTINCT cs.subject_id) AS total_subjects
FROM class_subjects cs
WHERE cs.school_id = @northgate_school_id 
  AND cs.teacher_id IS NOT NULL;

-- ============================================
-- Teacher Initials Setup for Reports
-- ============================================

-- Create a view for teacher initials that can be used in reports
CREATE OR REPLACE VIEW v_teacher_initials AS
SELECT 
  s.id AS staff_id,
  s.school_id,
  p.first_name,
  p.last_name,
  CONCAT(UPPER(LEFT(p.first_name, 1)), UPPER(LEFT(p.last_name, 1))) AS initials,
  CONCAT(p.first_name, ' ', p.last_name) AS full_name
FROM staff s
JOIN people p ON s.person_id = p.id
WHERE s.deleted_at IS NULL AND p.first_name IS NOT NULL AND p.last_name IS NOT NULL;

-- Show teacher initials for Northgate
SELECT * FROM v_teacher_initials WHERE school_id = @northgate_school_id ORDER BY last_name, first_name;

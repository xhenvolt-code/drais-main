USE drais_school;

-- Sample school data
INSERT INTO schools (id, name, short_code, email, phone, address) VALUES
(1, 'DRAIS Islamic School', 'DRAIS', 'info@drais.ac.ug', '+256701234567', 'Kampala, Uganda')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Sample people data with photos
INSERT INTO people (id, school_id, first_name, last_name, other_name, gender, date_of_birth, phone, email, address) VALUES
(1, 1, 'Ahmed', 'Hassan', 'Mohammed', 'male', '2010-05-15', '+256701234501', 'ahmed.hassan@student.drais.ac.ug', 'Kampala'),
(2, 1, 'Fatima', 'Ali', 'Aisha', 'female', '2011-03-22', '+256701234502', 'fatima.ali@student.drais.ac.ug', 'Entebbe'),
(3, 1, 'Omar', 'Ibrahim', 'Yusuf', 'male', '2009-08-10', '+256701234503', 'omar.ibrahim@student.drais.ac.ug', 'Mukono'),
(4, 1, 'Zeinab', 'Musa', 'Mariam', 'female', '2010-12-03', '+256701234504', 'zeinab.musa@student.drais.ac.ug', 'Jinja'),
(5, 1, 'Abdul', 'Rahman', 'Khalid', 'male', '2011-06-18', '+256701234505', 'abdul.rahman@student.drais.ac.ug', 'Mbale')
ON DUPLICATE KEY UPDATE first_name = VALUES(first_name);

-- Sample classes
INSERT INTO classes (id, school_id, name, class_level) VALUES
(1, 1, 'Primary 1', 1),
(2, 1, 'Primary 2', 2),
(3, 1, 'Primary 3', 3),
(4, 1, 'Primary 4', 4),
(5, 1, 'Primary 5', 5)
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- Sample students
INSERT INTO students (id, school_id, person_id, admission_no, status, admission_date) VALUES
(1, 1, 1, 'DRAIS/2024/001', 'active', '2024-01-15'),
(2, 1, 2, 'DRAIS/2024/002', 'active', '2024-01-16'),
(3, 1, 3, 'DRAIS/2024/003', 'active', '2024-01-17'),
(4, 1, 4, 'DRAIS/2024/004', 'active', '2024-01-18'),
(5, 1, 5, 'DRAIS/2024/005', 'active', '2024-01-19')
ON DUPLICATE KEY UPDATE status = VALUES(status);

-- Sample academic year and term
INSERT INTO academic_years (id, school_id, name, start_date, end_date, status) VALUES
(1, 1, '2024', '2024-01-01', '2024-12-31', 'active')
ON DUPLICATE KEY UPDATE status = VALUES(status);

INSERT INTO terms (id, school_id, academic_year_id, name, start_date, end_date, status) VALUES
(1, 1, 1, 'Term 1', '2024-01-15', '2024-04-15', 'active')
ON DUPLICATE KEY UPDATE status = VALUES(status);

-- Sample enrollments
INSERT INTO enrollments (id, student_id, class_id, academic_year_id, term_id, status) VALUES
(1, 1, 1, 1, 1, 'active'),
(2, 2, 1, 1, 1, 'active'),
(3, 3, 2, 1, 1, 'active'),
(4, 4, 2, 1, 1, 'active'),
(5, 5, 3, 1, 1, 'active')
ON DUPLICATE KEY UPDATE status = VALUES(status);

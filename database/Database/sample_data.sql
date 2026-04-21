-- Sample data for DRAIS School Management System
USE drais_school;

-- Insert sample school
INSERT INTO schools (id, name, legal_name, short_code, email, phone, currency, address) VALUES
(1, 'DRAIS School', 'DRAIS Academy of Islamic Studies', 'DRAIS', 'info@draisschool.com', '+256700000000', 'UGX', 'Kampala, Uganda');

-- Insert sample academic year
INSERT INTO academic_years (id, school_id, name, start_date, end_date, status) VALUES
(1, 1, '2025', '2025-01-01', '2025-12-31', 'active');

-- Insert sample term
INSERT INTO terms (id, school_id, academic_year_id, name, start_date, end_date, status) VALUES
(1, 1, 1, 'Term 1', '2025-01-01', '2025-04-30', 'active');

-- Insert sample classes
INSERT INTO classes (id, school_id, name, curriculum_id, class_level) VALUES
(1, 1, 'Primary 1', 1, 1),
(2, 1, 'Primary 2', 1, 2),
(3, 1, 'Primary 3', 1, 3),
(4, 1, 'Secondary 1', 1, 7),
(5, 1, 'Secondary 2', 1, 8);

-- Insert sample streams
INSERT INTO streams (id, school_id, class_id, name) VALUES
(1, 1, 1, 'A'),
(2, 1, 1, 'B'),
(3, 1, 2, 'A'),
(4, 1, 3, 'A'),
(5, 1, 4, 'A');

-- Insert sample districts and geography
INSERT INTO districts (id, name) VALUES
(1, 'Kampala'),
(2, 'Wakiso'),
(3, 'Mukono');

INSERT INTO counties (id, district_id, name) VALUES
(1, 1, 'Central Division'),
(2, 1, 'Kawempe Division'),
(3, 2, 'Kyadondo County');

INSERT INTO subcounties (id, county_id, name) VALUES
(1, 1, 'Central'),
(2, 2, 'Kawempe'),
(3, 3, 'Kira');

INSERT INTO parishes (id, subcounty_id, name) VALUES
(1, 1, 'City Centre'),
(2, 2, 'Kawempe'),
(3, 3, 'Kira');

INSERT INTO villages (id, parish_id, name) VALUES
(1, 1, 'Kampala Central'),
(2, 2, 'Kawempe Town'),
(3, 3, 'Kira Municipality');

-- Insert sample people
INSERT INTO people (id, school_id, first_name, last_name, other_name, gender, date_of_birth, phone, email, address) VALUES
(1, 1, 'Ahmed', 'Hassan', 'Ibrahim', 'male', '2010-03-15', '+256700111111', NULL, 'Kampala, Uganda'),
(2, 1, 'Fatima', 'Ali', 'Zainab', 'female', '2009-07-22', '+256700222222', NULL, 'Kampala, Uganda'),
(3, 1, 'Omar', 'Mohamed', 'Abdullah', 'male', '2011-01-10', '+256700333333', NULL, 'Wakiso, Uganda'),
(4, 1, 'Aisha', 'Abdallah', 'Khadija', 'female', '2010-09-05', '+256700444444', NULL, 'Mukono, Uganda'),
(5, 1, 'Yusuf', 'Ibrahim', 'Ismail', 'male', '2008-12-18', '+256700555555', NULL, 'Kampala, Uganda'),
(6, 1, 'Mariam', 'Osman', 'Halima', 'female', '2009-04-30', '+256700666666', NULL, 'Kampala, Uganda'),
(7, 1, 'Rashid', 'Ahmed', 'Salim', 'male', '2010-11-12', '+256700777777', NULL, 'Wakiso, Uganda'),
(8, 1, 'Safiya', 'Hussein', 'Amina', 'female', '2011-06-08', '+256700888888', NULL, 'Kampala, Uganda'),
(9, 1, 'Hamza', 'Musa', 'Omar', 'male', '2009-02-14', '+256700999999', NULL, 'Mukono, Uganda'),
(10, 1, 'Khadija', 'Salim', 'Fatou', 'female', '2010-08-25', '+256700101010', NULL, 'Kampala, Uganda');

-- Insert sample students
INSERT INTO students (id, school_id, person_id, admission_no, village_id, admission_date, status) VALUES
(1, 1, 1, 'XHN/0001/2025', 1, '2025-01-10', 'active'),
(2, 1, 2, 'XHN/0002/2025', 1, '2025-01-10', 'active'),
(3, 1, 3, 'XHN/0003/2025', 2, '2025-01-12', 'active'),
(4, 1, 4, 'XHN/0004/2025', 3, '2025-01-12', 'active'),
(5, 1, 5, 'XHN/0005/2025', 1, '2025-01-15', 'active'),
(6, 1, 6, 'XHN/0006/2025', 1, '2025-01-15', 'active'),
(7, 1, 7, 'XHN/0007/2025', 2, '2025-01-18', 'active'),
(8, 1, 8, 'XHN/0008/2025', 1, '2025-01-18', 'active'),
(9, 1, 9, 'XHN/0009/2025', 3, '2025-01-20', 'active'),
(10, 1, 10, 'XHN/0010/2025', 1, '2025-01-20', 'active');

-- Insert sample enrollments
INSERT INTO enrollments (id, student_id, class_id, stream_id, academic_year_id, term_id, status) VALUES
(1, 1, 1, 1, 1, 1, 'active'),
(2, 2, 1, 1, 1, 1, 'active'),
(3, 3, 1, 2, 1, 1, 'active'),
(4, 4, 2, 3, 1, 1, 'active'),
(5, 5, 4, 5, 1, 1, 'active'),
(6, 6, 2, 3, 1, 1, 'active'),
(7, 7, 1, 2, 1, 1, 'active'),
(8, 8, 3, 4, 1, 1, 'active'),
(9, 9, 4, 5, 1, 1, 'active'),
(10, 10, 3, 4, 1, 1, 'active');

-- Insert sample attendance records
INSERT INTO student_attendance (student_id, date, status, time_in, class_id) VALUES
(1, '2025-01-20', 'present', '08:00:00', 1),
(2, '2025-01-20', 'present', '08:05:00', 1),
(3, '2025-01-20', 'present', '08:10:00', 1),
(4, '2025-01-20', 'absent', NULL, 2),
(5, '2025-01-20', 'present', '07:55:00', 4),
(6, '2025-01-20', 'present', '08:15:00', 2),
(7, '2025-01-20', 'present', '08:20:00', 1),
(8, '2025-01-20', 'present', '08:00:00', 3),
(9, '2025-01-20', 'present', '08:30:00', 4),
(10, '2025-01-20', 'present', '08:25:00', 3);

-- Insert more attendance records for percentage calculation
INSERT INTO student_attendance (student_id, date, status, time_in, class_id) VALUES
-- Last 30 days attendance for student 1 (90% attendance)
(1, '2025-01-19', 'present', '08:00:00', 1),
(1, '2025-01-18', 'present', '08:05:00', 1),
(1, '2025-01-17', 'absent', NULL, 1),
(1, '2025-01-16', 'present', '08:10:00', 1),
(1, '2025-01-15', 'present', '08:00:00', 1),
-- Student 2 (80% attendance)
(2, '2025-01-19', 'present', '08:00:00', 1),
(2, '2025-01-18', 'absent', NULL, 1),
(2, '2025-01-17', 'present', '08:05:00', 1),
(2, '2025-01-16', 'absent', NULL, 1),
(2, '2025-01-15', 'present', '08:10:00', 1),
-- Student 3 (70% attendance)
(3, '2025-01-19', 'absent', NULL, 1),
(3, '2025-01-18', 'present', '08:00:00', 1),
(3, '2025-01-17', 'absent', NULL, 1),
(3, '2025-01-16', 'present', '08:05:00', 1),
(3, '2025-01-15', 'absent', NULL, 1);

-- Create sample uploads directory structure
-- Note: This would typically be done via file system, but documenting here
-- mkdir -p public/uploads/students

SELECT
  rc.id AS report_card_id,
  rc.student_id,
  rc.term_id,
  rc.overall_grade,
  rc.class_teacher_comment,
  rc.headteacher_comment,
  rc.dos_comment,
  s.admission_no,
  s.school_id,
  p.first_name,
  p.last_name,
  p.gender,
  p.photo_url,
  -- add other fields as needed
  t.name AS term_name
FROM report_cards rc
JOIN students s ON rc.student_id = s.id
JOIN people p ON s.person_id = p.id
JOIN terms t ON rc.term_id = t.id
WHERE rc.id = ?
  AND s.school_id = ?
LIMIT 1;

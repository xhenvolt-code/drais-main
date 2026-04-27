#!/usr/bin/env node
import mysql from 'mysql2/promise';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: process.env.TIDB_USER || '',
  password: process.env.TIDB_PASSWORD || '',
  database: process.env.TIDB_DB || 'drais',
  ssl: { rejectUnauthorized: false },
};

if (!config.user || !config.password) {
  console.error('ERROR: TIDB_USER and TIDB_PASSWORD environment variables must be set');
  process.exit(1);
}

const conn = await mysql.createConnection(config);

console.log('\n========== 1. CLASS_RESULTS TABLE SCHEMA ==========');
const [schema] = await conn.execute('DESCRIBE class_results');
console.table(schema);

console.log('\n========== 2. STUDENTS WITHOUT ADMISSION NUMBER ==========');
const [noAdmission] = await conn.execute(`
  SELECT id, person_id, admission_no, status, deleted_at, created_at
  FROM students
  WHERE admission_no IS NULL OR admission_no = ''
  LIMIT 20
`);
console.log(`Total students missing admission number: ${noAdmission.length}`);
if (noAdmission.length > 0) {
  console.table(noAdmission.slice(0, 10));
}

console.log('\n========== 3. SOFT DELETED STUDENTS IN REPORTS ==========');
const [softDeletedInReports] = await conn.execute(`
  SELECT COUNT(DISTINCT cr.student_id) as soft_deleted_count
  FROM class_results cr
  JOIN students s ON cr.student_id = s.id
  WHERE s.deleted_at IS NOT NULL
`);
console.log(`Soft-deleted students appearing in class_results:`, softDeletedInReports[0]);

console.log('\n========== 4. RECENT CLASS_RESULTS DATA SAMPLE ==========');
const [recentResults] = await conn.execute(`
  SELECT 
    id, student_id, class_id, subject_id, term_id, 
    academic_year_id, score, grade, created_at,
    (SELECT COUNT(*) FROM class_results WHERE academic_year_id IS NULL) as null_year_count,
    (SELECT COUNT(*) FROM class_results) as total_results
  FROM class_results
  ORDER BY created_at DESC
  LIMIT 1
`);
console.table(recentResults);

console.log('\n========== 5. COUNT OF RESULTS BY YEAR ==========');
const [yearCounts] = await conn.execute(`
  SELECT 
    CASE WHEN academic_year_id IS NULL THEN 'NULL' ELSE CAST(academic_year_id AS CHAR) END as year_id,
    COUNT(*) as count
  FROM class_results
  GROUP BY academic_year_id
  ORDER BY academic_year_id DESC
`);
console.table(yearCounts);

console.log('\n========== 6. RECENT 2026 RESULTS ==========');
const [results2026] = await conn.execute(`
  SELECT 
    cr.id, cr.student_id, cr.score, cr.grade, 
    cr.academic_year_id, ay.name as year_name,
    cr.term_id, t.name as term_name,
    s.admission_no, p.first_name, p.last_name
  FROM class_results cr
  LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
  LEFT JOIN terms t ON cr.term_id = t.id
  JOIN students s ON cr.student_id = s.id
  JOIN people p ON s.person_id = p.id
  WHERE ay.name = '2026' OR (ay.id IS NULL AND cr.created_at > DATE_SUB(NOW(), INTERVAL 30 DAY))
  ORDER BY cr.created_at DESC
  LIMIT 10
`);
console.table(results2026);

console.log('\n========== 7. NORTHGATE STUDENTS WITH MISSING ADMISSION ==========');
const [northgateNoAdm] = await conn.execute(`
  SELECT s.id, p.first_name, p.last_name, s.admission_no, s.created_at
  FROM students s
  JOIN people p ON s.person_id = p.id
  WHERE s.school_id = 6 AND (s.admission_no IS NULL OR s.admission_no = '')
  LIMIT 20
`);
console.log(`Northgate students missing admission number: ${northgateNoAdm.length}`);
if (northgateNoAdm.length > 0) {
  console.table(northgateNoAdm);
}

await conn.end();
console.log('\n✅ Database check complete');

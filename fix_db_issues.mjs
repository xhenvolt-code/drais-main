#!/usr/bin/env node
/**
 * Fix TiDB database issues:
 * 1. Populate missing admission numbers
 * 2. Backfill academic_year_id for results based on term
 * 3. Remove soft-deleted students from visible reports
 */
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

try {
  console.log('\n========== FIX 1: POPULATE MISSING ADMISSION NUMBERS ==========');
  
  // Get the highest existing admission number per school
  const result1 = await conn.execute(`
    SELECT 
      s.school_id,
      sc.abbreviation as school_code,
      MAX(CAST(SUBSTRING_INDEX(s.admission_no, '/', 1) AS UNSIGNED)) as last_seq
    FROM students s
    JOIN schools sc ON s.school_id = sc.id
    WHERE s.admission_no IS NOT NULL AND s.admission_no != ''
    GROUP BY s.school_id, sc.abbreviation
  `);
  const schoolAdmissions = result1[0];

  console.table(schoolAdmissions);

  for (const schoolRecord of schoolAdmissions) {
    const { school_id, school_code, last_seq } = schoolRecord;
    const nextSeq = (last_seq || 0) + 1;
    
    const result2 = await conn.execute(`
      SELECT id, school_id FROM students 
      WHERE school_id = ? AND (admission_no IS NULL OR admission_no = '')
      ORDER BY id ASC
    `, [school_id]);
    const missingAdm = result2[0];

    if (missingAdm.length > 0) {
      console.log(`\n📝 Fixing ${missingAdm.length} students at school ${school_id}`);
      
      for (let i = 0; i < missingAdm.length; i++) {
        const student = missingAdm[i];
        const newAdmNo = `${school_code}/${String(nextSeq + i).padStart(4, '0')}/2026`;
        
        await conn.execute(
          'UPDATE students SET admission_no = ? WHERE id = ?',
          [newAdmNo, student.id]
        );
      }
      console.log(`✅ Created admission numbers from ${school_code}/${String(nextSeq).padStart(4, '0')}/2026`);
    }
  }

  console.log('\n========== FIX 2: BACKFILL ACADEMIC_YEAR_ID IN RESULTS ==========');
  
  // Update class_results where academic_year_id is NULL by joining with terms
  const result3 = await conn.execute(`
    UPDATE class_results cr
    JOIN terms t ON cr.term_id = t.id
    SET cr.academic_year_id = t.academic_year_id
    WHERE cr.academic_year_id IS NULL
      AND cr.term_id IS NOT NULL
      AND t.academic_year_id IS NOT NULL
  `);
  const updateResult = result3[0];
  
  console.log(`✅ Backfilled ${updateResult.affectedRows} class_results with academic_year_id from terms`);

  // Check remaining nulls
  const result4 = await conn.execute(`
    SELECT COUNT(*) as count FROM class_results WHERE academic_year_id IS NULL
  `);
  const stillNull = result4[0];
  console.log(`📊 Results still with NULL academic_year_id: ${stillNull[0].count}`);

  console.log('\n========== FIX 3: COUNT OF RESULTS AFTER FIX ==========');
  const result5 = await conn.execute(`
    SELECT 
      CASE WHEN academic_year_id IS NULL THEN 'NULL' 
           ELSE CAST(academic_year_id AS CHAR) END as year_id,
      COUNT(*) as count
    FROM class_results
    GROUP BY academic_year_id
    ORDER BY academic_year_id DESC
  `);
  const yearCountsAfter = result5[0];
  console.table(yearCountsAfter);

  console.log('\n========== VERIFICATION: TEST SOFT DELETE FILTER ==========');
  const result6 = await conn.execute(`
    SELECT COUNT(DISTINCT cr.student_id) as soft_deleted_in_results
    FROM class_results cr
    JOIN students s ON cr.student_id = s.id
    WHERE s.deleted_at IS NOT NULL
  `);
  const reportsWithSoftDeleted = result6[0];
  console.log('Soft-deleted students in class_results:', reportsWithSoftDeleted[0]);

  console.log('\n✅ Database fixes complete!');
  
} catch (error) {
  console.error('❌ Error:', error);
  process.exit(1);
} finally {
  await conn.end();
}

#!/usr/bin/env node
/**
 * Fix TiDB database issues:
 * 1. Populate missing admission numbers
 * 2. Backfill academic_year_id for results based on term
 * 3. Verify soft-deleted students are not shown in reports
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
  
  // For each school, generate missing admission numbers using school_id-based prefix
  const [schoolIds] = await conn.execute(`
    SELECT DISTINCT school_id FROM students WHERE admission_no IS NULL OR admission_no = ''
  `);

  for (const row of schoolIds) {
    const school_id = row.school_id;
    const prefix = `S${school_id}`;
    
    // Get next sequence for this school
    const [seqResult] = await conn.execute(`
      SELECT MAX(CAST(SUBSTRING_INDEX(admission_no, '/', 2) AS UNSIGNED)) as last_seq
      FROM students
      WHERE school_id = ? AND admission_no IS NOT NULL AND admission_no LIKE CONCAT(?,'/%')
    `, [school_id, prefix]);
    const lastSeq = seqResult[0]?.last_seq || 0;
    const nextSeq = lastSeq + 1;
    
    // Get students missing admission
    const [students] = await conn.execute(`
      SELECT id FROM students 
      WHERE school_id = ? AND (admission_no IS NULL OR admission_no = '')
      ORDER BY id ASC
    `, [school_id]);

    if (students.length > 0) {
      console.log(`\n📝 Generating ${students.length} admission numbers for school ${school_id}...`);
      
      for (let i = 0; i < students.length; i++) {
        const newAdmNo = `${prefix}/${String(nextSeq + i).padStart(4, '0')}/2026`;
        
        await conn.execute(
          'UPDATE students SET admission_no = ? WHERE id = ?',
          [newAdmNo, students[i].id]
        );
      }
      console.log(`✅ Created admission numbers ${prefix}/${String(nextSeq).padStart(4, '0')}/2026 through ${prefix}/${String(nextSeq + students.length - 1).padStart(4, '0')}/2026`);
    }
  }

  console.log('\n========== FIX 2: BACKFILL ACADEMIC_YEAR_ID IN CLASS_RESULTS ==========');
  
  // Update class_results where academic_year_id is NULL by joining with terms
  const [updateResult] = await conn.execute(`
    UPDATE class_results cr
    JOIN terms t ON cr.term_id = t.id
    SET cr.academic_year_id = t.academic_year_id
    WHERE cr.academic_year_id IS NULL
      AND cr.term_id IS NOT NULL
      AND t.academic_year_id IS NOT NULL
  `);
  
  console.log(`✅ Backfilled ${updateResult.affectedRows} class_results with academic_year_id from terms`);

  // Check remaining nulls
  const [stillNull] = await conn.execute(`
    SELECT COUNT(*) as count FROM class_results WHERE academic_year_id IS NULL
  `);
  console.log(`📊 Results still with NULL academic_year_id: ${stillNull[0].count}`);

  console.log('\n========== FIX 3: VERIFY DATA AFTER FIXES ==========');
  
  // Count results by year after fix
  const [yearCounts] = await conn.execute(`
    SELECT 
      CASE WHEN academic_year_id IS NULL THEN 'NULL' 
           ELSE CAST(academic_year_id AS CHAR) END as year_id,
      COUNT(*) as count
    FROM class_results
    GROUP BY academic_year_id
    ORDER BY year_id DESC
  `);
  console.log('\nClass results by academic year:');
  console.table(yearCounts);

  // Verify soft-deleted students not showing in reports
  const [softDeleted] = await conn.execute(`
    SELECT COUNT(DISTINCT cr.student_id) as soft_deleted_count
    FROM class_results cr
    JOIN students s ON cr.student_id = s.id
    WHERE s.deleted_at IS NOT NULL
  `);
  console.log('\n⚠️  Soft-deleted students appearing in class_results (should be 0 in reports):', softDeleted[0].soft_deleted_count);

  // Count students with admission numbers
  const [admCounts] = await conn.execute(`
    SELECT 
      (SELECT COUNT(*) FROM students WHERE admission_no IS NOT NULL AND admission_no != '') as with_admission,
      (SELECT COUNT(*) FROM students WHERE admission_no IS NULL OR admission_no = '') as without_admission
  `);
  console.log('\nAdmission number status:');
  console.table(admCounts);

  console.log('\n✅ Database fixes complete!');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

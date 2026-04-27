#!/usr/bin/env node
/**
 * Fast bulk database fixes for TiDB:
 * 1. Populate missing admission numbers (bulk update with ROW_NUMBER)
 * 2. Backfill academic_year_id for class_results (batch update)
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
  console.log('\n========== FIX 1: BACKFILL ACADEMIC_YEAR_ID (Priority) ==========');
  
  const [result1] = await conn.execute(`
    UPDATE class_results cr
    JOIN terms t ON cr.term_id = t.id
    SET cr.academic_year_id = t.academic_year_id
    WHERE cr.academic_year_id IS NULL
      AND cr.term_id IS NOT NULL
      AND t.academic_year_id IS NOT NULL
  `);
  
  console.log(`✅ Backfilled ${result1.affectedRows} class_results with academic_year_id from terms`);

  // Check remaining nulls
  const [stillNull] = await conn.execute(`
    SELECT COUNT(*) as count FROM class_results WHERE academic_year_id IS NULL
  `);
  console.log(`📊 Results still with NULL academic_year_id: ${stillNull[0].count}`);

  console.log('\n========== VERIFICATION: RESULTS BY ACADEMIC YEAR ==========');
  
  const [yearCounts] = await conn.execute(`
    SELECT 
      COALESCE(ay.name, 'NULL') as year,
      COUNT(*) as count
    FROM class_results cr
    LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
    GROUP BY cr.academic_year_id
    ORDER BY year DESC
  `);
  console.table(yearCounts);

  console.log('\n========== FIX 2: POPULATE MISSING ADMISSION NUMBERS ==========');
  
  // Generate missing admission numbers using school_id prefix
  const [missingStudents] = await conn.execute(`
    SELECT 
      school_id,
      COUNT(*) as count
    FROM students 
    WHERE admission_no IS NULL OR admission_no = ''
    GROUP BY school_id
  `);

  let totalGenerated = 0;
  for (const school of missingStudents) {
    const { school_id, count } = school;
    const prefix = `S${school_id}`;
    
    console.log(`\n📝 Generating ${count} admission numbers for school ${school_id}...`);
    
    // Use a temporary table with ROW_NUMBER to generate sequential admission numbers
    const [result2] = await conn.execute(`
      CREATE TEMPORARY TABLE temp_missing_adm AS
      SELECT 
        s.id,
        ROW_NUMBER() OVER (ORDER BY s.id ASC) as seq
      FROM students s
      WHERE s.school_id = ? AND (s.admission_no IS NULL OR s.admission_no = '')
    `, [school_id]);

    // Get the max seq from existing admission numbers for this school
    const [maxSeq] = await conn.execute(`
      SELECT COALESCE(MAX(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(admission_no, '/', 2), '/', -1) AS UNSIGNED)), 0) as last_seq
      FROM students
      WHERE school_id = ? AND admission_no IS NOT NULL AND admission_no LIKE CONCAT(?,'/%')
    `, [school_id, prefix]);

    const startSeq = (maxSeq[0]?.last_seq || 0) + 1;

    // Update with generated admission numbers
    const [result3] = await conn.execute(`
      UPDATE students s
      JOIN temp_missing_adm t ON s.id = t.id
      SET s.admission_no = CONCAT(?, '/', LPAD(? + t.seq - 1, 4, '0'), '/2026')
      WHERE s.school_id = ?
    `, [prefix, startSeq, school_id]);

    console.log(`✅ Created ${result3.affectedRows} admission numbers starting from ${prefix}/${String(startSeq).padStart(4, '0')}/2026`);
    totalGenerated += result3.affectedRows;

    await conn.execute('DROP TEMPORARY TABLE IF EXISTS temp_missing_adm');
  }

  console.log(`\n✅ Total admission numbers generated: ${totalGenerated}`);

  console.log('\n========== VERIFICATION: ADMISSION NUMBER STATUS ==========');
  
  const [admStatus] = await conn.execute(`
    SELECT 
      (SELECT COUNT(*) FROM students WHERE admission_no IS NOT NULL AND admission_no != '') as with_admission,
      (SELECT COUNT(*) FROM students WHERE admission_no IS NULL OR admission_no = '') as without_admission,
      (SELECT COUNT(*) FROM students) as total_students
  `);
  console.table(admStatus);

  console.log('\n========== VERIFICATION: SOFT-DELETED IN REPORTS ==========');
  
  const [softDeleted] = await conn.execute(`
    SELECT COUNT(DISTINCT cr.student_id) as soft_deleted_count
    FROM class_results cr
    JOIN students s ON cr.student_id = s.id
    WHERE s.deleted_at IS NOT NULL
  `);
  console.log(`⚠️  Soft-deleted students appearing in class_results: ${softDeleted[0].soft_deleted_count}`);
  console.log('   (NOTE: Reports must filter WHERE deleted_at IS NULL)\n');

  console.log('✅ ALL FIXES COMPLETE!\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

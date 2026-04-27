#!/usr/bin/env node
/**
 * Generate missing admission numbers using a simple bulk approach
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

const conn = await mysql.createConnection(config);

try {
  console.log('\n========== POPULATING MISSING ADMISSION NUMBERS ==========\n');
  
  // Get all schools with missing admission students
  const [missingStudents] = await conn.execute(`
    SELECT 
      school_id,
      COUNT(*) as count
    FROM students 
    WHERE (admission_no IS NULL OR admission_no = '')
    GROUP BY school_id
    ORDER BY school_id ASC
  `);

  let totalGenerated = 0;
  for (const school of missingStudents) {
    const { school_id, count } = school;
    const prefix = `S${school_id}`;
    
    console.log(`📝 Processing school ${school_id}: ${count} students...`);
    
    // Get next sequence number
    const [maxSeqResult] = await conn.execute(`
      SELECT COALESCE(MAX(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(admission_no, '/', 2), '/', -1) AS UNSIGNED)), 0) as last_seq
      FROM students
      WHERE school_id = ? AND admission_no IS NOT NULL AND admission_no LIKE ?
    `, [school_id, `${prefix}/%`]);

    const lastSeq = maxSeqResult[0]?.last_seq || 0;
    const startSeq = lastSeq + 1;

    // Fetch missing students and update them
    const [studentsToFix] = await conn.execute(`
      SELECT id 
      FROM students 
      WHERE school_id = ? AND (admission_no IS NULL OR admission_no = '')
      ORDER BY id ASC
    `, [school_id]);

    for (let i = 0; i < studentsToFix.length; i++) {
      const newAdmNo = `${prefix}/${String(startSeq + i).padStart(4, '0')}/2026`;
      await conn.execute(
        'UPDATE students SET admission_no = ? WHERE id = ?',
        [newAdmNo, studentsToFix[i].id]
      );
    }

    console.log(`   ✅ Created ${count} admission numbers: ${prefix}/${String(startSeq).padStart(4, '0')}/2026 - ${prefix}/${String(startSeq + count - 1).padStart(4, '0')}/2026`);
    totalGenerated += count;
  }

  console.log(`\n✅ Total admission numbers generated: ${totalGenerated}\n`);

  console.log('========== FINAL VERIFICATION ==========\n');
  
  // Final status
  const [admStatus] = await conn.execute(`
    SELECT 
      (SELECT COUNT(*) FROM students WHERE admission_no IS NOT NULL AND admission_no != '') as with_admission,
      (SELECT COUNT(*) FROM students WHERE admission_no IS NULL OR admission_no = '') as without_admission,
      (SELECT COUNT(*) FROM students) as total_students
  `);
  console.table(admStatus);

  const [yearCounts] = await conn.execute(`
    SELECT 
      COALESCE(ay.name, 'NO YEAR') as academic_year,
      COUNT(*) as results_count
    FROM class_results cr
    LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
    GROUP BY cr.academic_year_id
    ORDER BY academic_year DESC
  `);
  console.log('\nClass Results by Academic Year:');
  console.table(yearCounts);

  console.log('\n✅ DATABASE FIXES COMPLETE!\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

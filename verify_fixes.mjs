#!/usr/bin/env node
/**
 * Quick verification of database fixes
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
  console.log('\n========== DATABASE FIX VERIFICATION ==========\n');
  
  // 1. Check academic_year_id population
  const [yearStats] = await conn.execute(`
    SELECT 
      COUNT(*) as total_results,
      SUM(CASE WHEN academic_year_id IS NOT NULL THEN 1 ELSE 0 END) as with_year,
      SUM(CASE WHEN academic_year_id IS NULL THEN 1 ELSE 0 END) as without_year
    FROM class_results
  `);
  
  console.log('1️⃣  Academic Year Backfill Status:');
  console.log(`   Total results: ${yearStats[0].total_results}`);
  console.log(`   With academic_year_id: ${yearStats[0].with_year} (${((yearStats[0].with_year/yearStats[0].total_results)*100).toFixed(1)}%)`);
  console.log(`   Without academic_year_id: ${yearStats[0].without_year} (${((yearStats[0].without_year/yearStats[0].total_results)*100).toFixed(1)}%)`);
  
  // 2. Check admission numbers
  const [admStatus] = await conn.execute(`
    SELECT 
      SUM(CASE WHEN admission_no IS NOT NULL AND admission_no != '' THEN 1 ELSE 0 END) as with_admission,
      SUM(CASE WHEN admission_no IS NULL OR admission_no = '' THEN 1 ELSE 0 END) as without_admission,
      COUNT(*) as total_students
    FROM students
  `);
  
  console.log('\n2️⃣  Admission Number Status:');
  console.log(`   With admission_no: ${admStatus[0].with_admission} (${((admStatus[0].with_admission/admStatus[0].total_students)*100).toFixed(1)}%)`);
  console.log(`   Without admission_no: ${admStatus[0].without_admission} (${((admStatus[0].without_admission/admStatus[0].total_students)*100).toFixed(1)}%)`);
  
  // 3. Check results by year
  const [yearBreakdown] = await conn.execute(`
    SELECT 
      COALESCE(ay.name, 'NO YEAR') as academic_year,
      COUNT(*) as results_count
    FROM class_results cr
    LEFT JOIN academic_years ay ON cr.academic_year_id = ay.id
    GROUP BY cr.academic_year_id
    ORDER BY academic_year DESC
  `);
  
  console.log('\n3️⃣  Results by Academic Year:');
  console.table(yearBreakdown);
  
  // 4. Check soft-deleted in results
  const [softDeleted] = await conn.execute(`
    SELECT COUNT(DISTINCT cr.student_id) as soft_deleted_count
    FROM class_results cr
    JOIN students s ON cr.student_id = s.id
    WHERE s.deleted_at IS NOT NULL
  `);
  
  console.log(`\n4️⃣  Soft-Deleted Students in Results: ${softDeleted[0].soft_deleted_count}`);
  if (softDeleted[0].soft_deleted_count > 0) {
    console.log(`   ⚠️  API filters (deleted_at IS NULL) have been added to:
   - src/app/api/results/by-term/route.ts
   - src/app/api/results/filtered/route.ts
   - src/app/api/reports/list/route.ts`);
  }
  
  console.log('\n✅ VERIFICATION COMPLETE\n');
  
} catch (error) {
  console.error('❌ Error:', error.message);
  process.exit(1);
} finally {
  await conn.end();
}

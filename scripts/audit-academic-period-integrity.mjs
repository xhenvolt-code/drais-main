#!/usr/bin/env node
import mysql from 'mysql2/promise';

async function main() {
  const schoolId = Number(process.argv[2] || process.env.SCHOOL_ID || 6);
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || '127.0.0.1',
    port: Number(process.env.DB_PORT || 4000),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'drais_school',
  });

  try {
    const [duplicateYears] = await conn.execute(
      `
      SELECT school_id, LOWER(TRIM(name)) AS year_key, COUNT(*) AS duplicate_count, GROUP_CONCAT(id ORDER BY id) AS year_ids
      FROM academic_years
      WHERE school_id = ? AND deleted_at IS NULL
      GROUP BY school_id, LOWER(TRIM(name))
      HAVING COUNT(*) > 1
      `,
      [schoolId]
    );

    const [duplicateTerms] = await conn.execute(
      `
      SELECT t.school_id, t.academic_year_id, ay.name AS academic_year_name,
             LOWER(TRIM(t.name)) AS term_key, COUNT(*) AS duplicate_count, GROUP_CONCAT(t.id ORDER BY t.id) AS term_ids
      FROM terms t
      LEFT JOIN academic_years ay ON ay.id = t.academic_year_id
      WHERE t.school_id = ? AND t.deleted_at IS NULL
      GROUP BY t.school_id, t.academic_year_id, ay.name, LOWER(TRIM(t.name))
      HAVING COUNT(*) > 1
      `,
      [schoolId]
    );

    const [orphanResults] = await conn.execute(
      `
      SELECT COUNT(*) AS orphan_count
      FROM class_results cr
      LEFT JOIN terms t ON t.id = cr.term_id
      LEFT JOIN academic_years ay ON ay.id = COALESCE(cr.academic_year_id, t.academic_year_id)
      WHERE cr.school_id = ?
        AND (
          (cr.term_id IS NOT NULL AND t.id IS NULL)
          OR (COALESCE(cr.academic_year_id, t.academic_year_id) IS NOT NULL AND ay.id IS NULL)
        )
      `,
      [schoolId]
    );

    const [yearCoverage] = await conn.execute(
      `
      SELECT
        COALESCE(ay.id, ay2.id) AS academic_year_id,
        COALESCE(ay.name, ay2.name) AS academic_year_name,
        COUNT(*) AS result_rows,
        COUNT(DISTINCT cr.student_id) AS students
      FROM class_results cr
      LEFT JOIN terms t ON t.id = cr.term_id
      LEFT JOIN academic_years ay ON ay.id = cr.academic_year_id
      LEFT JOIN academic_years ay2 ON ay2.id = t.academic_year_id
      WHERE cr.school_id = ?
      GROUP BY COALESCE(ay.id, ay2.id), COALESCE(ay.name, ay2.name)
      ORDER BY academic_year_name DESC
      `,
      [schoolId]
    );

    const [termCoverage] = await conn.execute(
      `
      SELECT
        t.id AS term_id,
        t.name AS term_name,
        ay.name AS academic_year_name,
        COUNT(*) AS result_rows,
        COUNT(DISTINCT cr.student_id) AS students
      FROM terms t
      LEFT JOIN academic_years ay ON ay.id = t.academic_year_id
      LEFT JOIN class_results cr ON cr.term_id = t.id AND cr.school_id = t.school_id
      WHERE t.school_id = ? AND t.deleted_at IS NULL
      GROUP BY t.id, t.name, ay.name
      ORDER BY ay.name DESC, t.term_number ASC, t.id ASC
      `,
      [schoolId]
    );

    console.log(JSON.stringify({
      school_id: schoolId,
      duplicate_academic_years: duplicateYears,
      duplicate_terms: duplicateTerms,
      orphan_result_links: orphanResults[0],
      year_report_coverage: yearCoverage,
      term_report_coverage: termCoverage,
    }, null, 2));
  } finally {
    await conn.end();
  }
}

main().catch((err) => {
  console.error('[audit-academic-period-integrity] failed:', err);
  process.exit(1);
});

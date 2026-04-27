-- ============================================================================
-- 032_academic_period_integrity_hardening.sql
-- Purpose:
--   1) Repair duplicate academic_years / terms per tenant
--   2) Re-point dependent rows to canonical records
--   3) Add structural uniqueness to prevent recurrence
-- ============================================================================

START TRANSACTION;

-- ----------------------------------------------------------------------------
-- 0) Ensure required columns exist
-- ----------------------------------------------------------------------------
ALTER TABLE academic_years ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE terms          ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL;
ALTER TABLE terms          ADD COLUMN IF NOT EXISTS term_number INT NULL;

-- Normalize term_number from name when missing.
UPDATE terms
SET term_number = CASE
  WHEN LOWER(TRIM(name)) IN ('term 1', 't1', 'first term')  THEN 1
  WHEN LOWER(TRIM(name)) IN ('term 2', 't2', 'second term') THEN 2
  WHEN LOWER(TRIM(name)) IN ('term 3', 't3', 'third term')  THEN 3
  ELSE term_number
END
WHERE term_number IS NULL;

-- ----------------------------------------------------------------------------
-- 1) Academic year dedupe mapping (school_id + normalized name)
-- ----------------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_ay_map;
CREATE TEMPORARY TABLE tmp_ay_map (
  old_id BIGINT NOT NULL,
  keep_id BIGINT NOT NULL,
  PRIMARY KEY (old_id)
);

INSERT INTO tmp_ay_map (old_id, keep_id)
SELECT ay.id AS old_id, canon.keep_id
FROM academic_years ay
JOIN (
  SELECT school_id, LOWER(TRIM(name)) AS name_key, MIN(id) AS keep_id, COUNT(*) AS cnt
  FROM academic_years
  WHERE deleted_at IS NULL
  GROUP BY school_id, LOWER(TRIM(name))
  HAVING COUNT(*) > 1
) canon
  ON canon.school_id = ay.school_id
 AND canon.name_key = LOWER(TRIM(ay.name))
WHERE ay.id <> canon.keep_id
  AND ay.deleted_at IS NULL;

-- Re-point known academic_year references.
UPDATE terms t
JOIN tmp_ay_map m ON t.academic_year_id = m.old_id
SET t.academic_year_id = m.keep_id;

UPDATE class_results cr
JOIN tmp_ay_map m ON cr.academic_year_id = m.old_id
SET cr.academic_year_id = m.keep_id;

UPDATE enrollments e
JOIN tmp_ay_map m ON e.academic_year_id = m.old_id
SET e.academic_year_id = m.keep_id;

SET @has_report_cards_ay = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'report_cards'
    AND column_name = 'academic_year_id'
);
SET @sql = IF(
  @has_report_cards_ay > 0,
  'UPDATE report_cards rc JOIN tmp_ay_map m ON rc.academic_year_id = m.old_id SET rc.academic_year_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_promotion_criteria_ay = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'promotion_criteria'
    AND column_name = 'academic_year_id'
);
SET @sql = IF(
  @has_promotion_criteria_ay > 0,
  'UPDATE promotion_criteria pc JOIN tmp_ay_map m ON pc.academic_year_id = m.old_id SET pc.academic_year_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE academic_years ay
JOIN tmp_ay_map m ON ay.id = m.old_id
SET ay.deleted_at = NOW(),
    ay.status = 'archived';

-- ----------------------------------------------------------------------------
-- 2) Term dedupe mapping (school_id + academic_year_id + normalized name)
-- ----------------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_term_map;
CREATE TEMPORARY TABLE tmp_term_map (
  old_id BIGINT NOT NULL,
  keep_id BIGINT NOT NULL,
  PRIMARY KEY (old_id)
);

INSERT INTO tmp_term_map (old_id, keep_id)
SELECT t.id AS old_id, canon.keep_id
FROM terms t
JOIN (
  SELECT school_id, academic_year_id, LOWER(TRIM(name)) AS name_key, MIN(id) AS keep_id, COUNT(*) AS cnt
  FROM terms
  WHERE deleted_at IS NULL
  GROUP BY school_id, academic_year_id, LOWER(TRIM(name))
  HAVING COUNT(*) > 1
) canon
  ON canon.school_id = t.school_id
 AND canon.academic_year_id = t.academic_year_id
 AND canon.name_key = LOWER(TRIM(t.name))
WHERE t.id <> canon.keep_id
  AND t.deleted_at IS NULL;

-- Re-point known term references.
UPDATE class_results cr
JOIN tmp_term_map m ON cr.term_id = m.old_id
SET cr.term_id = m.keep_id;

UPDATE enrollments e
JOIN tmp_term_map m ON e.term_id = m.old_id
SET e.term_id = m.keep_id;

SET @has_report_cards_term = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'report_cards'
    AND column_name = 'term_id'
);
SET @sql = IF(
  @has_report_cards_term > 0,
  'UPDATE report_cards rc JOIN tmp_term_map m ON rc.term_id = m.old_id SET rc.term_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_exams_term = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'exams'
    AND column_name = 'term_id'
);
SET @sql = IF(
  @has_exams_term > 0,
  'UPDATE exams ex JOIN tmp_term_map m ON ex.term_id = m.old_id SET ex.term_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_fee_structures_term = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'fee_structures'
    AND column_name = 'term_id'
);
SET @sql = IF(
  @has_fee_structures_term > 0,
  'UPDATE fee_structures fs JOIN tmp_term_map m ON fs.term_id = m.old_id SET fs.term_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_student_fee_items_term = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'student_fee_items'
    AND column_name = 'term_id'
);
SET @sql = IF(
  @has_student_fee_items_term > 0,
  'UPDATE student_fee_items sfi JOIN tmp_term_map m ON sfi.term_id = m.old_id SET sfi.term_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_fee_payments_term = (
  SELECT COUNT(*)
  FROM information_schema.columns
  WHERE table_schema = DATABASE()
    AND table_name = 'fee_payments'
    AND column_name = 'term_id'
);
SET @sql = IF(
  @has_fee_payments_term > 0,
  'UPDATE fee_payments fp JOIN tmp_term_map m ON fp.term_id = m.old_id SET fp.term_id = m.keep_id',
  'SELECT 1'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE terms t
JOIN tmp_term_map m ON t.id = m.old_id
SET t.deleted_at = NOW(),
    t.status = 'archived';

-- ----------------------------------------------------------------------------
-- 3) Structural uniqueness guards (TiDB-compatible)
-- NOTE:
--   We enforce uniqueness using deleted_at in the key. For active rows this is
--   NULL, which prevents duplicate active records with same business key.
-- ----------------------------------------------------------------------------
CREATE UNIQUE INDEX IF NOT EXISTS uq_ay_school_name_deleted
  ON academic_years (school_id, name, deleted_at);

CREATE UNIQUE INDEX IF NOT EXISTS uq_terms_school_year_name_deleted
  ON terms (school_id, academic_year_id, name, deleted_at);

CREATE UNIQUE INDEX IF NOT EXISTS uq_terms_school_year_number_deleted
  ON terms (school_id, academic_year_id, term_number, deleted_at);

COMMIT;

-- ============================================
-- Marks Migration Engine Tables
-- ============================================
-- Support for safe, transactional migration of marks
-- between subjects with audit trail and rollback

-- Create marks migration log table
CREATE TABLE IF NOT EXISTS marks_migration_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  migration_id VARCHAR(100) UNIQUE NOT NULL COMMENT 'Unique migration identifier for tracking',
  transaction_id VARCHAR(100) NOT NULL COMMENT 'Transaction ID for rollback capability',
  school_id BIGINT NOT NULL COMMENT 'Multi-tenant isolation',
  class_id BIGINT NOT NULL,
  source_subject_id BIGINT NOT NULL COMMENT 'Subject marks are migrated FROM',
  destination_subject_id BIGINT NOT NULL COMMENT 'Subject marks are migrated TO',
  academic_year_id BIGINT NOT NULL,
  term_id BIGINT NOT NULL,
  records_migrated INT NOT NULL DEFAULT 0 COMMENT 'Number of records successfully migrated',
  conflicts_resolved INT NOT NULL DEFAULT 0 COMMENT 'Number of conflicts handled',
  skipped INT NOT NULL DEFAULT 0 COMMENT 'Number of records skipped due to conflicts',
  conflict_resolution VARCHAR(50) NOT NULL COMMENT 'Strategy used: overwrite, skip, or merge',
  performed_by BIGINT NOT NULL COMMENT 'User ID who performed migration',
  reason TEXT COMMENT 'Migration reason/notes',
  migration_data JSON COMMENT 'Detailed data about migrated records for rollback',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  rolled_back_at TIMESTAMP NULL COMMENT 'When (if) migration was rolled back',
  rolled_back_by BIGINT NULL COMMENT 'User ID who performed rollback',
  INDEX idx_migration_id (migration_id),
  INDEX idx_transaction_id (transaction_id),
  INDEX idx_school_class (school_id, class_id),
  INDEX idx_timestamp (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 
COMMENT='Audit trail for marks migrations with rollback capability';

-- Ensure audit_log table has marks migration actions
-- This is idempotent - audit_log should already exist from core schema

-- Create marks migration validation rules table (for future expansion)
CREATE TABLE IF NOT EXISTS marks_migration_policies (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL,
  source_subject_id BIGINT NOT NULL,
  destination_subject_id BIGINT NOT NULL,
  is_permitted BOOLEAN DEFAULT TRUE COMMENT 'Whether this migration path is allowed',
  requires_approval BOOLEAN DEFAULT FALSE,
  approver_role VARCHAR(50) COMMENT 'Role required to approve migration',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL,
  deleted_at TIMESTAMP NULL,
  UNIQUE KEY uq_migration_path (school_id, source_subject_id, destination_subject_id),
  INDEX idx_school (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
COMMENT='Policies governing allowed marks migrations per school';

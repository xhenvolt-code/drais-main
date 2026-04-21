-- Finance Module Extensions for DRAIS
-- Version: 1.0.0 (Fixed)
-- Date: 2024-12-20

-- 1. Receipts table for receipt metadata
CREATE TABLE IF NOT EXISTS receipts (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  payment_id BIGINT NOT NULL,
  receipt_no VARCHAR(60) NOT NULL UNIQUE,
  file_url VARCHAR(255) DEFAULT NULL,
  generated_by BIGINT DEFAULT NULL,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  metadata JSON DEFAULT NULL,
  INDEX idx_receipts_school (school_id),
  INDEX idx_receipts_payment (payment_id),
  INDEX idx_receipts_no (receipt_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Receipt metadata and file references';

-- 2. Fee templates for reusable fee bundles
CREATE TABLE IF NOT EXISTS fee_templates (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  name VARCHAR(150) NOT NULL,
  description TEXT DEFAULT NULL,
  items JSON NOT NULL COMMENT 'Array of fee items with amounts',
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  INDEX idx_fee_templates_school (school_id),
  INDEX idx_fee_templates_created_by (created_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Reusable fee structure templates';

-- 3. Payment reconciliations tracking
CREATE TABLE IF NOT EXISTS payment_reconciliations (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  payment_id BIGINT NOT NULL,
  ledger_id BIGINT DEFAULT NULL,
  reconciled_by BIGINT DEFAULT NULL,
  reconciled_at TIMESTAMP NULL,
  status ENUM('pending','reconciled','failed') DEFAULT 'pending',
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_reconciliation_school (school_id),
  INDEX idx_reconciliation_payment (payment_id),
  INDEX idx_reconciliation_status (status),
  INDEX idx_reconciliation_ledger (ledger_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Payment reconciliation tracking';

-- 4. Finance actions audit trail
CREATE TABLE IF NOT EXISTS finance_actions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  actor_user_id BIGINT DEFAULT NULL,
  action VARCHAR(120) NOT NULL,
  entity_type VARCHAR(60) DEFAULT NULL,
  entity_id BIGINT DEFAULT NULL,
  metadata JSON DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_finance_actions_school (school_id),
  INDEX idx_finance_actions_actor (actor_user_id),
  INDEX idx_finance_actions_entity (entity_type, entity_id),
  INDEX idx_finance_actions_action (action),
  INDEX idx_finance_actions_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Finance operations audit trail';

-- 5. Payment methods configuration
CREATE TABLE IF NOT EXISTS payment_methods (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  code VARCHAR(60) NOT NULL,
  label VARCHAR(120) NOT NULL,
  config JSON DEFAULT NULL COMMENT 'Gateway configuration',
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY unique_school_code (school_id, code),
  INDEX idx_payment_methods_school (school_id),
  INDEX idx_payment_methods_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Payment gateway configurations';

-- 6. Enhanced ledger table with better categorization
ALTER TABLE ledger 
ADD COLUMN IF NOT EXISTS payment_method VARCHAR(60) DEFAULT NULL AFTER description,
ADD COLUMN IF NOT EXISTS batch_id VARCHAR(100) DEFAULT NULL AFTER payment_method,
ADD COLUMN IF NOT EXISTS reconciled TINYINT(1) DEFAULT 0 AFTER batch_id,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- 7. Enhanced fee_payments with better tracking
ALTER TABLE fee_payments 
ADD COLUMN IF NOT EXISTS discount_applied DECIMAL(14,2) DEFAULT 0 AFTER amount,
ADD COLUMN IF NOT EXISTS tax_amount DECIMAL(14,2) DEFAULT 0 AFTER discount_applied,
ADD COLUMN IF NOT EXISTS status ENUM('pending','completed','failed','refunded') DEFAULT 'completed' AFTER tax_amount,
ADD COLUMN IF NOT EXISTS gateway_reference VARCHAR(255) DEFAULT NULL AFTER reference,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- 8. Enhanced wallets with better balance tracking (FIXED - removed non-deterministic GENERATED column)
ALTER TABLE wallets 
ADD COLUMN IF NOT EXISTS is_active TINYINT(1) DEFAULT 1 AFTER currency,
ADD COLUMN IF NOT EXISTS account_number VARCHAR(100) DEFAULT NULL AFTER method,
ADD COLUMN IF NOT EXISTS bank_name VARCHAR(150) DEFAULT NULL AFTER account_number;

-- Note: current_balance will be computed dynamically in API layer for better performance

-- 9. Student fee items enhancements (FIXED - removed CURDATE() dependency)
ALTER TABLE student_fee_items 
ADD COLUMN IF NOT EXISTS due_date DATE DEFAULT NULL AFTER balance,
ADD COLUMN IF NOT EXISTS waived DECIMAL(14,2) DEFAULT 0 AFTER discount,
ADD COLUMN IF NOT EXISTS status ENUM('pending','partial','paid','overdue','waived') DEFAULT 'pending' AFTER waived,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER item,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at;

-- Update balance calculation to include waivers (deterministic - safe)
ALTER TABLE student_fee_items 
DROP COLUMN IF EXISTS balance,
ADD COLUMN balance DECIMAL(14,2) GENERATED ALWAYS AS (amount - discount - waived - paid) STORED;

-- 10. Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_fee_payments_status ON fee_payments(status, created_at);
CREATE INDEX IF NOT EXISTS idx_fee_payments_student_term ON fee_payments(student_id, term_id);
CREATE INDEX IF NOT EXISTS idx_fee_payments_wallet ON fee_payments(wallet_id, created_at);
CREATE INDEX IF NOT EXISTS idx_student_fee_items_status ON student_fee_items(status, due_date);
CREATE INDEX IF NOT EXISTS idx_student_fee_items_term ON student_fee_items(term_id, student_id);
CREATE INDEX IF NOT EXISTS idx_ledger_reconciled ON ledger(reconciled, created_at);
CREATE INDEX IF NOT EXISTS idx_ledger_batch ON ledger(batch_id);

-- 11. Insert default payment methods
INSERT INTO payment_methods (school_id, code, label, config, is_active) VALUES
(NULL, 'cash', 'Cash Payment', '{"currency": "UGX", "requires_receipt": true}', 1),
(NULL, 'bank_transfer', 'Bank Transfer', '{"requires_reference": true, "auto_reconcile": false}', 1),
(NULL, 'mpesa', 'Mobile Money (MPesa)', '{"api_key": "", "business_shortcode": "", "passkey": ""}', 1),
(NULL, 'cheque', 'Cheque Payment', '{"requires_reference": true, "clearing_days": 3}', 1),
(NULL, 'card', 'Card Payment', '{"processor": "stripe", "api_key": ""}', 1)
ON DUPLICATE KEY UPDATE label = VALUES(label);

-- 12. Insert default finance categories if not exists
INSERT IGNORE INTO finance_categories (school_id, type, name) VALUES
(NULL, 'income', 'Tuition Fees'),
(NULL, 'income', 'Registration Fees'),
(NULL, 'income', 'Examination Fees'),
(NULL, 'income', 'Transport Fees'),
(NULL, 'income', 'Boarding Fees'),
(NULL, 'income', 'Activity Fees'),
(NULL, 'income', 'Other Income'),
(NULL, 'expense', 'Staff Salaries'),
(NULL, 'expense', 'Utilities'),
(NULL, 'expense', 'Supplies'),
(NULL, 'expense', 'Maintenance'),
(NULL, 'expense', 'Other Expenses');

-- 13. Create views for reporting
CREATE OR REPLACE VIEW finance_summary AS
SELECT 
  w.school_id,
  w.id as wallet_id,
  w.name as wallet_name,
  w.currency,
  w.opening_balance,
  w.current_balance,
  COALESCE(income.total, 0) as total_income,
  COALESCE(expenses.total, 0) as total_expenses,
  DATE(NOW()) as summary_date
FROM wallets w
LEFT JOIN (
  SELECT 
    wallet_id, 
    SUM(amount) as total 
  FROM ledger 
  WHERE tx_type = 'credit' 
  GROUP BY wallet_id
) income ON w.id = income.wallet_id
LEFT JOIN (
  SELECT 
    wallet_id, 
    SUM(amount) as total 
  FROM ledger 
  WHERE tx_type = 'debit' 
  GROUP BY wallet_id
) expenses ON w.id = expenses.wallet_id
WHERE w.is_active = 1;

-- 14. Migration log
INSERT INTO audit_log (action, entity_type, entity_id, changes_json) VALUES
('finance_module_installed', 'system', 1, JSON_OBJECT(
  'tables_created', JSON_ARRAY('receipts', 'fee_templates', 'payment_reconciliations', 'finance_actions', 'payment_methods'),
  'enhancements', JSON_ARRAY('ledger', 'fee_payments', 'wallets', 'student_fee_items'),
  'views_created', JSON_ARRAY('finance_summary'),
  'default_payment_methods', 5,
  'default_categories', 12,
  'version', '1.0.0'
));

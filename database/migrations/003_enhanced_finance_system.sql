-- Enhanced Finance System for DRAIS
-- Version: 1.0.0

-- Enhanced wallets table with auto-balance calculation
ALTER TABLE wallets 
ADD COLUMN IF NOT EXISTS current_balance DECIMAL(14,2) DEFAULT 0 AFTER opening_balance,
ADD COLUMN IF NOT EXISTS last_transaction_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at,
ADD COLUMN IF NOT EXISTS status ENUM('active','inactive','closed') DEFAULT 'active' AFTER last_transaction_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER status;

-- Enhanced finance_categories with color coding and type
ALTER TABLE finance_categories 
ADD COLUMN IF NOT EXISTS category_type ENUM('income','expense','transfer') NOT NULL AFTER type,
ADD COLUMN IF NOT EXISTS color VARCHAR(20) DEFAULT '#3B82F6' AFTER name,
ADD COLUMN IF NOT EXISTS icon VARCHAR(50) DEFAULT 'DollarSign' AFTER color,
ADD COLUMN IF NOT EXISTS is_active TINYINT(1) DEFAULT 1 AFTER icon,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER is_active,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Enhanced ledger table with better tracking
ALTER TABLE ledger 
ADD COLUMN IF NOT EXISTS transaction_date DATE NOT NULL DEFAULT (CURDATE()) AFTER school_id,
ADD COLUMN IF NOT EXISTS running_balance DECIMAL(14,2) DEFAULT 0 AFTER amount,
ADD COLUMN IF NOT EXISTS receipt_number VARCHAR(50) DEFAULT NULL AFTER reference,
ADD COLUMN IF NOT EXISTS payment_method VARCHAR(50) DEFAULT NULL AFTER receipt_number,
ADD COLUMN IF NOT EXISTS notes TEXT DEFAULT NULL AFTER description,
ADD COLUMN IF NOT EXISTS approved_by BIGINT DEFAULT NULL AFTER created_by,
ADD COLUMN IF NOT EXISTS approved_at TIMESTAMP NULL DEFAULT NULL AFTER approved_by,
ADD COLUMN IF NOT EXISTS status ENUM('pending','approved','rejected') DEFAULT 'approved' AFTER approved_at,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Enhanced fee_structures with recurring capabilities
ALTER TABLE fee_structures 
ADD COLUMN IF NOT EXISTS fee_type ENUM('tuition','transport','boarding','meals','activity','uniform','books','other') DEFAULT 'tuition' AFTER school_id,
ADD COLUMN IF NOT EXISTS is_mandatory TINYINT(1) DEFAULT 1 AFTER item,
ADD COLUMN IF NOT EXISTS due_date DATE DEFAULT NULL AFTER amount,
ADD COLUMN IF NOT EXISTS late_fee_amount DECIMAL(14,2) DEFAULT 0 AFTER due_date,
ADD COLUMN IF NOT EXISTS description TEXT DEFAULT NULL AFTER late_fee_amount,
ADD COLUMN IF NOT EXISTS is_recurring TINYINT(1) DEFAULT 0 AFTER description,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER is_recurring,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Enhanced student_fee_items with payment tracking
ALTER TABLE student_fee_items 
ADD COLUMN IF NOT EXISTS fee_structure_id BIGINT DEFAULT NULL AFTER student_id,
ADD COLUMN IF NOT EXISTS due_date DATE DEFAULT NULL AFTER quantity,
ADD COLUMN IF NOT EXISTS late_fee DECIMAL(14,2) DEFAULT 0 AFTER discount,
ADD COLUMN IF NOT EXISTS status ENUM('pending','partial','paid','overdue','waived') DEFAULT 'pending' AFTER balance,
ADD COLUMN IF NOT EXISTS waived_by BIGINT DEFAULT NULL AFTER status,
ADD COLUMN IF NOT EXISTS waived_reason TEXT DEFAULT NULL AFTER waived_by,
ADD COLUMN IF NOT EXISTS last_payment_date TIMESTAMP NULL DEFAULT NULL AFTER waived_reason,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER last_payment_date,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Enhanced fee_payments with receipt tracking
ALTER TABLE fee_payments 
ADD COLUMN IF NOT EXISTS fee_item_id BIGINT DEFAULT NULL AFTER student_id,
ADD COLUMN IF NOT EXISTS transaction_id VARCHAR(100) DEFAULT NULL AFTER reference,
ADD COLUMN IF NOT EXISTS payment_status ENUM('pending','completed','failed','refunded') DEFAULT 'completed' AFTER receipt_no,
ADD COLUMN IF NOT EXISTS fee_balance_before DECIMAL(14,2) DEFAULT 0 AFTER payment_status,
ADD COLUMN IF NOT EXISTS fee_balance_after DECIMAL(14,2) DEFAULT 0 AFTER fee_balance_before,
ADD COLUMN IF NOT EXISTS receipt_url VARCHAR(255) DEFAULT NULL AFTER fee_balance_after,
ADD COLUMN IF NOT EXISTS notes TEXT DEFAULT NULL AFTER receipt_url,
ADD COLUMN IF NOT EXISTS processed_by BIGINT DEFAULT NULL AFTER notes,
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER created_at,
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMP NULL DEFAULT NULL AFTER updated_at;

-- Fee payment allocation table for partial payments
CREATE TABLE IF NOT EXISTS fee_payment_allocations (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  payment_id BIGINT NOT NULL,
  fee_item_id BIGINT NOT NULL,
  allocated_amount DECIMAL(14,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_payment (payment_id),
  INDEX idx_fee_item (fee_item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Wallet balance update trigger
DELIMITER //
CREATE TRIGGER update_wallet_balance 
AFTER INSERT ON ledger 
FOR EACH ROW 
BEGIN 
  UPDATE wallets 
  SET current_balance = (
    SELECT COALESCE(SUM(
      CASE 
        WHEN tx_type = 'credit' THEN amount 
        ELSE -amount 
      END
    ), 0) + opening_balance
    FROM ledger 
    WHERE wallet_id = NEW.wallet_id 
      AND (deleted_at IS NULL OR deleted_at = '')
      AND status = 'approved'
  ),
  last_transaction_at = NOW()
  WHERE id = NEW.wallet_id;
END //
DELIMITER ;

-- Performance indexes
CREATE INDEX IF NOT EXISTS idx_ledger_wallet_date ON ledger(wallet_id, transaction_date);
CREATE INDEX IF NOT EXISTS idx_ledger_category ON ledger(category_id, transaction_date);
CREATE INDEX IF NOT EXISTS idx_fee_items_student_term ON student_fee_items(student_id, term_id, status);
CREATE INDEX IF NOT EXISTS idx_fee_payments_student_date ON fee_payments(student_id, created_at);
CREATE INDEX IF NOT EXISTS idx_fee_structures_class_term ON fee_structures(class_id, term_id);

-- Insert default finance categories
INSERT INTO finance_categories (school_id, type, category_type, name, color, icon) VALUES
(1, 'income', 'income', 'Tuition Fees', '#10B981', 'GraduationCap'),
(1, 'income', 'income', 'Transport Fees', '#3B82F6', 'Truck'),
(1, 'income', 'income', 'Boarding Fees', '#8B5CF6', 'Home'),
(1, 'income', 'income', 'Activity Fees', '#F59E0B', 'Activity'),
(1, 'expense', 'expense', 'Staff Salaries', '#EF4444', 'Users'),
(1, 'expense', 'expense', 'Utilities', '#6B7280', 'Zap'),
(1, 'expense', 'expense', 'Supplies', '#EC4899', 'Package'),
(1, 'expense', 'expense', 'Maintenance', '#F97316', 'Settings'),
(1, 'transfer', 'transfer', 'Internal Transfer', '#06B6D4', 'ArrowRightLeft')
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- Create wallet balance view
CREATE OR REPLACE VIEW wallet_balances AS
SELECT 
  w.id,
  w.name,
  w.method,
  w.currency,
  w.opening_balance,
  COALESCE(l.current_balance, w.opening_balance) AS current_balance,
  w.last_transaction_at,
  w.status,
  w.school_id,
  w.branch_id
FROM wallets w
LEFT JOIN (
  SELECT 
    wallet_id,
    SUM(CASE WHEN tx_type = 'credit' THEN amount ELSE -amount END) AS current_balance
  FROM ledger 
  WHERE (deleted_at IS NULL OR deleted_at = '') AND status = 'approved'
  GROUP BY wallet_id
) l ON w.id = l.wallet_id
WHERE (w.deleted_at IS NULL OR w.deleted_at = '');

-- Update student fee item balance trigger
DELIMITER //
CREATE TRIGGER update_fee_item_balance 
AFTER INSERT ON fee_payments 
FOR EACH ROW 
BEGIN 
  UPDATE student_fee_items 
  SET 
    paid = paid + NEW.amount,
    last_payment_date = NEW.created_at,
    status = CASE 
      WHEN (paid + NEW.amount) >= (amount - discount + late_fee) THEN 'paid'
      WHEN (paid + NEW.amount) > 0 THEN 'partial'
      ELSE 'pending'
    END,
    updated_at = CURRENT_TIMESTAMP
  WHERE student_id = NEW.student_id 
    AND term_id = NEW.term_id
    AND (NEW.fee_item_id IS NULL OR id = NEW.fee_item_id);
END //
DELIMITER ;

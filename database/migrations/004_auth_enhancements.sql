-- Authentication & Security Enhancements for DRAIS
-- Version: 1.0.0
-- Date: 2024-12-20

-- Enhanced users table with proper authentication fields
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS name VARCHAR(150) DEFAULT NULL AFTER username,
  ADD COLUMN IF NOT EXISTS email_verified TINYINT(1) DEFAULT 0 AFTER email,
  ADD COLUMN IF NOT EXISTS email_verified_at TIMESTAMP NULL DEFAULT NULL AFTER email_verified,
  ADD COLUMN IF NOT EXISTS two_fa_enabled TINYINT(1) DEFAULT 0 AFTER role_id,
  ADD COLUMN IF NOT EXISTS last_password_change_at TIMESTAMP NULL DEFAULT NULL AFTER password_hash,
  ADD COLUMN IF NOT EXISTS last_login_ip VARCHAR(45) DEFAULT NULL AFTER last_login,
  ADD COLUMN IF NOT EXISTS password_algo VARCHAR(50) DEFAULT 'bcrypt' AFTER password_hash,
  ADD COLUMN IF NOT EXISTS login_attempts INT DEFAULT 0 AFTER two_fa_enabled,
  ADD COLUMN IF NOT EXISTS locked_until TIMESTAMP NULL DEFAULT NULL AFTER login_attempts,
  ADD COLUMN IF NOT EXISTS is_admin TINYINT(1) DEFAULT 0 AFTER role_id;

-- Make email unique if not already
ALTER TABLE users 
ADD UNIQUE KEY IF NOT EXISTS unique_email (email);

-- Password reset tokens table
CREATE TABLE IF NOT EXISTS password_resets (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  token VARCHAR(255) UNIQUE NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  used TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_user_id (user_id),
  INDEX idx_token (token),
  INDEX idx_expires (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Password reset tokens';

-- User sessions table for JWT token management
CREATE TABLE IF NOT EXISTS user_sessions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  session_token VARCHAR(255) UNIQUE NOT NULL,
  refresh_token VARCHAR(255) UNIQUE DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  expires_at TIMESTAMP NOT NULL,
  last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_user_id (user_id),
  INDEX idx_session_token (session_token),
  INDEX idx_expires (expires_at),
  INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User session management';

-- Failed login attempts tracking
CREATE TABLE IF NOT EXISTS login_attempts (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  success TINYINT(1) DEFAULT 0,
  attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_ip (ip_address),
  INDEX idx_attempted (attempted_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Login attempt tracking for security';

-- Activity logs for authentication events
CREATE TABLE IF NOT EXISTS auth_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT DEFAULT NULL,
  action VARCHAR(100) NOT NULL, -- login, logout, password_reset, etc.
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  details JSON DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Authentication activity logs';

-- Insert default admin user if none exists
INSERT IGNORE INTO users (
  username, 
  name, 
  email, 
  password_hash, 
  role_id, 
  is_admin, 
  status, 
  school_id
) VALUES (
  'admin',
  'System Administrator', 
  'admin@drais.local',
  '$2b$12$LQv3c1yqBwWFcDVqg7Td9.Q8K9J9Z9J9Z9J9Z9J9Z9J9Z9J9Z9J9Z9', -- 'admin123'
  1,
  1,
  'active',
  1
);

-- Create default role for admin if roles table exists
INSERT IGNORE INTO roles (school_id, name, description) VALUES
(1, 'Administrator', 'Full system access'),
(1, 'Teacher', 'Teaching and academic access'),
(1, 'Staff', 'General staff access'),
(1, 'Parent', 'Parent portal access');

-- Migration completion log
INSERT INTO audit_log (action, entity_type, entity_id, changes_json) VALUES
('auth_system_installed', 'system', 1, JSON_OBJECT(
  'tables_created', JSON_ARRAY('password_resets', 'user_sessions', 'login_attempts', 'auth_logs'),
  'users_enhanced', true,
  'default_admin_created', true,
  'version', '1.0.0'
));

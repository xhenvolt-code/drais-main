-- DRAIS Authentication System Migration
-- Run this after the main DRAIS.sql schema

USE drais_school;

-- Drop and recreate authentication tables to avoid inconsistencies
DROP TABLE IF EXISTS user_sessions;
DROP TABLE IF EXISTS user_devices;
DROP TABLE IF EXISTS auth_logs;

-- Ensure users table has all required authentication fields
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS first_name VARCHAR(100) AFTER person_id,
ADD COLUMN IF NOT EXISTS last_name VARCHAR(100) AFTER first_name,
ADD COLUMN IF NOT EXISTS login_attempts INT DEFAULT 0 AFTER last_login,
ADD COLUMN IF NOT EXISTS locked_until TIMESTAMP NULL AFTER login_attempts,
ADD COLUMN IF NOT EXISTS password_reset_token VARCHAR(64) NULL AFTER locked_until,
ADD COLUMN IF NOT EXISTS password_reset_expires TIMESTAMP NULL AFTER password_reset_token,
ADD COLUMN IF NOT EXISTS email_verified BOOLEAN DEFAULT FALSE AFTER password_reset_expires,
ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE AFTER email_verified,
ADD COLUMN IF NOT EXISTS last_activity TIMESTAMP NULL AFTER two_factor_enabled;

-- Create sessions table for secure session management (FIXED: consistent TIMESTAMP usage)
CREATE TABLE user_sessions (
  id VARCHAR(128) PRIMARY KEY,
  user_id BIGINT NOT NULL,
  school_id BIGINT DEFAULT 1,
  device_id VARCHAR(64) DEFAULT NULL,
  device_info JSON DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  token_hash VARCHAR(255) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_user_sessions_user (user_id),
  INDEX idx_user_sessions_expires (expires_at),
  INDEX idx_user_sessions_token (token_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create user_devices table for biometric authentication (FIXED: consistent TIMESTAMP usage)
CREATE TABLE user_devices (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  device_type VARCHAR(50) DEFAULT 'web',
  device_name VARCHAR(100) DEFAULT NULL,
  device_fingerprint VARCHAR(128) UNIQUE DEFAULT NULL,
  fingerprint_enabled BOOLEAN DEFAULT FALSE,
  face_enabled BOOLEAN DEFAULT FALSE,
  biometric_credential TEXT DEFAULT NULL,
  last_used_at TIMESTAMP DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_user_devices_user (user_id),
  INDEX idx_user_devices_fingerprint (device_fingerprint)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create auth_logs table for audit trail (FIXED: consistent TIMESTAMP usage)
CREATE TABLE auth_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT DEFAULT NULL,
  school_id BIGINT DEFAULT 1,
  action ENUM(
    'login_success',
    'login_failed',
    'logout',
    'password_reset_request',
    'password_reset_success',
    'biometric_setup',
    'biometric_login',
    'account_locked',
    'session_expired'
  ) NOT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  device_info JSON DEFAULT NULL,
  details TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_auth_logs_user (user_id),
  INDEX idx_auth_logs_action (action),
  INDEX idx_auth_logs_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default admin user if not exists
INSERT IGNORE INTO users (
  school_id, 
  first_name, 
  last_name, 
  email, 
  username, 
  password_hash, 
  role, 
  status,
  email_verified
) VALUES (
  1,
  'System',
  'Administrator', 
  'admin@drais.edu',
  'admin',
  '$2b$12$LQv3c1yqBwCVNppJQVJktu.vsQwK6V7YY8j9.kGDtVPYx0Y5kCn1y', -- password: admin123
  'admin',
  'active',
  TRUE
);

-- Update existing users to have school_id = 1 if NULL
UPDATE users SET school_id = 1 WHERE school_id IS NULL;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_school_status ON users(school_id, status);
CREATE INDEX IF NOT EXISTS idx_users_last_activity ON users(last_activity);

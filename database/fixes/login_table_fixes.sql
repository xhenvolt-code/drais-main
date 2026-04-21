-- Fix database schema issues that might cause login problems

USE drais_school;

-- Ensure users table has required columns for authentication
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255) DEFAULT NULL AFTER phone,
ADD COLUMN IF NOT EXISTS login_attempts INT DEFAULT 0 AFTER last_login,
ADD COLUMN IF NOT EXISTS locked_until TIMESTAMP NULL DEFAULT NULL AFTER login_attempts,
ADD COLUMN IF NOT EXISTS last_activity TIMESTAMP NULL DEFAULT NULL AFTER locked_until;

-- Ensure user_sessions table exists with correct structure
CREATE TABLE IF NOT EXISTS user_sessions (
  id VARCHAR(128) PRIMARY KEY,
  user_id BIGINT NOT NULL,
  school_id BIGINT DEFAULT 1,
  token_hash VARCHAR(255) NOT NULL,
  refresh_token_hash VARCHAR(255) DEFAULT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  login_method VARCHAR(20) DEFAULT 'password',
  expires_at TIMESTAMP NOT NULL,
  refresh_expires_at VARCHAR(255) DEFAULT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_user_id (user_id),
  INDEX idx_token_hash (token_hash),
  INDEX idx_expires_at (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Ensure auth_logs table exists
CREATE TABLE IF NOT EXISTS auth_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT DEFAULT NULL,
  school_id BIGINT DEFAULT 1,
  session_id VARCHAR(128) DEFAULT NULL,
  action VARCHAR(50) NOT NULL,
  ip_address VARCHAR(45) DEFAULT NULL,
  user_agent TEXT DEFAULT NULL,
  status VARCHAR(20) DEFAULT 'success',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Update any existing users without password_hash to have a default
UPDATE users 
SET password_hash = '$2b$12$LQv3c1yqBwCVNppJQVJktu.vsQwK6V7YY8j9.kGDtVPYx0Y5kCn1y' 
WHERE password_hash IS NULL OR password_hash = '';

-- Ensure all users have a school_id
UPDATE users SET school_id = 1 WHERE school_id IS NULL;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_credentials ON users(email, username, status);
CREATE INDEX IF NOT EXISTS idx_users_school_status ON users(school_id, status);

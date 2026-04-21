USE drais_school;

-- Ensure users table has password_hash column
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255) DEFAULT NULL AFTER phone;

-- Ensure all users have password_hash
UPDATE users 
SET password_hash = '$2b$12$LQv3c1yqBwCVNppJQVJktu.vsQwK6V7YY8j9.kGDtVPYx0Y5kCn1y' 
WHERE password_hash IS NULL OR password_hash = '';

-- Ensure all users have school_id
UPDATE users SET school_id = 1 WHERE school_id IS NULL;

-- Create user_sessions table if it doesn't exist
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
  refresh_expires_at TIMESTAMP DEFAULT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_user_id (user_id),
  INDEX idx_token_hash (token_hash),
  INDEX idx_expires_at (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_credentials ON users(email, username, status);
CREATE INDEX IF NOT EXISTS idx_users_school_status ON users(school_id, status);

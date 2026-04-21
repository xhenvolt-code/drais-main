-- DRAIS Authentication System Database Schema
-- Enterprise-ready authentication with multi-tenant support

USE drais_school;

-- Drop existing authentication tables to avoid inconsistencies
DROP TABLE IF EXISTS user_sessions;
DROP TABLE IF EXISTS user_devices;
DROP TABLE IF EXISTS login_attempts;
DROP TABLE IF EXISTS password_history;
DROP TABLE IF EXISTS auth_logs;

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- =============================
-- 1. AUTHENTICATION TABLES
-- =============================

-- Enhanced users table for authentication
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS person_id BIGINT DEFAULT NULL AFTER id,
ADD COLUMN IF NOT EXISTS first_name VARCHAR(100) AFTER person_id,
ADD COLUMN IF NOT EXISTS last_name VARCHAR(100) AFTER first_name,
ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255) NOT NULL AFTER phone,
ADD COLUMN IF NOT EXISTS role_id BIGINT DEFAULT NULL AFTER password_hash,
ADD COLUMN IF NOT EXISTS login_attempts INT DEFAULT 0 AFTER last_login,
ADD COLUMN IF NOT EXISTS locked_until TIMESTAMP NULL AFTER login_attempts,
ADD COLUMN IF NOT EXISTS failed_login_attempts INT DEFAULT 0 AFTER locked_until,
ADD COLUMN IF NOT EXISTS email_verified BOOLEAN DEFAULT FALSE AFTER failed_login_attempts,
ADD COLUMN IF NOT EXISTS email_verification_token VARCHAR(64) DEFAULT NULL AFTER email_verified,
ADD COLUMN IF NOT EXISTS password_reset_token VARCHAR(64) DEFAULT NULL AFTER email_verification_token,
ADD COLUMN IF NOT EXISTS password_reset_expires TIMESTAMP NULL DEFAULT NULL AFTER password_reset_token,
ADD COLUMN IF NOT EXISTS two_factor_enabled BOOLEAN DEFAULT FALSE AFTER password_reset_expires,
ADD COLUMN IF NOT EXISTS two_factor_secret VARCHAR(32) DEFAULT NULL AFTER two_factor_enabled,
ADD COLUMN IF NOT EXISTS biometric_enabled BOOLEAN DEFAULT FALSE AFTER two_factor_secret,
ADD COLUMN IF NOT EXISTS biometric_key TEXT NULL AFTER biometric_enabled,
ADD COLUMN IF NOT EXISTS passcode_hash TEXT NULL AFTER biometric_key,
ADD COLUMN IF NOT EXISTS profile_photo VARCHAR(255) DEFAULT NULL AFTER passcode_hash,
ADD COLUMN IF NOT EXISTS preferences JSON DEFAULT NULL AFTER profile_photo,
ADD COLUMN IF NOT EXISTS last_activity TIMESTAMP NULL AFTER preferences,
MODIFY COLUMN status ENUM('active','inactive','pending','suspended','locked') DEFAULT 'active';

-- Enhanced roles table with slug and hierarchy
ALTER TABLE roles
ADD COLUMN IF NOT EXISTS slug VARCHAR(50) AFTER name,
ADD COLUMN IF NOT EXISTS is_system_role TINYINT(1) DEFAULT 0 AFTER slug,
ADD COLUMN IF NOT EXISTS hierarchy_level TINYINT(1) DEFAULT 0 AFTER is_system_role;

-- User sessions table for secure token management (FIXED: consistent TIMESTAMP usage)
CREATE TABLE user_sessions (
    id VARCHAR(128) PRIMARY KEY,
    user_id BIGINT NOT NULL,
    school_id BIGINT DEFAULT 1,
    device_id VARCHAR(128) DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    user_agent TEXT DEFAULT NULL,
    device_fingerprint VARCHAR(64) DEFAULT NULL,
    device_info JSON DEFAULT NULL,
    login_method ENUM('password','biometric','2fa','sso') DEFAULT 'password',
    token_hash VARCHAR(255) NOT NULL,
    refresh_token_hash VARCHAR(255) DEFAULT NULL,
    expires_at TIMESTAMP NOT NULL,
    refresh_expires_at VARCHAR(255) DEFAULT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_sessions_user (user_id),
    INDEX idx_sessions_token (token_hash),
    INDEX idx_sessions_expires (expires_at),
    INDEX idx_sessions_active (is_active),
    INDEX idx_sessions_school (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- User devices for biometric authentication (FIXED: consistent TIMESTAMP usage)
CREATE TABLE user_devices (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    school_id BIGINT DEFAULT 1,
    device_name VARCHAR(100) DEFAULT NULL,
    device_type ENUM('desktop','mobile','tablet','web') DEFAULT 'web',
    device_fingerprint VARCHAR(128) UNIQUE NOT NULL,
    fingerprint_enabled BOOLEAN DEFAULT FALSE,
    face_enabled BOOLEAN DEFAULT FALSE,
    biometric_credential TEXT DEFAULT NULL,
    webauthn_credential_id VARCHAR(255) DEFAULT NULL,
    webauthn_public_key TEXT DEFAULT NULL,
    webauthn_counter BIGINT DEFAULT 0,
    trusted BOOLEAN DEFAULT FALSE,
    last_used_at VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_devices_user (user_id),
    INDEX idx_devices_fingerprint (device_fingerprint),
    INDEX idx_devices_credential (webauthn_credential_id),
    INDEX idx_devices_school (school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Comprehensive authentication logs (FIXED: consistent TIMESTAMP usage)
CREATE TABLE auth_logs (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT DEFAULT NULL,
    school_id BIGINT DEFAULT 1,
    session_id VARCHAR(128) DEFAULT NULL,
    action ENUM(
        'login_success',
        'login_failed',
        'logout',
        'password_change',
        'password_reset_request',
        'password_reset_success',
        'biometric_setup',
        'biometric_login',
        'biometric_failed',
        '2fa_setup',
        '2fa_verify_success',
        '2fa_verify_failed',
        'account_locked',
        'account_unlocked',
        'session_expired',
        'permission_denied',
        'role_changed',
        'email_verified'
    ) NOT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    user_agent TEXT DEFAULT NULL,
    device_fingerprint VARCHAR(64) DEFAULT NULL,
    device_info JSON DEFAULT NULL,
    location_data JSON DEFAULT NULL,
    additional_data JSON DEFAULT NULL,
    details TEXT DEFAULT NULL,
    risk_score INT DEFAULT 0,
    status ENUM('success','failed','blocked','pending') DEFAULT 'success',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_auth_logs_user (user_id),
    INDEX idx_auth_logs_action (action),
    INDEX idx_auth_logs_created (created_at),
    INDEX idx_auth_logs_school (school_id),
    INDEX idx_auth_logs_status (status),
    INDEX idx_auth_logs_session (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Login attempts for security tracking
CREATE TABLE login_attempts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    school_id BIGINT DEFAULT 1,
    email VARCHAR(255) DEFAULT NULL,
    username VARCHAR(255) DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    user_agent TEXT DEFAULT NULL,
    device_fingerprint VARCHAR(64) DEFAULT NULL,
    success BOOLEAN DEFAULT FALSE,
    failure_reason VARCHAR(255) DEFAULT NULL,
    user_id BIGINT DEFAULT NULL,
    session_id VARCHAR(128) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_attempts_email (email),
    INDEX idx_attempts_ip (ip_address),
    INDEX idx_attempts_success (success),
    INDEX idx_attempts_school (school_id),
    INDEX idx_attempts_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create password history for preventing reuse
CREATE TABLE password_history (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_password_history_user (user_id),
    INDEX idx_password_history_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create session cleanup procedure
DELIMITER $$
CREATE PROCEDURE CleanupExpiredSessions()
BEGIN
    -- Remove expired sessions
    DELETE FROM user_sessions 
    WHERE expires_at < NOW() OR is_active = FALSE;
    
    -- Log cleanup
    INSERT INTO auth_logs (action, additional_data, created_at) 
    VALUES ('session_cleanup', JSON_OBJECT('cleaned_sessions', ROW_COUNT()), NOW());
END$$
DELIMITER ;

-- Create event scheduler for automatic cleanup (run every hour)
SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS cleanup_expired_sessions
ON SCHEDULE EVERY 1 HOUR
DO
CALL CleanupExpiredSessions();

-- =============================
-- 2. DEFAULT DATA INSERTION
-- =============================

-- Insert default roles if they don't exist
INSERT IGNORE INTO roles (school_id, name, slug, description, is_system_role, hierarchy_level) VALUES
(1, 'Super Administrator', 'superadmin', 'System-wide administrator with full access', TRUE, 0),
(1, 'School Administrator', 'admin', 'School-level administrator', TRUE, 1),
(1, 'Teacher', 'teacher', 'Teaching staff with class management access', TRUE, 2),
(1, 'Finance Manager', 'finance', 'Financial operations and reporting', TRUE, 2),
(1, 'Staff', 'staff', 'General school staff', TRUE, 3),
(1, 'Student', 'student', 'Student with limited access', TRUE, 4),
(1, 'Parent/Guardian', 'parent', 'Parent/Guardian with student-related access', TRUE, 4);

-- Insert default admin user if not exists
INSERT IGNORE INTO users (
    school_id, 
    role_id, 
    first_name, 
    last_name, 
    email, 
    username, 
    password_hash, 
    role,
    status, 
    email_verified,
    created_at
) VALUES (
    1,
    (SELECT id FROM roles WHERE slug = 'admin' AND school_id = 1 LIMIT 1),
    'System',
    'Administrator',
    'admin@drais.local',
    'admin',
    '$2b$12$LQv3c1yqBWVHxkd0LQ4YCOWuP.k9Pj0PaZJLr.ZYJx5qKLJLr.ZYJ', -- password: admin123
    'admin',
    'active',
    TRUE,
    NOW()
);

-- Update existing users to have school_id = 1 if NULL
UPDATE users SET school_id = 1 WHERE school_id IS NULL;

-- Update admin user with correct role_id
UPDATE users SET role_id = (SELECT id FROM roles WHERE slug = 'admin' AND school_id = 1 LIMIT 1) 
WHERE username = 'admin' AND school_id = 1 AND role_id IS NULL;

-- =============================
-- 3. SECURITY TRIGGERS
-- =============================

-- Trigger to log password changes
DELIMITER $$
CREATE TRIGGER IF NOT EXISTS tr_password_history 
AFTER UPDATE ON users
FOR EACH ROW 
BEGIN
    IF OLD.password_hash != NEW.password_hash THEN
        INSERT INTO password_history (user_id, password_hash) 
        VALUES (NEW.id, OLD.password_hash);
    END IF;
END$$
DELIMITER ;

-- =============================
-- 4. VIEWS FOR EASY QUERYING
-- =============================

-- Active users with role information
CREATE OR REPLACE VIEW active_users_view AS
SELECT 
    u.id,
    u.school_id,
    u.first_name,
    u.last_name,
    CONCAT(COALESCE(u.first_name, ''), ' ', COALESCE(u.last_name, '')) AS full_name,
    u.email,
    u.username,
    u.status,
    u.last_login,
    u.profile_photo,
    COALESCE(r.name, u.role) AS role_name,
    COALESCE(r.slug, u.role) AS role_slug,
    COALESCE(r.hierarchy_level, 99) AS hierarchy_level,
    COUNT(DISTINCT s.id) AS active_sessions,
    MAX(s.updated_at) AS last_activity,
    u.created_at,
    u.updated_at
FROM users u
LEFT JOIN roles r ON u.role_id = r.id
LEFT JOIN user_sessions s ON u.id = s.user_id AND s.is_active = TRUE AND s.expires_at > NOW()
WHERE u.status IN ('active', 'pending') AND u.deleted_at IS NULL
GROUP BY u.id, r.id;

-- User permissions with role inheritance
CREATE OR REPLACE VIEW user_permissions_view AS
SELECT DISTINCT
    u.id AS user_id,
    u.school_id,
    u.email,
    u.username,
    COALESCE(r.name, u.role) AS role_name,
    COALESCE(r.slug, u.role) AS role_slug,
    p.module,
    p.action,
    p.resource,
    rp.granted
FROM users u
LEFT JOIN roles r ON u.role_id = r.id
LEFT JOIN role_permissions rp ON r.id = rp.role_id
LEFT JOIN permissions p ON rp.permission_id = p.id
WHERE u.status = 'active' 
  AND u.deleted_at IS NULL 
  AND (rp.granted = TRUE OR rp.granted IS NULL);

-- Security audit view
CREATE OR REPLACE VIEW security_audit_view AS
SELECT 
    al.id,
    al.school_id,
    al.user_id,
    u.email,
    u.username,
    al.action,
    al.ip_address,
    al.status,
    al.details,
    u.full_name,
    u.role_name,
    al.created_at
FROM auth_logs al
LEFT JOIN active_users_view u ON al.user_id = u.id
ORDER BY al.created_at DESC;

-- =============================
-- 5. PERFORMANCE INDEXES
-- =============================

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_school_status ON users(school_id, status);
CREATE INDEX IF NOT EXISTS idx_users_last_activity ON users(last_activity);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role_id);
CREATE INDEX IF NOT EXISTS idx_users_reset_token ON users(password_reset_token);
CREATE INDEX IF NOT EXISTS idx_users_verification_token ON users(email_verification_token);

COMMIT;

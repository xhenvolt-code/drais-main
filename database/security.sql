
-- =============================
-- ENTERPRISE AUTHENTICATION & SECURITY UPGRADE
-- Version: 2.1 - Authentication, RBAC, and Biometric Ready
-- =============================

-- =============================
-- 1) UPGRADE USERS TABLE FOR ENTERPRISE AUTHENTICATION
-- =============================

-- Drop existing users table constraints if they exist to allow modification
SET FOREIGN_KEY_CHECKS = 0;

-- Backup existing users data if table exists
CREATE TABLE IF NOT EXISTS users_backup AS SELECT * FROM users WHERE 1=0;

-- Recreate users table with enterprise features
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,                          -- Multi-tenant support
  person_id BIGINT DEFAULT NULL,                          -- Links to people.id if applicable
  email VARCHAR(255) UNIQUE,                              -- Primary login identifier
  username VARCHAR(255) UNIQUE,                           -- Alternative login identifier
  password_hash TEXT NOT NULL,                            -- bcrypt/argon2 hash
  role VARCHAR(200) DEFAULT 'teacher',
  status VARCHAR(200) DEFAULT 'active',
  last_login DATETIME NULL,                               -- Track last successful login
  login_attempts INT DEFAULT 0,                           -- Failed login tracking
  locked_until DATETIME NULL,                             -- Account lockout timestamp
  two_factor_enabled BOOLEAN DEFAULT FALSE,               -- 2FA activation status
  two_factor_secret VARCHAR(32) NULL,                     -- TOTP secret key
  biometric_enabled BOOLEAN DEFAULT FALSE,                -- Biometric auth activation
  biometric_key TEXT NULL,                                -- Encrypted passkey/fingerprint data
  passcode_hash TEXT NULL,                                -- Optional PIN for quick access
  password_reset_token VARCHAR(64) NULL,                  -- Password reset security
  password_reset_expires DATETIME NULL,                   -- Token expiration
  email_verified BOOLEAN DEFAULT FALSE,                   -- Email verification status
  email_verification_token VARCHAR(64) NULL,              -- Email verification token
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME NULL,                               -- Soft delete support
  
  -- Indexes for performance
  INDEX idx_school_id (school_id),
  INDEX idx_person_id (person_id),
  INDEX idx_email (email),
  INDEX idx_username (username),
  INDEX idx_status (status),
  INDEX idx_role (role),
  INDEX idx_last_login (last_login),
  INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Enterprise user authentication with biometric support';

-- =============================
-- 2) ENTERPRISE ROLE MANAGEMENT SYSTEM
-- =============================

-- Drop existing roles table and recreate with enterprise features
DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,                          -- Multi-tenant support  
  name VARCHAR(100) NOT NULL,                             -- Role name (unique per school)
  slug VARCHAR(100) NOT NULL,                             -- URL-friendly identifier
  description TEXT,                                       -- Role description
  is_system_role BOOLEAN DEFAULT FALSE,                   -- System vs custom roles
  hierarchy_level INT DEFAULT 0,                          -- Role hierarchy (0=highest)
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME NULL,
  
  -- Constraints
  UNIQUE KEY unique_school_role (school_id, name),
  UNIQUE KEY unique_school_slug (school_id, slug),
  
  -- Indexes
  INDEX idx_school_id (school_id),
  INDEX idx_slug (slug),
  INDEX idx_hierarchy (hierarchy_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Enterprise role definitions with hierarchy';

-- =============================
-- 3) GRANULAR PERMISSION SYSTEM
-- =============================

-- Drop existing permissions table and recreate
DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  module VARCHAR(100) NOT NULL,                           -- Module/feature name
  code VARCHAR(100) DEFAULT NULL,                           -- Specific action
  action VARCHAR(100) NOT NULL,                           -- Specific action
  resource VARCHAR(100) DEFAULT '*',                      -- Resource/entity type
  description TEXT,                                       -- Human readable description
  is_system_permission BOOLEAN DEFAULT TRUE,              -- System vs custom permissions
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Ensure unique permission combinations
  UNIQUE KEY unique_permission (module, action, resource),
  
  -- Indexes
  INDEX idx_module (module),
  INDEX idx_action (action),
  INDEX idx_resource (resource)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Granular permission definitions';

-- =============================
-- 4) ROLE-PERMISSION MAPPING
-- =============================

-- Drop existing role_permissions table and recreate
DROP TABLE IF EXISTS role_permissions;
CREATE TABLE role_permissions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  granted BOOLEAN DEFAULT TRUE,                           -- Allow explicit deny
  granted_by INT DEFAULT NULL,                            -- Who granted this permission
  granted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Constraints
  UNIQUE KEY unique_role_permission (role_id, permission_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permissions(id) ON DELETE CASCADE,
  FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL,
  
  -- Indexes
  INDEX idx_role_id (role_id),
  INDEX idx_permission_id (permission_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Role-permission assignments';

-- =============================
-- 5) USER-ROLE ASSIGNMENTS
-- =============================

-- Create user_roles table for flexible role assignment
CREATE TABLE IF NOT EXISTS user_roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  assigned_by INT DEFAULT NULL,                           -- Who assigned this role
  assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME NULL,                               -- Optional role expiration
  is_active BOOLEAN DEFAULT TRUE,                         -- Active/inactive role
  
  -- Constraints
  UNIQUE KEY unique_user_role (user_id, role_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (assigned_by) REFERENCES users(id) ON DELETE SET NULL,
  
  -- Indexes
  INDEX idx_user_id (user_id),
  INDEX idx_role_id (role_id),
  INDEX idx_assigned_at (assigned_at),
  INDEX idx_expires_at (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User role assignments with expiration support';

-- =============================
-- 6) COMPREHENSIVE AUTHENTICATION LOGGING
-- =============================

-- Drop existing audit_log and create comprehensive auth_logs
CREATE TABLE IF NOT EXISTS auth_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,                          -- Multi-tenant support
  user_id INT DEFAULT NULL,                               -- NULL for failed logins
  session_id VARCHAR(128) DEFAULT NULL,                   -- Session tracking
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
    'permission_denied',
    'role_changed',
    'email_verified'
  ) NOT NULL,
  ip_address VARCHAR(45),                                 -- IPv4/IPv6 support
  user_agent TEXT,                                        -- Browser/device info
  device_fingerprint VARCHAR(64) DEFAULT NULL,            -- Device identification
  location_data JSON DEFAULT NULL,                        -- Geographic data if available
  additional_data JSON DEFAULT NULL,                      -- Flexible metadata storage
  risk_score INT DEFAULT 0,                              -- Security risk assessment (0-100)
  status ENUM('success','failed','blocked','pending') DEFAULT 'success',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Foreign key constraints
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
  
  -- Indexes for performance and security analysis
  INDEX idx_school_id (school_id),
  INDEX idx_user_id (user_id),
  INDEX idx_action (action),
  INDEX idx_ip_address (ip_address),
  INDEX idx_created_at (created_at),
  INDEX idx_status (status),
  INDEX idx_risk_score (risk_score),
  INDEX idx_session_id (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Comprehensive authentication and security event logging';

-- =============================
-- 7) BIOMETRIC AUTHENTICATION SUPPORT
-- =============================

-- Enhanced biometric authentication table with WebAuthn support
CREATE TABLE IF NOT EXISTS user_biometric_credentials (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  credential_id VARCHAR(255) NOT NULL UNIQUE,             -- WebAuthn credential ID
  public_key TEXT NOT NULL,                               -- Public key for verification
  credential_type ENUM('passkey','fingerprint','face','voice') DEFAULT 'passkey',
  device_name VARCHAR(100) DEFAULT NULL,                  -- User-friendly device name
  device_info JSON DEFAULT NULL,                          -- Device metadata
  counter BIGINT DEFAULT 0,                              -- WebAuthn signature counter
  is_active BOOLEAN DEFAULT TRUE,                         -- Active/inactive credential
  last_used_at DATETIME NULL,                            -- Last successful authentication
  registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Constraints
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  
  -- Indexes
  INDEX idx_user_id (user_id),
  INDEX idx_credential_id (credential_id),
  INDEX idx_credential_type (credential_type),
  INDEX idx_last_used (last_used_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Biometric credentials for WebAuthn/passkey authentication';

-- =============================
-- 8) SESSION MANAGEMENT
-- =============================

-- User session tracking for security
CREATE TABLE IF NOT EXISTS user_sessions (
  id VARCHAR(128) PRIMARY KEY,                           -- Session ID
  user_id INT NOT NULL,
  school_id BIGINT DEFAULT NULL,
  ip_address VARCHAR(45),
  user_agent TEXT,
  device_fingerprint VARCHAR(64) DEFAULT NULL,
  login_method ENUM('password','biometric','2fa','sso') DEFAULT 'password',
  is_active BOOLEAN DEFAULT TRUE,
  last_activity DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  
  -- Constraints
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  
  -- Indexes
  INDEX idx_user_id (user_id),
  INDEX idx_expires_at (expires_at),
  INDEX idx_last_activity (last_activity),
  INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Active user session management';

-- =============================
-- 9) SECURITY SETTINGS
-- =============================

-- System security configuration
CREATE TABLE IF NOT EXISTS security_settings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,                          -- Multi-tenant support
  setting_key VARCHAR(100) NOT NULL,
  setting_value TEXT,
  data_type ENUM('string','integer','boolean','json') DEFAULT 'string',
  description TEXT,
  is_editable BOOLEAN DEFAULT TRUE,
  updated_by INT DEFAULT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  -- Constraints
  UNIQUE KEY unique_school_setting (school_id, setting_key),
  FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
  
  -- Indexes
  INDEX idx_school_id (school_id),
  INDEX idx_setting_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Security configuration settings per school';

-- =============================
-- 10) INSERT DEFAULT ROLES AND PERMISSIONS
-- =============================

-- Insert system roles
INSERT INTO roles (school_id, name, slug, description, is_system_role, hierarchy_level) VALUES
(NULL, 'Super Administrator', 'superadmin', 'System-wide administrator with full access', TRUE, 0),
(NULL, 'School Administrator', 'admin', 'School-level administrator', TRUE, 1),
(NULL, 'Teacher', 'teacher', 'Teaching staff with class management access', TRUE, 2),
(NULL, 'Finance Manager', 'finance', 'Financial operations and reporting', TRUE, 2),
(NULL, 'Staff', 'staff', 'General school staff', TRUE, 3),
(NULL, 'Student', 'student', 'Student with limited access', TRUE, 4),
(NULL, 'Parent/Guardian', 'parent', 'Parent/Guardian with student-related access', TRUE, 4)
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Insert core system permissions
INSERT INTO permissions (module, action, resource, description, is_system_permission) VALUES
-- User Management
('users', 'view', '*', 'View user accounts', TRUE),
('users', 'create', '*', 'Create new user accounts', TRUE),
('users', 'edit', '*', 'Edit user accounts', TRUE),
('users', 'delete', '*', 'Delete user accounts', TRUE),
('users', 'reset_password', '*', 'Reset user passwords', TRUE),

-- Role Management
('roles', 'view', '*', 'View roles and permissions', TRUE),
('roles', 'create', '*', 'Create custom roles', TRUE),
('roles', 'edit', '*', 'Edit role permissions', TRUE),
('roles', 'delete', '*', 'Delete custom roles', TRUE),

-- Academic Management
('academics', 'view', '*', 'View academic data', TRUE),
('academics', 'create', '*', 'Create academic records', TRUE),
('academics', 'edit', '*', 'Edit academic records', TRUE),
('academics', 'delete', '*', 'Delete academic records', TRUE),

-- Student Management
('students', 'view', '*', 'View student information', TRUE),
('students', 'create', '*', 'Register new students', TRUE),
('students', 'edit', '*', 'Edit student information', TRUE),
('students', 'delete', '*', 'Remove students', TRUE),

-- Finance Management
('finance', 'view', '*', 'View financial data', TRUE),
('finance', 'create', '*', 'Create financial records', TRUE),
('finance', 'edit', '*', 'Edit financial records', TRUE),
('finance', 'delete', '*', 'Delete financial records', TRUE),

-- Reports
('reports', 'view', '*', 'View reports', TRUE),
('reports', 'export', '*', 'Export reports', TRUE),

-- System Administration
('system', 'settings', '*', 'Manage system settings', TRUE),
('system', 'backup', '*', 'Perform system backups', TRUE),
('system', 'logs', '*', 'View system logs', TRUE)

ON DUPLICATE KEY UPDATE description=VALUES(description);

-- Assign permissions to Super Administrator role (gets all permissions)
INSERT INTO role_permissions (role_id, permission_id, granted)
SELECT r.id, p.id, TRUE
FROM roles r
CROSS JOIN permissions p
WHERE r.slug = 'superadmin'
ON DUPLICATE KEY UPDATE granted=VALUES(granted);

-- =============================
-- 11) INSERT DEFAULT SECURITY SETTINGS
-- =============================

-- Default security settings
INSERT INTO security_settings (school_id, setting_key, setting_value, data_type, description, is_editable) VALUES
(NULL, 'password_min_length', '8', 'integer', 'Minimum password length', TRUE),
(NULL, 'password_require_uppercase', 'true', 'boolean', 'Require uppercase letters in passwords', TRUE),
(NULL, 'password_require_lowercase', 'true', 'boolean', 'Require lowercase letters in passwords', TRUE),
(NULL, 'password_require_numbers', 'true', 'boolean', 'Require numbers in passwords', TRUE),
(NULL, 'password_require_symbols', 'false', 'boolean', 'Require symbols in passwords', TRUE),
(NULL, 'login_max_attempts', '5', 'integer', 'Maximum failed login attempts before lockout', TRUE),
(NULL, 'login_lockout_duration', '15', 'integer', 'Account lockout duration in minutes', TRUE),
(NULL, 'session_timeout', '480', 'integer', 'Session timeout in minutes', TRUE),
(NULL, 'two_factor_required_roles', '["superadmin","admin"]', 'json', 'Roles that require 2FA', TRUE),
(NULL, 'biometric_enabled', 'true', 'boolean', 'Enable biometric authentication', TRUE),
(NULL, 'password_reset_token_expiry', '60', 'integer', 'Password reset token expiry in minutes', TRUE)
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

-- =============================
-- 12) RE-ENABLE FOREIGN KEY CHECKS
-- =============================

SET FOREIGN_KEY_CHECKS = 1;

-- =============================
-- 13) CREATE VIEWS FOR COMMON QUERIES
-- =============================

-- User permissions view for easy access control
CREATE OR REPLACE VIEW user_permissions_view AS
SELECT DISTINCT
    u.id as user_id,
    u.email,
    u.username,
    u.role as default_role,
    r.name as role_name,
    r.slug as role_slug,
    p.module,
    p.action,
    p.resource,
    rp.granted,
    u.school_id
FROM users u
LEFT JOIN user_roles ur ON u.id = ur.user_id AND ur.is_active = TRUE
LEFT JOIN roles r ON ur.role_id = r.id
LEFT JOIN role_permissions rp ON r.id = rp.role_id AND rp.granted = TRUE
LEFT JOIN permissions p ON rp.permission_id = p.id
WHERE u.status = 'active' AND u.deleted_at IS NULL;

-- Active sessions view for monitoring
CREATE OR REPLACE VIEW active_sessions_view AS
SELECT 
    s.id as session_id,
    u.id as user_id,
    u.email,
    u.username,
    s.ip_address,
    s.login_method,
    s.last_activity,
    s.expires_at,
    s.school_id
FROM user_sessions s
JOIN users u ON s.user_id = u.id
WHERE s.is_active = TRUE 
AND s.expires_at > NOW()
AND u.status = 'active';

-- Onboarding Module: Idempotent Migration Script
-- Safe to run multiple times

USE drais_school;

-- Ensure users.school_id exists
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS school_id BIGINT DEFAULT NULL;

-- Ensure schools.short_code exists
ALTER TABLE schools
  ADD COLUMN IF NOT EXISTS short_code VARCHAR(50) DEFAULT NULL;

-- Optional: domain and status for SaaS evolution
ALTER TABLE schools
  ADD COLUMN IF NOT EXISTS domain VARCHAR(150) DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE';

-- Ensure role column exists in users (if using string roles)
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS role VARCHAR(50) DEFAULT 'staff';

-- Create default permissions if they don't exist
INSERT IGNORE INTO permissions (code, description) VALUES
  ('school.manage', 'Manage school settings'),
  ('users.create', 'Create users'),
  ('users.manage', 'Manage users'),
  ('students.view', 'View students'),
  ('students.manage', 'Manage students'),
  ('academics.view', 'View academic data'),
  ('academics.manage', 'Manage academic data'),
  ('finance.view', 'View financial data'),
  ('finance.manage', 'Manage financial data'),
  ('reports.view', 'View reports'),
  ('reports.generate', 'Generate reports'),
  ('system.admin', 'System administration');

-- Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_school_id ON users(school_id);
CREATE INDEX IF NOT EXISTS idx_schools_short_code ON schools(short_code);
CREATE INDEX IF NOT EXISTS idx_schools_status ON schools(status);

-- Emergency migration SQL for existing clients
-- MANUAL EXECUTION ONLY - DO NOT RUN AUTOMATICALLY
/*
-- Step 1: Create school entry for existing client
INSERT INTO schools (name, short_code, legal_name, email, phone, address, status) 
VALUES ('Al-Hanan Islamic School', 'ALHAN', 'Al-Hanan Islamic School Ltd', 'info@alhanan.com', '+256123456789', 'Kampala, Uganda', 'ACTIVE');

-- Step 2: Get the school ID
SET @school_id = LAST_INSERT_ID();

-- Step 3: Update existing users (BACKUP FIRST!)
CREATE TABLE users_backup_migration AS SELECT * FROM users WHERE school_id IS NULL;
UPDATE users SET school_id = @school_id WHERE school_id IS NULL;

-- Step 4: Update other tables as needed
UPDATE students SET school_id = @school_id WHERE school_id IS NULL;
UPDATE classes SET school_id = @school_id WHERE school_id IS NULL;
UPDATE subjects SET school_id = @school_id WHERE school_id IS NULL;
*/

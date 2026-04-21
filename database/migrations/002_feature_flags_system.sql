-- Feature Flags and Enhanced Notifications System
-- Version: 1.0.0
-- Date: 2024-12-20

-- Enhanced notifications table (building on existing)
-- Add DRAIS notifications system tables if they don't exist
CREATE TABLE IF NOT EXISTS notifications (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  actor_user_id BIGINT DEFAULT NULL,
  action VARCHAR(120) NOT NULL,
  entity_type VARCHAR(50) DEFAULT NULL,
  entity_id BIGINT DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  message TEXT DEFAULT NULL,
  metadata JSON DEFAULT NULL,
  priority ENUM('low','normal','high','critical') DEFAULT 'normal',
  channel VARCHAR(50) DEFAULT 'in_app',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_count INT DEFAULT 0,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  INDEX idx_notifications_school_created (school_id, created_at),
  INDEX idx_notifications_actor (actor_user_id),
  INDEX idx_notifications_action (action),
  INDEX idx_notifications_entity (entity_type, entity_id),
  INDEX idx_notifications_priority (priority, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Core notifications storage';

-- Feature flags table for managing new features
CREATE TABLE IF NOT EXISTS feature_flags (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  route_name VARCHAR(255) NOT NULL,
  route_path VARCHAR(255) NOT NULL,
  label VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  is_new BOOLEAN DEFAULT FALSE,
  is_enabled BOOLEAN DEFAULT TRUE,
  version_tag VARCHAR(50) DEFAULT 'v_current',
  category VARCHAR(100) DEFAULT 'general',
  priority INT DEFAULT 0,
  date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY unique_school_route (school_id, route_name),
  INDEX idx_feature_flags_new (is_new, is_enabled),
  INDEX idx_feature_flags_school (school_id, is_enabled),
  INDEX idx_feature_flags_expires (expires_at),
  INDEX idx_feature_flags_category (category, is_enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Feature flags for new functionality';

-- User feature interactions tracking
CREATE TABLE IF NOT EXISTS user_feature_interactions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  feature_flag_id BIGINT NOT NULL,
  interaction_type ENUM('viewed','clicked','dismissed') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_user_features (user_id, feature_flag_id),
  INDEX idx_feature_interactions (feature_flag_id, interaction_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Track user interactions with new features';

-- Insert current DRAIS feature flags for new/updated modules
INSERT INTO feature_flags (
  school_id, route_name, route_path, label, description, is_new, category, priority, expires_at
) VALUES
-- Authentication & Security features
(NULL, 'auth-security', '/auth/security', 'Enhanced Security', 'Advanced security features including 2FA, biometric auth, and session management', TRUE, 'security', 10, DATE_ADD(NOW(), INTERVAL 21 DAY)),
(NULL, 'auth-biometric', '/auth/biometric', 'Biometric Authentication', 'Fingerprint and WebAuthn passkey authentication for secure access', TRUE, 'security', 9, DATE_ADD(NOW(), INTERVAL 21 DAY)),
(NULL, 'auth-2fa', '/auth/2fa', 'Two-Factor Authentication', 'Enhanced security with TOTP-based two-factor authentication', TRUE, 'security', 8, DATE_ADD(NOW(), INTERVAL 21 DAY)),
(NULL, 'auth-sessions', '/auth/sessions', 'Session Management', 'Real-time session monitoring and device management', TRUE, 'security', 7, DATE_ADD(NOW(), INTERVAL 21 DAY)),
(NULL, 'auth-rbac', '/auth/roles', 'Role-Based Access Control', 'Granular permission system with hierarchical roles', TRUE, 'security', 6, DATE_ADD(NOW(), INTERVAL 21 DAY)),

-- Onboarding & Setup features
(NULL, 'onboarding-wizard', '/onboarding', 'School Setup Wizard', 'Streamlined 5-step school onboarding process with validation', TRUE, 'onboarding', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'school-selector', '/auth/login', 'Multi-School Selector', 'Advanced school selection with search and validation', TRUE, 'onboarding', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'migration-tools', '/admin/migration', 'Migration Assistant', 'Tools for migrating from existing DRAIS installations', TRUE, 'onboarding', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'setup-validation', '/onboarding/validate', 'Real-time Validation', 'Live validation of school information during setup', TRUE, 'onboarding', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Enhanced Dashboard features
(NULL, 'dashboard-analytics', '/dashboard', 'Analytics Dashboard', 'Comprehensive school analytics with interactive charts', TRUE, 'dashboard', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'dashboard-widgets', '/dashboard/widgets', 'Smart Widgets', 'Customizable dashboard widgets with real-time data', TRUE, 'dashboard', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'dashboard-charts', '/dashboard/charts', 'Interactive Charts', 'Beautiful Chart.js visualizations for school data', TRUE, 'dashboard', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'dashboard-metrics', '/dashboard/metrics', 'Key Metrics', 'Important school KPIs and performance indicators', TRUE, 'dashboard', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Enhanced UX & Theme features
(NULL, 'theme-customizer', '/settings/theme', 'Theme Customizer', 'Advanced theme customization with live preview', TRUE, 'ux', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'dark-mode', '/settings/appearance', 'Dark Mode Support', 'Beautiful dark mode with automatic theme switching', TRUE, 'ux', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'responsive-design', '/', 'Mobile Responsive', 'Fully responsive design optimized for all devices', TRUE, 'ux', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'animations', '/', 'Smooth Animations', 'Enhanced user experience with Framer Motion animations', TRUE, 'ux', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'sidebar-navigation', '/', 'Enhanced Navigation', 'Improved sidebar with collapsible sections and icons', TRUE, 'ux', 6, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Finance Management features
(NULL, 'finance-overview', '/finance', 'Finance Dashboard', 'Comprehensive financial overview with real-time insights', TRUE, 'finance', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'fee-management', '/finance/fees', 'Fee Management', 'Advanced fee structure management and payment tracking', TRUE, 'finance', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'payments-tracking', '/finance/payments', 'Payment Tracking', 'Real-time fee payment monitoring and receipt management', TRUE, 'finance', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'financial-reports', '/finance/reports', 'Financial Reports', 'Detailed financial reports and analytics', TRUE, 'finance', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'wallet-system', '/finance/wallets', 'Multi-Wallet System', 'Manage multiple payment methods and financial accounts', TRUE, 'finance', 6, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Branch Management features
(NULL, 'branch-management', '/branches', 'Branch Management', 'Multi-branch school management and coordination', TRUE, 'branches', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'branch-dashboard', '/branches/dashboard', 'Branch Dashboard', 'Individual branch performance tracking and analytics', TRUE, 'branches', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'inter-branch-reports', '/branches/reports', 'Inter-Branch Reports', 'Compare performance across multiple school branches', TRUE, 'branches', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'branch-staff', '/branches/staff', 'Branch Staff Management', 'Manage staff assignments across different branches', TRUE, 'branches', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- School Information features
(NULL, 'school-profile', '/school/profile', 'School Profile', 'Comprehensive school information management', TRUE, 'school', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'school-settings', '/school/settings', 'Advanced Settings', 'Detailed school configuration and preferences', TRUE, 'school', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'school-branding', '/school/branding', 'School Branding', 'Customize school logo, colors, and branding elements', TRUE, 'school', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'academic-calendar', '/school/calendar', 'Academic Calendar', 'Manage academic years, terms, and important dates', TRUE, 'school', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Students module features
(NULL, 'students-list', '/students/list', 'Student List', 'Enhanced student list with fingerprint support and advanced filtering', TRUE, 'students', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'students-attendance', '/attendance', 'Student Attendance', 'New comprehensive attendance tracking system', TRUE, 'students', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'students-requirements', '/students/requirements', 'Requirements', 'Track and manage student requirements per term', TRUE, 'students', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'students-contacts', '/students/contacts', 'Contacts', 'Manage guardian and family contact information', TRUE, 'students', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'students-documents', '/students/documents', 'Documents', 'Upload and manage student documents', TRUE, 'students', 6, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'students-history', '/students/history', 'Academic History', 'View comprehensive academic performance records', TRUE, 'students', 5, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Staff module features
(NULL, 'staff-overview', '/staff', 'Staff Overview', 'New comprehensive staff dashboard with analytics', TRUE, 'staff', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'staff-list', '/staff/list', 'Staff List', 'Enhanced staff management with new capabilities', TRUE, 'staff', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'staff-add', '/staff/add', 'Add Staff', 'Streamlined staff onboarding process', TRUE, 'staff', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'staff-attendance', '/staff/attendance', 'Staff Attendance', 'New staff attendance tracking system', TRUE, 'staff', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'departments', '/departments', 'Departments', 'Manage school departments and hierarchies', TRUE, 'staff', 6, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'workplans', '/work-plans', 'Work Plans', 'Create and track departmental work plans', TRUE, 'staff', 5, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Timetable & Scheduling features
(NULL, 'timetable-enhanced', '/timetable', 'Enhanced Timetable', 'Advanced timetable with recurring classes and notifications', TRUE, 'academics', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'recurring-classes', '/timetable/recurring', 'Recurring Classes', 'Set up weekly and bi-weekly recurring timetable entries', TRUE, 'academics', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'teacher-notifications', '/timetable/notifications', 'Teacher Notifications', 'Automated notifications for schedule changes and reminders', TRUE, 'academics', 8, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'room-booking', '/timetable/rooms', 'Room Booking', 'Manage classroom bookings and conflicts', TRUE, 'academics', 7, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- Tahfiz module (existing but enhanced)
(NULL, 'tahfiz-overview', '/tahfiz', 'Tahfiz System', 'Complete Quranic memorization tracking system', TRUE, 'academics', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),

-- System & Notifications
(NULL, 'notifications-system', '/notifications', 'Notifications', 'New real-time notification system', TRUE, 'system', 10, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'audit-logging', '/admin/audit', 'Audit Logging', 'Comprehensive system activity tracking and logging', TRUE, 'system', 9, DATE_ADD(NOW(), INTERVAL 14 DAY)),
(NULL, 'multi-tenant', '/', 'Multi-Tenant Architecture', 'Support for multiple schools in single installation', TRUE, 'system', 8, DATE_ADD(NOW(), INTERVAL 14 DAY))

ON DUPLICATE KEY UPDATE 
  is_new = VALUES(is_new),
  expires_at = VALUES(expires_at),
  updated_at = CURRENT_TIMESTAMP;

-- Insert comprehensive system notification about new features
INSERT INTO notifications (
  school_id, action, entity_type, title, message, priority, metadata
) VALUES
(NULL, 'major_system_update', 'system', 'DRAIS v2.1 - Major Update Available! 🚀', 
 'Welcome to DRAIS v2.1! We\'ve added incredible new features and improvements:\n\n🔒 SECURITY & AUTHENTICATION:\n• Enhanced security with 2FA and biometric auth\n• Advanced session management\n• Role-based access control (RBAC)\n\n🎯 ONBOARDING & SETUP:\n• 5-step school setup wizard\n• Multi-school selector with validation\n• Migration tools for existing installations\n\n📊 ENHANCED DASHBOARD:\n• Interactive analytics with Chart.js\n• Customizable widgets\n• Real-time metrics and KPIs\n\n🎨 IMPROVED USER EXPERIENCE:\n• Beautiful theme customizer\n• Dark mode support\n• Smooth animations with Framer Motion\n• Mobile-responsive design\n\n💰 FINANCE MANAGEMENT:\n• Comprehensive fee management\n• Payment tracking and receipts\n• Multi-wallet system\n• Financial reports\n\n🏢 MULTI-BRANCH SUPPORT:\n• Branch management system\n• Inter-branch reporting\n• Staff assignment across branches\n\n🏫 SCHOOL ADMINISTRATION:\n• Enhanced school profile management\n• Advanced settings and branding\n• Academic calendar management\n\n📅 ADVANCED TIMETABLE:\n• Recurring classes support\n• Teacher notifications\n• Room booking system\n\n👥 ENHANCED MODULES:\n• Student management with biometric support\n• Staff overview with analytics\n• Department and work plan management\n• Document management system\n\nLook for the ✨ NEW badges throughout the system to discover these amazing features!', 
 'high',
 JSON_OBJECT(
   'version', 'v2.1.0',
   'features_count', 45,
   'categories', JSON_ARRAY('security', 'onboarding', 'dashboard', 'ux', 'finance', 'branches', 'school', 'students', 'staff', 'academics', 'system'),
   'release_date', NOW(),
   'link', '/dashboard',
   'dismissible', true,
   'auto_read_after', 7200,
   'highlights', JSON_ARRAY(
     'Enhanced Security & Authentication',
     'Beautiful UX with Dark Mode',
     'Advanced Analytics Dashboard',
     'Multi-Branch Support',
     'Comprehensive Finance Management',
     'Smart Onboarding System'
   )
 )
);

-- Create scheduled cleanup procedure for expired feature flags
DELIMITER //
CREATE PROCEDURE IF NOT EXISTS CleanupExpiredFeatureFlags()
BEGIN
  UPDATE feature_flags 
  SET is_new = FALSE, updated_at = CURRENT_TIMESTAMP
  WHERE expires_at IS NOT NULL 
    AND expires_at <= NOW() 
    AND is_new = TRUE;
    
  INSERT INTO audit_log (action, entity_type, changes_json) 
  SELECT 'feature_flag_expired', 'feature_flag', 
         JSON_OBJECT('expired_count', ROW_COUNT(), 'cleanup_date', NOW());
END //
DELIMITER ;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_notifications_unread ON notifications(school_id, created_at DESC);

-- Migration log
INSERT INTO audit_log (action, entity_type, entity_id, changes_json) VALUES
('feature_flags_system_installed', 'system', 1, JSON_OBJECT(
  'tables_created', JSON_ARRAY('feature_flags', 'user_feature_interactions'),
  'features_added', 12,
  'version', 'v2.1.0',
  'expires_after_days', 14
));

-- DRAIS Notifications System Migration
-- Version: 1.0.0
-- Date: 2024-12-20

-- Notifications core table
CREATE TABLE IF NOT EXISTS notifications (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,              -- multi-tenant
  actor_user_id BIGINT DEFAULT NULL,          -- who caused it (nullable for system)
  action VARCHAR(120) NOT NULL,               -- e.g. "created_exam", "student_enrolled"
  entity_type VARCHAR(50) DEFAULT NULL,       -- e.g. "exam", "student", "document"
  entity_id BIGINT DEFAULT NULL,
  title VARCHAR(255) DEFAULT NULL,
  message TEXT DEFAULT NULL,                  -- human friendly
  metadata JSON DEFAULT NULL,                 -- structured data (for deep links, payload)
  priority ENUM('low','normal','high','critical') DEFAULT 'normal',
  channel VARCHAR(50) DEFAULT 'in_app',       -- 'in_app','email','sms','webhook' etc
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_count INT DEFAULT 0,                   -- number of recipients who marked read (for group notifications)
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  INDEX idx_notifications_school_created (school_id, created_at),
  INDEX idx_notifications_actor (actor_user_id),
  INDEX idx_notifications_action (action),
  INDEX idx_notifications_entity (entity_type, entity_id),
  INDEX idx_notifications_priority (priority, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Core notifications storage';

-- Recipients mapping (per-user state)
CREATE TABLE IF NOT EXISTS user_notifications (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  notification_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  school_id BIGINT DEFAULT NULL,
  is_read TINYINT(1) DEFAULT 0,
  is_archived TINYINT(1) DEFAULT 0,
  channel VARCHAR(50) DEFAULT 'in_app',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_at TIMESTAMP NULL DEFAULT NULL,
  archived_at TIMESTAMP NULL DEFAULT NULL,
  UNIQUE KEY uq_user_notification (notification_id, user_id),
  INDEX idx_user_notifications_user (user_id, is_read, is_archived),
  INDEX idx_user_notifications_school (school_id, user_id),
  INDEX idx_user_notifications_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Per-user notification state';

-- Notification templates for reuse & conversation triggers
CREATE TABLE IF NOT EXISTS notification_templates (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT DEFAULT NULL,
  code VARCHAR(120) NOT NULL,                 -- system friendly key: e.g. 'welcome_new_db', 'inactivity_reminder'
  title_template VARCHAR(255) DEFAULT NULL,   -- allow placeholders
  message_template TEXT DEFAULT NULL,         -- placeholders e.g. {{user_name}}, {{days_idle}}
  default_channel VARCHAR(50) DEFAULT 'in_app',
  priority ENUM('low','normal','high','critical') DEFAULT 'normal',
  is_system TINYINT(1) DEFAULT 0,            -- system templates vs custom
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_template_code (school_id, code),
  INDEX idx_templates_system (is_system, is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Reusable notification templates';

-- User preferences (which channels they want)
CREATE TABLE IF NOT EXISTS notification_preferences (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  school_id BIGINT DEFAULT NULL,
  channel VARCHAR(50) NOT NULL,               -- e.g. 'in_app','email'
  enabled TINYINT(1) DEFAULT 1,
  do_not_disturb TINYINT(1) DEFAULT 0,        -- temporary mute
  dnd_until TIMESTAMP NULL DEFAULT NULL,      -- when to stop DND
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_user_channel (user_id, channel),
  INDEX idx_preferences_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User notification preferences';

-- Lightweight queue for outgoing notifications (useful for retry/worker)
CREATE TABLE IF NOT EXISTS notification_queue (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  notification_id BIGINT NOT NULL,
  recipient_user_id BIGINT DEFAULT NULL,
  channel VARCHAR(50) DEFAULT 'in_app',
  attempts INT DEFAULT 0,
  max_attempts INT DEFAULT 3,
  last_attempt_at TIMESTAMP NULL,
  next_attempt_at TIMESTAMP NULL,             -- for retry scheduling
  status ENUM('pending','sent','failed','cancelled') DEFAULT 'pending',
  payload JSON DEFAULT NULL,
  error_message TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_queue_status (status, next_attempt_at),
  INDEX idx_queue_recipient (recipient_user_id),
  INDEX idx_queue_notification (notification_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Notification delivery queue';

-- Seed system templates
INSERT INTO notification_templates (school_id, code, title_template, message_template, is_system, priority) VALUES
(NULL, 'welcome_new_db', 'Welcome to DRAIS!', 'Welcome to DRAIS at {{school_name}}! Your school management system is ready. This is a fresh database - would you like to explore the features?', 1, 'normal'),
(NULL, 'inactivity_reminder', 'DRAIS Activity Reminder', 'It''s been {{days_idle}} days since your last activity on DRAIS. Would you like a quick refresher or demo of new features?', 1, 'low'),
(NULL, 'student_enrolled', 'New Student Enrolled', 'Student {{student_name}} has been enrolled in {{class_name}}', 1, 'normal'),
(NULL, 'exam_created', 'Exam Scheduled', 'New exam "{{exam_name}}" scheduled for {{class_name}} on {{exam_date}}', 1, 'normal'),
(NULL, 'attendance_marked', 'Attendance Recorded', 'Attendance has been marked for {{class_name}} on {{date}}', 1, 'low'),
(NULL, 'document_uploaded', 'Document Uploaded', 'New document "{{document_name}}" uploaded for {{entity_type}}', 1, 'low'),
(NULL, 'fee_payment', 'Fee Payment Received', 'Payment of {{amount}} received from {{student_name}}', 1, 'normal'),
(NULL, 'staff_added', 'New Staff Member', 'Staff member {{staff_name}} has been added to {{department_name}}', 1, 'normal')
ON DUPLICATE KEY UPDATE 
  title_template = VALUES(title_template),
  message_template = VALUES(message_template),
  updated_at = CURRENT_TIMESTAMP;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_notifications_recent ON notifications(school_id, created_at DESC, deleted_at);
CREATE INDEX IF NOT EXISTS idx_user_notifications_unread ON user_notifications(user_id, is_read, created_at DESC);

-- Migration log
INSERT INTO audit_log (action, entity_type, entity_id, changes_json) VALUES
('notifications_system_installed', 'system', 1, '{"tables_created": ["notifications", "user_notifications", "notification_templates", "notification_preferences", "notification_queue"], "version": "1.0.0"}');

-- DRAIS Notifications System Rollback
-- WARNING: This will remove all notification data

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS notification_queue;
DROP TABLE IF EXISTS notification_preferences;
DROP TABLE IF EXISTS user_notifications;
DROP TABLE IF EXISTS notification_templates;
DROP TABLE IF EXISTS notifications;

SET FOREIGN_KEY_CHECKS = 1;

-- Remove migration log entry
DELETE FROM audit_log WHERE action = 'notifications_system_installed' AND entity_type = 'system';

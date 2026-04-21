-- =============================
-- ENHANCED TIMETABLE MODULE FOR DRAIS
-- Supports: Teacher notifications, recurring entries, multi-school, real-time updates
-- =============================

USE drais_school;

-- =============================
-- DROP ALL EXISTING TIMETABLE TABLES TO AVOID INCONSISTENCIES
-- =============================
DROP TABLE IF EXISTS notification_delivery_log;
DROP TABLE IF EXISTS teacher_workload_summary;
DROP TABLE IF EXISTS timetable_conflicts;
DROP TABLE IF EXISTS room_bookings;
DROP TABLE IF EXISTS substitute_assignments;
DROP TABLE IF EXISTS lesson_attendance;
DROP TABLE IF EXISTS timetable_changes_log;
DROP TABLE IF EXISTS teacher_notification_preferences;
DROP TABLE IF EXISTS teacher_notifications;
DROP TABLE IF EXISTS period_definitions;
DROP TABLE IF EXISTS timetable_templates;
DROP TABLE IF EXISTS timetable;

-- =============================
-- 1) ENHANCED TIMETABLE TABLE
-- =============================
CREATE TABLE timetable (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  class_id BIGINT NOT NULL,
  subject_id BIGINT NOT NULL,
  teacher_id BIGINT NOT NULL,
  
  -- Scheduling Information
  lesson_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  day_of_week TINYINT NOT NULL, -- 1=Monday, 7=Sunday
  
  -- Location & Resources
  room VARCHAR(50) DEFAULT NULL,
  venue VARCHAR(100) DEFAULT NULL,
  required_resources TEXT DEFAULT NULL,
  
  -- Lesson Details
  lesson_title VARCHAR(200) DEFAULT NULL,
  lesson_description TEXT DEFAULT NULL,
  lesson_type ENUM('regular', 'revision', 'exam', 'practical', 'field_trip', 'makeup', 'extra') DEFAULT 'regular',
  
  -- Status & Tracking
  status ENUM('scheduled', 'ongoing', 'completed', 'cancelled', 'postponed', 'rescheduled') DEFAULT 'scheduled',
  attendance_taken TINYINT(1) DEFAULT 0,
  
  -- Recurrence Support
  is_recurring TINYINT(1) DEFAULT 0,
  recurrence_pattern ENUM('daily', 'weekly', 'monthly', 'custom') DEFAULT NULL,
  recurrence_end_date DATE DEFAULT NULL,
  recurrence_interval INT DEFAULT 1, -- Every N intervals (e.g., every 2 weeks)
  recurrence_days VARCHAR(20) DEFAULT NULL, -- JSON array for custom patterns: ["1","3","5"] for Mon,Wed,Fri
  parent_timetable_id BIGINT DEFAULT NULL, -- Links to original recurring entry
  
  -- Metadata
  notes TEXT DEFAULT NULL,
  created_by BIGINT DEFAULT NULL,
  updated_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL DEFAULT NULL,
  
  -- Indexes for performance
  INDEX idx_school_class_date (school_id, class_id, lesson_date),
  INDEX idx_teacher_date (teacher_id, lesson_date),
  INDEX idx_subject_date (subject_id, lesson_date),
  INDEX idx_status (status),
  INDEX idx_recurring (is_recurring, parent_timetable_id),
  INDEX idx_day_time (day_of_week, start_time),
  INDEX idx_updated (updated_at),
  
  -- Constraints
  CONSTRAINT chk_day_of_week CHECK (day_of_week BETWEEN 1 AND 7),
  CONSTRAINT chk_time_order CHECK (start_time < end_time),
  CONSTRAINT chk_recurrence_interval CHECK (recurrence_interval > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 2) TIMETABLE TEMPLATES
-- =============================
CREATE TABLE timetable_templates (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  academic_year_id BIGINT DEFAULT NULL,
  term_id BIGINT DEFAULT NULL,
  
  -- Template Configuration
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  default_lesson_duration INT DEFAULT 45, -- minutes
  break_duration INT DEFAULT 15, -- minutes
  periods_per_day INT DEFAULT 8,
  school_start_time TIME DEFAULT '08:00:00',
  school_end_time TIME DEFAULT '17:00:00',
  
  -- Status
  is_active TINYINT(1) DEFAULT 1,
  is_published TINYINT(1) DEFAULT 0,
  
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_school_active (school_id, is_active),
  INDEX idx_academic_term (academic_year_id, term_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 3) PERIOD DEFINITIONS
-- =============================
CREATE TABLE period_definitions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  template_id BIGINT DEFAULT NULL,
  
  period_number INT NOT NULL,
  period_name VARCHAR(50) NOT NULL, -- "Period 1", "Morning Break", "Lunch Break"
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  period_type ENUM('lesson', 'break', 'lunch', 'assembly', 'other') DEFAULT 'lesson',
  
  -- Days this period applies to
  applies_monday TINYINT(1) DEFAULT 1,
  applies_tuesday TINYINT(1) DEFAULT 1,
  applies_wednesday TINYINT(1) DEFAULT 1,
  applies_thursday TINYINT(1) DEFAULT 1,
  applies_friday TINYINT(1) DEFAULT 1,
  applies_saturday TINYINT(1) DEFAULT 0,
  applies_sunday TINYINT(1) DEFAULT 0,
  
  is_active TINYINT(1) DEFAULT 1,
  
  INDEX idx_school_template (school_id, template_id),
  INDEX idx_period_time (period_number, start_time),
  
  CONSTRAINT chk_period_time_order CHECK (start_time < end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 4) TEACHER NOTIFICATIONS
-- =============================
CREATE TABLE teacher_notifications (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  teacher_id BIGINT NOT NULL,
  
  -- Notification Content
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  notification_type ENUM('lesson_reminder', 'lesson_change', 'lesson_cancelled', 'new_assignment', 'general', 'urgent') DEFAULT 'general',
  
  -- Related Entity
  related_entity_type VARCHAR(50) DEFAULT NULL, -- 'timetable', 'exam', 'meeting'
  related_entity_id BIGINT DEFAULT NULL,
  
  -- Scheduling
  scheduled_for DATETIME DEFAULT NULL, -- When to send the notification
  sent_at DATETIME DEFAULT NULL,
  
  -- Status
  status ENUM('pending', 'sent', 'read', 'dismissed', 'failed') DEFAULT 'pending',
  priority ENUM('low', 'normal', 'high', 'urgent') DEFAULT 'normal',
  
  -- Channels
  send_email TINYINT(1) DEFAULT 0,
  send_sms TINYINT(1) DEFAULT 0,
  send_push TINYINT(1) DEFAULT 1,
  send_in_app TINYINT(1) DEFAULT 1,
  
  -- Metadata
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  expires_at DATETIME DEFAULT NULL,
  
  INDEX idx_teacher_status (teacher_id, status),
  INDEX idx_school_type (school_id, notification_type),
  INDEX idx_scheduled (scheduled_for, status),
  INDEX idx_related_entity (related_entity_type, related_entity_id),
  INDEX idx_priority_status (priority, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 5) NOTIFICATION PREFERENCES
-- =============================
CREATE TABLE teacher_notification_preferences (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  teacher_id BIGINT NOT NULL,
  school_id BIGINT NOT NULL DEFAULT 1,
  
  -- Lesson Reminders
  lesson_reminder_enabled TINYINT(1) DEFAULT 1,
  lesson_reminder_minutes INT DEFAULT 15, -- Minutes before lesson
  
  -- Change Notifications
  schedule_change_enabled TINYINT(1) DEFAULT 1,
  cancellation_enabled TINYINT(1) DEFAULT 1,
  
  -- Channel Preferences
  default_email TINYINT(1) DEFAULT 1,
  default_sms TINYINT(1) DEFAULT 0,
  default_push TINYINT(1) DEFAULT 1,
  default_in_app TINYINT(1) DEFAULT 1,
  
  -- Timing Preferences
  notification_start_time TIME DEFAULT '06:00:00',
  notification_end_time TIME DEFAULT '22:00:00',
  weekend_notifications TINYINT(1) DEFAULT 0,
  
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_teacher_school (teacher_id, school_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 6) LESSON CHANGES LOG
-- =============================
CREATE TABLE timetable_changes_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  timetable_id BIGINT NOT NULL,
  
  -- Change Information
  change_type ENUM('created', 'updated', 'cancelled', 'rescheduled', 'completed') NOT NULL,
  field_changed VARCHAR(100) DEFAULT NULL, -- Which field was changed
  old_value TEXT DEFAULT NULL,
  new_value TEXT DEFAULT NULL,
  
  -- Reason & Notes
  reason VARCHAR(200) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  
  -- Approval Workflow
  requires_approval TINYINT(1) DEFAULT 0,
  approved_by BIGINT DEFAULT NULL,
  approved_at DATETIME DEFAULT NULL,
  approval_status ENUM('pending', 'approved', 'rejected') DEFAULT NULL,
  
  -- Notifications
  notification_sent TINYINT(1) DEFAULT 0,
  affected_teachers TEXT DEFAULT NULL, -- JSON array of teacher IDs
  affected_students TEXT DEFAULT NULL, -- JSON array of student IDs
  
  changed_by BIGINT NOT NULL,
  changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_timetable (timetable_id),
  INDEX idx_change_type (change_type),
  INDEX idx_changed_by (changed_by),
  INDEX idx_approval (approval_status, requires_approval)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 7) LESSON ATTENDANCE TRACKING
-- =============================
CREATE TABLE lesson_attendance (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  timetable_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  
  status ENUM('present', 'absent', 'late', 'excused', 'not_marked') DEFAULT 'not_marked',
  arrival_time TIME DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  
  marked_by BIGINT DEFAULT NULL,
  marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_lesson_student (timetable_id, student_id),
  INDEX idx_status (status),
  INDEX idx_marked_by (marked_by)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 8) SUBSTITUTE TEACHERS
-- =============================
CREATE TABLE substitute_assignments (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  timetable_id BIGINT NOT NULL,
  original_teacher_id BIGINT NOT NULL,
  substitute_teacher_id BIGINT NOT NULL,
  
  -- Assignment Details
  reason VARCHAR(200) DEFAULT NULL,
  start_date DATE NOT NULL,
  end_date DATE DEFAULT NULL,
  
  -- Status
  status ENUM('pending', 'confirmed', 'active', 'completed', 'cancelled') DEFAULT 'pending',
  
  -- Notifications
  original_teacher_notified TINYINT(1) DEFAULT 0,
  substitute_notified TINYINT(1) DEFAULT 0,
  students_notified TINYINT(1) DEFAULT 0,
  
  assigned_by BIGINT NOT NULL,
  assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_timetable (timetable_id),
  INDEX idx_original_teacher (original_teacher_id),
  INDEX idx_substitute_teacher (substitute_teacher_id),
  INDEX idx_status_dates (status, start_date, end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 9) ROOM BOOKINGS & CONFLICTS
-- =============================
CREATE TABLE room_bookings (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  room VARCHAR(50) NOT NULL,
  
  -- Booking Details
  booking_date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  purpose VARCHAR(200) NOT NULL,
  
  -- Booking Entity
  booked_by_type ENUM('timetable', 'event', 'meeting', 'exam', 'manual') DEFAULT 'manual',
  booked_by_id BIGINT DEFAULT NULL,
  
  -- Requester
  requested_by BIGINT NOT NULL,
  approved_by BIGINT DEFAULT NULL,
  
  status ENUM('pending', 'approved', 'rejected', 'cancelled') DEFAULT 'pending',
  priority ENUM('low', 'normal', 'high') DEFAULT 'normal',
  
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_room_date (room, booking_date),
  INDEX idx_room_time (room, start_time, end_time),
  INDEX idx_booked_by (booked_by_type, booked_by_id),
  INDEX idx_status (status),
  
  CONSTRAINT chk_booking_time_order CHECK (start_time < end_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 10) TIMETABLE CONFLICTS DETECTION
-- =============================
CREATE TABLE timetable_conflicts (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  
  -- Conflicting Entries
  timetable_id_1 BIGINT NOT NULL,
  timetable_id_2 BIGINT NOT NULL,
  
  -- Conflict Type
  conflict_type ENUM('teacher_double_booking', 'room_double_booking', 'class_double_booking', 'resource_conflict') NOT NULL,
  conflict_severity ENUM('warning', 'error', 'critical') DEFAULT 'warning',
  
  -- Resolution
  status ENUM('detected', 'acknowledged', 'resolved', 'ignored') DEFAULT 'detected',
  resolution_notes TEXT DEFAULT NULL,
  resolved_by BIGINT DEFAULT NULL,
  resolved_at DATETIME DEFAULT NULL,
  
  detected_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_timetable_entries (timetable_id_1, timetable_id_2),
  INDEX idx_conflict_type (conflict_type),
  INDEX idx_status (status),
  INDEX idx_severity (conflict_severity)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 11) TEACHER WORKLOAD TRACKING
-- =============================
CREATE TABLE teacher_workload_summary (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  teacher_id BIGINT NOT NULL,
  
  -- Time Period
  week_start_date DATE NOT NULL,
  academic_year_id BIGINT DEFAULT NULL,
  term_id BIGINT DEFAULT NULL,
  
  -- Workload Metrics
  total_scheduled_hours DECIMAL(5,2) DEFAULT 0,
  total_teaching_hours DECIMAL(5,2) DEFAULT 0,
  total_classes INT DEFAULT 0,
  total_subjects INT DEFAULT 0,
  
  -- Performance Metrics
  lessons_completed INT DEFAULT 0,
  lessons_cancelled INT DEFAULT 0,
  lessons_rescheduled INT DEFAULT 0,
  average_attendance_rate DECIMAL(5,2) DEFAULT 0,
  
  -- Load Status
  workload_status ENUM('underloaded', 'optimal', 'overloaded', 'critical') DEFAULT 'optimal',
  
  last_calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  UNIQUE KEY unique_teacher_week (teacher_id, week_start_date),
  INDEX idx_school_week (school_id, week_start_date),
  INDEX idx_workload_status (workload_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 12) NOTIFICATION DELIVERY LOG
-- =============================
CREATE TABLE notification_delivery_log (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  notification_id BIGINT NOT NULL,
  
  -- Delivery Details
  channel ENUM('email', 'sms', 'push', 'in_app') NOT NULL,
  recipient_id BIGINT NOT NULL,
  recipient_address VARCHAR(255) DEFAULT NULL, -- email or phone number
  
  -- Status
  delivery_status ENUM('pending', 'sent', 'delivered', 'failed', 'bounced') DEFAULT 'pending',
  failure_reason TEXT DEFAULT NULL,
  
  -- Timing
  sent_at DATETIME DEFAULT NULL,
  delivered_at DATETIME DEFAULT NULL,
  read_at DATETIME DEFAULT NULL,
  
  -- Response Tracking
  clicked TINYINT(1) DEFAULT 0,
  clicked_at DATETIME DEFAULT NULL,
  
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  INDEX idx_notification (notification_id),
  INDEX idx_recipient_channel (recipient_id, channel),
  INDEX idx_delivery_status (delivery_status),
  INDEX idx_sent_at (sent_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =============================
-- 13) VIEWS FOR EASY QUERYING
-- =============================

-- Current Day's Lessons for Teachers
CREATE OR REPLACE VIEW teacher_daily_schedule AS
SELECT 
  t.id,
  t.school_id,
  t.teacher_id,
  CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
  t.lesson_date,
  t.start_time,
  t.end_time,
  t.room,
  c.name AS class_name,
  s.name AS subject_name,
  t.status,
  t.lesson_title,
  t.lesson_type,
  t.attendance_taken,
  CASE 
    WHEN t.lesson_date = CURDATE() AND t.start_time <= CURTIME() AND t.end_time >= CURTIME() 
    THEN 'ongoing'
    WHEN t.lesson_date = CURDATE() AND t.start_time > CURTIME() 
    THEN 'upcoming'
    WHEN t.lesson_date = CURDATE() AND t.end_time < CURTIME() 
    THEN 'past'
    ELSE 'scheduled'
  END AS lesson_status
FROM timetable t
JOIN staff st ON t.teacher_id = st.id
JOIN people p ON st.person_id = p.id
JOIN classes c ON t.class_id = c.id
JOIN subjects s ON t.subject_id = s.id
WHERE t.deleted_at IS NULL
AND t.status IN ('scheduled', 'ongoing', 'completed');

-- Class Timetable View
CREATE OR REPLACE VIEW class_timetable_view AS
SELECT 
  t.id,
  t.school_id,
  t.class_id,
  c.name AS class_name,
  t.lesson_date,
  t.day_of_week,
  t.start_time,
  t.end_time,
  s.name AS subject_name,
  CONCAT(p.first_name, ' ', p.last_name) AS teacher_name,
  t.room,
  t.status,
  t.lesson_type,
  t.is_recurring
FROM timetable t
JOIN classes c ON t.class_id = c.id
JOIN subjects s ON t.subject_id = s.id
JOIN staff st ON t.teacher_id = st.id
JOIN people p ON st.person_id = p.id
WHERE t.deleted_at IS NULL
ORDER BY t.lesson_date, t.start_time;

-- =============================
-- 14) TRIGGERS FOR AUTOMATIC NOTIFICATIONS
-- =============================

DELIMITER $$

-- Trigger to create notifications when timetable changes
CREATE TRIGGER after_timetable_update
AFTER UPDATE ON timetable
FOR EACH ROW
BEGIN
  -- Only create notifications for significant changes
  IF (OLD.status != NEW.status OR 
      OLD.start_time != NEW.start_time OR 
      OLD.end_time != NEW.end_time OR 
      OLD.room != NEW.room OR
      OLD.lesson_date != NEW.lesson_date) THEN
    
    INSERT INTO teacher_notifications (
      school_id,
      teacher_id,
      title,
      message,
      notification_type,
      related_entity_type,
      related_entity_id,
      scheduled_for,
      status,
      priority
    ) VALUES (
      NEW.school_id,
      NEW.teacher_id,
      'Lesson Schedule Updated',
      CONCAT('Your ', 
        (SELECT name FROM subjects WHERE id = NEW.subject_id),
        ' lesson for ',
        (SELECT name FROM classes WHERE id = NEW.class_id),
        ' has been updated.'
      ),
      'lesson_change',
      'timetable',
      NEW.id,
      NOW(),
      'pending',
      'normal'
    );
    
    -- Log the change
    INSERT INTO timetable_changes_log (
      school_id,
      timetable_id,
      change_type,
      changed_by,
      changed_at
    ) VALUES (
      NEW.school_id,
      NEW.id,
      'updated',
      NEW.updated_by,
      NOW()
    );
  END IF;
END$$

-- Trigger to create lesson reminders
CREATE TRIGGER after_timetable_insert
AFTER INSERT ON timetable
FOR EACH ROW
BEGIN
  DECLARE reminder_time DATETIME;
  DECLARE reminder_minutes INT DEFAULT 15;
  
  -- Get teacher's reminder preference
  SELECT lesson_reminder_minutes INTO reminder_minutes
  FROM teacher_notification_preferences 
  WHERE teacher_id = NEW.teacher_id AND school_id = NEW.school_id
  LIMIT 1;
  
  -- Calculate reminder time
  SET reminder_time = TIMESTAMP(NEW.lesson_date, NEW.start_time) - INTERVAL COALESCE(reminder_minutes, 15) MINUTE;
  
  -- Only create reminder if it's in the future
  IF reminder_time > NOW() THEN
    INSERT INTO teacher_notifications (
      school_id,
      teacher_id,
      title,
      message,
      notification_type,
      related_entity_type,
      related_entity_id,
      scheduled_for,
      status,
      priority
    ) VALUES (
      NEW.school_id,
      NEW.teacher_id,
      'Upcoming Lesson Reminder',
      CONCAT('You have a ', 
        (SELECT name FROM subjects WHERE id = NEW.subject_id),
        ' lesson with ',
        (SELECT name FROM classes WHERE id = NEW.class_id),
        ' starting at ', TIME_FORMAT(NEW.start_time, '%H:%i'),
        CASE WHEN NEW.room IS NOT NULL THEN CONCAT(' in room ', NEW.room) ELSE '' END
      ),
      'lesson_reminder',
      'timetable',
      NEW.id,
      reminder_time,
      'pending',
      'normal'
    );
  END IF;
END$$

DELIMITER ;

-- =============================
-- 15) INDEXES FOR PERFORMANCE
-- =============================

-- Additional performance indexes
CREATE INDEX idx_timetable_composite_1 ON timetable(school_id, teacher_id, lesson_date, status);
CREATE INDEX idx_timetable_composite_2 ON timetable(school_id, class_id, lesson_date, start_time);
CREATE INDEX idx_notifications_teacher_status ON teacher_notifications(teacher_id, status, scheduled_for);
CREATE INDEX idx_changes_log_timetable_date ON timetable_changes_log(timetable_id, changed_at);

-- =============================
-- 16) SAMPLE DATA FOR TESTING
-- =============================

-- Insert default notification preferences for existing teachers
INSERT IGNORE INTO teacher_notification_preferences (teacher_id, school_id)
SELECT id, 1 FROM staff WHERE position LIKE '%teacher%' OR position LIKE '%Teacher%';

-- Insert sample period definitions
INSERT INTO period_definitions (school_id, period_number, period_name, start_time, end_time, period_type) VALUES
(1, 1, 'Period 1', '08:00:00', '08:45:00', 'lesson'),
(1, 2, 'Period 2', '08:45:00', '09:30:00', 'lesson'),
(1, 3, 'Break', '09:30:00', '09:45:00', 'break'),
(1, 4, 'Period 3', '09:45:00', '10:30:00', 'lesson'),
(1, 5, 'Period 4', '10:30:00', '11:15:00', 'lesson'),
(1, 6, 'Period 5', '11:15:00', '12:00:00', 'lesson'),
(1, 7, 'Lunch Break', '12:00:00', '13:00:00', 'lunch'),
(1, 8, 'Period 6', '13:00:00', '13:45:00', 'lesson'),
(1, 9, 'Period 7', '13:45:00', '14:30:00', 'lesson'),
(1, 10, 'Period 8', '14:30:00', '15:15:00', 'lesson');

-- =============================
-- END OF ENHANCED TIMETABLE MODULE
-- =============================

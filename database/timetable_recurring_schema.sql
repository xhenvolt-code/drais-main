-- =============================
-- RECURRING TIMETABLE SCHEMA UPDATES
-- =============================

USE drais_school;

-- Drop existing timetable_exceptions table to avoid inconsistencies
DROP TABLE IF EXISTS timetable_exceptions;

-- Alter existing timetable table to support recurring classes
ALTER TABLE timetable 
ADD COLUMN IF NOT EXISTS recurrence ENUM('none', 'weekly', 'biweekly') DEFAULT 'none' AFTER is_recurring,
ADD COLUMN IF NOT EXISTS start_date DATE DEFAULT NULL AFTER recurrence,
ADD COLUMN IF NOT EXISTS end_date DATE DEFAULT NULL AFTER start_date,
ADD COLUMN IF NOT EXISTS exception_id BIGINT DEFAULT NULL AFTER end_date;

-- Create timetable_exceptions table for handling skipped/rescheduled classes
CREATE TABLE timetable_exceptions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  school_id BIGINT NOT NULL DEFAULT 1,
  timetable_id BIGINT NOT NULL,
  exception_date DATE NOT NULL,
  exception_type ENUM('skip', 'reschedule', 'modify') DEFAULT 'skip',
  
  -- For rescheduled classes
  new_date DATE DEFAULT NULL,
  new_start_time TIME DEFAULT NULL,
  new_end_time TIME DEFAULT NULL,
  new_room VARCHAR(50) DEFAULT NULL,
  new_venue VARCHAR(100) DEFAULT NULL,
  
  -- For modified classes
  modified_title VARCHAR(200) DEFAULT NULL,
  modified_description TEXT DEFAULT NULL,
  modified_lesson_type ENUM('regular', 'revision', 'exam', 'practical', 'field_trip', 'makeup', 'extra') DEFAULT NULL,
  
  reason VARCHAR(255) DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  
  created_by BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_timetable_date (timetable_id, exception_date),
  INDEX idx_school_date (school_id, exception_date),
  
  UNIQUE KEY unique_timetable_exception (timetable_id, exception_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_timetable_recurrence ON timetable(recurrence, start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_timetable_recurring_dates ON timetable(school_id, recurrence, start_date, end_date, day_of_week);

-- Update existing single-instance classes to use the new schema
UPDATE timetable 
SET recurrence = 'none', 
    start_date = lesson_date, 
    end_date = lesson_date 
WHERE recurrence IS NULL OR recurrence = '';

-- Create view for expanded recurring timetable (for reporting/display)
CREATE OR REPLACE VIEW timetable_expanded AS
WITH RECURSIVE date_series AS (
  -- Base case: get all timetable entries with their start dates
  SELECT 
    t.id,
    t.school_id,
    t.teacher_id,
    t.class_id,
    t.subject_id,
    t.start_time,
    t.end_time,
    t.day_of_week,
    t.room,
    t.venue,
    t.lesson_title,
    t.lesson_description,
    t.lesson_type,
    t.status,
    t.recurrence,
    t.start_date as occurrence_date,
    t.end_date,
    t.notes,
    0 as week_offset
  FROM timetable t
  WHERE t.deleted_at IS NULL
    AND t.recurrence != 'none'
    AND t.start_date IS NOT NULL
  
  UNION ALL
  
  -- Recursive case: generate subsequent occurrences
  SELECT 
    ds.id,
    ds.school_id,
    ds.teacher_id,
    ds.class_id,
    ds.subject_id,
    ds.start_time,
    ds.end_time,
    ds.day_of_week,
    ds.room,
    ds.venue,
    ds.lesson_title,
    ds.lesson_description,
    ds.lesson_type,
    ds.status,
    ds.recurrence,
    CASE 
      WHEN ds.recurrence = 'weekly' THEN DATE_ADD(ds.occurrence_date, INTERVAL 1 WEEK)
      WHEN ds.recurrence = 'biweekly' THEN DATE_ADD(ds.occurrence_date, INTERVAL 2 WEEK)
      ELSE ds.occurrence_date
    END as occurrence_date,
    ds.end_date,
    ds.notes,
    ds.week_offset + CASE 
      WHEN ds.recurrence = 'weekly' THEN 1
      WHEN ds.recurrence = 'biweekly' THEN 2
      ELSE 0
    END as week_offset
  FROM date_series ds
  WHERE CASE 
    WHEN ds.recurrence = 'weekly' THEN DATE_ADD(ds.occurrence_date, INTERVAL 1 WEEK)
    WHEN ds.recurrence = 'biweekly' THEN DATE_ADD(ds.occurrence_date, INTERVAL 2 WEEK)
    ELSE ds.occurrence_date
  END <= ds.end_date
    AND ds.week_offset < 52 -- Prevent infinite recursion
)
SELECT 
  ds.*,
  -- Check if this occurrence has an exception
  CASE 
    WHEN ex.id IS NOT NULL THEN 
      CASE ex.exception_type
        WHEN 'skip' THEN 'cancelled'
        WHEN 'reschedule' THEN 'rescheduled'
        WHEN 'modify' THEN 'modified'
        ELSE ds.status
      END
    ELSE ds.status
  END as effective_status,
  ex.id as exception_id,
  ex.exception_type,
  ex.new_date,
  ex.new_start_time,
  ex.new_end_time,
  ex.reason as exception_reason
FROM date_series ds
LEFT JOIN timetable_exceptions ex ON ds.id = ex.timetable_id AND ds.occurrence_date = ex.exception_date
WHERE DAYOFWEEK(ds.occurrence_date) = CASE ds.day_of_week
  WHEN 1 THEN 2  -- Monday
  WHEN 2 THEN 3  -- Tuesday
  WHEN 3 THEN 4  -- Wednesday
  WHEN 4 THEN 5  -- Thursday
  WHEN 5 THEN 6  -- Friday
  WHEN 6 THEN 7  -- Saturday
  WHEN 7 THEN 1  -- Sunday
END

UNION ALL

-- Include single-instance classes (recurrence = 'none')
SELECT 
  t.id,
  t.school_id,
  t.teacher_id,
  t.class_id,
  t.subject_id,
  t.start_time,
  t.end_time,
  t.day_of_week,
  t.room,
  t.venue,
  t.lesson_title,
  t.lesson_description,
  t.lesson_type,
  t.status,
  t.recurrence,
  t.lesson_date as occurrence_date,
  t.lesson_date as end_date,
  t.notes,
  0 as week_offset,
  t.status as effective_status,
  NULL as exception_id,
  NULL as exception_type,
  NULL as new_date,
  NULL as new_start_time,
  NULL as new_end_time,
  NULL as exception_reason
FROM timetable t
WHERE t.deleted_at IS NULL
  AND (t.recurrence = 'none' OR t.recurrence IS NULL)
  AND t.lesson_date IS NOT NULL;

-- =============================
-- END OF RECURRING TIMETABLE SCHEMA
-- =============================

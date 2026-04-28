-- Migration: Add custom_initials column to class_subjects
-- Purpose: Enable persistent, editable teacher initials for reports
-- Date: April 28, 2026

-- Check if column already exists
ALTER TABLE `class_subjects` 
ADD COLUMN IF NOT EXISTS `custom_initials` VARCHAR(10) DEFAULT NULL COMMENT 'Custom teacher initials (overrides auto-generated)';

-- Index for faster queries
ALTER TABLE `class_subjects`
ADD INDEX IF NOT EXISTS `idx_custom_initials` (`custom_initials`);

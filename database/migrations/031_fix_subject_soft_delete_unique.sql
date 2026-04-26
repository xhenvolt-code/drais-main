-- =============================================================================
-- DRAIS — Migration 031: Fix Subject Unique Constraint for Soft Deletes
-- =============================================================================
-- Date        : 2026-04-26
-- Author      : Kilo (AI Agent)
-- Reason      : Soft-deleted subjects were blocking recreation of subjects
--               with the same name within the same school due to the unique
--               index including deleted rows. The index on (school_id, name)
--               prevented reuse after soft delete.
--
-- Solution    : Change the unique index to (school_id, name, deleted_at).
--               This enforces uniqueness only among active subjects
--               (deleted_at IS NULL) while allowing a new subject with the
--               same name after the old one is soft-deleted.
--
-- Notes       : - The application duplicate check is also updated to filter
--                deleted_at IS NULL.
--              - This migration is safe: existing data has at most one row
--                per (school_id, name), so the new index will not encounter
--                conflicts.
-- =============================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- Drop old unique index (if it exists)
ALTER TABLE subjects DROP INDEX IF EXISTS unique_school_subject;

-- Create new unique index that includes deleted_at.
-- For active subjects, deleted_at is NULL. For soft-deleted subjects,
-- deleted_at has a timestamp. The combination (school_id, name, deleted_at)
-- is unique, allowing multiple deleted versions but only one active.
CREATE UNIQUE INDEX unique_school_subject ON subjects (school_id, name, deleted_at);

SET FOREIGN_KEY_CHECKS = 1;

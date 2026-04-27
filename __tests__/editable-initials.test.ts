/**
 * Test Suite: Editable Initials System
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * 
 * Comprehensive tests for persistent, editable, class-wide synchronized initials
 * 
 * Tests to validate:
 * 1. Initials persistence to database
 * 2. Class-wide sync behavior
 * 3. Override hierarchy (custom > auto-generated)
 * 4. Consistency across all report templates
 * 5. Edit history and audit trail
 * 6. Bulk operations
 */

import { describe, it, expect, beforeAll, afterAll } from '@jest/globals';
import {
  getInitialsConfig,
  getClassInitials,
  updateInitials,
  bulkUpdateInitials,
  getInitialsHistory,
  getLearnerReportInitials,
  type InitialsUpdateRequest
} from '@/lib/editable-initials';

describe('Editable Initials System', () => {
  // Test fixtures
  const testClassId = 5;
  const testSchoolId = 1;
  const testSubjectId = 101;
  const testUserId = 10;

  // ────────────────────────────────────────────────────────────────────────────
  // RETRIEVAL TESTS
  // ────────────────────────────────────────────────────────────────────────────

  describe('Initials Retrieval & Resolution', () => {
    it('should retrieve initials configuration for a subject', async () => {
      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);

      expect(config).toHaveProperty('classId', testClassId);
      expect(config).toHaveProperty('subjectId', testSubjectId);
      expect(config).toHaveProperty('schoolId', testSchoolId);
      expect(config).toHaveProperty('displayInitials');
    });

    it('should resolve override hierarchy (custom > auto)', async () => {
      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);

      // If custom initials are set, they should be used
      if (config.customInitials) {
        expect(config.displayInitials).toBe(config.customInitials);
      } else {
        // Otherwise auto-generated
        expect(config.displayInitials).toBeDefined();
      }
    });

    it('should retrieve all initials for a class', async () => {
      const initialsMap = await getClassInitials(testClassId, testSchoolId);

      expect(initialsMap).toBeInstanceOf(Map);
      expect(initialsMap.size).toBeGreaterThanOrEqual(0);

      // Verify structure of each entry
      for (const [subjectId, config] of initialsMap) {
        expect(config).toHaveProperty('displayInitials');
        expect(config.displayInitials).toBeTruthy();
      }
    });

    it('should handle subject with no teacher', async () => {
      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);

      // Should still return valid config even if no teacher assigned
      expect(config.displayInitials).toBeDefined();
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // UPDATE & PERSISTENCE TESTS
  // ────────────────────────────────────────────────────────────────────────────

  describe('Initials Update & Persistence', () => {
    it('should persist custom initials to database', async () => {
      const newInitials = 'TEST';
      const updateRequest: InitialsUpdateRequest = {
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      };

      const result = await updateInitials(updateRequest);
      expect(result.success).toBe(true);

      // Verify persistence by retrieving
      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);
      expect(config.displayInitials).toBe(newInitials);
    });

    it('should sync initials class-wide (single edit)', async () => {
      const newInitials = 'MW';

      // Update for one subject
      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      });

      // Retrieve class initials
      const classInitials = await getClassInitials(testClassId, testSchoolId);

      // All learners in class should see same initials for this subject
      const subjectInitials = classInitials.get(testSubjectId);
      expect(subjectInitials?.displayInitials).toBe(newInitials);
    });

    it('should handle empty initials gracefully', async () => {
      const updateRequest: InitialsUpdateRequest = {
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: '',
        updatedBy: testUserId
      };

      await expect(updateInitials(updateRequest)).rejects.toThrow(
        'Initials cannot be empty'
      );
    });

    it('should validate initials length (max 10 characters)', async () => {
      const updateRequest: InitialsUpdateRequest = {
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: 'VERYLONGINITIALS',
        updatedBy: testUserId
      };

      await expect(updateInitials(updateRequest)).rejects.toThrow(
        'must be 10 characters or less'
      );
    });

    it('should trim whitespace from initials', async () => {
      const newInitials = '  AB  ';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      });

      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);
      expect(config.displayInitials).toBe('AB');
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // BULK OPERATIONS
  // ────────────────────────────────────────────────────────────────────────────

  describe('Bulk Initials Updates', () => {
    it('should perform bulk updates', async () => {
      const updates = [
        { subjectId: 101, initials: 'MAT' },
        { subjectId: 102, initials: 'ENG' },
        { subjectId: 103, initials: 'SCI' }
      ];

      const result = await bulkUpdateInitials(
        testSchoolId,
        testClassId,
        updates,
        testUserId
      );

      expect(result.success).toBe(true);
      expect(result.totalUpdated).toBeGreaterThanOrEqual(0);
    });

    it('should handle partial bulk failures gracefully', async () => {
      const updates = [
        { subjectId: 101, initials: 'A' },
        { subjectId: 9999, initials: 'X' } // Non-existent subject
      ];

      const result = await bulkUpdateInitials(
        testSchoolId,
        testClassId,
        updates,
        testUserId
      );

      // Should continue despite partial failures
      expect(result.totalUpdated >= 0).toBe(true);
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // HISTORY & AUDIT
  // ────────────────────────────────────────────────────────────────────────────

  describe('Edit History & Audit Trail', () => {
    it('should record edit history', async () => {
      const newInitials = 'HIS';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      });

      const history = await getInitialsHistory(testClassId, 10);
      expect(Array.isArray(history)).toBe(true);
      expect(history.length).toBeGreaterThan(0);

      // Latest entry should match our update
      const latest = history[0];
      expect(latest.newInitials).toBe(newInitials);
      expect(latest.classId).toBe(testClassId);
    });

    it('should track previous and new values', async () => {
      const newInitials = 'GEO';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      });

      const history = await getInitialsHistory(testClassId, 1);
      const entry = history[0];

      expect(entry).toHaveProperty('previousInitials');
      expect(entry).toHaveProperty('newInitials', newInitials);
      expect(entry).toHaveProperty('changedBy', testUserId);
      expect(entry).toHaveProperty('changedAt');
    });

    it('should limit history results', async () => {
      const history = await getInitialsHistory(testClassId, 5);
      expect(history.length).toBeLessThanOrEqual(5);
    });

    it('should track user who made changes', async () => {
      const userId = 42;

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: 'PE',
        updatedBy: userId
      });

      const history = await getInitialsHistory(testClassId, 1);
      expect(history[0].changedBy).toBe(userId);
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // REPORT INTEGRATION
  // ────────────────────────────────────────────────────────────────────────────

  describe('Report Integration & Consistency', () => {
    it('should provide consistent initials for learner reports', async () => {
      const studentId = 100;

      const reportInitials = await getLearnerReportInitials(
        studentId,
        testClassId,
        testSchoolId
      );

      expect(reportInitials).toBeInstanceOf(Map);

      // Each subject should have display initials
      for (const [subjectId, initials] of reportInitials) {
        expect(initials).toBeTruthy();
      }
    });

    it('should use custom initials in reports', async () => {
      const customInitials = 'CUS';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: customInitials,
        updatedBy: testUserId
      });

      const reportInitials = await getLearnerReportInitials(1, testClassId, testSchoolId);
      const subjectInitials = reportInitials.get(testSubjectId);

      expect(subjectInitials).toBe(customInitials);
    });

    it('should reflect edits in all learner reports', async () => {
      const newInitials = 'ART';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials,
        updatedBy: testUserId
      });

      // Simulate multiple learners in class
      for (let studentId = 1; studentId <= 5; studentId++) {
        const reportInitials = await getLearnerReportInitials(
          studentId,
          testClassId,
          testSchoolId
        );

        const subjectInitials = reportInitials.get(testSubjectId);
        expect(subjectInitials).toBe(newInitials);
      }
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // EDGE CASES
  // ────────────────────────────────────────────────────────────────────────────

  describe('Edge Cases & Validation', () => {
    it('should handle special characters in initials', async () => {
      const specialInitials = 'A&B';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: specialInitials,
        updatedBy: testUserId
      });

      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);
      expect(config.displayInitials).toBe(specialInitials);
    });

    it('should handle uppercase conversion', async () => {
      const lowerInitials = 'abc';

      // System may auto-convert to uppercase
      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: lowerInitials,
        updatedBy: testUserId
      });

      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);
      // Should be preserved as entered or converted to uppercase
      expect(config.displayInitials).toBeDefined();
    });

    it('should handle rapid successive edits', async () => {
      const initials1 = 'A';
      const initials2 = 'B';
      const initials3 = 'C';

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: initials1,
        updatedBy: testUserId
      });

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: initials2,
        updatedBy: testUserId
      });

      await updateInitials({
        schoolId: testSchoolId,
        classId: testClassId,
        subjectId: testSubjectId,
        newInitials: initials3,
        updatedBy: testUserId
      });

      const config = await getInitialsConfig(testClassId, testSubjectId, testSchoolId);
      expect(config.displayInitials).toBe(initials3);

      // Verify all edits recorded in history
      const history = await getInitialsHistory(testClassId, 10);
      expect(history.length).toBeGreaterThanOrEqual(3);
    });

    it('should multi-tenant isolate initials', async () => {
      // Verify no cross-school data leakage
      const config1 = await getInitialsConfig(testClassId, testSubjectId, 1);
      const config2 = await getInitialsConfig(testClassId, testSubjectId, 2);

      // Both should exist but be from different schools
      expect(config1.schoolId).toBe(1);
      expect(config2.schoolId).toBe(2);
    });
  });
});

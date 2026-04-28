/**
 * Test Suite: Allocation Validation Library
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 *
 * Tests for teacher-class-subject assignment validation logic.
 */

import { describe, it, expect } from '@jest/globals';
import {
  validateAllocationInput,
  generateTeacherInitials,
  resolveDisplayInitials,
} from '@/lib/allocation-validation';

describe('Allocation Validation Library', () => {
  // ────────────────────────────────────────────────────────────────────────────
  // validateAllocationInput
  // ────────────────────────────────────────────────────────────────────────────

  describe('validateAllocationInput', () => {
    it('should accept valid input and return normalized values', () => {
      const result = validateAllocationInput({
        class_id: 1,
        subject_id: 2,
        teacher_id: 5,
        custom_initials: 'HM',
      });

      expect(result.class_id).toBe(1);
      expect(result.subject_id).toBe(2);
      expect(result.teacher_id).toBe(5);
      expect(result.custom_initials).toBe('HM');
    });

    it('should accept null/empty teacher_id', () => {
      const result = validateAllocationInput({
        class_id: 1,
        subject_id: 2,
        teacher_id: null,
      });

      expect(result.teacher_id).toBeNull();
    });

    it('should accept string numbers and convert to number', () => {
      const result = validateAllocationInput({
        class_id: '10',
        subject_id: '20',
        teacher_id: '30',
      });

      expect(result.class_id).toBe(10);
      expect(result.subject_id).toBe(20);
      expect(result.teacher_id).toBe(30);
    });

    it('should trim whitespace from custom_initials', () => {
      const result = validateAllocationInput({
        class_id: 1,
        subject_id: 2,
        custom_initials: '  HM  ',
      });

      expect(result.custom_initials).toBe('HM');
    });

    it('should throw if class_id is missing', () => {
      expect(() => validateAllocationInput({ class_id: '', subject_id: 2 }))
        .toThrow('Valid class ID is required.');
    });

    it('should throw if class_id is NaN', () => {
      expect(() => validateAllocationInput({ class_id: 'abc', subject_id: 2 }))
        .toThrow('Valid class ID is required.');
    });

    it('should throw if subject_id is missing', () => {
      expect(() => validateAllocationInput({ class_id: 1, subject_id: null }))
        .toThrow('Valid subject ID is required.');
    });

    it('should throw if custom_initials exceeds 10 characters', () => {
      const longString = 'ABCDEFGHIJKLMNOP';
      expect(() => validateAllocationInput({
        class_id: 1,
        subject_id: 2,
        custom_initials: longString,
      })).toThrow('Custom initials must be 10 characters or less.');
    });

    it('should accept custom_initials exactly 10 characters', () => {
      const result = validateAllocationInput({
        class_id: 1,
        subject_id: 2,
        custom_initials: 'ABCDEFGHIJ',
      });
      expect(result.custom_initials).toBe('ABCDEFGHIJ');
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // generateTeacherInitials
  // ────────────────────────────────────────────────────────────────────────────

  describe('generateTeacherInitials', () => {
    it('should generate correct initials from full name', () => {
      expect(generateTeacherInitials('Hassan', 'Musa')).toBe('HM');
      expect(generateTeacherInitials('Amina', 'Ali')).toBe('AA');
      expect(generateTeacherInitials('Peter', 'Jones')).toBe('PJ');
    });

    it('should handle lowercase input', () => {
      expect(generateTeacherInitials('hassan', 'musa')).toBe('HM');
    });

    it('should handle leading/trailing spaces', () => {
      expect(generateTeacherInitials('  Hassan  ', '  Musa  ')).toBe('HM');
    });

    it('should return empty string if both names empty', () => {
      expect(generateTeacherInitials('', '')).toBe('');
    });

    it('should return first initial only if last name empty', () => {
      expect(generateTeacherInitials('Hassan', '')).toBe('H');
    });

    it('should return last initial only if first name empty', () => {
      expect(generateTeacherInitials('', 'Musa')).toBe('M');
    });
  });

  // ────────────────────────────────────────────────────────────────────────────
  // resolveDisplayInitials
  // ────────────────────────────────────────────────────────────────────────────

  describe('resolveDisplayInitials', () => {
    it('should prioritize custom_initials over auto-generated', () => {
      const display = resolveDisplayInitials('XY', 'AB', 1);
      expect(display).toBe('XY');
    });

    it('should use auto_generated if no custom_initials and teacher assigned', () => {
      const display = resolveDisplayInitials(null, 'HM', 1);
      expect(display).toBe('HM');
    });

    it('should return N/A if no teacher and no custom initials', () => {
      const display = resolveDisplayInitials(null, undefined, null);
      expect(display).toBe('N/A');
    });

    it('should return ?? if teacher assigned but no name data (unlikely)', () => {
      const display = resolveDisplayInitials(null, '', 1);
      expect(display).toBe('??');
    });
  });
});

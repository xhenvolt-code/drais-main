/**
 * src/lib/drce/totalsCalculator.ts
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 *
 * Utilities for calculating totals and averages in DRCE report tables
 */

import type { DRCEColumn, DRCEDataContext, DRCEResultsTableTotalsConfig } from './schema';
import { resolveBinding } from './bindingResolver';

/**
 * Generate default totals configuration for a results table
 * Automatically detects numeric columns (typically score/marks columns)
 */
export function generateDefaultTotalsConfig(
  columns: DRCEColumn[],
  options?: {
    labelColumnId?: string;
    sumColumnIds?: string[];
    showAverage?: boolean;
  }
): DRCEResultsTableTotalsConfig {
  // If not specified, try to find score/marks column
  let sumColumnIds = options?.sumColumnIds;
  if (!sumColumnIds || sumColumnIds.length === 0) {
    sumColumnIds = columns
      .filter(col => 
        col.id.toLowerCase().includes('score') || 
        col.id.toLowerCase().includes('marks') ||
        col.id.toLowerCase().includes('total') ||
        col.id.toLowerCase().includes('grade_points')
      )
      .map(col => col.id);
  }

  // If no score columns found, use all numeric-looking columns
  if (sumColumnIds.length === 0) {
    sumColumnIds = columns.slice(-2).map(col => col.id); // Last 2 columns typically score/grade
  }

  // Find label column (usually first column like subject_name)
  const labelColumnId = options?.labelColumnId || 
    columns.find(col => col.header.toLowerCase().includes('subject'))?.id ||
    columns[0]?.id ||
    'subject';

  return {
    enabled: true,
    labelColumnId,
    labelText: 'TOTAL',
    sumColumnIds,
    showAverage: options?.showAverage ?? true,
    averageLabelColumnId: labelColumnId,
    averageLabelText: 'AVERAGE',
    rowStyle: {
      fontWeight: 'bold',
      background: 'rgba(0, 0, 0, 0.05)',
    },
  };
}

/**
 * Calculate totals for specified columns in results
 */
export function calculateColumnTotals(
  results: Array<Record<string, any>>,
  sumColumnIds: string[],
  ctx: DRCEDataContext,
): Record<string, number> {
  const totals: Record<string, number> = {};

  sumColumnIds.forEach(colId => {
    let sum = 0;
    let count = 0;

    results.forEach(row => {
      const column = ctx.columns?.find(c => c.id === colId);
      if (column && column.binding) {
        const value = resolveBinding(column.binding, ctx, row);
        const numValue = parseFloat(String(value));
        if (!isNaN(numValue)) {
          sum += numValue;
          count++;
        }
      }
    });

    totals[colId] = count > 0 ? sum : 0;
  });

  return totals;
}

/**
 * Calculate averages for specified columns in results
 */
export function calculateColumnAverages(
  results: Array<Record<string, any>>,
  sumColumnIds: string[],
  ctx: DRCEDataContext,
): Record<string, number> {
  const totals = calculateColumnTotals(results, sumColumnIds, ctx);
  const count = results.length;

  const averages: Record<string, number> = {};
  sumColumnIds.forEach(colId => {
    averages[colId] = count > 0 ? totals[colId] / count : 0;
  });

  return averages;
}

/**
 * Format a number to display with appropriate decimal places
 */
export function formatNumber(value: number, decimalPlaces: number = 2): string {
  if (value % 1 === 0) {
    return String(value); // No decimals if whole number
  }
  return value.toFixed(decimalPlaces);
}

/**
 * Get overall totals and averages summary
 */
export function getReportSummary(
  results: Array<Record<string, any>>,
  sumColumnIds: string[],
  ctx: DRCEDataContext,
): {
  totalScores: Record<string, number>;
  averageScores: Record<string, number>;
  overallTotal: number;
  overallAverage: number;
  subjectCount: number;
} {
  const totalScores = calculateColumnTotals(results, sumColumnIds, ctx);
  const averageScores = calculateColumnAverages(results, sumColumnIds, ctx);

  const overallTotal = Object.values(totalScores).reduce((sum, val) => sum + val, 0);
  const subjectCount = sumColumnIds.length;
  const overallAverage = subjectCount > 0 ? overallTotal / subjectCount : 0;

  return {
    totalScores,
    averageScores,
    overallTotal,
    overallAverage,
    subjectCount,
  };
}

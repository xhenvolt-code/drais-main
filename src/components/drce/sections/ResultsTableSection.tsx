// src/components/drce/sections/ResultsTableSection.tsx
'use client';

import React, { useState } from 'react';
import type { DRCEResultsTableSection, DRCETheme, DRCEDataContext } from '@/lib/drce/schema';
import {
  resolveTableStyle,
  resolveTableHeaderCellStyle,
  resolveTableDataCellStyle,
} from '@/lib/drce/styleResolver';
import { resolveBinding } from '@/lib/drce/bindingResolver';

interface Props {
  section: DRCEResultsTableSection;
  theme: DRCETheme;
  ctx: DRCEDataContext;
  /** Optional callback when an editable cell is changed */
  onCellChange?: (columnId: string, rowIndex: number, newValue: string) => Promise<void>;
}

/**
 * Calculate totals for numeric columns
 */
function calculateTotals(
  results: Array<Record<string, any>>,
  sumColumnIds: string[],
  ctx: DRCEDataContext,
): Record<string, number> {
  const totals: Record<string, number> = {};

  sumColumnIds.forEach(colId => {
    let sum = 0;
    let count = 0;

    results.forEach(row => {
      const columnBinding = ctx.columns?.find(c => c.id === colId)?.binding || '';
      if (columnBinding) {
        const value = resolveBinding(columnBinding, ctx, row);
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
 * Calculate averages for numeric columns
 */
function calculateAverages(
  results: Array<Record<string, any>>,
  sumColumnIds: string[],
  ctx: DRCEDataContext,
): Record<string, number> {
  const totals = calculateTotals(results, sumColumnIds, ctx);
  const count = results.length;

  const averages: Record<string, number> = {};
  sumColumnIds.forEach(colId => {
    averages[colId] = count > 0 ? totals[colId] / count : 0;
  });

  return averages;
}

export function ResultsTableSection({ section, ctx, onCellChange }: Props) {
  const [editingCell, setEditingCell] = useState<{ col: string; row: number } | null>(null);
  const [isSaving, setIsSaving] = useState(false);

  if (!section.visible) return null;

  const language = ctx.language ?? 'en';
  const isRTL = language === 'ar';
  const { style } = section;
  const tableStyle = { 
    ...resolveTableStyle(style), 
    direction: isRTL ? 'rtl' : 'ltr'
  };

  let visibleCols = [...(section.columns || [])]
    .filter(c => c.visible)
    .sort((a, b) => a.order - b.order);

  // Reverse column order for RTL
  if (isRTL) {
    visibleCols = visibleCols.slice().reverse();
  }

  const allResults = ctx.results ?? [];
  const subjectFilter = section.subjectFilter ?? 'all';
  const results = subjectFilter === 'all'
    ? allResults
    : allResults.filter(r =>
        subjectFilter === 'primary'
          ? (r.subjectType ?? 'primary') === 'primary'
          : (r.subjectType ?? 'primary') === 'secondary',
      );

  const totalsConfig = section.totalsConfig;
  const totalsEnabled = totalsConfig?.enabled ?? false;
  const sumColumnIds = totalsConfig?.sumColumnIds ?? [];
  const totals = totalsEnabled ? calculateTotals(results, sumColumnIds, ctx) : {};
  const averages = totalsEnabled && totalsConfig?.showAverage ? calculateAverages(results, sumColumnIds, ctx) : {};

  const handleCellBlur = async (
    e: React.FocusEvent<HTMLTableCellElement>,
    columnId: string,
    rowIndex: number,
  ) => {
    const newValue = e.currentTarget.textContent?.trim() || '';
    if (onCellChange) {
      setIsSaving(true);
      try {
        await onCellChange(columnId, rowIndex, newValue);
      } catch (error) {
        console.error('Failed to save cell change:', error);
      } finally {
        setIsSaving(false);
      }
    }
    setEditingCell(null);
  };

  return (
    <table style={tableStyle}>
      <colgroup>
        {visibleCols.map(col => (
          <col key={col.id} style={{ width: col.width }} />
        ))}
      </colgroup>
      <thead>
        <tr>
          {visibleCols.map(col => (
            <th
              key={col.id}
              style={resolveTableHeaderCellStyle(style, col.align, col.style)}
            >
              {col.header}
            </th>
          ))}
        </tr>
      </thead>
      <tbody>
        {results.map((row, i) => (
          <tr key={i}>
            {visibleCols.map(col => {
              const cellValue = resolveBinding(col.binding, ctx, row as unknown as Record<string, unknown>);
              const isEditable = col.contentEditable === true;
              
              return (
                <td
                  key={col.id}
                  style={{
                    ...resolveTableDataCellStyle(style, col.align, col.style),
                    cursor: isEditable ? 'text' : 'default',
                  }}
                  contentEditable={isEditable}
                  suppressContentEditableWarning={isEditable}
                  onBlur={isEditable ? (e) => handleCellBlur(e, col.id, i) : undefined}
                  onFocus={() => isEditable && setEditingCell({ col: col.id, row: i })}
                >
                  {cellValue}
                </td>
              );
            })}
          </tr>
        ))}
        
        {/* Totals Row */}
        {totalsEnabled && (
          <tr style={{ fontWeight: 'bold', backgroundColor: 'rgba(0, 0, 0, 0.05)' }}>
            {visibleCols.map(col => {
              const isTotalCol = sumColumnIds.includes(col.id);
              const isLabelCol = col.id === totalsConfig?.labelColumnId;
              let cellContent: React.ReactNode = '';

              if (isLabelCol) {
                cellContent = totalsConfig?.labelText ?? 'TOTAL';
              } else if (isTotalCol) {
                const total = totals[col.id];
                cellContent = total !== undefined && total !== null 
                  ? (typeof total === 'number' && total % 1 !== 0 ? total.toFixed(2) : total)
                  : '';
              }

              return (
                <td
                  key={col.id}
                  style={{
                    ...resolveTableDataCellStyle(style, col.align, totalsConfig?.rowStyle),
                    fontWeight: 'bold',
                    backgroundColor: 'rgba(0, 0, 0, 0.05)',
                  }}
                >
                  {cellContent}
                </td>
              );
            })}
          </tr>
        )}

        {/* Average Row */}
        {totalsEnabled && totalsConfig?.showAverage && (
          <tr style={{ fontStyle: 'italic', backgroundColor: 'rgba(0, 0, 0, 0.02)' }}>
            {visibleCols.map(col => {
              const isAverageCol = sumColumnIds.includes(col.id);
              const isLabelCol = col.id === (totalsConfig?.averageLabelColumnId ?? totalsConfig?.labelColumnId);
              let cellContent: React.ReactNode = '';

              if (isLabelCol) {
                cellContent = totalsConfig?.averageLabelText ?? 'AVERAGE';
              } else if (isAverageCol) {
                const average = averages[col.id];
                cellContent = average !== undefined && average !== null 
                  ? (typeof average === 'number' && average % 1 !== 0 ? average.toFixed(2) : average)
                  : '';
              }

              return (
                <td
                  key={col.id}
                  style={{
                    ...resolveTableDataCellStyle(style, col.align, totalsConfig?.rowStyle),
                    fontStyle: 'italic',
                    backgroundColor: 'rgba(0, 0, 0, 0.02)',
                  }}
                >
                  {cellContent}
                </td>
              );
            })}
          </tr>
        )}
      </tbody>
    </table>
  );
}


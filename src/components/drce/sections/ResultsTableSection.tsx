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

export function ResultsTableSection({ section, ctx, onCellChange }: Props) {
  const [editingCell, setEditingCell] = useState<{ col: string; row: number } | null>(null);
  const [isSaving, setIsSaving] = useState(false);

  if (!section.visible) return null;

  const { style } = section;
  const tableStyle = resolveTableStyle(style);

  const visibleCols = [...(section.columns || [])]
    .filter(c => c.visible)
    .sort((a, b) => a.order - b.order);

  const allResults = ctx.results ?? [];
  const subjectFilter = section.subjectFilter ?? 'all';
  const results = subjectFilter === 'all'
    ? allResults
    : allResults.filter(r =>
        subjectFilter === 'primary'
          ? (r.subjectType ?? 'primary') === 'primary'
          : (r.subjectType ?? 'primary') === 'secondary',
      );

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
      </tbody>
    </table>
  );
}


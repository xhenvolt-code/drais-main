// src/components/drce/sections/GradeTableSection.tsx
'use client';

import React from 'react';
import type { DRCEGradeTableSection, DRCETheme, DRCEDataContext } from '@/lib/drce/schema';
import { resolveGradeTableHeaderCellStyle, resolveGradeTableDataCellStyle } from '@/lib/drce/styleResolver';

interface Props {
  section: DRCEGradeTableSection;
  theme: DRCETheme;
  ctx?: DRCEDataContext;
}

// Fallback when no grades are configured
const DEFAULT_ROWS_EN = [
  ['GRADE',       'D1', 'D2', 'C3', 'C4', 'C5', 'C6', 'P7', 'P8', 'F9'],
  ['SCORE RANGE', '90-100', '80-89', '70-79', '60-69', '50-59', '45-49', '40-44', '35-39', '0-34'],
];

const DEFAULT_ROWS_AR = [
  ['التقدير',       'D1', 'D2', 'C3', 'C4', 'C5', 'C6', 'P7', 'P8', 'F9'],
  ['نطاق الدرجات', '90-100', '80-89', '70-79', '60-69', '50-59', '45-49', '40-44', '35-39', '0-34'],
];

export function GradeTableSection({ section, theme, ctx }: Props) {
  if (!section.visible) return null;
  
  const language = ctx?.language ?? 'en';
  const isRTL = language === 'ar';
  const { style } = section;
  const thStyle = resolveGradeTableHeaderCellStyle(style);
  const tdStyle = resolveGradeTableDataCellStyle(style);

  // Use configured grades if present, otherwise fall back to defaults
  const grades = section.grades?.length ? section.grades : null;

  // Only GRADE and SCORE RANGE rows — no REMARKS row
  let rows: string[][] = grades
    ? [
        ['GRADE', ...grades.map(g => g.label)],
        ['SCORE RANGE', ...grades.map(g => `${g.min}${g.min === g.max ? '' : `–${g.max}`}`)],
      ]
    : (language === 'ar' ? DEFAULT_ROWS_AR : DEFAULT_ROWS_EN);

  // Reverse column order for RTL (except keep first column for labels)
  if (isRTL) {
    rows = rows.map(row => [row[0], ...row.slice(1).reverse()]);
  }

  return (
    <table style={{ 
      width: '100%', 
      borderCollapse: 'collapse', 
      fontSize: 10, 
      fontFamily: theme.fontFamily,
      direction: isRTL ? 'rtl' : 'ltr',
    }}>
      <tbody>
        {rows.map((row, ri) => (
          <tr key={ri}>
            {row.map((cell, ci) => (
              <td 
                key={ci} 
                style={{
                  ...(ci === 0 || ri === 0 ? thStyle : tdStyle),
                  textAlign: isRTL ? 'right' : 'left',
                  direction: isRTL ? 'rtl' : 'ltr',
                }}
              >
                {cell}
              </td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
}

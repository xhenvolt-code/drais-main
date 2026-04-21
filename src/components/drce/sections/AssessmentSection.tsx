// src/components/drce/sections/AssessmentSection.tsx
'use client';

import React from 'react';
import type { DRCEAssessmentSection, DRCETheme, DRCEDataContext } from '@/lib/drce/schema';
import { resolveBinding } from '@/lib/drce/bindingResolver';

interface Props {
  section: DRCEAssessmentSection;
  theme: DRCETheme;
  ctx: DRCEDataContext;
}

export function AssessmentSection({ section, theme, ctx }: Props) {
  if (!section.visible) return null;

  const style = section.style as Record<string, unknown>;
  const layout = String(style.layout ?? 'table');

  const visibleFields = [...section.fields]
    .filter(f => f.visible)
    .sort((a, b) => a.order - b.order);

  if (layout === 'flex' || visibleFields.length === 0) {
    // Simple flex fallback
    return (
      <div style={{ display: 'flex', flexWrap: 'wrap', gap: '4px 16px', margin: '6px 0', fontFamily: theme.fontFamily }}>
        {visibleFields.map(field => (
          <div key={field.id} style={{ flex: '1 1 160px', display: 'flex', alignItems: 'baseline', gap: 4 }}>
            <span style={{ color: '#555', fontSize: theme.baseFontSize - 1 }}>{field.label}:</span>
            <span style={{ color: theme.secondaryColor, fontWeight: 'bold', fontSize: theme.baseFontSize }}>
              {resolveBinding(field.binding, ctx)}
            </span>
          </div>
        ))}
      </div>
    );
  }

  // Table layout: first `positionFields` columns = "Position", rest = "Grade Assessment"
  const positionCount = Math.min(Number(style.positionFields ?? 2), visibleFields.length);
  const posFields = visibleFields.slice(0, positionCount);
  const assFields = visibleFields.slice(positionCount);

  const borderColor = String(style.borderColor ?? '#ccc');

  const cell: React.CSSProperties = {
    border: `1px solid ${borderColor}`,
    padding: '2px 8px',
    fontSize: 11,
    fontFamily: theme.fontFamily,
  };
  const headerCell: React.CSSProperties = {
    ...cell,
    background: String(style.headerBackground ?? '#f2f2f2'),
    fontWeight: 'bold',
    textAlign: 'center',
  };
  const labelCell: React.CSSProperties = { ...cell, textAlign: 'center', fontSize: 10, color: '#444' };
  const valueCell: React.CSSProperties = {
    ...cell,
    color: String(style.valueColor ?? theme.secondaryColor),
    fontWeight: 'bold',
    textAlign: 'center',
    fontSize: 12,
  };

  return (
    <table style={{ width: '100%', borderCollapse: 'collapse', margin: '4px 0', fontFamily: theme.fontFamily }}>
      <tbody>
        {/* Header row: Position | Grade Assessment */}
        <tr>
          {posFields.length > 0 && (
            <td style={headerCell} colSpan={posFields.length}>Position</td>
          )}
          {assFields.length > 0 && (
            <td style={headerCell} colSpan={assFields.length}>
              {String(style.assessmentLabel ?? 'Grade Assessment')}
            </td>
          )}
        </tr>
        {/* Label row */}
        <tr>
          {visibleFields.map(f => (
            <td key={f.id} style={labelCell}>{f.label}</td>
          ))}
        </tr>
        {/* Value row */}
        <tr>
          {visibleFields.map(f => (
            <td key={f.id} style={valueCell}>
              {resolveBinding(f.binding, ctx) ?? '—'}
            </td>
          ))}
        </tr>
      </tbody>
    </table>
  );
}


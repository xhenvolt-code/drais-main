// src/components/drce/sections/NextTermBeginsSection.tsx
'use client';

import React from 'react';
import type { DRCENextTermBeginsSection } from '@/lib/drce/schema';

export function NextTermBeginsSection({
  section,
  nextTermBegins
}: {
  section: DRCENextTermBeginsSection;
  nextTermBegins?: string;
}) {
  if (!section.visible) return null;

  const style = section.style;

  // Use custom date, then context-provided date, then fallback
  const fallbackDate = section.content.customDate || nextTermBegins || (() => {
    // This will be set by the report context, but provide defaults for DRCE editor
    const today = new Date();
    const currentYear = today.getFullYear();
    // Default to May 25th of current year or next year if past May
    const may25 = new Date(currentYear, 4, 25); // May is month 4 (0-indexed)
    return may25 < today ? `${currentYear + 1}-05-25` : `${currentYear}-05-25`;
  })();

  const dateText = (() => {
    try {
      // Parse YYYY-MM-DD format from date input
      const date = new Date(fallbackDate);
      if (isNaN(date.getTime())) {
        // Fallback if date parsing fails
        return fallbackDate;
      }
      return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    } catch (error) {
      console.warn('Failed to parse custom date:', fallbackDate);
      return fallbackDate; // Return as-is if parsing fails
    }
  })();
     
  const containerStyle: React.CSSProperties = {
    background: style.background || '#f0f0f0',
    color: style.color || '#000',
    fontSize: style.fontSize || 14,
    fontWeight: style.fontWeight ? parseInt(style.fontWeight.toString()) : 500,
    textAlign: style.textAlign || 'center',
    padding: style.padding || '12px 16px',
    borderRadius: style.borderRadius || 4,
    border: style.borderWidth && style.borderColor 
      ? `${style.borderWidth}px solid ${style.borderColor}` 
      : 'none',
    marginBottom: '12px'
  };

  return (
    <div style={containerStyle}>
      {style.icon && <span style={{ marginRight: '8px' }}>{style.icon}</span>}
      <span>
        {section.content.text}
        {dateText && <> • {dateText}</>}
      </span>
    </div>
  );
}

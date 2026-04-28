// src/components/drce/sections/NextTermBeginsSection.tsx
'use client';

import React from 'react';
import type { DRCENextTermBeginsSection } from '@/lib/drce/schema';

export function NextTermBeginsSection({ section }: { section: DRCENextTermBeginsSection }) {
  if (!section.visible) return null;

  const style = section.style;
  const dateText = section.content.customDate || new Date().toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

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

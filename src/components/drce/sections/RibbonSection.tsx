// src/components/drce/sections/RibbonSection.tsx
'use client';

import React from 'react';
import type { DRCERibbonSection, DRCETheme, DRCEDataContext } from '@/lib/drce/schema';
import { resolveToken } from '@/lib/drce/tokenResolver';

interface Props {
  section: DRCERibbonSection;
  theme: DRCETheme;
  ctx: DRCEDataContext;
}

// 7-sided ribbon: rectangle body + small centred downward arrow at the bottom.
// Exact replica of rpt.html: points="0,5 600,5 600,30 315,30 300,45 285,30 0,30"
function ArrowDownRibbon({ text, style }: { text: string; style: React.CSSProperties }) {
  const bg    = (style.backgroundColor as string) || '#999';
  const color = (style.color as string)           || '#000';
  const fontSize = (style.fontSize as number)     || 12;
  // viewBox 600×50 keeps the same proportions as the original SVG.
  // Text sits in the rectangle (y 0–30); arrow tip reaches y=45.
  return (
    <div style={{ textAlign: 'center', margin: '0 0 4px 0', position: 'relative', height: 46 }}>
      <svg viewBox="0 0 600 50" width="100%" height="46" preserveAspectRatio="none">
        {/* Rectangle (0→30) + small centred arrow (30→45), 30 px wide each side */}
        <polygon
          points="0,0 600,0 600,30 315,30 300,45 285,30 0,30"
          fill={bg}
        />
      </svg>
      {/* Text label sits inside the rectangle portion */}
      <div style={{
        position: 'absolute', top: 0, left: 0, right: 0,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        height: 30, color, fontSize, fontWeight: 'bold',
      }}>
        {text}
      </div>
    </div>
  );
}

function ChevronRibbon({ text, style }: { text: string; style: React.CSSProperties }) {
  const bg = (style.backgroundColor as string) || '#999';
  const color = (style.color as string) || '#000';
  const fontSize = (style.fontSize as number) || 12;
  return (
    <div style={{ position: 'relative', display: 'flex', alignItems: 'center', margin: '2px 0' }}>
      <div style={{
        flex: 1, background: bg, color, fontSize,
        fontWeight: 'bold', padding: '4px 12px 4px 8px',
        clipPath: 'polygon(0 0, calc(100% - 12px) 0, 100% 50%, calc(100% - 12px) 100%, 0 100%)',
      }}>
        {text}
      </div>
    </div>
  );
}

export function RibbonSection({ section, theme, ctx }: Props) {
  if (!section.visible) return null;
  const { style, content } = section;
  const text = resolveToken(content.text, ctx);

  const cssStyle: React.CSSProperties = {
    backgroundColor: style.background ?? theme.accentColor,
    color: style.color ?? '#000',
    fontSize: style.fontSize ?? theme.baseFontSize,
    fontWeight: style.fontWeight ?? 'bold',
    padding: style.padding ?? '4px',
    textAlign: style.textAlign ?? 'center',
  };

  if (content.shape === 'arrow-down') return <ArrowDownRibbon text={text} style={cssStyle} />;
  if (content.shape === 'chevron') return <ChevronRibbon text={text} style={cssStyle} />;
  return <div style={cssStyle}>{text}</div>;
}

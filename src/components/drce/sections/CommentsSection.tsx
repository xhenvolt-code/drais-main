// src/components/drce/sections/CommentsSection.tsx
'use client';

import React from 'react';
import type { DRCECommentsSection, DRCETheme, DRCEDataContext } from '@/lib/drce/schema';
import { resolveCommentRibbonStyle, resolveCommentTextStyle } from '@/lib/drce/styleResolver';
import { resolveBinding } from '@/lib/drce/bindingResolver';

interface Props {
  section: DRCECommentsSection;
  theme: DRCETheme;
  ctx: DRCEDataContext;
}

// Right-pointing arrow label — mirrors rpt.html polygon
function RightArrowLabel({ label, bg, color, fontSize = 10 }: { label: string; bg: string; color: string; fontSize?: number }) {
  return (
    <div style={{ position: 'relative', display: 'inline-flex', alignItems: 'center', minWidth: 140 }}>
      <svg viewBox="0 0 140 24" width="140" height="24" preserveAspectRatio="none" style={{ position: 'absolute', top: 0, left: 0 }}>
        <polygon points="0,0 125,0 140,12 125,24 0,24" fill={bg} />
      </svg>
      <span style={{
        position: 'relative', zIndex: 1, color, fontSize,
        fontWeight: 'bold', padding: '2px 20px 2px 6px', lineHeight: '20px',
      }}>
        {label}
      </span>
    </div>
  );
}

export function CommentsSection({ section, theme, ctx }: Props) {
  if (!section.visible) return null;
  const { style } = section;
  const ribbonStyle = resolveCommentRibbonStyle(style);
  const textStyle = resolveCommentTextStyle(style);

  const visibleItems = [...section.items]
    .filter(i => i.visible)
    .sort((a, b) => a.order - b.order);

  return (
    <div style={{ margin: '6px 0', fontFamily: theme.fontFamily, fontSize: theme.baseFontSize }}>
      {visibleItems.map(item => {
        const value = resolveBinding(item.binding, ctx);
        return (
          <div key={item.id} style={{ ...ribbonStyle, marginBottom: 3 }}>
            <RightArrowLabel
              label={item.label}
              bg={style.ribbonBackground ?? theme.accentColor}
              color={style.ribbonColor ?? '#000'}
              fontSize={style.ribbonFontSize ?? 10}
            />
            <span style={{
              ...textStyle,
              borderBottom: '1.5px dotted #777',
              display: 'inline-block',
              minWidth: 220,
              paddingBottom: 2,
              flex: 1,
            }}>{value || '\u00A0'}</span>
          </div>
        );
      })}
    </div>
  );
}

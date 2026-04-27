// src/components/drce/DRCEDocumentRenderer.tsx
// Renders a full DRCEDocument given data context + school info.
// Used for both live preview in the editor and final print output.
'use client';

import React from 'react';
import { QRCodeSVG } from 'qrcode.react';
import type { DRCEDocument, DRCEDataContext, DRCESection } from '@/lib/drce/schema';
import { resolvePageStyle, resolvePageDimensions } from '@/lib/drce/styleResolver';
import type { DRCERenderContext } from './types';

import { HeaderSection }      from './sections/HeaderSection';
import { BannerSection }      from './sections/BannerSection';
import { StudentInfoSection } from './sections/StudentInfoSection';
import { RibbonSection }      from './sections/RibbonSection';
import { ResultsTableSection } from './sections/ResultsTableSection';
import { AssessmentSection }  from './sections/AssessmentSection';
import { CommentsSection }    from './sections/CommentsSection';
import { GradeTableSection }  from './sections/GradeTableSection';
import { SpacerSection }      from './sections/SpacerSection';
import { DividerSection }     from './sections/DividerSection';

interface Props {
  document: DRCEDocument;
  dataCtx: DRCEDataContext;
  renderCtx: DRCERenderContext;
  /** Optional wrapper className for outer div */
  className?: string;
  /** Called when a section is clicked in editor mode */
  onSectionClick?: (sectionId: string) => void;
  /** ID of the currently selected section (highlights it) */
  selectedSectionId?: string | null;
}

function renderSection(
  section: DRCESection,
  doc: DRCEDocument,
  dataCtx: DRCEDataContext,
  renderCtx: DRCERenderContext,
) {
  const { theme } = doc;
  switch (section.type) {
    case 'header':       return <HeaderSection      key={section.id} section={section} theme={theme} ctx={renderCtx} />;
    case 'banner':       return <BannerSection      key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'student_info': return <StudentInfoSection key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'ribbon':       return <RibbonSection      key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'results_table':return <ResultsTableSection key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'assessment':   return <AssessmentSection  key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'comments':     return <CommentsSection    key={section.id} section={section} theme={theme} ctx={dataCtx} />;
    case 'grade_table':  return <GradeTableSection  key={section.id} section={section} theme={theme} />;
    case 'spacer':       return <SpacerSection      key={section.id} section={section} />;
    case 'divider':      return <DividerSection     key={section.id} section={section} />;
    default:             return null;
  }
}

function getSectionWrapperStyle(section: DRCESection, isSelected: boolean, isInteractive: boolean): React.CSSProperties {
  const sectionStyle = (section as { style?: Record<string, unknown> }).style ?? {};
  const borderWidth = Number(sectionStyle.borderWidth ?? 0);
  const borderStyle = (sectionStyle.borderStyle as string | undefined) ?? 'solid';
  const borderColor = (sectionStyle.borderColor as string | undefined) ?? '#111827';
  const positioning = (sectionStyle.position as string | undefined) ?? 'relative';
  const rotate = Number(sectionStyle.rotation ?? 0);
  const scale = Number(sectionStyle.scale ?? 1);
  const visibility = section.visible ? ((sectionStyle.visibility as string | undefined) ?? 'visible') : 'hidden';

  return {
    width: (sectionStyle.width as string | number | undefined) ?? undefined,
    height: (sectionStyle.height as string | number | undefined) ?? undefined,
    minWidth: (sectionStyle.minWidth as string | number | undefined) ?? undefined,
    minHeight: (sectionStyle.minHeight as string | number | undefined) ?? undefined,
    maxWidth: (sectionStyle.maxWidth as string | number | undefined) ?? undefined,
    maxHeight: (sectionStyle.maxHeight as string | number | undefined) ?? undefined,
    border: (sectionStyle.border as string | undefined) ?? undefined,
    padding: (sectionStyle.padding as string | number | undefined) ?? undefined,
    margin: (sectionStyle.margin as string | number | undefined) ?? undefined,
    marginTop: (sectionStyle.spacingTop as number | undefined) ?? undefined,
    marginBottom: (sectionStyle.spacingBottom as number | undefined) ?? undefined,
    borderWidth: borderWidth || undefined,
    borderStyle: borderWidth ? borderStyle : undefined,
    borderColor: borderWidth ? borderColor : undefined,
    borderRadius: (sectionStyle.borderRadius as number | string | undefined) ?? undefined,
    background: (sectionStyle.background as string | undefined) ?? undefined,
    opacity: Number(sectionStyle.opacity ?? 1),
    transform: `rotate(${rotate}deg) scale(${scale})`,
    transformOrigin: (sectionStyle.transformOrigin as string | undefined) ?? 'center',
    position: (positioning as React.CSSProperties['position']) ?? 'relative',
    left: (sectionStyle.left as number | string | undefined) ?? undefined,
    top: (sectionStyle.top as number | string | undefined) ?? undefined,
    right: (sectionStyle.right as number | string | undefined) ?? undefined,
    bottom: (sectionStyle.bottom as number | string | undefined) ?? undefined,
    zIndex: (sectionStyle.zIndex as number | undefined) ?? undefined,
    visibility: visibility as React.CSSProperties['visibility'],
    display: (sectionStyle.display as React.CSSProperties['display']) ?? undefined,
    alignSelf: (sectionStyle.alignSelf as React.CSSProperties['alignSelf']) ?? undefined,
    cursor: isInteractive ? 'pointer' : undefined,
    outline: isSelected ? '2px solid #6366f1' : undefined,
    outlineOffset: isSelected ? 2 : undefined,
    boxSizing: 'border-box',
    transition: isInteractive ? 'outline 0.1s' : undefined,
  };
}

export function DRCEDocumentRenderer({
  document,
  dataCtx,
  renderCtx,
  className,
  onSectionClick,
  selectedSectionId,
}: Props) {
  const { theme, watermark, sections } = document;
  const pageStyle = resolvePageStyle(theme);
  const { width, minHeight } = resolvePageDimensions(theme);

  const sorted = [...(sections ?? [])].sort((a, b) => a.order - b.order);

  return (
    <div style={{ ...pageStyle, width, minHeight }} className={className}>
      {/* Watermark */}
      {watermark?.enabled && (
        <div
          aria-hidden
          style={{
            position:  'absolute',
            inset:     0,
            display:   'flex',
            alignItems:    watermark.position === 'center' ? 'center' : 'flex-start',
            justifyContent: watermark.position === 'center' ? 'center' : 'flex-start',
            pointerEvents: 'none',
            zIndex: 0,
            overflow: 'hidden',
          }}
        >
          {watermark.type === 'text' ? (
            <span style={{
              color:       watermark.color,
              fontSize:    watermark.fontSize,
              opacity:     watermark.opacity,
              transform:   `rotate(${watermark.rotation}deg)`,
              fontWeight:  'bold',
              userSelect:  'none',
              whiteSpace:  'nowrap',
            }}>
              {watermark.content}
            </span>
          ) : watermark.type === 'qrcode' ? (
            <div style={{ opacity: watermark.opacity, transform: `rotate(${watermark.rotation}deg)` }}>
              <QRCodeSVG
                value={watermark.content || 'https://drais.app'}
                size={watermark.fontSize ?? 120}
              />
            </div>
          ) : watermark.imageUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              src={watermark.imageUrl}
              alt={watermark.content}
              style={{
                opacity:   watermark.opacity,
                transform: `rotate(${watermark.rotation}deg)`,
                maxWidth:  '60%',
                maxHeight: '60%',
              }}
            />
          ) : null}
        </div>
      )}

      {/* Sections */}
      <div style={{ position: 'relative', zIndex: 1 }}>
        {sorted.map(section => {
          const rendered = renderSection(section, document, dataCtx, renderCtx);
          if (!rendered) return null;

          const isSelected = selectedSectionId === section.id;
          return (
            <div
              key={section.id}
              onClick={onSectionClick ? () => onSectionClick(section.id) : undefined}
              style={getSectionWrapperStyle(section, isSelected, Boolean(onSectionClick))}
            >
              {rendered}
            </div>
          );
        })}
      </div>
    </div>
  );
}

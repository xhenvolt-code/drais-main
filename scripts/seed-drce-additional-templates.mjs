#!/usr/bin/env node
/**
 * scripts/seed-drce-additional-templates.mjs
 *
 * Adds 5 additional DRCE templates matching the report selector looks:
 * - Arabic Template
 * - Dual Curriculum Layout
 * - Modern Clean Template
 * - Arabic (Clone)
 * - Modern Traditional
 *
 * Run: node scripts/seed-drce-additional-templates.mjs
 * Safe to re-run — inserts with INSERT IGNORE
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const DEFAULT_WATERMARK = {
  enabled: false,
  type: 'text',
  content: 'CONFIDENTIAL',
  imageUrl: null,
  opacity: 0.08,
  position: 'center',
  rotation: -30,
  fontSize: 72,
  color: '#000000',
  scope: 'page',
};

const DEFAULT_PAGE_BORDER = {
  enabled: false,
  color: '#cccccc',
  width: 1,
  style: 'solid',
  radius: 0,
};

const DEFAULT_GRADE_ROWS = [
  { label: 'D1', min: 90,  max: 100, remark: 'Distinction 1' },
  { label: 'D2', min: 80,  max: 89,  remark: 'Distinction 2' },
  { label: 'C3', min: 70,  max: 79,  remark: 'Credit 3' },
  { label: 'C4', min: 60,  max: 69,  remark: 'Credit 4' },
  { label: 'C5', min: 50,  max: 59,  remark: 'Credit 5' },
  { label: 'C6', min: 45,  max: 49,  remark: 'Credit 6' },
  { label: 'P7', min: 40,  max: 44,  remark: 'Pass 7' },
  { label: 'P8', min: 35,  max: 39,  remark: 'Pass 8' },
  { label: 'F9', min: 0,   max: 34,  remark: 'Fail 9' },
];

// ─── 4. Arabic Template (RTL, same structure as default)

const ARABIC_THEME = {
  primaryColor:   '#0000FF',
  secondaryColor: '#B22222',
  accentColor:    '#999999',
  fontFamily:     'Arial, sans-serif',
  baseFontSize:   12,
  pagePadding:    '16px 18px',
  pageBackground: '#ffffff',
  pageBorder:     DEFAULT_PAGE_BORDER,
  pageSize:       'a4',
  orientation:    'portrait',
};

const ARABIC_TEMPLATE = {
  $schema: 'drce/v1',
  meta: {
    id:           '4',
    name:         'Arabic Template',
    school_id:    null,
    version:      1,
    created_at:   '2026-04-25T00:00:00Z',
    updated_at:   '2026-04-25T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'arabic',
  },
  theme:     ARABIC_THEME,
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'three-column', paddingBottom: 10, borderBottom: '1px solid #eee', opacity: 1, logoWidth: 64, logoHeight: 64 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#0000FF', color: '#ffffff', fontSize: 16,
        fontWeight: 'bold', textAlign: 'center', padding: '8px',
        letterSpacing: '0.1em', textTransform: 'uppercase', borderRadius: 0,
      },
    },
    {
      id: 'section-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'Name',        binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',       binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',        binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: { border: '2px solid #1a4be7', borderRadius: 0, padding: '8px', background: '#f8faff' },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Results', shape: 'flat' },
      style: { background: '#0000FF', color: '#ffffff', fontWeight: 'bold', fontSize: 12, padding: '6px 0', textAlign: 'center' },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '25%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '10%', visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '10%', visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '10%', visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center' },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '25%', visible: true, order: 5, align: 'left' },
        { id: 'col-initials', header: 'Initials', binding: 'result.initials',     width: '12%', visible: true, order: 6, align: 'center', contentEditable: true, contentEditable: true },
      ],
      style: { headerBackground: '#f0f8ff', headerBorder: '1px solid #000', rowBorder: '1px solid #ddd', padding: 4 },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position', binding: 'assessment.classPosition', visible: true, order: 0 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',    visible: true, order: 1 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',      visible: true, order: 2 },
      ],
      style: {},
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'Class teacher comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-head',  label: 'Headteacher comment:',   binding: 'comments.headTeacher',  visible: true, order: 1 },
      ],
      style: { ribbonBackground: '#999999', ribbonColor: '#ffffff', textColor: '#0000FF', textFontStyle: 'italic' },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#f0f8ff', border: '1px solid #000' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── 5. Modern Traditional (Conservative design)

const MODERN_TRADITIONAL = {
  $schema: 'drce/v1',
  meta: {
    id:           '5',
    name:         'Modern Traditional',
    school_id:    null,
    version:      1,
    created_at:   '2026-04-25T00:00:00Z',
    updated_at:   '2026-04-25T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'modern_traditional',
  },
  theme: {
    primaryColor:   '#1F2937',
    secondaryColor: '#DC2626',
    accentColor:    '#6B7280',
    fontFamily:     'Georgia, serif',
    baseFontSize:   11,
    pagePadding:    '20px 24px',
    pageBackground: '#FAFAF9',
    pageBorder:     { enabled: true, color: '#D1D5DB', width: 1, style: 'solid', radius: 2 },
    pageSize:       'a4',
    orientation:    'portrait',
  },
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'centered', paddingBottom: 8, borderBottom: '2px solid #1F2937', opacity: 1, logoWidth: 70, logoHeight: 70 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#1F2937', color: '#ffffff', fontSize: 14,
        fontWeight: 'bold', textAlign: 'center', padding: '10px',
        letterSpacing: '0.15em', textTransform: 'uppercase', borderRadius: 2,
      },
    },
    {
      id: 'section-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'Name',        binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',       binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',        binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: { border: '1px solid #D1D5DB', borderRadius: 2, padding: '12px', background: '#FFFFFF', labelColor: '#374151', valueColor: '#DC2626', valueFontWeight: 'bold' },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Academic Performance', shape: 'flat' },
      style: { background: '#F3F4F6', color: '#1F2937', fontWeight: 'bold', fontSize: 11, padding: '6px 0', textAlign: 'center', borderTop: '1px solid #D1D5DB', borderBottom: '1px solid #D1D5DB' },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '28%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '9%',  visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '9%',  visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '9%',  visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center', style: { fontWeight: 'bold', color: '#DC2626' } },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '27%', visible: true, order: 5, align: 'left' },
        { id: 'col-initials', header: 'الرمز',    binding: 'result.initials',     width: '10%', visible: true, order: 6, align: 'center', contentEditable: true },
      ],
      style: { headerBackground: '#F3F4F6', headerBorder: '1px solid #D1D5DB', rowBorder: '1px solid #E5E7EB', headerFontSize: 10, rowFontSize: 10, padding: 5 },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position', binding: 'assessment.classPosition', visible: true, order: 0 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',    visible: true, order: 1 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',      visible: true, order: 2 },
      ],
      style: { layout: 'horizontal' },
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'Class Teacher Comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos',   label: 'DOS Comment:',           binding: 'comments.dos',          visible: true, order: 1 },
        { id: 'c-head',  label: 'Headteacher Comment:',   binding: 'comments.headTeacher',  visible: true, order: 2 },
      ],
      style: { ribbonBackground: '#F3F4F6', ribbonColor: '#1F2937', textColor: '#374151', textFontStyle: 'normal', borderTop: '1px solid #D1D5DB' },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#F3F4F6', border: '1px solid #D1D5DB' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── 6. Minimal Clean (Very simple, minimalist design)

const MINIMAL_CLEAN = {
  $schema: 'drce/v1',
  meta: {
    id:           '6',
    name:         'Minimal Clean',
    school_id:    null,
    version:      1,
    created_at:   '2026-04-25T00:00:00Z',
    updated_at:   '2026-04-25T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'minimal_clean',
  },
  theme: {
    primaryColor:   '#000000',
    secondaryColor: '#666666',
    accentColor:    '#CCCCCC',
    fontFamily:     'Helvetica, Arial, sans-serif',
    baseFontSize:   10,
    pagePadding:    '12px 16px',
    pageBackground: '#FFFFFF',
    pageBorder:     DEFAULT_PAGE_BORDER,
    pageSize:       'a4',
    orientation:    'portrait',
  },
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'centered', paddingBottom: 4, borderBottom: '1px solid #000', opacity: 1, logoWidth: 50, logoHeight: 50 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#000000', color: '#ffffff', fontSize: 12,
        fontWeight: 'bold', textAlign: 'center', padding: '4px',
        letterSpacing: '0.05em', textTransform: 'uppercase', borderRadius: 0,
      },
    },
    {
      id: 'section-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'Name',        binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',       binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',        binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: { border: '1px solid #000', borderRadius: 0, padding: '6px 8px', background: '#FFFFFF', labelColor: '#000', valueColor: '#000', valueFontWeight: 'normal', valueFontSize: 10 },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Results', shape: 'flat' },
      style: { background: '#FFFFFF', color: '#000000', fontWeight: 'bold', fontSize: 10, padding: '2px 0', textAlign: 'center', borderTop: '1px solid #000', borderBottom: '1px solid #000' },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '30%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '8%',  visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '8%',  visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '8%',  visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '6%',  visible: true, order: 4, align: 'center' },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '32%', visible: true, order: 5, align: 'left' },
        { id: 'col-initials', header: 'Init',     binding: 'result.initials',     width: '8%',  visible: true, order: 6, align: 'center' },
      ],
      style: { headerBackground: '#FFFFFF', headerBorder: '1px solid #000', rowBorder: '1px solid #000', headerFontSize: 9, rowFontSize: 9, padding: 3 },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position', binding: 'assessment.classPosition', visible: true, order: 0 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',    visible: true, order: 1 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',      visible: true, order: 2 },
      ],
      style: {},
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'Class Teacher:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-head',  label: 'Headteacher:',   binding: 'comments.headTeacher',  visible: true, order: 1 },
      ],
      style: { ribbonBackground: '#FFFFFF', ribbonColor: '#000000', textColor: '#000000', textFontStyle: 'normal', borderTop: '1px solid #000' },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#FFFFFF', border: '1px solid #000' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── 7. Professional Business (Corporate style)

const PROFESSIONAL_BUSINESS = {
  $schema: 'drce/v1',
  meta: {
    id:           '7',
    name:         'Professional Business',
    school_id:    null,
    version:      1,
    created_at:   '2026-04-25T00:00:00Z',
    updated_at:   '2026-04-25T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'professional_business',
  },
  theme: {
    primaryColor:   '#003D7A',
    secondaryColor: '#2E5090',
    accentColor:    '#666666',
    fontFamily:     'Calibri, Arial, sans-serif',
    baseFontSize:   11,
    pagePadding:    '16px 20px',
    pageBackground: '#FFFFFF',
    pageBorder:     { enabled: false, color: '#003D7A', width: 2, style: 'solid', radius: 0 },
    pageSize:       'a4',
    orientation:    'portrait',
  },
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'three-column', paddingBottom: 12, borderBottom: '3px solid #003D7A', opacity: 1, logoWidth: 66, logoHeight: 66 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#003D7A', color: '#ffffff', fontSize: 15,
        fontWeight: 'bold', textAlign: 'center', padding: '8px 12px',
        letterSpacing: '0.1em', textTransform: 'uppercase', borderRadius: 0,
      },
    },
    {
      id: 'section-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'Name',        binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',       binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',        binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: { border: '1px solid #003D7A', borderRadius: 0, padding: '10px 12px', background: '#F0F4F8', labelColor: '#003D7A', valueColor: '#2E5090', valueFontWeight: 'bold', valueFontSize: 12 },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Academic Results', shape: 'flat' },
      style: { background: '#003D7A', color: '#ffffff', fontWeight: 'bold', fontSize: 12, padding: '5px 0', textAlign: 'center' },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '26%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '9%',  visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '9%',  visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '9%',  visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center', style: { fontWeight: 'bold', color: '#2E5090' } },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '27%', visible: true, order: 5, align: 'left' },
        { id: 'col-initials', header: 'Initials', binding: 'result.initials',     width: '12%', visible: true, order: 6, align: 'center' },
      ],
      style: { headerBackground: '#003D7A', headerBorder: '1px solid #003D7A', headerColor: '#FFFFFF', rowBorder: '1px solid #B0B8C8', headerFontSize: 11, rowFontSize: 11, padding: 5 },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position', binding: 'assessment.classPosition', visible: true, order: 0 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',    visible: true, order: 1 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',      visible: true, order: 2 },
      ],
      style: { border: '1px solid #B0B8C8', padding: '8px 12px' },
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'Class Teacher Comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos',   label: 'DOS Comment:',           binding: 'comments.dos',          visible: true, order: 1 },
        { id: 'c-head',  label: 'Headteacher Comment:',   binding: 'comments.headTeacher',  visible: true, order: 2 },
      ],
      style: { ribbonBackground: '#003D7A', ribbonColor: '#ffffff', textColor: '#2E5090', textFontStyle: 'normal', borderTop: '2px solid #003D7A', paddingTop: '12px', marginTop: '20px' },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#003D7A', headerColor: '#FFFFFF', border: '1px solid #003D7A' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── Main

async function main() {
  const conn = await mysql.createConnection({
    host:     process.env.TIDB_HOST     || process.env.DB_HOST,
    port:     Number(process.env.TIDB_PORT || process.env.DB_PORT || 4000),
    user:     process.env.TIDB_USER     || process.env.DB_USER,
    password: process.env.TIDB_PASSWORD || process.env.DB_PASSWORD,
    database: process.env.TIDB_DB       || process.env.TIDB_DATABASE || process.env.DB_NAME,
    ssl:      process.env.TIDB_HOST
      ? { rejectUnauthorized: true, minVersion: 'TLSv1.2' }
      : undefined,
  });

  try {
    console.log('Seeding additional DRCE templates...\n');

    const templates = [
      { template: ARABIC_TEMPLATE, name: 'Arabic Template' },
      { template: MODERN_TRADITIONAL, name: 'Modern Traditional' },
      { template: MINIMAL_CLEAN, name: 'Minimal Clean' },
      { template: PROFESSIONAL_BUSINESS, name: 'Professional Business' },
    ];

    for (const { template, name } of templates) {
      const schemaJson = JSON.stringify(template);
      const [result] = await conn.execute(
        `INSERT INTO dvcf_documents 
           (school_id, document_type, name, description, schema_json, schema_version, is_default, template_key)
         VALUES (?, ?, ?, ?, ?, 1, 0, ?)
         ON DUPLICATE KEY UPDATE 
           schema_json = VALUES(schema_json), 
           updated_at = NOW()`,
        [null, 'report_card', template.meta.name, `Report template: ${name}`, schemaJson, template.meta.template_key],
      );

      if (result.affectedRows > 0) {
        console.log(`✓ Added/Updated "${name}" (template_key=${template.meta.template_key})`);
      }
    }

    console.log('\n✓ Additional templates seeding complete!');
  } catch (err) {
    console.error('✗ Error:', err.message);
    process.exit(1);
  } finally {
    await conn.end();
  }
}

main();

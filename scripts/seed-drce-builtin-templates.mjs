#!/usr/bin/env node
/**
 * scripts/seed-drce-builtin-templates.mjs
 *
 * Seeds/updates the three built-in DRCE templates (DRAIS Default, Modern Clean, Northgate Classic)
 * with their complete schema_json from src/lib/drce/defaults.ts
 *
 * Run: node scripts/seed-drce-builtin-templates.mjs
 * Safe to re-run — updates existing templates
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

// Grade scale shared across DRAIS/Modern
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

const DEFAULT_WATERMARK = {
  enabled:   false,
  type:      'text',
  content:   'CONFIDENTIAL',
  imageUrl:  null,
  opacity:   0.08,
  position:  'center',
  rotation:  -30,
  fontSize:  72,
  color:     '#000000',
  scope:     'page',
};

const DEFAULT_PAGE_BORDER = {
  enabled: false,
  color:   '#cccccc',
  width:   1,
  style:   'solid',
  radius:  0,
};

// ─── 1. DRAIS Default Template ──────────────────────────────────────────────

const DRAIS_THEME = {
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

const DRAIS_DEFAULT = {
  $schema: 'drce/v1',
  meta: {
    id:           '1',
    name:         'Default Template',
    school_id:    null,
    version:      1,
    created_at:   '2026-01-01T00:00:00Z',
    updated_at:   '2026-01-01T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   true,
    template_key: 'drais_default',
  },
  theme:     DRAIS_THEME,
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
        { id: 'f-gender', label: 'Sex',          binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',        binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',       binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.',  binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',         binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: { border: '1px solid #ddd', borderRadius: 0, padding: '8px', background: '#f9f9f9' },
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
        { id: 'col-initials', header: 'Initials', binding: 'result.initials',     width: '12%', visible: true, order: 6, align: 'center' },
      ],
      style: { headerBackground: '#e8e8e8', headerBorder: '1px solid #000', rowBorder: '1px solid #ddd', padding: 4 },
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
      style: { ribbonBackground: '#e8e8e8', ribbonColor: '#000000', textColor: '#0000FF', textFontStyle: 'italic' },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#e8e8e8', border: '1px solid #000' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── 2. Modern Clean Template ─────────────────────────────────────────────────

const MODERN_THEME = {
  primaryColor:   '#0d9488',
  secondaryColor: '#059669',
  accentColor:    '#10b981',
  fontFamily:     'Inter, sans-serif',
  baseFontSize:   11,
  pagePadding:    '18px 20px',
  pageBackground: '#ffffff',
  pageBorder:     { ...DEFAULT_PAGE_BORDER, enabled: false },
  pageSize:       'a4',
  orientation:    'portrait',
};

const MODERN_CLEAN = {
  $schema: 'drce/v1',
  meta: {
    id:           '2',
    name:         'Modern Clean',
    school_id:    null,
    version:      1,
    created_at:   '2026-01-01T00:00:00Z',
    updated_at:   '2026-01-01T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'modern_clean',
  },
  theme:     MODERN_THEME,
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'three-column', paddingBottom: 12, borderBottom: '2px solid #0d9488', opacity: 1, logoWidth: 64, logoHeight: 64 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#0d9488', color: '#ffffff', fontSize: 15,
        fontWeight: 'bold', textAlign: 'center', padding: '10px',
        letterSpacing: '0.08em', textTransform: 'uppercase', borderRadius: 4,
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
      style: {
        border: '1px solid #d1fae5', borderRadius: 4, padding: '10px',
        background: '#f0fdf4', labelColor: '#047857',
        valueColor: '#064e3b', valueFontWeight: 'bold', valueFontSize: 13,
      },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Academic Performance', shape: 'flat' },
      style: {
        background: '#d1fae5', color: '#065f46', fontWeight: 'bold',
        fontSize: 12, padding: '6px 0', textAlign: 'center',
      },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '30%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '8%',  visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '8%',  visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '8%',  visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center', style: { color: '#0d9488', fontWeight: 'bold' } },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '30%', visible: true, order: 5, align: 'left', style: { fontStyle: 'italic', color: '#065f46' } },
        { id: 'col-initials', header: 'Initials', binding: 'result.initials',     width: '8%',  visible: true, order: 6, align: 'center' },
      ],
      style: {
        headerBackground: '#d1fae5', headerBorder: '1px solid #6ee7b7',
        rowBorder: '1px solid #d1fae5', headerFontSize: 11, rowFontSize: 11,
        headerTextTransform: 'uppercase', padding: 5,
      },
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
      style: {
        ribbonBackground: '#d1fae5', ribbonColor: '#065f46',
        textColor: '#047857', textFontStyle: 'italic',
      },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#d1fae5', border: '1px solid #6ee7b7' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── 3. Northgate Classic Template ──────────────────────────────────────────

const NORTHGATE_THEME = {
  primaryColor:   '#0000FF',
  secondaryColor: '#B22222',
  accentColor:    '#999999',
  fontFamily:     'Arial, sans-serif',
  baseFontSize:   11,
  pagePadding:    '14px 16px',
  pageBackground: '#ffffff',
  pageBorder:     DEFAULT_PAGE_BORDER,
  pageSize:       'a4',
  orientation:    'portrait',
};

const NORTHGATE_CLASSIC = {
  $schema: 'drce/v1',
  meta: {
    id:           '3',
    name:         'Northgate Classic',
    school_id:    null,
    version:      1,
    created_at:   '2026-01-01T00:00:00Z',
    updated_at:   '2026-01-01T00:00:00Z',
    report_type:  'end_of_term',
    is_default:   false,
    template_key: 'northgate_classic',
  },
  theme:     NORTHGATE_THEME,
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: { layout: 'three-column', paddingBottom: 8, borderBottom: '1px solid #ddd', opacity: 1, logoWidth: 60, logoHeight: 60 },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#0000FF', color: '#ffffff', fontSize: 14,
        fontWeight: 'bold', textAlign: 'center', padding: '6px',
        letterSpacing: '0.12em', textTransform: 'uppercase', borderRadius: 0,
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
      style: { border: '1px solid #999', borderRadius: 0, padding: '4px 6px', background: '#ffffff' },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Academic Results', shape: 'flat' },
      style: { background: '#B22222', color: '#ffffff', fontWeight: 'bold', fontSize: 11, padding: '4px 0', textAlign: 'center' },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'Subject',  binding: 'result.subjectName',  width: '30%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid',      header: 'MT',       binding: 'result.midTermScore', width: '10%', visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'EOT',      binding: 'result.endTermScore', width: '10%', visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'Total',    binding: 'result.total',        width: '10%', visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center' },
        { id: 'col-comment',  header: 'Comment',  binding: 'result.comment',      width: '22%', visible: true, order: 5, align: 'left' },
        { id: 'col-initials', header: 'Init',     binding: 'result.initials',     width: '10%', visible: true, order: 6, align: 'center' },
      ],
      style: { headerBackground: '#e8e8e8', headerBorder: '1px solid #333', rowBorder: '1px solid #ddd', padding: 3 },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position',  binding: 'assessment.classPosition',  visible: true, order: 0 },
        { id: 'a-stream-pos', label: 'Stream Position', binding: 'assessment.streamPosition', visible: true, order: 1 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',     visible: true, order: 2 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',       visible: true, order: 3 },
      ],
      style: {},
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'Class teacher comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos',   label: 'DOS Comment:',           binding: 'comments.dos',          visible: true, order: 1 },
        { id: 'c-head',  label: 'Headteacher comment:',   binding: 'comments.headTeacher',  visible: true, order: 2 },
      ],
      style: {
        ribbonBackground: '#dddddd', ribbonColor: '#000000',
        textColor: '#0000FF', textFontStyle: 'italic',
      },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#f2f2f2', border: '1px solid #000' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── Main ──────────────────────────────────────────────────────────────────

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
    console.log('Seeding DRCE built-in templates...\n');

    const templates = [
      { template: DRAIS_DEFAULT, name: 'DRAIS Default' },
      { template: MODERN_CLEAN, name: 'Modern Clean' },
      { template: NORTHGATE_CLASSIC, name: 'Northgate Classic' },
    ];

    for (const { template, name } of templates) {
      const schemaJson = JSON.stringify(template);
      const [result] = await conn.execute(
        `UPDATE dvcf_documents 
         SET schema_json = ?, schema_version = 1, updated_at = NOW() 
         WHERE id = ? AND template_key = ?`,
        [schemaJson, template.meta.id, template.meta.template_key],
      );

      if (result.affectedRows > 0) {
        console.log(`✓ Updated "${name}" (id=${template.meta.id})`);
      } else {
        console.log(`✗ Failed to update "${name}" — record not found`);
      }
    }

    console.log('\n✓ Seeding complete!');
  } catch (err) {
    console.error('✗ Error:', err.message);
    process.exit(1);
  } finally {
    await conn.end();
  }
}

main();

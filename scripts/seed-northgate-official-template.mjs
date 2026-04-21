#!/usr/bin/env node
/**
 * scripts/seed-northgate-official-template.mjs
 *
 * Inserts the Northgate Official template (exact rpt.html replica) into
 * dvcf_documents with school_id = 6 (Northgate School only).
 *
 * Run: node scripts/seed-northgate-official-template.mjs
 * Safe to re-run — skips if template_key='northgate_official' already exists
 * for school_id = 6.
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const NORTHGATE_SCHOOL_ID = 6;
const TEMPLATE_KEY        = 'northgate_official';

// ─── Grade rows (Northgate-specific boundaries from rpt.html) ─────────────────
const NORTHGATE_GRADE_ROWS = [
  { label: 'D1', min: 90, max: 100, remark: 'Distinction 1' },
  { label: 'D2', min: 80, max: 89,  remark: 'Distinction 2' },
  { label: 'C3', min: 70, max: 79,  remark: 'Credit 3' },
  { label: 'C4', min: 60, max: 69,  remark: 'Credit 4' },
  { label: 'C5', min: 55, max: 59,  remark: 'Credit 5' },
  { label: 'C6', min: 50, max: 54,  remark: 'Credit 6' },
  { label: 'P7', min: 45, max: 49,  remark: 'Pass 7' },
  { label: 'P8', min: 40, max: 44,  remark: 'Pass 8' },
  { label: 'F9', min: 0,  max: 39,  remark: 'Fail 9' },
];

// ─── Shared column definition (EOT-only, no MT) ───────────────────────────────
function makeColumns(prefix) {
  return [
    { id: `${prefix}-col-subject`,  header: 'Subject',  binding: 'result.subjectName',  width: '25%', visible: true, order: 0, align: 'left'   },
    { id: `${prefix}-col-eot`,      header: 'EOT',      binding: 'result.endTermScore', width: '10%', visible: true, order: 1, align: 'center' },
    { id: `${prefix}-col-total`,    header: 'Total',    binding: 'result.total',        width: '10%', visible: true, order: 2, align: 'center' },
    { id: `${prefix}-col-grade`,    header: 'Grade',    binding: 'result.grade',        width: '8%',  visible: true, order: 3, align: 'center', style: { color: '#B22222' } },
    { id: `${prefix}-col-comment`,  header: 'Comment',  binding: 'result.comment',      width: '37%', visible: true, order: 4, align: 'left',   style: { fontStyle: 'italic', color: '#0000FF', fontSize: 11 } },
    { id: `${prefix}-col-initials`, header: 'Initials', binding: 'result.initials',     width: '10%', visible: true, order: 5, align: 'center', style: { color: '#0000FF', fontWeight: 'bold' } },
  ];
}

const TABLE_STYLE = {
  headerBackground: '#f2f2f2', headerBorder: '1px solid #333',
  rowBorder: '1px solid #333', headerFontSize: 11, rowFontSize: 11,
  headerTextTransform: 'uppercase', padding: 4,
};

// ─── Full DRCE document (mirrors rpt.html exactly) ────────────────────────────
const document = {
  $schema:  'drce/v1',
  meta: {
    id:           '0',
    name:         'Northgate Official',
    school_id:    NORTHGATE_SCHOOL_ID,
    version:      1,
    created_at:   new Date().toISOString(),
    updated_at:   new Date().toISOString(),
    report_type:  'mid_term',
    is_default:   false,
    template_key: TEMPLATE_KEY,
  },
  theme: {
    primaryColor:   '#0000FF',
    secondaryColor: '#B22222',
    accentColor:    '#999999',
    fontFamily:     'Arial, sans-serif',
    baseFontSize:   12,
    pagePadding:    '10px 10px',
    pageBackground: '#ffffff',
    pageBorder:     { enabled: true, color: '#cccccc', width: 1, style: 'solid', radius: 0 },
    pageSize:       'a4',
    orientation:    'portrait',
  },
  watermark: {
    enabled: false, type: 'text', content: 'CONFIDENTIAL', imageUrl: null,
    opacity: 0.08, position: 'center', rotation: -30, fontSize: 72,
    color: '#000000', scope: 'page',
  },
  sections: [
    // 1 — Header
    {
      id: 'ng-header', type: 'header', visible: true, order: 0,
      style: { layout: 'three-column', paddingBottom: 5, borderBottom: 'none', opacity: 1, logoWidth: 80, logoHeight: 80 },
    },
    // 2 — Blue title banner
    {
      id: 'ng-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#0000FF', color: '#ffffff', fontSize: 14,
        fontWeight: 'bold', textAlign: 'center', padding: '5px',
        letterSpacing: '0.12em', textTransform: 'uppercase', borderRadius: 0,
      },
    },
    // 3 — Student info
    {
      id: 'ng-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'Name',       binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'Class',       binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'Term',        binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: {
        border: '1px dashed #999', borderRadius: 0, padding: '4px 8px',
        background: '#ffffff', labelColor: '#555555',
        valueColor: '#B22222', valueFontWeight: 'bold', valueFontSize: 14,
      },
    },
    // 4 — Ribbon: Principal Subjects
    {
      id: 'ng-ribbon-principal', type: 'ribbon', visible: true, order: 3,
      content: { text: 'Principal Subjects Comprising the General Assessment', shape: 'arrow-down' },
      style: { background: '#999999', color: '#000000', fontWeight: 'bold', fontSize: 12, padding: '4px 0', textAlign: 'center' },
    },
    // 5 — Principal results table
    {
      id: 'ng-results-principal', type: 'results_table', visible: true, order: 4,
      columns: makeColumns('p'),
      style: TABLE_STYLE,
    },
    // 6 — Ribbon: Other Subjects
    {
      id: 'ng-ribbon-other', type: 'ribbon', visible: true, order: 5,
      content: { text: 'Other subjects (Not part of Assessment)', shape: 'arrow-down' },
      style: { background: '#999999', color: '#000000', fontWeight: 'bold', fontSize: 12, padding: '4px 0', textAlign: 'center' },
    },
    // 7 — Other subjects table
    {
      id: 'ng-results-other', type: 'results_table', visible: true, order: 6,
      columns: makeColumns('o'),
      style: TABLE_STYLE,
    },
    // 8 — Position / Assessment
    {
      id: 'ng-assessment', type: 'assessment', visible: true, order: 7,
      fields: [
        { id: 'a-class-pos',  label: 'Class Position',  binding: 'assessment.classPosition',  visible: true, order: 0 },
        { id: 'a-stream-pos', label: 'Stream Position', binding: 'assessment.streamPosition', visible: true, order: 1 },
        { id: 'a-aggregates', label: 'Aggregates',      binding: 'assessment.aggregates',     visible: true, order: 2 },
        { id: 'a-division',   label: 'Division',        binding: 'assessment.division',       visible: true, order: 3 },
      ],
      style: {},
    },
    // 9 — Comments
    {
      id: 'ng-comments', type: 'comments', visible: true, order: 8,
      items: [
        { id: 'c-class', label: 'Class teacher comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos',   label: 'DOS Comment:',           binding: 'comments.dos',          visible: true, order: 1 },
        { id: 'c-head',  label: 'Headteacher comment:',   binding: 'comments.headTeacher',  visible: true, order: 2 },
      ],
      style: { ribbonBackground: '#dddddd', ribbonColor: '#000000', textColor: '#0000FF', textFontStyle: 'italic' },
    },
    // 10 — Grade scale (Northgate boundaries)
    {
      id: 'ng-grade-table', type: 'grade_table', visible: true, order: 9,
      style: { headerBackground: '#f2f2f2', border: '1px solid #000' },
      grades: NORTHGATE_GRADE_ROWS,
    },
  ],
  shapes: [],
};

// ─── Main ─────────────────────────────────────────────────────────────────────
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
    // Idempotency: skip if already exists
    const [rows] = await conn.execute(
      `SELECT id FROM dvcf_documents WHERE template_key = ? AND school_id = ? LIMIT 1`,
      [TEMPLATE_KEY, NORTHGATE_SCHOOL_ID],
    );

    if (rows.length > 0) {
      console.log(`✓ Template '${TEMPLATE_KEY}' already exists for school_id=${NORTHGATE_SCHOOL_ID} (id=${rows[0].id}). Nothing to do.`);
      return;
    }

    const schemaJson = JSON.stringify(document);

    const [result] = await conn.execute(
      `INSERT INTO dvcf_documents
         (school_id, document_type, name, description, schema_json, schema_version, is_default, template_key)
       VALUES (?, 'report_card', ?, 'Exact replica of rpt.html — Northgate School only', ?, 1, 0, ?)`,
      [NORTHGATE_SCHOOL_ID, document.meta.name, schemaJson, TEMPLATE_KEY],
    );

    console.log(`✓ Inserted '${document.meta.name}' with id=${result.insertId} for school_id=${NORTHGATE_SCHOOL_ID}`);
    console.log('  This template is visible ONLY to Northgate School users.');
  } finally {
    await conn.end();
  }
}

main().catch(err => {
  console.error('✗ Seed failed:', err.message);
  process.exit(1);
});

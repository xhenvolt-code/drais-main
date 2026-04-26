#!/usr/bin/env node

/**
 * scripts/seed-drce-arabic-clone.mjs
 *
 * Seeds the Arabic Clone DRCE template to dvcf_documents table.
 * This is a right-to-left Arabic variant with distinct styling.
 * Matches the 'arabic-clone' option visible in academics/reports.
 *
 * Run: node scripts/seed-drce-arabic-clone.mjs
 */

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: join(__dirname, '..', '.env.local') });

const DEFAULT_WATERMARK = {
  enabled: false,
  type: 'text',
  content: 'مجهول',
  imageUrl: null,
  opacity: 0.08,
  position: 'center',
  rotation: -30,
  fontSize: 72,
  color: '#000000',
  scope: 'page',
};

const DEFAULT_GRADE_ROWS = [
  { label: 'د1', min: 90, max: 100, remark: 'تميز جداً' },
  { label: 'د2', min: 80, max: 89,  remark: 'تميز' },
  { label: 'م3', min: 70, max: 79,  remark: 'جيد جداً' },
  { label: 'م4', min: 60, max: 69,  remark: 'جيد' },
  { label: 'م5', min: 50, max: 59,  remark: 'متوسط' },
  { label: 'م6', min: 45, max: 49,  remark: 'ضعيف' },
  { label: 'ر7', min: 40, max: 44,  remark: 'مقبول' },
  { label: 'ر8', min: 35, max: 39,  remark: 'راسب' },
  { label: 'ر9', min: 0,  max: 34,  remark: 'راسب جداً' },
];

const ARABIC_CLONE_TEMPLATE = {
  $schema: 'drce/v1',
  meta: {
    id: '9',
    name: 'Arabic Clone',
    school_id: null,
    version: 1,
    created_at: '2026-01-01T00:00:00Z',
    updated_at: '2026-01-01T00:00:00Z',
    report_type: 'end_of_term',
    is_default: false,
    template_key: 'arabic-clone',
  },
  theme: {
    primaryColor:   '#006633',
    secondaryColor: '#B22222',
    accentColor:    '#D4AF37',
    fontFamily:     'Traditional Arabic, Arial, sans-serif',
    baseFontSize:   12,
    pagePadding:    '16px 18px',
    pageBackground: '#ffffff',
    pageBorder: { enabled: false, color: '#cccccc', width: 1, style: 'solid', radius: 0 },
    pageSize: 'a4',
    orientation: 'portrait',
  },
  watermark: DEFAULT_WATERMARK,
  sections: [
    {
      id: 'section-header', type: 'header', visible: true, order: 0,
      style: {
        layout: 'three-column',
        paddingBottom: 12,
        borderBottom: '2px solid #006633',
        opacity: 1,
        logoWidth: 70,
        logoHeight: 70,
        showLogo: true,
        showName: true,
        showArabicName: true,
        showAddress: true,
        showContact: true,
        showCentreNo: true,
        showRegistrationNo: true,
        gap: 16,
      },
    },
    {
      id: 'section-banner', type: 'banner', visible: true, order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#006633',
        color: '#ffffff',
        fontSize: 16,
        fontWeight: 'bold',
        textAlign: 'right',
        padding: '10px',
        letterSpacing: '0.1em',
        textTransform: 'uppercase',
        borderRadius: 4,
      },
    },
    {
      id: 'section-student-info', type: 'student_info', visible: true, order: 2,
      fields: [
        { id: 'f-name',   label: 'الاسم',        binding: 'student.fullName',    visible: true, order: 0 },
        { id: 'f-gender', label: 'الجنس',         binding: 'student.gender',      visible: true, order: 1 },
        { id: 'f-class',  label: 'الصف',         binding: 'student.className',   visible: true, order: 2 },
        { id: 'f-stream', label: 'المجموعة',      binding: 'student.streamName',  visible: true, order: 3 },
        { id: 'f-admno',  label: 'رقم القيد',     binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term',   label: 'الفصل',         binding: 'meta.term',           visible: true, order: 5 },
      ],
      style: {
        border: '2px solid #006633',
        borderRadius: 8,
        padding: '12px',
        background: '#f8fbf8',
        labelColor: '#006633',
        valueColor: '#B22222',
        valueFontWeight: 'bold',
        valueFontSize: 14,
        showBarcode: true,
        showPhoto: true,
        fieldsPerRow: 3,
      },
    },
    {
      id: 'section-ribbon-1', type: 'ribbon', visible: true, order: 3,
      content: { text: 'النتائج الأكاديمية', shape: 'arrow-down' },
      style: {
        background: '#D4AF37',
        color: '#006633',
        fontWeight: 'bold',
        fontSize: 12,
        padding: '6px 0',
        textAlign: 'center',
      },
    },
    {
      id: 'section-results', type: 'results_table', visible: true, order: 4,
      columns: [
        { id: 'col-subject',  header: 'المادة',  binding: 'result.subjectName',  width: '25%', visible: true, order: 0, align: 'right' },
        { id: 'col-mid',      header: '中期',     binding: 'result.midTermScore', width: '10%', visible: true, order: 1, align: 'center' },
        { id: 'col-eot',      header: 'نهائي',    binding: 'result.endTermScore', width: '10%', visible: true, order: 2, align: 'center' },
        { id: 'col-total',    header: 'المجموع',  binding: 'result.total',        width: '10%', visible: true, order: 3, align: 'center' },
        { id: 'col-grade',    header: 'الدرجة',    binding: 'result.grade',        width: '8%',  visible: true, order: 4, align: 'center', style: { color: '#B22222', fontWeight: 'bold' } },
        { id: 'col-comment',  header: 'التعليق',  binding: 'result.comment',      width: '27%', visible: true, order: 5, align: 'right', style: { fontStyle: 'italic', color: '#006633' } },
        { id: 'col-initials', header: 'الرمز',    binding: 'result.initials',     width: '10%', visible: true, order: 6, align: 'center' },
      ],
      style: {
        headerBackground: '#f0f8f0',
        headerBorder: '2px solid #006633',
        rowBorder: '1px solid #c8e6c9',
        headerFontSize: 11,
        rowFontSize: 11,
        headerTextTransform: 'none',
        padding: 5,
      },
    },
    {
      id: 'section-assessment', type: 'assessment', visible: true, order: 5,
      fields: [
        { id: 'a-class-pos',  label: 'الترتيب في الصف',  binding: 'assessment.classPosition',  visible: true, order: 0 },
        { id: 'a-aggregates', label: 'المجاميع',         binding: 'assessment.aggregates',     visible: true, order: 1 },
        { id: 'a-division',   label: 'التقدير',         binding: 'assessment.division',       visible: true, order: 2 },
      ],
      style: {},
    },
    {
      id: 'section-comments', type: 'comments', visible: true, order: 6,
      items: [
        { id: 'c-class', label: 'تعليق المعلم:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos',   label: 'تعليق المشرف:', binding: 'comments.dos',          visible: true, order: 1 },
        { id: 'c-head',  label: 'تعليق المدير:',  binding: 'comments.headTeacher',  visible: true, order: 2 },
      ],
      style: {
        ribbonBackground: '#D4AF37',
        ribbonColor: '#006633',
        textColor: '#006633',
        textFontStyle: 'italic',
      },
    },
    {
      id: 'section-grade-table', type: 'grade_table', visible: true, order: 7,
      style: { headerBackground: '#f0f8f0', border: '2px solid #006633' },
      grades: DEFAULT_GRADE_ROWS,
    },
  ],
  shapes: [],
};

async function seedTemplate() {
  const connection = await mysql.createConnection({
    host: process.env.TIDB_HOST || process.env.DB_HOST,
    port: Number(process.env.TIDB_PORT || process.env.DB_PORT || 4000),
    user: process.env.TIDB_USER || process.env.DB_USER,
    password: process.env.TIDB_PASSWORD || process.env.DB_PASSWORD,
    database: process.env.TIDB_DB || process.env.DB_NAME,
    ssl: process.env.TIDB_HOST ? { rejectUnauthorized: true, minVersion: 'TLSv1.2' } : undefined,
  });

  try {
    console.log('Seeding arabic-clone DRCE template...\n');

    const schemaJson = JSON.stringify(ARABIC_CLONE_TEMPLATE);
    const id = '9';
    const templateKey = 'arabic-clone';

    const [updateResult] = await connection.execute(
      `UPDATE dvcf_documents 
       SET schema_json = ?, schema_version = 1, updated_at = NOW() 
       WHERE id = ? AND template_key = ?`,
      [schemaJson, id, templateKey],
    );

    if (updateResult.affectedRows > 0) {
      console.log(`✓ Updated "Arabic Clone" (id=${id})`);
    } else {
      const [insertResult] = await connection.execute(
        `INSERT INTO dvcf_documents 
           (id, school_id, document_type, name, description, schema_json, schema_version, is_default, template_key, created_at, updated_at)
         VALUES (?, ?, 'report_card', ?, ?, ?, 1, 0, ?, NOW(), NOW())
         ON DUPLICATE KEY UPDATE 
           schema_json = VALUES(schema_json), updated_at = NOW()`,
        [id, null, 'Arabic Clone', 'Arabic RTL variant with gold/green theme', schemaJson, templateKey],
      );
      if (insertResult.affectedRows > 0) {
        console.log(`✓ Inserted "Arabic Clone" (id=${id})`);
      } else {
        console.log(`✗ Failed to insert/update "Arabic Clone"`);
      }
    }

    console.log('\n✓ Arabic clone template seeding complete!');
  } catch (error) {
    console.error('✗ Error seeding template:', error.message);
    process.exit(1);
  } finally {
    await connection.end();
  }
}

seedTemplate();

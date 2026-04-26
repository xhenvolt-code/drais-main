#!/usr/bin/env node

// ============================================================================
// scripts/seed-drce-default-clone.mjs
// Seeds the Default Clone DRCE template to dvcf_documents table
// This template matches the 'default-clone' option visible in academics/reports
// ============================================================================

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

dotenv.config({ path: join(__dirname, '..', '.env.local') });

// Load defaults from src/lib/drce/defaults.ts (simplified schema version)
const DEFAULT_CLONE_TEMPLATE = {
  $schema: 'drce/v1',
  meta: {
    id: '8',
    name: 'Default Clone',
    school_id: null,
    version: 1,
    created_at: '2026-01-01T00:00:00Z',
    updated_at: '2026-01-01T00:00:00Z',
    report_type: 'end_of_term',
    is_default: false,
    template_key: 'default-clone',
  },
  theme: {
    primaryColor: '#0000FF',
    secondaryColor: '#B22222',
    accentColor: '#999999',
    fontFamily: 'Arial, sans-serif',
    baseFontSize: 12,
    pagePadding: '16px 18px',
    pageBackground: '#ffffff',
    pageBorder: {
      enabled: false,
      color: '#cccccc',
      width: 1,
      style: 'solid',
      radius: 0,
    },
    pageSize: 'a4',
    orientation: 'portrait',
  },
  watermark: {
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
  },
  sections: [
    {
      id: 'section-header',
      type: 'header',
      visible: true,
      order: 0,
      style: {
        layout: 'three-column',
        paddingBottom: 10,
        borderBottom: '1px solid #eee',
        opacity: 1,
        logoWidth: 64,
        logoHeight: 64,
        showLogo: true,
        showName: true,
        showArabicName: true,
        showAddress: true,
        showContact: true,
        showCentreNo: true,
        showRegistrationNo: true,
      },
    },
    {
      id: 'section-banner',
      type: 'banner',
      visible: true,
      order: 1,
      content: { text: '{reportTitle}' },
      style: {
        backgroundColor: '#0000FF',
        color: '#ffffff',
        fontSize: 16,
        fontWeight: 'bold',
        textAlign: 'center',
        padding: '8px',
        letterSpacing: '0.1em',
        textTransform: 'uppercase',
        borderRadius: 0,
      },
    },
    {
      id: 'section-student-info',
      type: 'student_info',
      visible: true,
      order: 2,
      fields: [
        { id: 'f-name', label: 'Name', binding: 'student.fullName', visible: true, order: 0 },
        { id: 'f-gender', label: 'Sex', binding: 'student.gender', visible: true, order: 1 },
        { id: 'f-class', label: 'Class', binding: 'student.className', visible: true, order: 2 },
        { id: 'f-stream', label: 'Stream', binding: 'student.streamName', visible: true, order: 3 },
        { id: 'f-admno', label: 'Student No.', binding: 'student.admissionNo', visible: true, order: 4 },
        { id: 'f-term', label: 'Term', binding: 'meta.term', visible: true, order: 5 },
      ],
      style: {
        border: '1px dashed #999',
        borderRadius: 0,
        padding: '8px',
        background: '#ffffff',
        labelColor: '#555555',
        valueColor: '#B22222',
        valueFontWeight: 'bold',
        valueFontSize: 14,
      },
    },
    {
      id: 'section-ribbon-1',
      type: 'ribbon',
      visible: true,
      order: 3,
      content: { text: 'Principal Subjects Comprising the General Assessment', shape: 'arrow-down' },
      style: {
        background: '#999999',
        color: '#000000',
        fontWeight: 'bold',
        fontSize: 12,
        padding: '4px 0',
        textAlign: 'center',
      },
    },
    {
      id: 'section-results',
      type: 'results_table',
      visible: true,
      order: 4,
      columns: [
        { id: 'col-subject', header: 'Subject', binding: 'result.subjectName', width: '25%', visible: true, order: 0, align: 'left' },
        { id: 'col-mid', header: 'MT', binding: 'result.midTermScore', width: '8%', visible: true, order: 1, align: 'center' },
        { id: 'col-eot', header: 'EOT', binding: 'result.endTermScore', width: '8%', visible: true, order: 2, align: 'center' },
        { id: 'col-total', header: 'Total', binding: 'result.total', width: '8%', visible: true, order: 3, align: 'center' },
        { id: 'col-grade', header: 'Grade', binding: 'result.grade', width: '8%', visible: true, order: 4, align: 'center', style: { color: '#B22222' } },
        { id: 'col-comment', header: 'Comment', binding: 'result.comment', width: '35%', visible: true, order: 5, align: 'left', style: { fontStyle: 'italic', color: '#0000FF' } },
        { id: 'col-initials', header: 'Initials', binding: 'result.initials', width: '8%', visible: true, order: 6, align: 'center', style: { color: '#0000FF', fontWeight: 'bold' } },
      ],
      style: {
        headerBackground: '#f2f2f2',
        headerBorder: '1px solid #333',
        rowBorder: '1px solid #333',
        headerFontSize: 11,
        rowFontSize: 11,
        headerTextTransform: 'uppercase',
        padding: 4,
      },
    },
    {
      id: 'section-assessment',
      type: 'assessment',
      visible: true,
      order: 5,
      fields: [
        { id: 'a-class-pos', label: 'Class Position', binding: 'assessment.classPosition', visible: true, order: 0 },
        { id: 'a-aggregates', label: 'Aggregates', binding: 'assessment.aggregates', visible: true, order: 1 },
        { id: 'a-division', label: 'Division', binding: 'assessment.division', visible: true, order: 2 },
      ],
      style: {},
    },
    {
      id: 'section-comments',
      type: 'comments',
      visible: true,
      order: 6,
      items: [
        { id: 'c-class', label: 'Class teacher comment:', binding: 'comments.classTeacher', visible: true, order: 0 },
        { id: 'c-dos', label: 'DOS Comment:', binding: 'comments.dos', visible: true, order: 1 },
        { id: 'c-head', label: 'Headteacher comment:', binding: 'comments.headTeacher', visible: true, order: 2 },
      ],
      style: {
        ribbonBackground: '#dddddd',
        ribbonColor: '#000000',
        textColor: '#0000FF',
        textFontStyle: 'italic',
      },
    },
    {
      id: 'section-grade-table',
      type: 'grade_table',
      visible: true,
      order: 7,
      style: { headerBackground: '#f2f2f2', border: '1px solid #000' },
      grades: [
        { label: 'D1', min: 90, max: 100, remark: 'Distinction 1' },
        { label: 'D2', min: 80, max: 89, remark: 'Distinction 2' },
        { label: 'C3', min: 70, max: 79, remark: 'Credit 3' },
        { label: 'C4', min: 60, max: 69, remark: 'Credit 4' },
        { label: 'C5', min: 50, max: 59, remark: 'Credit 5' },
        { label: 'C6', min: 45, max: 49, remark: 'Credit 6' },
        { label: 'P7', min: 40, max: 44, remark: 'Pass 7' },
        { label: 'P8', min: 35, max: 39, remark: 'Pass 8' },
        { label: 'F9', min: 0, max: 34, remark: 'Fail 9' },
      ],
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
    console.log('Seeding default-clone DRCE template...\n');

    const schemaJson = JSON.stringify(DEFAULT_CLONE_TEMPLATE);
    const id = '8';
    const templateKey = 'default-clone';

    // Try UPDATE first (built-in template style)
    const [updateResult] = await connection.execute(
      `UPDATE dvcf_documents 
       SET schema_json = ?, schema_version = 1, updated_at = NOW() 
       WHERE id = ? AND template_key = ?`,
      [schemaJson, id, templateKey],
    );

    if (updateResult.affectedRows > 0) {
      console.log(`✓ Updated "Default Clone" (id=${id})`);
    } else {
      // Insert if not exists
      const [insertResult] = await connection.execute(
        `INSERT INTO dvcf_documents 
           (id, school_id, document_type, name, description, schema_json, schema_version, is_default, template_key, created_at, updated_at)
         VALUES (?, ?, 'report_card', ?, ?, ?, 1, 0, ?, NOW(), NOW())
         ON DUPLICATE KEY UPDATE 
           schema_json = VALUES(schema_json), updated_at = NOW()`,
        [id, null, 'Default Clone', 'Clone of default template for variant selection', schemaJson, templateKey],
      );
      if (insertResult.affectedRows > 0) {
        console.log(`✓ Inserted "Default Clone" (id=${id})`);
      } else {
        console.log(`✗ Failed to insert/update "Default Clone"`);
      }
    }

    console.log('\n✓ Default clone template seeding complete!');
  } catch (error) {
    console.error('✗ Error seeding template:', error.message);
    process.exit(1);
  } finally {
    await connection.end();
  }
}

seedTemplate();

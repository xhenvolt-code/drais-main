/**
 * scripts/enable-drce-totals.mjs
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 *
 * Enables totals/averages in all DRCE report templates
 * Run: node scripts/enable-drce-totals.mjs
 */

import mysql from 'mysql2/promise';
import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

// Load environment variables
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const envPath = path.join(__dirname, '..', '.env.local');

if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf-8');
  envContent.split('\n').forEach(line => {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#')) {
      const [key, ...valueParts] = trimmed.split('=');
      const value = valueParts.join('=');
      if (key && value) {
        process.env[key] = value;
      }
    }
  });
}

// Use TiDB Cloud if available, fallback to local MySQL
const isTiDB = process.env.DATABASE_MODE === 'tidb' || process.env.TIDB_HOST;
const host = isTiDB ? (process.env.TIDB_HOST || 'localhost') : (process.env.DB_HOST || 'localhost');
const port = isTiDB ? (process.env.TIDB_PORT || 4000) : (process.env.DB_PORT || 3306);
const user = isTiDB ? (process.env.TIDB_USER || 'root') : (process.env.DB_USER || 'root');
const password = isTiDB ? (process.env.TIDB_PASSWORD || '') : (process.env.DB_PASSWORD || '');
const database = isTiDB ? (process.env.TIDB_DB || 'drais') : (process.env.DB_NAME || 'drais_system');

console.log(`🔗 Connecting to ${isTiDB ? 'TiDB Cloud' : 'Local MySQL'} at ${host}:${port}\n`);

const poolConfig = {
  host,
  port,
  user,
  password,
  database,
  waitForConnections: true,
  connectionLimit: 5,
  queueLimit: 0,
};

// Add SSL for TiDB Cloud
if (isTiDB) {
  poolConfig.ssl = {};
}

const pool = mysql.createPool(poolConfig);

/**
 * Generate default totals configuration
 */
function generateDefaultTotalsConfig(columns) {
  // Find numeric columns (score/marks)
  let sumColumnIds = columns
    .filter(col =>
      col.id.toLowerCase().includes('score') ||
      col.id.toLowerCase().includes('marks') ||
      col.id.toLowerCase().includes('total') ||
      col.id.toLowerCase().includes('grade_points')
    )
    .map(col => col.id);

  // If no score columns found, use last 2 columns
  if (sumColumnIds.length === 0) {
    sumColumnIds = columns.slice(-2).map(col => col.id);
  }

  // Find label column (usually subject name)
  const labelColumnId = 
    columns.find(col => col.header.toLowerCase().includes('subject'))?.id ||
    columns[0]?.id ||
    'subject';

  return {
    enabled: true,
    labelColumnId,
    labelText: 'TOTAL',
    sumColumnIds,
    showAverage: true,
    averageLabelColumnId: labelColumnId,
    averageLabelText: 'AVERAGE',
    rowStyle: {
      fontWeight: 'bold',
      background: 'rgba(0, 0, 0, 0.05)',
    },
  };
}

/**
 * Update a template to include totals configuration
 */
async function updateTemplateWithTotals(templateId, schema) {
  try {
    // Find results_table section
    const resultsTableSection = schema.sections?.find(s => s.type === 'results_table');
    
    if (!resultsTableSection) {
      console.log(`⚠️  Template ${templateId}: No results_table section found, skipping`);
      return false;
    }

    // Skip if already has totals config
    if (resultsTableSection.totalsConfig?.enabled) {
      console.log(`⏭️  Template ${templateId}: Already has totals enabled, skipping`);
      return false;
    }

    // Generate and apply totals config
    const totalsConfig = generateDefaultTotalsConfig(resultsTableSection.columns);
    resultsTableSection.totalsConfig = totalsConfig;

    // Update database
    const [result] = await pool.execute(
      'UPDATE drce_documents SET schema = ?, updated_at = NOW() WHERE id = ?',
      [JSON.stringify(schema), templateId]
    );

    if (result.affectedRows > 0) {
      console.log(`✅ Template ${templateId}: Totals enabled (${totalsConfig.sumColumnIds.length} score columns)`);
      return true;
    }
    return false;
  } catch (error) {
    console.error(`❌ Template ${templateId}: Error updating`, error.message);
    return false;
  }
}

/**
 * Main function
 */
async function main() {
  console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('🎨 DRCE Totals/Averages Enablement Script');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

  const conn = await pool.getConnection();

  try {
    // Get all DRCE report templates
    const [templates] = await conn.execute(
      `SELECT id, name, \`schema\` FROM drce_documents 
       WHERE template_type = 'report_card' OR type = 'report_card'
       ORDER BY built_in DESC, created_at ASC`
    );

    console.log(`📋 Found ${templates.length} DRCE templates\n`);

    let updated = 0;
    let skipped = 0;
    let failed = 0;

    for (const template of templates) {
      try {
        const schema = JSON.parse(template.schema);
        const success = await updateTemplateWithTotals(template.id, schema);
        if (success) {
          updated++;
        } else {
          skipped++;
        }
      } catch (error) {
        console.error(`❌ ${template.name} (ID: ${template.id}): ${error.message}`);
        failed++;
      }
    }

    console.log(`\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`);
    console.log(`Summary:`);
    console.log(`  ✅ Updated:  ${updated}`);
    console.log(`  ⏭️  Skipped:  ${skipped}`);
    console.log(`  ❌ Failed:   ${failed}`);
    console.log(`\n✨ Totals/Averages feature is now enabled on all templates!\n`);

  } catch (error) {
    console.error('Fatal error:', error);
    process.exit(1);
  } finally {
    await conn.end();
    await pool.end();
  }
}

main().catch(err => {
  console.error('Error:', err);
  process.exit(1);
});

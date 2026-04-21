#!/usr/bin/env node

/**
 * Database Schema Importer
 * 
 * This script imports the DraisIbunBaz_schema.sql file into the MySQL database
 * configured via environment variables.
 * 
 * Usage:
 *   node scripts/import-schema.js
 *   npm run import:schema
 */

const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, '../.env.local') });

const dbConfig = {
  host: process.env.MYSQL_HOST || process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.MYSQL_PORT || process.env.DB_PORT || '3306', 10),
  user: process.env.MYSQL_USER || process.env.DB_USER || 'root',
  password: process.env.MYSQL_PASSWORD || process.env.DB_PASS || '',
};

const dbName = process.env.MYSQL_DB || process.env.DB_NAME || 'ibunbaz_drais';
const schemaPath = path.join(__dirname, '../DraisIbunBaz_schema.sql');

async function importSchema() {
  let connection;

  try {
    console.log('🔌 Connecting to MySQL server...');
    console.log(`   Host: ${dbConfig.host}`);
    console.log(`   Port: ${dbConfig.port}`);
    console.log(`   User: ${dbConfig.user}`);
    console.log(`   Database: ${dbName}`);

    // Connect without database first to create database if needed
    connection = await mysql.createConnection({
      host: dbConfig.host,
      port: dbConfig.port,
      user: dbConfig.user,
      password: dbConfig.password,
    });

    console.log('✅ Connected to MySQL server');

    // Create database if it doesn't exist
    console.log(`\n📦 Creating database '${dbName}' if it doesn't exist...`);
    await connection.execute(`CREATE DATABASE IF NOT EXISTS \`${dbName}\``);
    console.log(`✅ Database '${dbName}' ready`);

    // Select the database
    await connection.execute(`USE \`${dbName}\``);

    // Read the schema file
    console.log('\n📄 Reading schema file...');
    if (!fs.existsSync(schemaPath)) {
      throw new Error(`Schema file not found: ${schemaPath}`);
    }

    const schemaSql = fs.readFileSync(schemaPath, 'utf8');
    console.log(`✅ Schema file loaded (${(schemaSql.length / 1024).toFixed(2)} KB)`);

    // Split by statements and execute
    console.log('\n⚙️  Importing schema...');
    const statements = schemaSql
      .split(';')
      .map(stmt => stmt.trim())
      .filter(stmt => stmt && !stmt.startsWith('/*!') && !stmt.startsWith('--'));

    let executed = 0;
    let skipped = 0;

    for (const statement of statements) {
      try {
        if (statement.length > 0) {
          await connection.execute(statement + ';');
          executed++;
        }
      } catch (err) {
        // Skip comments and warning statements
        if (err.message && err.message.includes('syntax')) {
          console.warn(`⚠️  Skipping problematic statement: ${statement.substring(0, 50)}...`);
          skipped++;
        } else if (!err.message.includes('You have an error in your SQL syntax')) {
          throw err;
        }
      }
    }

    console.log(`✅ Schema imported successfully!`);
    console.log(`   Statements executed: ${executed}`);
    if (skipped > 0) {
      console.log(`   Statements skipped: ${skipped}`);
    }

    // Verify database
    console.log('\n🔍 Verifying database...');
    const [tables] = await connection.execute('SHOW TABLES');
    console.log(`✅ Database contains ${tables.length} tables`);

    console.log('\n🎉 Database import completed successfully!');
    console.log(`   Connect to database: mysql -h ${dbConfig.host} -u ${dbConfig.user} ${dbName}`);

  } catch (error) {
    console.error('\n❌ Error importing schema:', error.message);
    if (error.code === 'ECONNREFUSED') {
      console.error('   Make sure MySQL is running and accessible');
      console.error('   Check your database configuration in .env.local');
    }
    process.exit(1);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

importSchema();

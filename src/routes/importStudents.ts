import express from 'express';
import multer from 'multer';
import xlsx from 'xlsx';
import mysql from 'mysql2/promise';
import { validateData, mapHeaders } from './utils/importHelpers';

const router = express.Router();
const upload = multer({ dest: 'uploads/' });

const db = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'drais_school',
});

router.post('/import-students', upload.single('file'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No file uploaded' });
    }

    // Parse Excel file
    const workbook = xlsx.readFile(req.file.path);
    const sheet = workbook.Sheets[workbook.SheetNames[0]];
    const rows = xlsx.utils.sheet_to_json(sheet, { header: 1 });

    if (rows.length < 2) {
      return res.status(400).json({ error: 'Excel file is empty or invalid' });
    }

    // Extract headers and data
    const headers = rows[0];
    const dataRows = rows.slice(1);

    // Map headers to DB fields
    const { mappedHeaders, unmappedHeaders } = mapHeaders(headers);

    if (unmappedHeaders.length > 0) {
      return res.status(400).json({
        error: 'Unmapped headers found',
        unmappedHeaders,
      });
    }

    // Validate and clean data
    const { validRows, errors } = validateData(dataRows, mappedHeaders);

    if (errors.length > 0) {
      return res.status(400).json({
        error: 'Validation errors found',
        errors,
      });
    }

    // Insert data into `people` and `students` tables
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      for (const row of validRows) {
        const [personResult] = await connection.query(
          `INSERT INTO people (first_name, last_name, gender, date_of_birth, phone, email, address) VALUES (?, ?, ?, ?, ?, ?, ?)`,
          [
            row.first_name,
            row.last_name,
            row.gender,
            row.date_of_birth,
            row.phone,
            row.email,
            row.address,
          ]
        );

        const personId = personResult.insertId;

        await connection.query(
          `INSERT INTO students (person_id, admission_no, village_id, admission_date, status, notes) VALUES (?, ?, ?, ?, ?, ?)`,
          [
            personId,
            row.admission_no,
            row.village_id,
            row.admission_date,
            row.status,
            row.notes,
          ]
        );
      }

      await connection.commit();
      res.json({ message: 'Data imported successfully', importedRows: validRows.length });
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'An error occurred during import' });
  }
});

export default router;

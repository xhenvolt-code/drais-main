import mysql from 'mysql2/promise';
import { query, withTransaction } from './db';

interface StudentFee {
  student_id: number;
  term_id: number;
  class_id: number;
  fee_structure_id: number;
  item: string;
  amount: number;
  balance: number;
}

export async function initializeFeesSystem(school_id: number) {
  return await withTransaction(async (connection) => {
    // 1. Get all active students
    const [students] = await connection.query<mysql.RowDataPacket[]>(`
      SELECT s.id as student_id, s.class_id, s.stream_id, 
             p.first_name, p.last_name,
             c.name as class_name
      FROM students s 
      JOIN people p ON s.person_id = p.id
      JOIN classes c ON s.class_id = c.id
      WHERE s.school_id = ? AND s.status = 'active'
    `, [school_id]);

    // 2. Get current term
    const [currentTermRows] = await connection.query<mysql.RowDataPacket[]>(`
      SELECT id FROM terms 
      WHERE school_id = ? AND status = 'active' 
      ORDER BY start_date DESC LIMIT 1
    `, [school_id]);
    const currentTerm = currentTermRows[0] as { id: number } | undefined;
    
    if (!currentTerm?.id) {
      throw new Error('No active term found');
    }

    // 3. Get or create fee structures
    const [structures] = await connection.query<mysql.RowDataPacket[]>(`
      SELECT * FROM fee_structures 
      WHERE school_id = ? AND term_id = ?
    `, [school_id, currentTerm.id]);

    // Create default structure if none exists
    if (!structures.length) {
      await connection.query(`
        INSERT INTO fee_structures (school_id, class_id, term_id, item, amount)
        SELECT ?, class_id, ?, 'Tuition', 500000
        FROM classes WHERE school_id = ?
      `, [school_id, currentTerm.id, school_id]);
    }

    // 4. Get existing fee items
    const [existingItems] = await connection.query<mysql.RowDataPacket[]>(`
      SELECT student_id, term_id 
      FROM student_fee_items
      WHERE school_id = ? AND term_id = ?
    `, [school_id, currentTerm.id]);

    // 5. Create missing fee items
    const existingKeys = new Set(
      existingItems.map((i) => `${i.student_id}_${i.term_id}`)
    );

    const newItems: StudentFee[] = [];

    for (const student of students) {
      const key = `${student.student_id}_${currentTerm.id}`;
      if (!existingKeys.has(key)) {
        // Get structure for student's class
        const structure = structures.find((s) => 
          s.class_id === student.class_id
        );

        if (structure) {
          newItems.push({
            student_id: student.student_id,
            term_id: currentTerm.id,
            class_id: student.class_id,
            fee_structure_id: structure.id,
            item: structure.item,
            amount: structure.amount,
            balance: structure.amount // Initial balance equals full amount
          });
        }
      }
    }

    // Bulk insert new items
    if (newItems.length) {
      await connection.query(`
        INSERT INTO student_fee_items 
        (school_id, student_id, term_id, class_id, fee_structure_id, item, amount, balance)
        VALUES ?
      `, [newItems.map(i => [
        school_id,
        i.student_id,
        i.term_id,
        i.class_id,
        i.fee_structure_id,
        i.item,
        i.amount,
        i.balance
      ])]);
    }

    return {
      initialized: true,
      studentsCount: students.length,
      newItemsCount: newItems.length
    };
  });
}

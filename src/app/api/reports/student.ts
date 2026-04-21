import { NextApiRequest, NextApiResponse } from 'next';
import { query } from '../../../../lib/db';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'GET') {
    try {
      const { student_id, term_id } = req.query;
      const results = await query(
        `SELECT s.first_name, s.last_name, s.date_of_birth, c.name AS class_name, r.subject_name, r.score, r.out_of, r.remarks
         FROM students s
         JOIN classes c ON s.class_id = c.id
         JOIN results r ON s.id = r.student_id
         WHERE s.id = ? AND r.term_id = ?`,
        [student_id, term_id]
      );

      if (results.length === 0) {
        return res.status(404).json({ success: false, message: 'No results found for the specified student and term.' });
      }

      const student = results[0];
      const age = new Date().getFullYear() - new Date(student.date_of_birth).getFullYear();

      res.status(200).json({
        success: true,
        school: {
          name: 'BUGEMBE ISLAMIC INSTITUTE',
          address: 'BUGEMBE, JINJA',
          arabic_name: 'معهد بوجيمبي الإسلامي',
          arabic_address: 'بوجيمبي، جينجا',
        },
        student: {
          first_name: student.first_name,
          last_name: student.last_name,
          class_name: student.class_name,
          age,
        },
        results: results.map(r => ({
          subject_name: r.subject_name,
          score: r.score,
          out_of: r.out_of,
          remarks: r.remarks,
        })),
        comments: {
          class_teacher_comment: 'عمل ممتاز، استمر في التفوق.',
          dos_comment: 'أداء رائع، حافظ على هذا المستوى.',
          headteacher_comment: 'نتائج مبهرة، نحن فخورون بك.',
        },
      });
    } catch (error) {
      res.status(500).json({ success: false, message: 'Failed to fetch report data.', error });
    }
  } else {
    res.setHeader('Allow', ['GET']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
  }
}
import { NextApiRequest, NextApiResponse } from 'next';
import { getConnection } from '@/lib/db';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'GET') {
    let connection;
    try {
      connection = await getConnection();
      const [books] = await connection.execute('SELECT * FROM tahfiz_books');
      res.status(200).json(books);
    } catch (error) {
      res.status(500).json({ error: 'Failed to fetch books' });
    } finally {
      if (connection) await connection.end();
    }
  } else {
    res.setHeader('Allow', ['GET']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
  }
}

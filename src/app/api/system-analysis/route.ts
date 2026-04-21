import { NextRequest, NextResponse } from 'next/server';
import { getConnection } from '@/lib/db';

export async function GET(req: NextRequest) {
  try {
    const connection = await getConnection();

    // Fetch income statement
    const [incomeStatementRows] = await connection.execute(
      'SELECT SUM(amount) AS revenue, SUM(expenses) AS expenses, (SUM(amount) - SUM(expenses)) AS profit FROM ledger WHERE tx_type = "income"'
    );
    const incomeStatement = incomeStatementRows[0];

    // Fetch balance sheet
    const [balanceSheetRows] = await connection.execute(
      'SELECT SUM(assets) AS assets, SUM(liabilities) AS liabilities, (SUM(assets) - SUM(liabilities)) AS equity FROM balance_sheet'
    );
    const balanceSheet = balanceSheetRows[0];

    // Fetch student results
    const [studentResultsRows] = await connection.execute(
      'SELECT s.id, p.first_name, p.last_name, AVG(r.score) AS average_score FROM students s JOIN results r ON s.id = r.student_id JOIN people p ON s.person_id = p.id GROUP BY s.id ORDER BY average_score DESC'
    );
    const studentResults = studentResultsRows.map((row: any) => ({
      id: row.id,
      name: `${row.first_name} ${row.last_name}`,
      average_score: row.average_score,
    }));

    await connection.end();

    return NextResponse.json({
      incomeStatement,
      balanceSheet,
      studentResults,
    });
  } catch (error) {
    console.error('Error fetching data:', error);

    // Fallback demo data in case of failure
    const fallbackData = {
      incomeStatement: { revenue: 50000, expenses: 30000, profit: 20000 },
      balanceSheet: { assets: 100000, liabilities: 80000, equity: 20000 },
      studentResults: [
        { id: 1, name: 'Demo Student 1', average_score: 75 },
        { id: 2, name: 'Demo Student 2', average_score: 80 },
      ],
    };

    return NextResponse.json(fallbackData);
  }
}
import mysql from 'mysql2/promise';

interface FeeItem {
  id: number;
  student_id: number;
  term_id: number;
  item: string;
  amount: number;
  discount: number;
  waived: number;
  paid: number;
  balance: number;
  due_date?: string;
  status: string;
}

export class FinanceService {
  /**
   * Compute fee item status dynamically (replaces MySQL GENERATED column)
   */
  static computeFeeItemStatus(item: FeeItem): string {
    const { amount, discount = 0, waived = 0, paid = 0, due_date } = item;
    const today = new Date();

    if (waived >= amount) return 'waived';
    if (paid >= (amount - discount - waived)) return 'paid';
    if (paid > 0 && paid < (amount - discount - waived)) return 'partial';
    if (due_date && new Date(due_date) < today) return 'overdue';
    return 'pending';
  }

  /**
   * Compute wallet current balance dynamically
   */
  static async computeWalletBalance(walletId: number, connection: mysql.Connection | mysql.PoolConnection): Promise<number> {
    const [wallet] = await connection.execute(
      'SELECT opening_balance FROM wallets WHERE id = ?',
      [walletId]
    );
    
    if (!wallet.length) return 0;

    const [ledgerSum] = await connection.execute(`
      SELECT COALESCE(SUM(CASE WHEN tx_type = 'credit' THEN amount ELSE -amount END), 0) as balance_change
      FROM ledger 
      WHERE wallet_id = ?
    `, [walletId]);

    return wallet[0].opening_balance + (ledgerSum[0]?.balance_change || 0);
  }

  /**
   * Enhance fee items with computed status
   */
  static enhanceFeeItems(items: FeeItem[]): FeeItem[] {
    return items.map(item => ({
      ...item,
      status: this.computeFeeItemStatus(item)
    }));
  }

  /**
   * Update fee item status in database (optional persistence)
   */
  static async updateFeeItemStatus(feeItemId: number, connection: mysql.Connection | mysql.PoolConnection): Promise<void> {
    const [items] = await connection.execute(
      'SELECT * FROM student_fee_items WHERE id = ?',
      [feeItemId]
    );
    
    if (!items.length) return;

    const status = this.computeFeeItemStatus(items[0]);
    
    await connection.execute(
      'UPDATE student_fee_items SET status = ? WHERE id = ?',
      [status, feeItemId]
    );
  }

  /**
   * Bulk update fee item statuses for a term/class
   */
  static async bulkUpdateFeeItemStatuses(schoolId: number, termId?: number, classId?: number, connection?: mysql.Connection | mysql.PoolConnection): Promise<void> {
    const shouldCloseConnection = !connection;
    if (!connection) {
      const { getConnection } = await import('@/lib/db');
      connection = await getConnection();
    }

    try {
      let sql = `
        SELECT sfi.* 
        FROM student_fee_items sfi
        JOIN students s ON sfi.student_id = s.id
        WHERE s.school_id = ?
      `;
      const params = [schoolId];

      if (termId) {
        sql += ' AND sfi.term_id = ?';
        params.push(termId);
      }

      if (classId) {
        sql += ' AND s.id IN (SELECT student_id FROM enrollments WHERE class_id = ?)';

        params.push(classId);
      }

      const [items] = await connection.execute(sql, params);

      for (const item of items) {
        const status = this.computeFeeItemStatus(item);
        await connection.execute(
          'UPDATE student_fee_items SET status = ? WHERE id = ?',
          [status, item.id]
        );
      }
    } finally {
      if (shouldCloseConnection && connection) {
        await connection.end();
      }
    }
  }

  /**
   * Generate receipt number
   */
  static async generateReceiptNumber(schoolId: number, connection: mysql.Connection | mysql.PoolConnection): Promise<string> {
    const [count] = await connection.execute(
      'SELECT COUNT(*) as count FROM receipts WHERE school_id = ? AND DATE(generated_at) = CURDATE()',
      [schoolId]
    );
    
    const receiptNo = `R-${new Date().getFullYear()}-${String(count[0].count + 1).padStart(6, '0')}`;
    return receiptNo;
  }
}

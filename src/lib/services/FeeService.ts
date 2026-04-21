import { getConnection } from '@/lib/db';

export interface FeeItem {
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
  status?: 'pending' | 'partial' | 'paid' | 'overdue' | 'waived';
  created_at: string;
  updated_at: string;
}

/**
 * Compute fee item status dynamically based on amounts and due date
 * This replaces the problematic MySQL GENERATED column
 */
export function computeFeeItemStatus(item: Partial<FeeItem>): FeeItem['status'] {
  const { amount = 0, discount = 0, waived = 0, paid = 0, due_date } = item;
  const today = new Date();
  
  // Priority order: waived > paid > partial > overdue > pending
  if (waived >= amount) return 'waived';
  if (paid >= (amount - discount - waived)) return 'paid';
  if (paid > 0 && paid < (amount - discount - waived)) return 'partial';
  if (due_date && new Date(due_date) < today) return 'overdue';
  return 'pending';
}

/**
 * Compute wallet current balance dynamically
 * This replaces the problematic MySQL GENERATED column
 */
export async function computeWalletBalance(walletId: number): Promise<number> {
  const connection = await getConnection();
  
  try {
    const [result] = await connection.execute(`
      SELECT 
        w.opening_balance,
        COALESCE(SUM(CASE WHEN l.tx_type = 'credit' THEN l.amount ELSE -l.amount END), 0) as net_transactions
      FROM wallets w
      LEFT JOIN ledger l ON w.id = l.wallet_id
      WHERE w.id = ?
      GROUP BY w.id, w.opening_balance
    `, [walletId]);
    
    if (result.length === 0) return 0;
    
    const { opening_balance, net_transactions } = result[0] as any;
    return (opening_balance || 0) + (net_transactions || 0);
  } finally {
    await connection.end();
  }
}

/**
 * Apply status computation to fee items array
 */
export function applyFeeItemStatuses(items: Partial<FeeItem>[]): FeeItem[] {
  return items.map(item => ({
    ...item,
    status: computeFeeItemStatus(item)
  })) as FeeItem[];
}

/**
 * Update fee item status in database after API operations
 * Call this after payments, discounts, or waivers are applied
 */
export async function updateFeeItemStatus(feeItemId: number): Promise<void> {
  const connection = await getConnection();
  
  try {
    // Get current item data
    const [items] = await connection.execute(`
      SELECT amount, discount, waived, paid, due_date
      FROM student_fee_items 
      WHERE id = ?
    `, [feeItemId]);
    
    if (items.length === 0) return;
    
    const item = items[0] as Partial<FeeItem>;
    const newStatus = computeFeeItemStatus(item);
    
    // Update status in database
    await connection.execute(`
      UPDATE student_fee_items 
      SET status = ?, updated_at = CURRENT_TIMESTAMP
      WHERE id = ?
    `, [newStatus, feeItemId]);
    
  } finally {
    await connection.end();
  }
}

/**
 * Batch update fee item statuses for multiple items
 */
export async function batchUpdateFeeItemStatuses(feeItemIds: number[]): Promise<void> {
  const connection = await getConnection();
  
  try {
    await connection.beginTransaction();
    
    for (const id of feeItemIds) {
      await updateFeeItemStatus(id);
    }
    
    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    await connection.end();
  }
}

const FeeService = {
  computeFeeItemStatus,
  computeWalletBalance,
  applyFeeItemStatuses,
  updateFeeItemStatus,
  batchUpdateFeeItemStatuses
};

export default FeeService;

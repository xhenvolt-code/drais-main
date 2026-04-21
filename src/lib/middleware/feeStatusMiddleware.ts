import { updateFeeItemStatus } from '@/lib/services/FeeService';

/**
 * Middleware to automatically update fee item statuses after operations
 * Call this after any operation that might change fee item status
 */
export class FeeStatusMiddleware {
  /**
   * Update status after payment operations
   */
  static async afterPayment(feeItemIds: number[]): Promise<void> {
    try {
      for (const id of feeItemIds) {
        await updateFeeItemStatus(id);
      }
    } catch (error) {
      console.error('Error updating fee item statuses after payment:', error);
      // Don't throw - status updates are non-critical for payment success
    }
  }

  /**
   * Update status after discount/waiver operations
   */
  static async afterDiscountOrWaiver(feeItemIds: number[]): Promise<void> {
    try {
      for (const id of feeItemIds) {
        await updateFeeItemStatus(id);
      }
    } catch (error) {
      console.error('Error updating fee item statuses after discount/waiver:', error);
    }
  }

  /**
   * Update status after fee item modification
   */
  static async afterFeeModification(feeItemId: number): Promise<void> {
    try {
      await updateFeeItemStatus(feeItemId);
    } catch (error) {
      console.error('Error updating fee item status after modification:', error);
    }
  }
}

export default FeeStatusMiddleware;

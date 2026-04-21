const { NotificationService } = require('../src/lib/NotificationService');

async function processNotificationQueue() {
  console.log('Starting notification queue processing...');
  
  try {
    const notificationService = new NotificationService();
    const result = await notificationService.processQueue(100);
    
    console.log(`Processed: ${result.processed}, Failed: ${result.failed}`);
    
    if (result.processed > 0 || result.failed > 0) {
      console.log(`Queue processing completed. Processed: ${result.processed}, Failed: ${result.failed}`);
    }
  } catch (error) {
    console.error('Error processing notification queue:', error);
  }
}

// Run immediately if called directly
if (require.main === module) {
  processNotificationQueue()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error('Worker error:', error);
      process.exit(1);
    });
}

module.exports = { processNotificationQueue };

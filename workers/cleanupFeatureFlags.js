const { getConnection } = require('../src/lib/db');

async function cleanupExpiredFeatureFlags() {
  console.log('Starting feature flags cleanup...');
  
  let connection;
  
  try {
    connection = await getConnection();
    
    // Call the stored procedure to cleanup expired flags
    await connection.execute('CALL CleanupExpiredFeatureFlags()');
    
    // Get count of cleaned up flags
    const [result] = await connection.execute(`
      SELECT COUNT(*) as expired_count 
      FROM feature_flags 
      WHERE expires_at <= NOW() AND is_new = FALSE
    `);
    
    console.log(`Feature flags cleanup completed. Processed: ${result[0]?.expired_count || 0} flags`);
    
  } catch (error) {
    console.error('Error during feature flags cleanup:', error);
  } finally {
    if (connection) await connection.end();
  }
}

// Run immediately if called directly
if (require.main === module) {
  cleanupExpiredFeatureFlags()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error('Cleanup worker error:', error);
      process.exit(1);
    });
}

module.exports = { cleanupExpiredFeatureFlags };

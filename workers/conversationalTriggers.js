const { NotificationService } = require('../src/lib/NotificationService');
const { getConnection } = require('../src/lib/db');

async function checkConversationalTriggers() {
  console.log('Checking conversational triggers...');
  
  let connection;
  
  try {
    connection = await getConnection();
    const notificationService = new NotificationService();
    
    // Check for new databases (welcome trigger)
    const [notificationCount] = await connection.execute(
      'SELECT COUNT(*) as count FROM notifications WHERE created_at > DATE_SUB(NOW(), INTERVAL 1 DAY)'
    );
    
    if (notificationCount[0].count === 0) {
      // No recent notifications - might be a new database
      const [schools] = await connection.execute('SELECT id, name FROM schools LIMIT 5');
      
      for (const school of schools) {
        // Get admin users for this school
        const [admins] = await connection.execute(`
          SELECT u.id
          FROM users u
          JOIN roles r ON u.role_id = r.id
          WHERE u.school_id = ? AND u.status = 'active'
          AND (r.name LIKE '%admin%' OR r.name LIKE '%head%')
          LIMIT 3
        `, [school.id]);
        
        if (admins.length > 0) {
          await notificationService.createFromTemplate(
            'welcome_new_db',
            { school_name: school.name },
            admins.map(admin => admin.id),
            { school_id: school.id }
          );
          
          console.log(`Welcome notification sent to ${admins.length} admins for school ${school.name}`);
        }
      }
    }
    
    // Check for inactivity (30+ days)
    const [inactiveSchools] = await connection.execute(`
      SELECT s.id, s.name, MAX(COALESCE(a.created_at, n.created_at, s.created_at)) as last_activity
      FROM schools s
      LEFT JOIN audit_log a ON s.id = a.school_id 
      LEFT JOIN notifications n ON s.id = n.school_id
      GROUP BY s.id, s.name
      HAVING last_activity < DATE_SUB(NOW(), INTERVAL 30 DAY)
      LIMIT 5
    `);
    
    for (const school of inactiveSchools) {
      const daysSinceActivity = Math.floor((Date.now() - new Date(school.last_activity)) / (1000 * 60 * 60 * 24));
      
      // Get admin users for this school
      const [admins] = await connection.execute(`
        SELECT u.id
        FROM users u
        JOIN roles r ON u.role_id = r.id
        WHERE u.school_id = ? AND u.status = 'active'
        AND (r.name LIKE '%admin%' OR r.name LIKE '%head%')
        LIMIT 3
      `, [school.id]);
      
      if (admins.length > 0) {
        await notificationService.createFromTemplate(
          'inactivity_reminder',
          { 
            school_name: school.name,
            days_idle: daysSinceActivity
          },
          admins.map(admin => admin.id),
          { school_id: school.id }
        );
        
        console.log(`Inactivity reminder sent to ${admins.length} admins for school ${school.name} (${daysSinceActivity} days idle)`);
      }
    }
    
    console.log('Conversational triggers check completed');
  } catch (error) {
    console.error('Error checking conversational triggers:', error);
  } finally {
    if (connection) await connection.end();
  }
}

// Run immediately if called directly
if (require.main === module) {
  checkConversationalTriggers()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error('Trigger worker error:', error);
      process.exit(1);
    });
}

module.exports = { checkConversationalTriggers };

import mysql from 'mysql2/promise';

const config = {
  host: 'gateway01.eu-central-1.prod.aws.tidbcloud.com',
  port: 4000,
  user: '2Trc8kJebpKLb1Z.root',
  password: 'QMNAOiP9J1rANv4Z',
  database: 'drais',
  ssl: { rejectUnauthorized: false }
};

(async () => {
  const conn = await mysql.createConnection(config);
  const [cols] = await conn.execute("DESCRIBE people");
  console.table(cols);
  
  // Sample data
  const [rows] = await conn.execute("SELECT * FROM people LIMIT 3");
  console.log('\nSample people data:');
  console.table(rows);
  
  await conn.end();
})();

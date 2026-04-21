import mysql from 'mysql2/promise';

// Database configuration
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'drais_school',
  port: parseInt(process.env.DB_PORT || '3306'),
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  acquireTimeout: 60000,
  timeout: 60000,
  reconnect: true
};

// Create connection pool
let pool: mysql.Pool;

const getPool = () => {
  if (!pool) {
    pool = mysql.createPool(dbConfig);
  }
  return pool;
};

/**
 * Execute a database query with parameters
 * @param query SQL query string
 * @param params Query parameters array
 * @returns Promise with query results
 */
export async function executeQuery(query: string, params: unknown[] = []): Promise<unknown> {
  try {
    const connection = getPool();
    const [results] = await connection.execute(query, params);
    return results;
  } catch (error) {
    console.error('Database query error:', error);
    throw error;
  }
}

/**
 * Execute a database query and return the first row
 * @param query SQL query string
 * @param params Query parameters array
 * @returns Promise with first row or null
 */
export async function executeQuerySingle(query: string, params: any[] = []): Promise<any> {
  try {
    const results = await executeQuery(query, params);
    return Array.isArray(results) && results.length > 0 ? results[0] : null;
  } catch (error) {
    console.error('Database query single error:', error);
    throw error;
  }
}

/**
 * Execute a transaction with multiple queries
 * @param queries Array of {query, params} objects
 * @returns Promise with transaction results
 */
export async function executeTransaction(queries: { query: string; params?: unknown[] }[]): Promise<unknown[]> {
  const connection = await getPool().getConnection();
  
  try {
    await connection.beginTransaction();
    
    const results = [];
    for (const { query, params = [] } of queries) {
      const [result] = await connection.execute(query, params);
      results.push(result);
    }
    
    await connection.commit();
    return results;
  } catch (error) {
    await connection.rollback();
    console.error('Database transaction error:', error);
    throw error;
  } finally {
    connection.release();
  }
}

/**
 * Close the database connection pool
 */
export async function closeConnection(): Promise<void> {
  if (pool) {
    await pool.end();
  }
}

/**
 * Test database connection
 */
export async function testConnection(): Promise<boolean> {
  try {
    const connection = getPool();
    await connection.execute('SELECT 1');
    return true;
  } catch (error) {
    console.error('Database connection test failed:', error);
    return false;
  }
}

// Default export for backward compatibility
const DatabaseService = {
  executeQuery,
  executeQuerySingle,
  executeTransaction,
  closeConnection,
  testConnection
};

export default DatabaseService;

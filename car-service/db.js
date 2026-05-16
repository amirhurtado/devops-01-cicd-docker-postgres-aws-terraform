const { Pool } = require('pg');

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

async function init() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS cars (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL,
      model TEXT NOT NULL
    )
  `);
}

module.exports = { pool, init };

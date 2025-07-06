// config/db.js
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  user: process.env.DB_USER,         // DB username
  host: process.env.DB_HOST,         // e.g., localhost
  database: process.env.DB_NAME,     // your DB name
  password: process.env.DB_PASS,     // DB password
  port: process.env.DB_PORT || 5432, // Default port
});

pool.connect((err, client, release) => {
  if (err) {
    console.error('❌ DB Connection Error:', err.message);
  } else {
    client.query('SELECT NOW()', (err, result) => {
      release(); // always release the client back to the pool
      if (err) {
        console.error('❌ Query Failed:', err.message);
      } else {
        console.log('✅ DB Connected:', result.rows[0].now);
      }
    });
  }
});
module.exports = pool;

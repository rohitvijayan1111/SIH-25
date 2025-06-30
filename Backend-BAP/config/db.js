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


module.exports = pool;

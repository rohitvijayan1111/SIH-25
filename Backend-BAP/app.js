// app.js

require('dotenv').config(); // Load .env config first
const express = require('express');
const pool = require('./config/db'); // Your pg Pool setup
const app = express();

// Middleware to parse JSON
app.use(express.json());

// Basic route to check server and DB
app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.send(`✅ BAP Server is running. DB time is: ${result.rows[0].now}`);
  } catch (error) {
    console.error('DB error:', error.message);
    res.status(500).send('❌ BAP Database connection failed');
  }
});



// Start server
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`🚀 Server started on http://localhost:${PORT}`);
});

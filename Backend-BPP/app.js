// app.js
const express = require('express');
const db = require('./config/db');
require('dotenv').config();
const becknRoutes = require('./routes/becknRoutes');

const app = express();
app.use(express.json());

// Simple DB Test Route
app.get('/test-db', async (req, res) => {
  try {
    const result = await db.query('SELECT NOW()');
    res.send(`✅ DB Connected: ${result.rows[0].now}`);
  } catch (err) {
    console.error('❌ DB Connection Error:', err);
    res.status(500).send('Database connection failed');
  }
});
app.use('/', becknRoutes);
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`🚀 Server running at http://localhost:${PORT}`);
});

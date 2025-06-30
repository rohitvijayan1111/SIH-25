
require('dotenv').config();
const express = require('express');
const pool = require('./config/db');
const attachTransactionId = require('./middlewares/transactionMiddleware'); 
const app = express();

// Middleware to parse JSON
app.use(express.json());

app.use(attachTransactionId);


const becknRoutes = require('./routes/becknRoutes');
app.use('/bap', becknRoutes);

// Start server
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`🚀 Server started on http://localhost:${PORT}`);
});

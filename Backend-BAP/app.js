require("dotenv").config();
const express = require("express");
const pool = require("./config/db");
const attachTransactionId = require("./middlewares/transactionMiddleware");
const cartRoutes = require("./cart/cartRoutes");
const app = express();
const cors = require("cors");
// Middleware to parse JSON
app.use(express.json());

app.use(attachTransactionId);
// ✅ Enable CORS
app.use(
  cors({
    origin: "*", // or use specific origin like 'http://localhost:8081'
    methods: ["GET", "POST","PUT","OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

const becknRoutes = require("./routes/becknRoutes");
app.use("/bap", becknRoutes);
app.use("/cart", cartRoutes);

app.get('/test-db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.send(`✅ DB Connected: ${result.rows[0].now}`);
  } catch (err) {
    console.error('❌ DB Connection Error:', err);
    res.status(500).send('Database connection failed');
  }
});

// Start server
const PORT = process.env.PORT;
const HOST = "0.0.0.0"; // Allow external access via LAN IP

app.listen(PORT, HOST, () => {
  console.log(`🚀 Server running at http://0.0.0.0:${PORT}`);
});

// app.js
const express = require("express");
const db = require("./config/db");
require("dotenv").config();
const becknRoutes = require("./routes/becknRoutes");
const batchRoute = require("./routes/batchRoute.js");
const certificateRoutes = require("./routes/certificateRoutes");
const transfersRoutes = require("./routes/transferRoute");
const chain_events = require("./routes/chain_events");
const paymentsRoutes = require("./routes/payments");
const escrowRoutes = require("./routes/escrowsRoutes");
const productsRoutes = require('./routes/products');

const middlemenPurchaseRoutes = require('./routes/middlemenPurchaseController');


const cors = require("cors");
const app = express();
app.use(express.json());

// Simple DB Test Route
app.get("/test-db", async (req, res) => {
  try {
    const result = await db.query("SELECT NOW()");
    res.send(`✅ DB Connected: ${result.rows[0].now}`);
  } catch (err) {
    console.error("❌ DB Connection Error:", err);
    res.status(500).send("Database connection failed");
  }
});
app.use(
  cors({
    origin: "*", // or use specific origin like 'http://localhost:8081'
    methods: ["GET", "POST", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

app.use("/", becknRoutes);
app.use("/api/batches/", batchRoute);
app.use("/api/certificate", certificateRoutes);
app.use("/api/transfers", transfersRoutes);
app.use("/api/chain-events", chain_events);
app.use("/api/payments", paymentsRoutes);
app.use("/api/escrows", escrowRoutes);
app.use('/api/middlemen', middlemenPurchaseRoutes);
app.use('/api/products', productsRoutes);
const PORT = process.env.PORT;
const HOST = "0.0.0.0"; // Allow external access via LAN IP

app.listen(PORT, HOST, () => {
  console.log(`🚀 Server running at http://0.0.0.0:${PORT}`);
});

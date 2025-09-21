const db = require("../config/db");
//Create Payment (Lock Payment)
exports.createPayment = async (req, res) => {
  try {
    const {
      order_id,
      batch_id,
      payer,
      payee,
      amount,
      currency = "INR",
      payment_method,
      payment_status = "INITIATED"
    } = req.body;

    const query = `
      INSERT INTO payments (order_id, batch_id, payer, payee, amount, currency, payment_method, payment_status)
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *;
    `;

    const values = [order_id, batch_id, payer, payee, amount, currency, payment_method, payment_status];
    const result = await db.query(query, values);

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating payment:", err);
    res.status(500).json({ error: "Failed to create payment" });
  }
};

//Release Payment
exports.releasePayment = async (req, res) => {
  try {
    const { id } = req.params;
    const { chain_tx } = req.body;

    const query = `
      UPDATE payments
      SET payment_status = 'RELEASED',
          chain_tx = COALESCE($1, chain_tx)
      WHERE id = $2
      RETURNING id, payment_status, chain_tx;
    `;

    const result = await db.query(query, [chain_tx, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Payment not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error releasing payment:", err);
    res.status(500).json({ error: "Failed to release payment" });
  }
};

//Refund Payment
exports.refundPayment = async (req, res) => {
  try {
    const { id } = req.params;
    const { chain_tx, reason } = req.body;

    const query = `
      UPDATE payments
      SET payment_status = 'REFUNDED',
          chain_tx = COALESCE($1, chain_tx)
      WHERE id = $2
      RETURNING id, payment_status, chain_tx;
    `;

    const result = await db.query(query, [chain_tx, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Payment not found" });

    res.json({ ...result.rows[0], reason });
  } catch (err) {
    console.error("Error refunding payment:", err);
    res.status(500).json({ error: "Failed to refund payment" });
  }
};

//Upload Payment Proof (IPFS CID)
exports.uploadProof = async (req, res) => {
  try {
    const { id } = req.params;
    const { proof_cid } = req.body;

    const query = `
      UPDATE payments
      SET proof_cid = $1
      WHERE id = $2
      RETURNING id, proof_cid;
    `;

    const result = await db.query(query, [proof_cid, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Payment not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error uploading proof:", err);
    res.status(500).json({ error: "Failed to upload proof" });
  }
};

//Get Payment by ID
exports.getPaymentById = async (req, res) => {
  try {
    const { id } = req.params;

    const query = `SELECT * FROM payments WHERE id = $1;`;
    const result = await db.query(query, [id]);

    if (result.rows.length === 0) return res.status(404).json({ error: "Payment not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error fetching payment:", err);
    res.status(500).json({ error: "Failed to fetch payment" });
  }
};

//List Payments (with filters)
exports.listPayments = async (req, res) => {
  try {
    const { status, order_id, batch_id, payer, payee } = req.query;

    let conditions = [];
    let values = [];
    let idx = 1;

    if (status) { conditions.push(`payment_status = $${idx++}`); values.push(status); }
    if (order_id) { conditions.push(`order_id = $${idx++}`); values.push(order_id); }
    if (batch_id) { conditions.push(`batch_id = $${idx++}`); values.push(batch_id); }
    if (payer) { conditions.push(`payer = $${idx++}`); values.push(payer); }
    if (payee) { conditions.push(`payee = $${idx++}`); values.push(payee); }

    const query = `
      SELECT * FROM payments
      ${conditions.length > 0 ? "WHERE " + conditions.join(" AND ") : ""}
      ORDER BY created_at DESC;
    `;

    const result = await db.query(query, values);
    res.json(result.rows);
  } catch (err) {
    console.error("Error listing payments:", err);
    res.status(500).json({ error: "Failed to list payments" });
  }
};

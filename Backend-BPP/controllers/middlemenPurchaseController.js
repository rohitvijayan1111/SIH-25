// controllers/middlemenPurchaseController.js
const db = require("../config/db");

// 1️⃣ Create / Add Purchase
exports.createPurchase = async (req, res) => {
  try {
    const {
      purchase_code,
      middleman_id,
      farmer_id,
      batch_id,
      product_id,
      quantity_kg,
      price_per_kg,
      currency = 'INR',
      payment_mode
    } = req.body;

    const query = `
      INSERT INTO middlemen_purchase
      (purchase_code, middleman_id, farmer_id, batch_id, product_id, quantity_kg, price_per_kg, currency, payment_mode)
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
      RETURNING *;
    `;
    const values = [purchase_code, middleman_id, farmer_id, batch_id, product_id, quantity_kg, price_per_kg, currency, payment_mode];

    const { rows } = await db.query(query, values);

    res.status(201).json({ status: 'success', data: rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 2️⃣ Get Purchase Details
exports.getPurchaseById = async (req, res) => {
  try {
    const { purchase_id } = req.params;

    const { rows } = await db.query(
      'SELECT * FROM middlemen_purchase WHERE id = $1',
      [purchase_id]
    );

    if (!rows.length) return res.status(404).json({ status: 'error', message: 'Purchase not found' });

    res.json({ status: 'success', data: rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 3️⃣ List Purchases
exports.listPurchases = async (req, res) => {
  try {
    const { middleman_id, farmer_id, payment_status, delivery_status } = req.query;

    let query = 'SELECT * FROM middlemen_purchase WHERE 1=1';
    const values = [];
    let idx = 1;

    if (middleman_id) { query += ` AND middleman_id = $${idx++}`; values.push(middleman_id); }
    if (farmer_id) { query += ` AND farmer_id = $${idx++}`; values.push(farmer_id); }
    if (payment_status) { query += ` AND payment_status = $${idx++}`; values.push(payment_status); }
    if (delivery_status) { query += ` AND delivery_status = $${idx++}`; values.push(delivery_status); }

    query += ' ORDER BY purchase_date DESC';

    const { rows } = await db.query(query, values);
    res.json({ status: 'success', data: rows });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 4️⃣ Update Payment Status
exports.updatePaymentStatus = async (req, res) => {
  try {
    const { purchase_id } = req.params;
    const { payment_status, chain_tx, proof_cid } = req.body;

    const query = `
      UPDATE middlemen_purchase
      SET payment_status = $1, chain_tx = COALESCE($2, chain_tx), proof_cid = COALESCE($3, proof_cid), updated_at = NOW()
      WHERE id = $4
      RETURNING *;
    `;
    const values = [payment_status, chain_tx, proof_cid, purchase_id];

    const { rows } = await db.query(query, values);
    if (!rows.length) return res.status(404).json({ status: 'error', message: 'Purchase not found' });

    res.json({ status: 'success', data: rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 5️⃣ Update Delivery Status
exports.updateDeliveryStatus = async (req, res) => {
  try {
    const { purchase_id } = req.params;
    const { delivery_status } = req.body;

    const { rows } = await db.query(
      'UPDATE middlemen_purchase SET delivery_status = $1, updated_at = NOW() WHERE id = $2 RETURNING *',
      [delivery_status, purchase_id]
    );

    if (!rows.length) return res.status(404).json({ status: 'error', message: 'Purchase not found' });

    res.json({ status: 'success', data: rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 6️⃣ Get Blockchain & Proof Details
exports.getProof = async (req, res) => {
  try {
    const { purchase_id } = req.params;
    const { rows } = await db.query(
      'SELECT id, chain_tx, proof_cid FROM middlemen_purchase WHERE id = $1',
      [purchase_id]
    );

    if (!rows.length) return res.status(404).json({ status: 'error', message: 'Purchase not found' });

    res.json({ status: 'success', data: rows[0] });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 7️⃣ Delete / Cancel Purchase
exports.deletePurchase = async (req, res) => {
  try {
    const { purchase_id } = req.params;

    const { rows } = await db.query(
      'SELECT payment_status FROM middlemen_purchase WHERE id = $1',
      [purchase_id]
    );
    if (!rows.length) return res.status(404).json({ status: 'error', message: 'Purchase not found' });
    if (rows[0].payment_status !== 'PENDING')
      return res.status(400).json({ status: 'error', message: 'Cannot delete purchase after payment' });

    await db.query('DELETE FROM middlemen_purchase WHERE id = $1', [purchase_id]);
    res.json({ status: 'success', message: 'Purchase cancelled successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

// 8️⃣ Analytics / Reports
exports.getReport = async (req, res) => {
  try {
    const { middleman_id, from, to } = req.query;

    let query = 'SELECT * FROM middlemen_purchase WHERE 1=1';
    const values = [];
    let idx = 1;

    if (middleman_id) { query += ` AND middleman_id = $${idx++}`; values.push(middleman_id); }
    if (from && to) { query += ` AND purchase_date BETWEEN $${idx++} AND $${idx++}`; values.push(from, to); }

    const { rows } = await db.query(query, values);

    const total_purchases = rows.length;
    const total_quantity = rows.reduce((sum, p) => sum + Number(p.quantity_kg), 0);
    const total_spent = rows.reduce((sum, p) => sum + Number(p.total_price), 0);
    const pending_payments = rows.filter(p => p.payment_status === 'PENDING').length;
    const delivered_batches = rows.filter(p => p.delivery_status === 'DELIVERED').length;

    res.json({
      status: 'success',
      data: { total_purchases, total_quantity, total_spent, pending_payments, delivered_batches }
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 'error', message: error.message });
  }
};

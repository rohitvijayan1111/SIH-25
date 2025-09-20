// controllers/escrowsController.js
const db = require("../config/db");

// 1. Create & Lock Escrow
exports.createEscrow = async (req, res) => {
  try {
    const { escrow_ref, order_id, amount } = req.body;

    const query = `
      INSERT INTO escrows (escrow_ref, order_id, amount, locked, locked_at)
      VALUES ($1, $2, $3, TRUE, NOW())
      RETURNING *;
    `;

    const result = await db.query(query, [escrow_ref, order_id, amount]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating escrow:", err);
    res.status(500).json({ error: "Failed to create escrow" });
  }
};

// 2. Release Escrow
exports.releaseEscrow = async (req, res) => {
  try {
    const { id } = req.params;
    const { chain_tx } = req.body;

    const query = `
      UPDATE escrows
      SET released = TRUE,
          released_at = NOW(),
          chain_tx = COALESCE($1, chain_tx)
      WHERE id = $2
      RETURNING id, escrow_ref, released, released_at, chain_tx;
    `;

    const result = await db.query(query, [chain_tx, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Escrow not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error releasing escrow:", err);
    res.status(500).json({ error: "Failed to release escrow" });
  }
};

// 3. Refund Escrow
exports.refundEscrow = async (req, res) => {
  try {
    const { id } = req.params;
    const { chain_tx, reason } = req.body;

    const query = `
      UPDATE escrows
      SET released = FALSE,
          chain_tx = COALESCE($1, chain_tx)
      WHERE id = $2
      RETURNING id, escrow_ref, released, chain_tx;
    `;

    const result = await db.query(query, [chain_tx, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Escrow not found" });

    res.json({ ...result.rows[0], refunded: true, reason });
  } catch (err) {
    console.error("Error refunding escrow:", err);
    res.status(500).json({ error: "Failed to refund escrow" });
  }
};

// 4. Upload Blockchain Proof
exports.uploadProof = async (req, res) => {
  try {
    const { id } = req.params;
    const { chain_tx } = req.body;

    const query = `
      UPDATE escrows
      SET chain_tx = $1
      WHERE id = $2
      RETURNING id, escrow_ref, chain_tx;
    `;

    const result = await db.query(query, [chain_tx, id]);
    if (result.rows.length === 0) return res.status(404).json({ error: "Escrow not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error uploading proof:", err);
    res.status(500).json({ error: "Failed to upload proof" });
  }
};

// 5. Get Escrow by ID
exports.getEscrowById = async (req, res) => {
  try {
    const { id } = req.params;

    const query = `SELECT * FROM escrows WHERE id = $1;`;
    const result = await db.query(query, [id]);

    if (result.rows.length === 0) return res.status(404).json({ error: "Escrow not found" });

    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error fetching escrow:", err);
    res.status(500).json({ error: "Failed to fetch escrow" });
  }
};

// 6. List Escrows (filters)
exports.listEscrows = async (req, res) => {
  try {
    const { status, order_id, escrow_ref } = req.query;

    let conditions = [];
    let values = [];
    let idx = 1;

    if (status === "locked") conditions.push(`locked = TRUE AND released = FALSE`);
    if (status === "released") conditions.push(`released = TRUE`);
    if (order_id) { conditions.push(`order_id = $${idx++}`); values.push(order_id); }
    if (escrow_ref) { conditions.push(`escrow_ref = $${idx++}`); values.push(escrow_ref); }

    const query = `
      SELECT * FROM escrows
      ${conditions.length > 0 ? "WHERE " + conditions.join(" AND ") : ""}
      ORDER BY locked_at DESC;
    `;

    const result = await db.query(query, values);
    res.json(result.rows);
  } catch (err) {
    console.error("Error listing escrows:", err);
    res.status(500).json({ error: "Failed to list escrows" });
  }
};

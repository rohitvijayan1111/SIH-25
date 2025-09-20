const pool = require("../config/db"); 

// Create new transfer record
const createTransfer = async (req, res) => {
  try {
    const {
      batch_id,
      from_actor,
      to_actor,
      quantity_kg,
      location_name,
      geo_lat,
      geo_lon
    } = req.body;

    if (!batch_id || !from_actor || !to_actor || !quantity_kg) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    const query = `
      INSERT INTO transfers (
        batch_id, from_actor, to_actor, quantity_kg,
        location_name, geo_lat, geo_lon
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING *;
    `;

    const values = [
      batch_id,
      from_actor,
      to_actor,
      quantity_kg,
      location_name,
      geo_lat,
      geo_lon
    ];

    const result = await pool.query(query, values);

    return res.status(201).json({
      message: "Transfer recorded successfully",
      transfer: result.rows[0]
    });

  } catch (err) {
    console.error("Error creating transfer:", err);
    return res.status(500).json({ error: "Internal Server Error" });
  }
};


// Fetch transfer history for a batch
const getTransfersByBatch = async (req, res) => {
  try {
    const { batch_id } = req.params;

    const result = await pool.query(
      `SELECT from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon, timestamp, chain_tx
       FROM transfers
       WHERE batch_id = $1 AND deleted = FALSE
       ORDER BY timestamp ASC`,
      [batch_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "No transfers found for this batch." });
    }

    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching transfers:", error);
    res.status(500).json({ error: "Server error while fetching transfers" });
  }
};


// Fetch Latest Transfer Event for a batch
const getLatestTransferByBatch = async (req, res) => {
  try {
    const { batch_id } = req.params;

    const result = await pool.query(
      `SELECT from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon, timestamp, chain_tx
       FROM transfers
       WHERE batch_id = $1 AND deleted = FALSE
       ORDER BY timestamp DESC
       LIMIT 1`,
      [batch_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "No transfers found for this batch." });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching latest transfer:", error);
    res.status(500).json({ error: "Server error while fetching latest transfer" });
  }
};


// Track Transfers by Actor
const getTransfersByActor = async (req, res) => {
  try {
    const { actor_name } = req.params;

    const result = await pool.query(
      `SELECT batch_id, from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon, timestamp, chain_tx
       FROM transfers
       WHERE (from_actor = $1 OR to_actor = $1) AND deleted = FALSE
       ORDER BY timestamp DESC`,
      [actor_name]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: `No transfers found for actor ${actor_name}` });
    }

    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching transfers by actor:", error);
    res.status(500).json({ error: "Server error while fetching transfers by actor" });
  }
};


// Verify Transfer on Blockchain
const verifyTransferOnChain = async (req, res) => {
  try {
    const { transfer_id } = req.params;

    const result = await pool.query(
      `SELECT id, batch_id, from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon, timestamp, chain_tx
       FROM transfers
       WHERE id = $1 AND deleted = FALSE`,
      [transfer_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Transfer not found" });
    }

    const transfer = result.rows[0];

    const isVerified = transfer.chain_tx ? true : false;

    res.status(200).json({
      transfer_id: transfer.id,
      batch_id: transfer.batch_id,
      chain_tx: transfer.chain_tx,
      verified: isVerified,
      note: isVerified 
        ? "Transfer exists on blockchain" 
        : "Transfer not yet committed to blockchain"
    });
  } catch (error) {
    console.error("Error verifying transfer:", error);
    res.status(500).json({ error: "Server error while verifying transfer" });
  }
};


// Update Transfer
const updateTransfer = async (req, res) => {
  try {
    const { id } = req.params;
    const { from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon } = req.body;

    const check = await pool.query(`SELECT * FROM transfers WHERE id = $1 AND deleted = FALSE`, [id]);
    if (check.rows.length === 0) {
      return res.status(404).json({ message: "Transfer not found" });
    }

    const transfer = check.rows[0];

    if (transfer.chain_tx) {
      return res.status(400).json({ message: "Cannot update transfer after blockchain confirmation" });
    }

    const result = await pool.query(
      `UPDATE transfers
       SET from_actor = COALESCE($1, from_actor),
           to_actor = COALESCE($2, to_actor),
           quantity_kg = COALESCE($3, quantity_kg),
           location_name = COALESCE($4, location_name),
           geo_lat = COALESCE($5, geo_lat),
           geo_lon = COALESCE($6, geo_lon),
           timestamp = CURRENT_TIMESTAMP
       WHERE id = $7
       RETURNING *`,
      [from_actor, to_actor, quantity_kg, location_name, geo_lat, geo_lon, id]
    );

    res.status(200).json({
      message: "Transfer updated successfully",
      updated_transfer: result.rows[0]
    });
  } catch (error) {
    console.error("Error updating transfer:", error);
    res.status(500).json({ error: "Server error while updating transfer" });
  }
};


// Delete Transfer (Soft Delete)
const deleteTransfer = async (req, res) => {
  try {
    const { id } = req.params;

    const check = await pool.query(
      `SELECT * FROM transfers WHERE id = $1 AND deleted = FALSE`,
      [id]
    );

    if (check.rows.length === 0) {
      return res.status(404).json({ message: "Transfer not found or already deleted" });
    }

    const transfer = check.rows[0];

    if (transfer.chain_tx) {
      return res.status(400).json({ message: "Cannot delete transfer after blockchain confirmation" });
    }

    await pool.query(
      `UPDATE transfers 
       SET deleted = TRUE, timestamp = CURRENT_TIMESTAMP
       WHERE id = $1`,
      [id]
    );

    res.status(200).json({ 
      message: "Transfer record deleted (soft delete applied)", 
      transfer_id: id 
    });

  } catch (error) {
    console.error("Error deleting transfer:", error);
    res.status(500).json({ error: "Server error while deleting transfer" });
  }
};


module.exports = { 
  createTransfer,
  getTransfersByBatch,
  getLatestTransferByBatch,
  getTransfersByActor,
  verifyTransferOnChain,
  updateTransfer,
  deleteTransfer
};

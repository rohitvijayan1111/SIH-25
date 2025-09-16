// middleware/blockchainLogger.js
const crypto = require("crypto");
const pool = require("../config/db");
async function logBlockchainEvent(entityType, entityId, action, payload) {
  // hash the payload (immutability)
  const hash = crypto.createHash("sha256")
                     .update(JSON.stringify(payload))
                     .digest("hex");

  // get previous hash (last entry for same entityId)
  const prev = await pool.query(
    "SELECT hash FROM blockchain_ledger WHERE entity_id=$1 ORDER BY created_at DESC LIMIT 1",
    [entityId]
  );

  const prevHash = prev.rows.length > 0 ? prev.rows[0].hash : null;

  // insert into blockchain_ledger
  await pool.query(
    `INSERT INTO blockchain_ledger(entity_type, entity_id, action, hash, prev_hash)
     VALUES ($1, $2, $3, $4, $5)`,
    [entityType, entityId, action, hash, prevHash]
  );
}

module.exports = logBlockchainEvent;

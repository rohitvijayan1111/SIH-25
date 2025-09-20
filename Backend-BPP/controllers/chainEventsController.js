const pool = require("../config/db");

// Record a New Chain Event
const createChainEvent = async (req, res) => {
  try {
    const { event_type, entity_type, entity_id, details, tx_hash } = req.body;

    // Validate required fields
    if (!event_type || !entity_type || !entity_id) {
      return res.status(400).json({ error: "Missing required fields: event_type, entity_type, entity_id" });
    }

    const query = `
      INSERT INTO chain_events (
        event_type, entity_type, entity_id, details, tx_hash
      )
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;

    const values = [event_type, entity_type, entity_id, details || {}, tx_hash || null];

    const result = await pool.query(query, values);

    res.status(201).json({
      message: "Chain event recorded successfully",
      event: result.rows[0]
    });
  } catch (err) {
    console.error("Error creating chain event:", err);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

//Fetch All Chain Events
const getAllChainEvents = async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT id, event_type, entity_type, entity_id, details, tx_hash, created_at
      FROM chain_events
      ORDER BY created_at ASC;
    `);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "No chain events found." });
    }

    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching chain events:", err);
    res.status(500).json({ error: "Server error while fetching chain events" });
  }
};

// Fetch Events by Entity
const getEventsByEntity = async (req, res) => {
  try {
    const { entity_type, entity_id } = req.params;

    const result = await pool.query(
      `SELECT id, event_type, entity_type, entity_id, details, tx_hash, created_at
       FROM chain_events
       WHERE entity_type = $1 AND entity_id = $2
       ORDER BY created_at ASC`,
      [entity_type, entity_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: `No events found for ${entity_type} with ID ${entity_id}` });
    }

    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching events by entity:", err);
    res.status(500).json({ error: "Server error while fetching events by entity" });
  }
};

//Fetch Events by Actor
const getEventsByActor = async (req, res) => {
  try {
    const { actor_name } = req.params;

    const result = await pool.query(
      `SELECT id, event_type, entity_type, entity_id, details, tx_hash, created_at
       FROM chain_events
       WHERE details::text ILIKE $1
       ORDER BY created_at ASC`,
      [`%${actor_name}%`]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: `No events found involving actor ${actor_name}` });
    }

    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching events by actor:", err);
    res.status(500).json({ error: "Server error while fetching events by actor" });
  }
};


// Fetch Latest Event for an Entity
const getLatestEventByEntity = async (req, res) => {
  try {
    const { entity_type, entity_id } = req.params;

    const result = await pool.query(
      `SELECT id, event_type, entity_type, entity_id, details, tx_hash, created_at
       FROM chain_events
       WHERE entity_type = $1 AND entity_id = $2
       ORDER BY created_at DESC
       LIMIT 1`,
      [entity_type, entity_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: `No events found for ${entity_type} with ID ${entity_id}` });
    }

    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("Error fetching latest event for entity:", err);
    res.status(500).json({ error: "Server error while fetching latest event" });
  }
};

//Verify Event on Blockchain
const verifyEventOnChain = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `SELECT id, tx_hash
       FROM chain_events
       WHERE id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Event not found" });
    }

    const event = result.rows[0];

    const isVerified = event.tx_hash ? true : false;

    res.status(200).json({
      event_id: event.id,
      tx_hash: event.tx_hash,
      verified: isVerified,
      note: isVerified
        ? "Event exists on blockchain"
        : "Event not yet committed to blockchain"
    });
  } catch (err) {
    console.error("Error verifying event on blockchain:", err);
    res.status(500).json({ error: "Server error while verifying event" });
  }
};

module.exports = {
  createChainEvent,
  getAllChainEvents,
  getEventsByEntity,
  getEventsByActor,
  getLatestEventByEntity,
  verifyEventOnChain
};

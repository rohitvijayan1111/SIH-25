// controllers/locationController.js

const db = require('../db'); // make sure this points to your pg db config
const { v4: uuidv4 } = require('uuid');

// ✅ Create new location
exports.createLocation = async (req, res) => {
  try {
    const { farmer_id, location_code, gps, address } = req.body;

    if (!farmer_id || !location_code || !address) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const result = await db.query(
      `INSERT INTO locations (id, farmer_id, location_code, gps, address)
       VALUES ($1, $2, $3, $4, $5)
       RETURNING *`,
      [uuidv4(), farmer_id, location_code, gps, address]
    );

    res.status(201).json({ message: 'Location created', data: result.rows[0] });
  } catch (error) {
    console.error('Create Location Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// ✅ Update location by ID
exports.updateLocation = async (req, res) => {
  try {
    const { id } = req.params;
    const { location_code, gps, address } = req.body;

    const result = await db.query(
      `UPDATE locations
       SET location_code = COALESCE($1, location_code),
           gps = COALESCE($2, gps),
           address = COALESCE($3, address),
           created_at = CURRENT_TIMESTAMP
       WHERE id = $4
       RETURNING *`,
      [location_code, gps, address, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Location not found' });
    }

    res.json({ message: 'Location updated', data: result.rows[0] });
  } catch (error) {
    console.error('Update Location Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

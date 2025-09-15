const db = require('../db');  // Your pg-pool or client instance

exports.createFarmer = async (req, res) => {
  try {
    const { name, phone, farm_location, organic_certified, kyc_id } = req.body;

    // Basic validation
    if (!name || !phone) {
      return res.status(400).json({ success: false, error: 'Name and phone are required' });
    }

    const query = `
      INSERT INTO farmers (name, phone, farm_location, organic_certified, kyc_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id, name, phone, farm_location, organic_certified, kyc_id, created_at
    `;

    const values = [
      name,
      phone,
      farm_location || null,
      organic_certified ?? false,
      kyc_id || null
    ];

    const { rows } = await db.query(query, values);

    return res.status(201).json({ success: true, data: rows[0] });

  } catch (error) {
    console.error('Create farmer error:', error);

    // Handle unique constraint on phone nicely
    if (error.code === '23505') {  // unique_violation
      return res.status(409).json({ success: false, error: 'Phone number already exists' });
    }

    return res.status(500).json({ success: false, error: 'Internal server error' });
  }
};
exports.updateFarmer = async (req, res) => {
  const { id } = req.params;
  const updates = req.body;

  // Build the dynamic SQL SET clause
  const fields = Object.keys(updates);
  if (fields.length === 0) {
    return res.status(400).json({ error: 'No fields to update' });
  }

  const setClause = fields.map((field, i) => `${field} = $${i + 1}`).join(', ');
  const values = Object.values(updates);

  try {
    const result = await db.query(
      `UPDATE farmers SET ${setClause}, updated_at = NOW() WHERE id = $${fields.length + 1} RETURNING *`,
      [...values, id]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Farmer not found' });
    }

    res.status(200).json({ message: 'Farmer updated', farmer: result.rows[0] });
  } catch (err) {
    console.error('Update error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};
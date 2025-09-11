const db = require('../db');
const { v4: uuidv4 } = require('uuid');

// Create a new product batch
exports.createProductBatch = async (req, res) => {
  try {
    const { product_id, price_per_unit, quantity, manufactured_on, expiry_date } = req.body;

    if (!product_id || !price_per_unit || !quantity) {
      return res.status(400).json({ error: 'product_id, price_per_unit, and quantity are required' });
    }

    const id = uuidv4();

    const result = await db.query(
      `INSERT INTO product_batches (
        id, product_id, price_per_unit, quantity, manufactured_on, expiry_date
      ) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [id, product_id, price_per_unit, quantity, manufactured_on || null, expiry_date || null]
    );

    res.status(201).json({ message: 'Batch created successfully', batch: result.rows[0] });
  } catch (error) {
    console.error('Error creating batch:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get all batches for a product
exports.getBatchesByProductId = async (req, res) => {
  try {
    const { productId } = req.params;

    const result = await db.query(
      `SELECT * FROM product_batches WHERE product_id = $1 ORDER BY manufactured_on DESC`,
      [productId]
    );

    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error fetching batches:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Update a product batch by ID
exports.updateBatch = async (req, res) => {
  try {
    const { id } = req.params;
    const { price_per_unit, quantity, manufactured_on, expiry_date } = req.body;

    const result = await db.query(
      `UPDATE product_batches
       SET price_per_unit = COALESCE($1, price_per_unit),
           quantity = COALESCE($2, quantity),
           manufactured_on = COALESCE($3, manufactured_on),
           expiry_date = COALESCE($4, expiry_date)
       WHERE id = $5
       RETURNING *`,
      [price_per_unit, quantity, manufactured_on, expiry_date, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Batch not found' });
    }

    res.status(200).json({ message: 'Batch updated successfully', batch: result.rows[0] });
  } catch (error) {
    console.error('Error updating batch:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Delete a product batch
exports.deleteBatch = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await db.query(`DELETE FROM product_batches WHERE id = $1 RETURNING *`, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Batch not found or already deleted' });
    }

    res.status(200).json({ message: 'Batch deleted successfully', deletedBatch: result.rows[0] });
  } catch (error) {
    console.error('Error deleting batch:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get total available quantity for a product
exports.getAvailableQuantity = async (req, res) => {
  try {
    const { productId } = req.params;

    const result = await db.query(
      `SELECT COALESCE(SUM(quantity), 0) AS total_quantity
       FROM product_batches
       WHERE product_id = $1`,
      [productId]
    );

    res.status(200).json({ product_id: productId, available_quantity: parseInt(result.rows[0].total_quantity, 10) });
  } catch (error) {
    console.error('Error fetching quantity:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

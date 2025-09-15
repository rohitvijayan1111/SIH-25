const db = require('../db');
const { v4: uuidv4 } = require('uuid');

exports.createProduct = async (req, res) => {
  try {
    const {
      farmer_id,
      name,
      type,
      unit,
      organic,
      description,
      image_url
    } = req.body;

    if (!farmer_id || !name || !type) {
      return res.status(400).json({ error: 'Required fields: farmer_id, name, type' });
    }

    const id = uuidv4();
    const created_at = new Date();

    const query = `
      INSERT INTO products (
        id, farmer_id, name, type, unit, organic, description, image_url, created_at
      ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
      RETURNING id;
    `;

    const values = [
      id,
      farmer_id,
      name,
      type,
      unit || null,
      organic || false,
      description || null,
      image_url || null,
      created_at
    ];

    const result = await db.query(query, values);

    res.status(201).json({
      message: 'Product created successfully',
      product_id: result.rows[0].id
    });

  } catch (error) {
    console.error('Error creating product:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      type,
      unit,
      organic,
      description,
      image_url
    } = req.body;

    const updated_at = new Date(); // You can also add this to the table if needed

    const query = `
      UPDATE products
      SET
        name = COALESCE($1, name),
        type = COALESCE($2, type),
        unit = COALESCE($3, unit),
        organic = COALESCE($4, organic),
        description = COALESCE($5, description),
        image_url = COALESCE($6, image_url)
      WHERE id = $7
      RETURNING *;
    `;

    const values = [
      name,
      type,
      unit,
      organic,
      description,
      image_url,
      id
    ];

    const result = await db.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.status(200).json({
      message: 'Product updated successfully',
      product: result.rows[0]
    });

  } catch (error) {
    console.error('Error updating product:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await db.query(`DELETE FROM products WHERE id = $1 RETURNING *`, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found or already deleted' });
    }

    res.status(200).json({
      message: 'Product deleted successfully',
      deletedProduct: result.rows[0]
    });

  } catch (error) {
    console.error('Error deleting product:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
exports.getProductsByFarmer = async (req, res) => {
  try {
    const { farmerId } = req.params;

    const query = `
      SELECT 
        p.id AS product_id,
        p.name,
        p.type,
        p.unit,
        p.organic,
        p.description,
        p.image_url,
        p.created_at,
        f.name AS farmer_name,
        f.farm_location
      FROM products p
      JOIN farmers f ON p.farmer_id = f.id
      WHERE p.farmer_id = $1
      ORDER BY p.created_at DESC;
    `;

    const result = await db.query(query, [farmerId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: 'No products found for this farmer' });
    }

    res.status(200).json({
      farmer_id: farmerId,
      products: result.rows
    });

  } catch (error) {
    console.error('Error fetching products by farmer:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

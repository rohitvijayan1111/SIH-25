// controllers/productsController.js
const pool =  require("../config/db");

// 1. Add Product
exports.addProduct = async (req, res) => {
  try {
    const { name, type, unit, description, image_url } = req.body;

    if (!name || !type) {
      return res.status(400).json({ error: 'Name and type are required' });
    }

    const validTypes = ['crop','dairy','livestock','tool','fertilizer','seed'];
    if (!validTypes.includes(type)) {
      return res.status(400).json({ error: 'Invalid product type' });
    }

    const result = await pool.query(
      `INSERT INTO products (name, type, unit, description, image_url)
       VALUES ($1, $2, $3, $4, $5) RETURNING *`,
      [name, type, unit || null, description || null, image_url || null]
    );

    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
};

// 2. Get All Products
exports.getAllProducts = async (req, res) => {
  try {
    const { type, name } = req.query;

    let query = `SELECT * FROM products`;
    const params = [];
    const conditions = [];

    if (type) {
      params.push(type);
      conditions.push(`type = $${params.length}`);
    }
    if (name) {
      params.push(`%${name}%`);
      conditions.push(`name ILIKE $${params.length}`);
    }

    if (conditions.length) {
      query += ' WHERE ' + conditions.join(' AND ');
    }

    const result = await pool.query(query, params);
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
};

// 3. Get Product Details
exports.getProductById = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM products WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
};

// 4. Update Product
exports.updateProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, type, unit, description, image_url } = req.body;

    // Build dynamic update query
    const fields = [];
    const values = [];
    let idx = 1;

    if (name) { fields.push(`name = $${idx++}`); values.push(name); }
    if (type) {
      const validTypes = ['crop','dairy','livestock','tool','fertilizer','seed'];
      if (!validTypes.includes(type)) return res.status(400).json({ error: 'Invalid type' });
      fields.push(`type = $${idx++}`); values.push(type);
    }
    if (unit) { fields.push(`unit = $${idx++}`); values.push(unit); }
    if (description) { fields.push(`description = $${idx++}`); values.push(description); }
    if (image_url) { fields.push(`image_url = $${idx++}`); values.push(image_url); }

    if (fields.length === 0) {
      return res.status(400).json({ error: 'No fields to update' });
    }

    values.push(id); // for WHERE clause
    const query = `UPDATE products SET ${fields.join(', ')} WHERE id = $${idx} RETURNING *`;

    const result = await pool.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
};

// 5. Delete Product
exports.deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('DELETE FROM products WHERE id = $1 RETURNING *', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.json({ message: 'Product deleted successfully' });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
};

const pool = require('../config/db');
const { v4: uuidv4 } = require('uuid');


// ✅ Fetch all orders
exports.getAllOrders = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM orders ORDER BY created_at DESC');
    res.status(200).json({
      success: true,
      count: result.rows.length,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching orders:', error.message);
    res.status(500).json({ success: false, message: 'Server Error' });
  }
};

// ✅ Fetch single order by ID (with items)
exports.getOrderById = async (req, res) => {
  const { id } = req.params;
  try {
    // Fetch order
    const orderResult = await pool.query('SELECT * FROM orders WHERE id = $1', [id]);
    if (orderResult.rows.length === 0) {
      return res.status(404).json({ success: false, message: 'Order not found' });
    }

    // Fetch related items
    const itemsResult = await pool.query(
      'SELECT * FROM order_items WHERE order_id = $1',
      [id]
    );

    res.status(200).json({
      success: true,
      data: {
        ...orderResult.rows[0],
        items: itemsResult.rows,
      },
    });
  } catch (error) {
    console.error('Error fetching order by ID:', error.message);
    res.status(500).json({ success: false, message: 'Server Error' });
  }
};

// ✅ Get all orders by customer (user_id)
exports.getOrdersByCustomer = async (req, res) => {
  const { user_id } = req.params;
  try {
    const result = await pool.query(
      'SELECT * FROM orders WHERE user_id = $1 ORDER BY created_at DESC',
      [user_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: `No orders found for customer ID: ${user_id}`,
      });
    }

    res.status(200).json({
      success: true,
      count: result.rows.length,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching orders by customer ID:', error.message);
    res.status(500).json({ success: false, message: 'Server Error' });
  }
};

// ✅ Get all items for a specific order
exports.getOrderItems = async (req, res) => {
  const { order_id } = req.params;
  try {
    const result = await pool.query(
      'SELECT * FROM order_items WHERE order_id = $1',
      [order_id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: `No items found for order ID: ${order_id}`,
      });
    }

    res.status(200).json({
      success: true,
      count: result.rows.length,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching order items:', error.message);
    res.status(500).json({ success: false, message: 'Server Error' });
  }
};


// ✅ Create new order (and optionally order_items)
exports.createOrder = async (req, res) => {
  const {
    user_id,
    farmer_id,
    total_amount,
    delivery_address,
    items = [], // optional
  } = req.body;

  // Basic validation
  if (!user_id || !farmer_id || !total_amount) {
    return res.status(400).json({
      success: false,
      message: 'Missing required fields: user_id, farmer_id, total_amount',
    });
  }

  const client = await pool.connect();

  try {
    await client.query('BEGIN'); // Start transaction

    // Generate a new order ID
    const orderId = uuidv4();

    // Insert into orders table
    const insertOrderQuery = `
      INSERT INTO orders (id, user_id, farmer_id, total_amount, delivery_address, status, created_at, updated_at)
      VALUES ($1, $2, $3, $4, $5, 'INITIATED', NOW(), NOW())
      RETURNING *;
    `;
    const orderResult = await client.query(insertOrderQuery, [
      orderId,
      user_id,
      farmer_id,
      total_amount,
      delivery_address || null,
    ]);

    // If order_items are provided, insert them
    if (items.length > 0) {
      const insertItemQuery = `
        INSERT INTO order_items (id, order_id, bpp_product_id, item_name, quantity, unit_price, batch_id)
        VALUES ($1, $2, $3, $4, $5, $6, $7);
      `;

      for (const item of items) {
        await client.query(insertItemQuery, [
          uuidv4(),
          orderId,
          item.bpp_product_id,
          item.item_name,
          item.quantity,
          item.unit_price,
          item.batch_id,
        ]);
      }
    }

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: 'Order created successfully',
      order: orderResult.rows[0],
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating order:', error.message);
    res.status(500).json({ success: false, message: 'Server Error' });
  } finally {
    client.release();
  }
};

const db = require('../config/db');
const { v4: uuidv4 } = require('uuid');

exports.addToCart = async (req, res) => {
  try {
    const {
      user_id,
      bpp_id,
      bpp_product_id,
      provider_id,
      provider_name,
      provider_address,
      fulfillment_id,
      item_name,
      quantity,
      unit_price
    } = req.body;

    const insertQuery = `
      INSERT INTO user_cart (
        id, user_id, bpp_id, bpp_product_id, provider_id, provider_name,
        provider_address, fulfillment_id, item_name,
        quantity, unit_price
      )
      VALUES (
        $1, $2, $3, $4, $5, $6,
        $7, $8, $9,
        $10, $11
      )
      ON CONFLICT (user_id, bpp_product_id, provider_id)
      DO UPDATE SET
        quantity = EXCLUDED.quantity,
        unit_price = EXCLUDED.unit_price,
        provider_name = EXCLUDED.provider_name,
        provider_address = EXCLUDED.provider_address,
        fulfillment_id = EXCLUDED.fulfillment_id,
        item_name = EXCLUDED.item_name,
        added_at = CURRENT_TIMESTAMP;
    `;

    const values = [
      uuidv4(), user_id, bpp_id, bpp_product_id, provider_id, provider_name,
      provider_address, fulfillment_id, item_name,
      quantity, unit_price
    ];

    await db.query(insertQuery, values);

    res.status(201).json({ message: 'Item added or updated in cart' });
  } catch (error) {
    console.error('Add to Cart Error:', error);
    res.status(500).json({ error: 'Failed to add/update item in cart' });
  }
};



exports.updateCartItem = async (req, res) => {
  try {
    const {
      user_id,
      bpp_product_id,
      provider_id,
      quantity
    } = req.body;

    if (quantity <= 0) {
      await db.query(
        `DELETE FROM user_cart WHERE user_id = $1 AND bpp_product_id = $2 AND provider_id = $3`,
        [user_id, bpp_product_id, provider_id]
      );
      return res.status(200).json({ message: 'Item removed from cart' });
    }

    const updateQuery = `
      UPDATE user_cart
      SET quantity = $1
      WHERE user_id = $2 AND bpp_product_id = $3 AND provider_id = $4
    `;

    await db.query(updateQuery, [quantity, user_id, bpp_product_id, provider_id]);

    res.status(200).json({ message: 'Cart updated successfully' });
  } catch (error) {
    console.error('Update Cart Error:', error);
    res.status(500).json({ error: 'Failed to update cart' });
  }
};


exports.viewCart = async (req, res) => {
  try {
    const { user_id } = req.params;

    const query = `
      SELECT 
        provider_id,
        provider_name,
        provider_address,
        bpp_product_id,
        bpp_id,
        fulfillment_id,
        item_name,
        quantity,
        unit_price,
        (quantity * unit_price) AS total_price
      FROM user_cart
      WHERE user_id = $1
      ORDER BY provider_name, item_name
    `;

    const { rows } = await db.query(query, [user_id]);

    // ✅ Group by provider_id
    const groupedCart = {};
    for (const row of rows) {
      const {
        provider_id,
        provider_name,
        provider_address,
        bpp_product_id,
        bpp_id,
        fulfillment_id,
        item_name,
        quantity,
        unit_price,
        total_price
      } = row;

      if (!groupedCart[provider_id]) {
        groupedCart[provider_id] = {
          provider_id,
          provider_name,
          provider_address,
          items: []
        };
      }

      groupedCart[provider_id].items.push({
        bpp_product_id,
        bpp_id,
        fulfillment_id,
        item_name,
        quantity,
        unit_price: parseFloat(unit_price),
        total_price: parseFloat(total_price)
      });
    }

    res.status(200).json({
      user_id,
      cart: Object.values(groupedCart)
    });

  } catch (error) {
    console.error('View Cart Error:', error);
    res.status(500).json({ error: 'Failed to fetch cart' });
  }
};


exports.clearCart = async (req, res) => {
  try {
    const { user_id, provider_id } = req.body;

    if (!user_id) {
      return res.status(400).json({ error: 'user_id is required' });
    }

    if (provider_id) {
      // Clear cart items for specific provider
      await db.query(
        `DELETE FROM user_cart WHERE user_id = $1 AND provider_id = $2`,
        [user_id, provider_id]
      );
      return res.status(200).json({
        message: `🧹 Cart cleared for provider: ${provider_id}`,
      });
    }

    // Clear entire cart for user
    await db.query(
      `DELETE FROM user_cart WHERE user_id = $1`,
      [user_id]
    );

    res.status(200).json({ message: '🧹 Entire cart cleared successfully' });
  } catch (error) {
    console.error('Clear Cart Error:', error);
    res.status(500).json({ error: 'Failed to clear cart' });
  }
};
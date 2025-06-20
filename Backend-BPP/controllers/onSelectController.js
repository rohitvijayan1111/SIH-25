const db = require('../config/db'); // PG Client setup

// Handle /on_select request
exports.handleSelect = async (req, res) => {
  try {
    const { items } = req.body.message.catalog; // selected items from BAP

    // Collect product IDs from request
    const productIds = items.map(item => item.id);

    // Query product availability and price
    const query = `
      SELECT 
        p.id AS product_id,
        p.name AS product_name,
        p.stock,
        p.unit,
        pl.price_per_unit,
        pl.valid_from,
        pl.valid_to,
        cf.fulfillment_code,
        cf.gps AS fulfillment_gps,
        cf.address AS fulfillment_address
      FROM products p
      INNER JOIN price_list pl ON p.id = pl.product_id
      INNER JOIN catalog_fulfillments cf ON p.farmer_id = cf.farmer_id
      WHERE p.id = ANY($1)
        AND CURRENT_DATE BETWEEN pl.valid_from AND pl.valid_to
    `;

    const { rows } = await db.query(query, [productIds]);

    // Validate stock and prepare items response
    const responseItems = rows.map(row => ({
      id: row.product_id,
      descriptor: {
        name: row.product_name
      },
     quantity: {
  available: { count: row.stock },
  unitized: {
    measure: {
      unit: row.unit || 'unit'
    }
  }
},
price: {
  currency: 'INR',
  value: Number(row.price_per_unit).toFixed(2)
}
,
      fulfillment: {
        fulfillment_id: row.fulfillment_code,
        location: {
          gps: row.fulfillment_gps,
          address: row.fulfillment_address
        }
      }
    }));

    // Build ONDC /on_select response
    const response = {
      context: {
        domain: 'agri.bpp',
        action: 'on_select',
        timestamp: new Date().toISOString(),
        message_id: req.body.context.message_id,
        transaction_id: req.body.context.transaction_id
      },
      message: {
        catalog: {
          items: responseItems
        }
      }
    };

    res.json(response);
  } catch (error) {
    console.error('on_select error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

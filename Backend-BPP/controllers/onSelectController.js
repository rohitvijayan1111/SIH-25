const db = require('../config/db');

exports.handleSelect = async (req, res) => {
  try {
    const { items } = req.body.message.catalog;
    const productIds = items.map(item => item.id);

    const query = `
      SELECT 
        p.id AS product_id,
        p.name AS product_name,
        p.type AS category_id,
        p.unit,
        p.stock,
        p.organic,
        pl.price_per_unit,
        cf.fulfillment_code,
        cf.type AS fulfillment_type,
        cf.gps AS fulfillment_gps,
        cf.address AS fulfillment_address,
        l.location_code AS location_id,
        l.gps AS location_gps,
        l.address AS location_address,
        f.id AS provider_id,
        f.name AS provider_name
      FROM products p
      INNER JOIN price_list pl ON p.id = pl.product_id
      INNER JOIN catalog_fulfillments cf ON p.farmer_id = cf.farmer_id
      INNER JOIN locations l ON p.farmer_id = l.farmer_id
      INNER JOIN farmers f ON p.farmer_id = f.id
      WHERE p.id = ANY($1)
        AND CURRENT_DATE BETWEEN pl.valid_from AND pl.valid_to
    `;

    const { rows } = await db.query(query, [productIds]);

    const providersMap = new Map();
    const fulfillmentMap = new Map();

    for (const row of rows) {
      // ✅ Group fulfillments
      if (!fulfillmentMap.has(row.fulfillment_code)) {
        fulfillmentMap.set(row.fulfillment_code, {
          id: row.fulfillment_code,
          type: row.fulfillment_type || 'Self-Pickup',
          location: {
            gps: row.fulfillment_gps,
            address: row.fulfillment_address
          }
        });
      }

      // ✅ Prepare item
      const item = {
        id: row.product_id,
        descriptor: {
          name: row.product_name,
          code: row.product_id.slice(0, 12)
        },
        category_id: row.category_id,
        location_id: row.location_id,
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
        },
        tags: [
          {
            code: 'organic',
            value: row.organic ? 'true' : 'false'
          }
        ],
        fulfillment_id: row.fulfillment_code,
        matched: true,
        ttl: 'PT1H'
      };

      // ✅ Group by provider
      if (!providersMap.has(row.provider_id)) {
        providersMap.set(row.provider_id, {
          id: row.provider_id,
          descriptor: {
            name: row.provider_name
          },
          locations: [
            {
              id: row.location_id,
              gps: row.location_gps,
              address: row.location_address
            }
          ],
          items: [item]
        });
      } else {
        providersMap.get(row.provider_id).items.push(item);
      }
    }

    // ✅ Construct ONDC response
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
          providers: Array.from(providersMap.values()),
          fulfillments: Array.from(fulfillmentMap.values())
        }
      }
    };

    res.json(response);
  } catch (error) {
    console.error('on_select error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

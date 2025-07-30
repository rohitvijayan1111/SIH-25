const db = require('../config/db');

exports.handleSelect = async (req, res) => {
  try {
   const item = req.body.message?.catalog?.items?.[0];

    const productId = item?.id;
    if (!productId) {
      return res.status(400).json({ error: 'Product ID missing in request' });
    }
  const query = ` 
  SELECT 
    p.id AS product_id,
    p.name AS product_name,
    p.type AS category_id,
    p.unit,
    p.organic,
    p.description,
    p.image_url,

    pb.id AS batch_id,
    pb.price_per_unit,
    pb.quantity,
    pb.manufactured_on,
    pb.expiry_date,

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
  INNER JOIN product_batches pb 
    ON p.id = pb.product_id
  INNER JOIN catalog_fulfillments cf 
    ON p.farmer_id = cf.farmer_id
  INNER JOIN locations l 
    ON p.farmer_id = l.farmer_id
  INNER JOIN farmers f 
    ON p.farmer_id = f.id

  WHERE p.id = $1
    AND (pb.expiry_date IS NULL OR pb.expiry_date > CURRENT_DATE)
    AND pb.quantity > 0

  ORDER BY pb.manufactured_on DESC
  LIMIT 5;
`;


    const { rows } = await db.query(query, [productId]);
    console.log(rows);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Product not found or not available' });
    }

   const firstRow = rows[0];

    // 🔁 Collect batches from all rows
    const batches = rows.map(row => ({
      price: {
        currency: 'INR',
        value: Number(row.price_per_unit).toFixed(2)
      },
      expiry_date: row.expiry_date
    }));

    const itemData = {
      id: firstRow.product_id,
      descriptor: {
        name: firstRow.product_name,
        description: firstRow.description,
        image: firstRow.image_url,
        code: firstRow.product_id.slice(0, 12)
      },
      category_id: firstRow.category_id,
      location_id: firstRow.location_id,
      quantity: {
        available: {
          count: rows.reduce((sum, r) => sum + Number(r.quantity), 0)
        },
        unitized: {
          measure: {
            unit: firstRow.unit || 'unit'
          }
        }
      },
      // price: {
      //   currency: 'INR',
      //   value: Number(firstRow.price_per_unit).toFixed(2) // main price
      // },
      batches, // ✅ include all batches
      tags: [
        {
          code: 'organic',
          value: firstRow.organic ? 'true' : 'false'
        }
      ],
      fulfillment_id: firstRow.fulfillment_code,
      matched: true,
      ttl: 'PT1H'
    };

    const provider = {
      id: firstRow.provider_id,
      descriptor: {
        name: firstRow.provider_name
      },
      locations: [
        {
          id: firstRow.location_id,
          gps: firstRow.location_gps,
          address: firstRow.location_address
        }
      ],
      items: [itemData]
    };

    const fulfillment = {
      id: firstRow.fulfillment_code,
      type: firstRow.fulfillment_type || 'Self-Pickup',
      location: {
        gps: firstRow.fulfillment_gps,
        address: firstRow.fulfillment_address
      }
    };

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
          providers: [provider],
          fulfillments: [fulfillment]
        }
      }
    };

    res.json(response);
  } catch (error) {
    console.error('on_select error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};
const pool = require('../config/db');
const { v4: uuidv4 } = require('uuid');

async function handleOnInit({ items, transaction_id, customer_location }) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const ordersItems = [];
    let totalPrice = 0;
    let providerId = null;
    let providerName = null;
    let fulfillment = null;

    for (const item of items) {
      if (!item.id || !item.quantity || item.quantity <= 0) {
        throw new Error(`Invalid item data: id=${item.id}, quantity=${item.quantity}`);
      }

      // STEP 1: Fetch product + batch info using batch_id (item.id assumed to be batch_id)
      const productQuery = `
        SELECT 
          p.id AS product_id,
          p.name,
          p.unit,
          p.image_url,
          p.organic,
          pb.id AS batch_id,
          pb.price_per_unit,
          pb.quantity,
          f.id AS farmer_id,
          f.name AS farmer_name
        FROM product_batches pb
        INNER JOIN products p ON pb.product_id = p.id
        INNER JOIN farmers f ON p.farmer_id = f.id
        WHERE pb.id = $1
          AND pb.quantity >= $2
          AND (pb.expiry_date IS NULL OR pb.expiry_date > CURRENT_DATE)
      `;
      const productRes = await client.query(productQuery, [item.id, item.quantity]);

      if (productRes.rows.length === 0) {
        throw new Error(`No available product batch found for batch_id ${item.id} with required quantity ${item.quantity}`);
      }

      const product = productRes.rows[0];

      // STEP 2: Save provider and fulfillment info once
      if (!providerId) {
        providerId = product.farmer_id;
        providerName = product.farmer_name;

        const fulfillQuery = `
          SELECT fulfillment_code, type, gps, address, estimated_delivery
          FROM catalog_fulfillments
          WHERE farmer_id = $1
          LIMIT 1
        `;
        const fulfillRes = await client.query(fulfillQuery, [providerId]);

        if (fulfillRes.rows.length === 0) {
          throw new Error(`Fulfillment info not found for farmer_id ${providerId}`);
        }
        fulfillment = fulfillRes.rows[0];
      }

      const unitPrice = parseFloat(product.price_per_unit);
      if (isNaN(unitPrice)) {
        throw new Error(`Invalid price for batch_id ${product.batch_id}`);
      }
      const itemTotalPrice = unitPrice * item.quantity;
      totalPrice += itemTotalPrice;

      // STEP 3: Prepare order item object
      ordersItems.push({
        id: product.product_id,
        quantity: {
          count: item.quantity,
          unitized: {
            measure: {
              unit: product.unit
            }
          }
        },
        price: {
          currency: 'INR',
          value: unitPrice.toFixed(2)
        },
        descriptor: {
          name: product.name,
          images: product.image_url ? [product.image_url] : []
        },
        fulfillment_id: fulfillment.fulfillment_code,
        tags: [
          {
            code: 'organic',
            value: String(product.organic)
          }
        ]
      });
    }

    const order_id = uuidv4();
    const message_id = `msg-${Date.now()}`;

    await client.query('COMMIT');

    return {
      context: {
        domain: 'agri.bpp',
        action: 'on_init',
        timestamp: new Date().toISOString(),
        transaction_id,
        message_id
      },
      message: {
        order: {
          id: order_id,
          provider: {
            id: providerId,
            descriptor: {
              name: providerName
            }
          },
          items: ordersItems,
          quote: {
            price: { currency: 'INR', value: totalPrice.toFixed(2) },
            breakup: ordersItems.map(item => ({
              title: `${item.descriptor.name} (${item.quantity.count} ${item.quantity.unitized.measure.unit})`,
              price: {
                currency: 'INR',
                value: (parseFloat(item.price.value) * item.quantity.count).toFixed(2)
              }
            }))
          },
          fulfillment: {
            id: fulfillment.fulfillment_code,
            type: fulfillment.type || 'Self-Pickup',
            start: {
              location: {
                gps: fulfillment.gps,
                address: fulfillment.address
              }
            },
            end: {
              location: customer_location
            },
            estimated_delivery: fulfillment.estimated_delivery
              ? new Date(fulfillment.estimated_delivery).toISOString()
              : null,
            state: {
              descriptor: {
                code: 'RECEIVED'
              }
            }
          },
          payment: {
            type: 'ON-ORDER',
            collected_by: 'BAP',
            status: 'NOT-PAID',
            ttl: 'PT15M'
          }
        }
      }
    };

  } catch (err) {
    await client.query('ROLLBACK');
    console.error('❌ Error in handleOnInit:', err.message);
    throw err;
  } finally {
    client.release();
  }
}

module.exports = { handleOnInit };

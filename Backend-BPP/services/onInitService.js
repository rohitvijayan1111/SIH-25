const pool = require('../config/db');
const { v4: uuidv4 } = require('uuid');

async function handleOnInit({ items, transaction_id, customer_location }) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');

    const order_id = uuidv4();
    const message_id = `msg-${Date.now()}`;
    const ordersItems = [];
    let totalPrice = 0;
    let totalQuantity = 0;
    let totalWeightKg = 0;
    let providerId = null;
    let providerName = null;
    let fulfillment = null;

    for (const item of items) {
      if (!item.id || !item.quantity || item.quantity <= 0) {
        console.warn(`⚠️ Skipping invalid item: id=${item.id}, quantity=${item.quantity}`);
        continue;
      }

      const batchQuery = `
        SELECT 
          p.id AS product_id,
          p.name,
          p.unit,
          p.image_url,
          p.organic,
          p.weight,              -- weight per unit in kg
          pb.id AS batch_id,
          pb.price_per_unit,
          pb.quantity AS available_qty,
          f.id AS farmer_id,
          f.name AS farmer_name
        FROM product_batches pb
        INNER JOIN products p ON pb.product_id = p.id
        INNER JOIN farmers f ON p.farmer_id = f.id
        WHERE p.id = $1
          AND pb.quantity > 0
          AND (pb.expiry_date IS NULL OR pb.expiry_date > CURRENT_DATE)
        ORDER BY pb.expiry_date ASC NULLS LAST
        LIMIT 1
      `;

      const res = await client.query(batchQuery, [item.id]);

      if (res.rows.length === 0) {
        console.warn(`⚠️ Skipping unavailable product: product_id ${item.id}`);
        continue;
      }

      const product = res.rows[0];

      const fulfillQuery = `
        SELECT fulfillment_code, type, gps, address, estimated_delivery
        FROM catalog_fulfillments
        WHERE farmer_id = $1
        LIMIT 1
      `;

      if (!providerId) {
        providerId = product.farmer_id;
        providerName = product.farmer_name;

        const fulfillRes = await client.query(fulfillQuery, [providerId]);
        if (fulfillRes.rows.length === 0) {
          throw new Error(`No fulfillment config found for farmer_id ${providerId}`);
        }
        fulfillment = fulfillRes.rows[0];
      }

      const availableQty = product.available_qty;
      const servedQty = Math.min(availableQty, item.quantity);

      totalQuantity += servedQty;

      // Calculate total weight in kg using product.weight (per unit kg)
      const weightPerUnitKg = parseFloat(product.weight) || 0;
      totalWeightKg += servedQty * weightPerUnitKg;

      const unitPrice = parseFloat(product.price_per_unit);
      const itemTotalPrice = unitPrice * servedQty;
      totalPrice += itemTotalPrice;

      ordersItems.push({
        id: product.product_id,
        quantity: {
          count: servedQty,
          unitized: {
            measure: { unit: product.unit }
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
          total_quantity: totalQuantity,
          total_weight_kg: parseFloat(totalWeightKg.toFixed(3)),  // total weight rounded to 3 decimals
          quote: {
            price: {
              currency: 'INR',
              value: totalPrice.toFixed(2)
            },
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

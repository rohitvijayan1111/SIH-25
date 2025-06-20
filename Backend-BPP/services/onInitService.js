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
      const productQuery = `
        SELECT p.id, p.name, p.unit, p.stock, p.image_url, p.organic,
               pl.price_per_unit,
               f.id as farmer_id, f.name as farmer_name
        FROM products p
        JOIN price_list pl ON p.id = pl.product_id
        JOIN farmers f ON p.farmer_id = f.id
        WHERE p.id = $1 AND pl.valid_from <= CURRENT_DATE AND pl.valid_to >= CURRENT_DATE
      `;
      const productRes = await client.query(productQuery, [item.id]);
      if (productRes.rows.length === 0) throw new Error(`Product or valid price not found for product id ${item.id}`);

      const product = productRes.rows[0];

      if (product.stock < item.quantity) throw new Error(`Insufficient stock for product ${product.name}`);

      // Save provider info once
      if (!providerId) {
        providerId = product.farmer_id;
        providerName = product.farmer_name;

        const fulfillQuery = `
          SELECT fulfillment_code, type, gps, address, estimated_delivery
          FROM catalog_fulfillments
          WHERE farmer_id = $1 LIMIT 1
        `;
        const fulfillRes = await client.query(fulfillQuery, [providerId]);
        if (fulfillRes.rows.length === 0) throw new Error('Fulfillment info not available');
        fulfillment = fulfillRes.rows[0];
      }

      const unitPrice = parseFloat(product.price_per_unit);
      const itemTotalPrice = unitPrice * item.quantity;
      totalPrice += itemTotalPrice;

      ordersItems.push({
        id: product.id,
        quantity: {
          count: item.quantity,
          unitized: {
            measure: {
              unit: product.unit
            }
          }
        },
        price: { currency: 'INR', value: unitPrice.toFixed(2) },
        descriptor: {
          name: product.name,
          images: [product.image_url]
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

    const order_id = `order-locked-${uuidv4()}`;
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
    throw err;
  } finally {
    client.release();
  }
}

module.exports = { handleOnInit };

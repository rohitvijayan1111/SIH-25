const { v4: uuidv4 } = require("uuid");
const db = require("../config/db"); // Pool (not using defaults like db.none)

exports.handleConfirm = async (req, res) => {
  try {
    const { context, message } = req.body;
    if (!context || !message?.order) {
      return res.status(400).json({ error: "Missing context or message.order in request body" });
    }

    const order = message.order;
    const bapOrderId = order.id || `order-${uuidv4()}`;
    const farmerId = order.provider?.id;
    const totalPrice = parseFloat(order.quote?.price?.value);
    const paymentStatus = order.payment?.status;
    const paymentTxnId = order.payment?.transaction_id;
    const deliveryAddress = order.fulfillment?.end?.location?.address;
    const buyerContact = order.fulfillment?.end?.contact?.phone;
    const estimatedDelivery = order.fulfillment?.estimated_delivery;
    const items = order.items;

    if (!farmerId || !totalPrice || !paymentStatus || !deliveryAddress || !buyerContact || !estimatedDelivery || !Array.isArray(items)) {
      return res.status(400).json({ error: "Missing required order fields" });
    }

    const newOrderId = uuidv4();
    const fulfillmentId = uuidv4();
    const breakup = [];

   await db.query(
  `INSERT INTO orders (
      id, bap_order_id, farmer_id, total_price, payment_status,
      delivery_address, buyer_contact, payment_transaction_id
   )
   VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
  [
    newOrderId,
    bapOrderId,
    farmerId,
    totalPrice,
    paymentStatus,
    deliveryAddress,
    buyerContact,
    paymentTxnId
  ]
);


    for (const item of items) {
      const productId = item.id;
      const quantity = item.quantity?.count;

      if (!productId || typeof quantity !== "number") {
        return res.status(400).json({ error: "Missing item id or quantity" });
      }

      const productRes = await db.query(
        `SELECT p.name, pl.price_per_unit FROM products p
         JOIN price_list pl ON p.id = pl.product_id
         WHERE p.id = $1 AND CURRENT_DATE BETWEEN pl.valid_from AND pl.valid_to
         LIMIT 1`,
        [productId]
      );

      if (!productRes.rowCount) {
        return res.status(404).json({ error: `Product or pricing not found for ID: ${productId}` });
      }

      const { name, price_per_unit } = productRes.rows[0];
      const itemTotal = price_per_unit * quantity;

      await db.query(
        `UPDATE products SET stock = stock - $1 WHERE id = $2 AND stock >= $1`,
        [quantity, productId]
      );

      await db.query(
        `INSERT INTO order_fulfillments (id, order_id, bpp_product_id, farmer_id, status, estimated_delivery)
         VALUES ($1, $2, $3, $4, 'RECEIVED', $5)`,
        [uuidv4(), bapOrderId, productId, farmerId, estimatedDelivery]
      );

      await db.query(
        `INSERT INTO inventory_logs (id, product_id, change_type, quantity, reason)
         VALUES ($1, $2, 'OUT', $3, 'Order Confirmed')`,
        [uuidv4(), productId, quantity]
      );

      breakup.push({
        title: `${name} (${quantity})`,
        price: { currency: "INR", value: itemTotal.toFixed(2) }
      });

      item.descriptor = { name };
    }

    order.provider.descriptor = { name: "Thanjavur Organic Farmer Group" }; // Optional: can be fetched from DB

    const response = {
      context: {
        domain: "agri.bpp",
        action: "on_confirm",
        version: "1.2.0",
        transaction_id: context.transaction_id,
        message_id: `msg-${uuidv4()}`,
        timestamp: new Date().toISOString()
      },
      message: {
        order: {
          id: bapOrderId,
          provider: order.provider,
          items: items.map(item => ({
            id: item.id,
            descriptor: item.descriptor,
            quantity: item.quantity,
            fulfillment_id: fulfillmentId
          })),
          quote: {
            price: order.quote.price,
            breakup
          },
          fulfillment: {
            id: fulfillmentId,
            type: "Delivery",
            start: {
              location: { address: "Farmer Market, Thanjavur" }
            },
            end: order.fulfillment.end,
            estimated_delivery: estimatedDelivery,
            state: {
              descriptor: { code: "CONFIRMED" }
            }
          },
          billing: order.billing,
          payment: order.payment,
          customer: order.customer
        }
      }
    };

    res.status(200).json(response);
  } catch (error) {
    console.error("Error in handleConfirm:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};
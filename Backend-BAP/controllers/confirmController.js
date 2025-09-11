const { v4: uuidv4 } = require("uuid");
const db = require("../config/db");

exports.handleConfirm = async (req, res) => {
  try {
    const { context, message } = req.body;
    if (!context || !message?.order) {
      return res.status(400).json({ error: "Missing context or message.order in request body" });
    }

    const order = message.order;
   const bapOrderId = order.id;
    const farmerId = order.provider?.id;
    const totalAmount = parseFloat(order.quote?.price?.value);
    const rawStatus = order.payment?.status;
    const paymentStatus = rawStatus === 'PAID' ? 'COMPLETED' : rawStatus;
    const paymentTxnId = order.payment?.transaction_id;
    const deliveryAddress = order.fulfillment?.end?.location?.address;
    const buyerContact = order.fulfillment?.end?.contact?.phone;
    const estimatedDelivery = order.fulfillment?.estimated_delivery;
    const items = order.items;

    if (!farmerId || !totalAmount || !paymentStatus || !deliveryAddress || !buyerContact || !estimatedDelivery || !Array.isArray(items)) {
      return res.status(400).json({ error: "Missing required order fields" });
    }

    const userRes = await db.query(
      `SELECT id FROM users WHERE phone = $1 LIMIT 1`,
      [buyerContact]
    );
    if (userRes.rowCount === 0) {
      return res.status(404).json({ error: "User not found for given phone number" });
    }
    const userId = userRes.rows[0].id;

    const newOrderId = uuidv4();
    const fulfillmentId = order.fulfillment?.id || uuidv4();

    await db.query(
      `INSERT INTO orders (
        id, user_id, bpp_id, farmer_id, fulfillment_id, status,
        total_amount, delivery_address
      ) VALUES ($1, $2, $3, $4, $5, 'CONFIRMED', $6, $7)`,
      [bapOrderId, userId, context.domain, farmerId, fulfillmentId, totalAmount, deliveryAddress]
    );

    await db.query(
      `INSERT INTO payment_transactions (
        id, order_id, method, amount, payment_status, transaction_ref
      ) VALUES ($1, $2, $3, $4, $5, $6)`,
      [uuidv4(), bapOrderId, order.payment?.type || 'UNKNOWN', totalAmount, paymentStatus, paymentTxnId]
    );

    const breakup = [];

    for (const item of items) {
      const productId = item.id;
      const quantity = item.quantity?.count;
      if (!productId || typeof quantity !== "number") {
        return res.status(400).json({ error: "Missing item id or quantity" });
      }

      const unitPrice = parseFloat(order.quote.breakup.find(b => b.title.includes(productId))?.price?.value) / quantity || 70.00;
      const itemTotal = unitPrice * quantity;

      await db.query(
        `INSERT INTO order_items (id, order_id, bpp_product_id, item_name, quantity, unit_price)
         VALUES ($1, $2, $3, $4, $5, $6)`,
        [uuidv4(), bapOrderId, productId, item.id, quantity, unitPrice]
      );

      breakup.push({
        title: `${item.id} (${quantity})`,
        price: { currency: "INR", value: itemTotal.toFixed(2) }
      });
    }

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
          provider: {
            id: farmerId,
            descriptor: { name: "Thanjavur Organic Farmer Group" }
          },
          items: items.map(item => ({
            id: item.id,
            descriptor: { name: item.id },
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

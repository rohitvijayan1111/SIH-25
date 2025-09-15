const { handleOnInit } = require('../services/onInitService');

exports.onInit = async (req, res) => {
  try {
    const order = req.body.message.order;
    const context = req.body.context;

    const transaction_id = context.transaction_id;
    const customer_location = order.fulfillment?.end?.location;
    const provider = order.provider;

    if (!order.items || order.items.length === 0) {
      return res.status(400).json({ error: "No items in order" });
    }

    // Optional: Validate if all items belong to the same provider
    const providerIdFromItems = provider?.id || null;

    const items = order.items.map(item => ({
      id: item.id,
      quantity: item.quantity?.count || 0,
      fulfillment_id: item.fulfillment_id || order.fulfillment?.id || null
    }));

    // You may fetch product or provider info from DB inside handleOnInit
    const result = await handleOnInit({
      items,
      transaction_id,
      customer_location,
      provider_id: providerIdFromItems
    });

    return res.json(result);
  } catch (err) {
    console.error("onInit error:", err);
    return res.status(500).json({ error: err.message });
  }
};

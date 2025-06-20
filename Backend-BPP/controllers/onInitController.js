// controllers/onInitController.js
const { handleOnInit } = require('../services/onInitService');

exports.onInit = async (req, res) => {
  try {
    const input = req.body.message.order;
    const transaction_id = req.body.context.transaction_id;
    const customer_location = input.fulfillment?.end?.location;

    // Pass all items array, mapping each item to {id, quantity.count}
    const items = input.items.map(item => ({
      id: item.id,
      quantity: item.quantity.count
    }));

    const result = await handleOnInit({
      items,
      transaction_id,
      customer_location
    });

    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const express = require('express');
const router = express.Router();
const orderController =require('../controllers/orderController');

// 🆕 Create new order
router.post('/', orderController.createOrder);

// ✅ Fetch all orders
router.get('/', orderController.getAllOrders);

// ✅ Fetch specific order (with items)
router.get('/:id', orderController.getOrderById);

// ✅ Fetch all orders by a specific customer
router.get('/customer/:user_id', orderController.getOrdersByCustomer);

// ✅ Fetch items for a specific order
router.get('/:order_id/items', orderController.getOrderItems);

module.exports = router;

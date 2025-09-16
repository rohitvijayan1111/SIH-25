const express = require('express');
const router = express.Router();
const cartController = require('./cartController');

// POST /cart/add
router.post('/add', cartController.addToCart);
router.get('/view/:user_id', cartController.viewCart);
router.put('/update', cartController.updateCartItem);
router.delete('/clear', cartController.clearCart);
// router.get('/getcategories/:user_id', cartController.getTopCategories);
router.get('/getcategories', cartController.getTopCategories);

module.exports = router;

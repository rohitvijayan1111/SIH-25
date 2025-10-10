const express = require('express');
const router = express.Router();
const productController = require('../controller/productController');

router.post('/', productController.createProduct);
router.put('/:id', productController.updateProduct);
router.delete('/:id', productController.deleteProduct);
router.get('/all-products-byfarmer/:farmerId', productController.getProductsByFarmer);
module.exports = router;

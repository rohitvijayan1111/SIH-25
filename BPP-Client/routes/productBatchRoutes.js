const express = require('express');
const router = express.Router();
const batchController = require('../controllers/productBatchController');

router.post('/batch', batchController.createProductBatch);
router.get('/batches/:productId', batchController.getBatchesByProductId);
router.put('/batch/:id', batchController.updateBatch);
router.delete('/batch/:id', batchController.deleteBatch);
router.get('/quantity/:productId', batchController.getAvailableQuantity);

module.exports = router;



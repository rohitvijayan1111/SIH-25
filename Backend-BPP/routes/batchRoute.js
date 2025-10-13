const express = require('express');
const {
  createBatch,
  updateStatus,
  splitBatch,
  mergeBatches,
  updateBatch,
  anchorMetadata,
  getInventory,
  getProduceProducts,
  getBatchesbyFarmers,
  getAllBatches,
  getBatchesByProductName,
} = require('../controllers/batchController'); // no .js extension needed in CommonJS

const router = express.Router();

// 1️⃣ Create a new batch
router.post('/', createBatch);

// 2️⃣ Update batch status
router.patch('/:id/status', updateStatus);

// 3️⃣ Split a batch
router.post('/:id/split', splitBatch);

// 4️⃣ Merge batches
router.post('/merge', mergeBatches);

// 5️⃣ Update harvest/location/meta info
router.patch('/:id', updateBatch);

// 6️⃣ Anchor metadata (meta_hash) for blockchain
router.patch('/:batchId/anchor', anchorMetadata);

// GET /api/discovery
router.get('/', getInventory);

router.get('/product/categories', getProduceProducts);

router.get('/:farmer_id', getBatchesbyFarmers);

// GET /all_batches
router.get('/batches', getAllBatches);
router.get('/product/:product_name', getBatchesByProductName);

module.exports = router;

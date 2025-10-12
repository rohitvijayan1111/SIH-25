// routes/middlemenPurchaseRoutes.js
const express = require('express');
const router = express.Router();
const middlemenPurchaseController = require('../controllers/middlemenPurchaseController');

// 1️⃣ Create / Add Purchase
router.post('/purchases', middlemenPurchaseController.createPurchase);

// 2️⃣ Get Purchase Details by ID
router.get(
  '/purchases/:purchase_id',
  middlemenPurchaseController.getPurchaseById
);

// 3️⃣ List Purchases with optional filters
router.get('/purchases', middlemenPurchaseController.listPurchases);

// 4️⃣ Update Payment Status
router.patch(
  '/purchases/:purchase_id/payment',
  middlemenPurchaseController.updatePaymentStatus
);

// 5️⃣ Update Delivery Status
router.patch(
  '/purchases/:purchase_id/delivery',
  middlemenPurchaseController.updateDeliveryStatus
);

// 6️⃣ Get Blockchain & Proof Details
router.get(
  '/purchases/:purchase_id/proof',
  middlemenPurchaseController.getProof
);

// 7️⃣ Delete / Cancel Purchase
router.delete(
  '/purchases/:purchase_id',
  middlemenPurchaseController.deletePurchase
);

// 8️⃣ Analytics / Reports
router.get('/purchases/report', middlemenPurchaseController.getReport);
// In your routes file (e.g., middlemenPurchaseRoutes.js)
router.patch(
  '/purchases/:purchase_id',
  middlemenPurchaseController.updatePurchase
);

module.exports = router;

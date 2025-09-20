const express = require("express");
const router = express.Router();
const paymentsController = require("../controllers/paymentsController");

// 1. Create Payment (Lock Payment)
router.post("/", paymentsController.createPayment);

// 2. Release Payment (Upon Delivery Confirmation)
router.patch("/:id/release", paymentsController.releasePayment);

// 3. Refund Payment (Handle Disputes)
router.patch("/:id/refund", paymentsController.refundPayment);

// 4. Upload Payment Proof (IPFS CID)
router.post("/:id/proof", paymentsController.uploadProof);

// 5. Get Payment by ID
router.get("/:id", paymentsController.getPaymentById);

// 6. List Payments (with filters)
router.get("/", paymentsController.listPayments);

module.exports = router;

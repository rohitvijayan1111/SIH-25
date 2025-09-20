const express = require("express");
const router = express.Router();
const escrowsController = require("../controllers/escrowsController");

// 1. Create & Lock Escrow
// POST /api/escrows
router.post("/", escrowsController.createEscrow);

// 2. Release Escrow
// PUT /api/escrows/:id/release
router.put("/:id/release", escrowsController.releaseEscrow);

// 3. Refund Escrow
// PUT /api/escrows/:id/refund
router.put("/:id/refund", escrowsController.refundEscrow);

// 4. Upload Blockchain Proof
// PUT /api/escrows/:id/proof
router.put("/:id/proof", escrowsController.uploadProof);

// 5. Get Escrow by ID
// GET /api/escrows/:id
router.get("/:id", escrowsController.getEscrowById);

// 6. List Escrows (with filters: ?status=locked|released&order_id=...&escrow_ref=...)
// GET /api/escrows
router.get("/", escrowsController.listEscrows);

module.exports = router;

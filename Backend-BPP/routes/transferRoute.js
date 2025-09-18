const express = require("express");
const router = express.Router();
const {
  createTransfer,
  getTransfersByBatch,
  getLatestTransferByBatch,
  getTransfersByActor,
  verifyTransferOnChain,
  updateTransfer,
  deleteTransfer
} = require("../controllers/transfersController");

// 1️⃣ Create Transfer Record
router.post("/", createTransfer);

// 2️⃣ Fetch Transfer History by Batch
router.get("/batch/:batch_id", getTransfersByBatch);

// 3️⃣ Fetch Latest Transfer Event for a Batch
router.get("/latest/:batch_id", getLatestTransferByBatch);

// 4️⃣ Fetch Transfers by Actor (from_actor or to_actor)
router.get("/actor/:actor_name", getTransfersByActor);

// 5️⃣ Verify Transfer on Blockchain
router.get("/:transfer_id/verify", verifyTransferOnChain);

// 6️⃣ Update Transfer Record
router.put("/:id", updateTransfer);

// 7️⃣ Delete Transfer Record (soft delete)
router.delete("/:id", deleteTransfer);

module.exports = router;

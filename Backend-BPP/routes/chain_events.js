const express = require("express");
const router = express.Router();
const {
  createChainEvent,
  getAllChainEvents,
  getEventsByEntity,
  getEventsByActor,
  getLatestEventByEntity,
  verifyEventOnChain
} = require('../controllers/chainEventsController'); 

// Record a New Chain Event
router.post("/", createChainEvent);

// Fetch All Chain Events
router.get("/", getAllChainEvents);

// Fetch Events by Entity
router.get("/entity/:entity_type/:entity_id", getEventsByEntity);

// Fetch Events by Actor
router.get("/actor/:actor_name", getEventsByActor);

// Fetch Latest Event for an Entity
router.get("/latest/:entity_type/:entity_id", getLatestEventByEntity);

// Verify Event on Blockchain
router.get("/:id/verify", verifyEventOnChain);

module.exports = router;

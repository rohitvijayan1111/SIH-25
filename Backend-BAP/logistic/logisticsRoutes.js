const express = require("express");
const router = express.Router();
const logisticsController = require("./logisticsController");

// POST: Search logistics
router.post("/search", logisticsController.searchLogistics);

module.exports = router;

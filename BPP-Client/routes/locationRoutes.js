// routes/locationRoutes.js

const express = require('express');
const router = express.Router();
const locationController = require('../controller/locationController');

// POST - Create Location
router.post('/create', locationController.createLocation);

// PUT - Update Location
router.put('/update/:id', locationController.updateLocation);

module.exports = router;

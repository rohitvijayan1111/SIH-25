// routes/searchRoutes.js
const express = require('express');
const router = express.Router();
const searchController = require('../controllers/searchController');
const initController = require('../controllers/initController');

router.post('/search', searchController.handleSearch);
router.post('/init', initController.handleInit);
module.exports = router;

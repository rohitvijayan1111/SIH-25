// routes/searchRoutes.js
const express = require('express');
const router = express.Router();
const searchController = require('../controllers/searchController');
const initController = require('../controllers/initController');
const selectContorller = require('../controllers/selectController');

router.post('/search', searchController.handleSearch);
router.post('/select', selectContorller.handleSelect);
router.post('/init', initController.handleInit);
module.exports = router;




// routes/searchRoutes.js
const express = require('express');
const router = express.Router();
const searchController = require('../controllers/searchController');
const initController = require('../controllers/initController');
const selectContorller = require('../controllers/selectController');
const confirmController = require('../controllers/confirmController');

router.post('/search', searchController.handleSearch);
router.post('/select', selectContorller.handleSelect);
router.post('/init', initController.handleInit);
router.post('/confirm', confirmController.handleConfirm);
module.exports = router;




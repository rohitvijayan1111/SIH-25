// routes/becknRoutes.js
const express = require('express');
const router = express.Router();
const onSearchController = require('../controllers/onSearchController');
const onSelectController = require('../controllers/onSelectController');
const onInitController  = require('../controllers/onInitController');
const confirmController = require('../controllers/confirmController');
const onRatingController = require('../controllers/onRatingController');
router.post('/bpp/on_search', onSearchController.handleSearch);
router.post('/bpp/on_select', onSelectController.handleSelect);
router.post('/bpp/on_init', onInitController.onInit);
router.post('/bpp/on_confirm', confirmController.handleConfirm);
router.post('/bpp/on_rating', onRatingController.saveRating);
module.exports = router;

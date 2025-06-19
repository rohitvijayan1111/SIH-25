// routes/becknRoutes.js
const express = require('express');
const router = express.Router();
const onSearchController = require('../controllers/onSearchController');


router.post('/bpp/on_search', onSearchController.handleSearch);

module.exports = router;
   
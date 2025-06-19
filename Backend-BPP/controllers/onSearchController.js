// controllers/onSearchController.js

const inventoryService = require('../services/inventoryService');
const responseBuilder = require('../utils/responseBuilder');

exports.handleSearch = async (req, res) => {
  try {
    const products = await inventoryService.getAvailableProducts();
    const response = responseBuilder.buildOnSearchResponse(products);
    res.json(response);
  } catch (error) {
    console.error('on_search error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

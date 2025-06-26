const inventoryService = require('../services/inventoryService');
const responseBuilder = require('../utils/responseBuilder');
const geolib = require('geolib');
exports.handleSearch = async (req, res) => {
  try {
      const { productName = '', lat, lon, radius } = req.body;
       // Validate latitude, longitude, and radius
    if (lat === undefined || lon === undefined) {
      return res.status(400).json({ error: 'Missing user latitude or longitude' });
    }
      const userLocation = {
      latitude: parseFloat(lat),
      longitude: parseFloat(lon),
    };

     const radiusKm = radius ? parseFloat(radius) : 50; 

     if (
      isNaN(userLocation.latitude) ||
      isNaN(userLocation.longitude) ||
      isNaN(radiusKm)
    ) {
      return res
        .status(400)
        .json({ error: 'Invalid latitude, longitude, or radius value' });
    }
    const filteredCatalog = await inventoryService.getAvailableProductsWithMeta({
      productName,
      userLocation,
      radiusKm
    });
    
    const response = responseBuilder.buildOnSearchResponse(filteredCatalog);       // uses full product meta
    res.json(response);
  } catch (error) {
    console.error('on_search error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

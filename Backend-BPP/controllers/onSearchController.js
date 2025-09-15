const inventoryService = require('../services/inventoryService');
const responseBuilder = require('../utils/responseBuilder');

exports.handleSearch = async (req, res) => {
  try {
    const {
      item = {},
      category = {},
    } = req.body.intent || {};
    const {lat,lon}=req.body;
    console.log(req.body);
    const productName = item?.descriptor?.name || '';
    const categoryId = category?.id || '';
    // const lat = fulfillment?.end?.location?.gps?.split(',')[0];
    // const lon = fulfillment?.end?.location?.gps?.split(',')[1];
    const radius = req.body.radius || 50;

    if (!lat || !lon) {
      return res.status(400).json({ error: 'Missing user latitude or longitude in intent' });
    }

    const userLocation = {
      latitude: parseFloat(lat),
      longitude: parseFloat(lon),
    };

    const radiusKm = parseFloat(radius);

    if (
      isNaN(userLocation.latitude) ||
      isNaN(userLocation.longitude) ||
      isNaN(radiusKm)
    ) {
      return res
        .status(400)
        .json({ error: 'Invalid latitude, longitude, or radius value' });
    }

    // Call updated inventory service
    const filteredCatalog = await inventoryService.getAvailableProductsWithMeta({
      keyword: productName,
      category: categoryId,
      userLocation,
      radiusKm
    });

    const response = responseBuilder.buildOnSearchResponse(filteredCatalog);
    res.json(response);
  } catch (error) {
    console.error('🔴 on_search error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

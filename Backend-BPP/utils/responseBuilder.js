// utils/responseBuilder.js
exports.buildOnSearchResponse = (products) => {
  return {
    context: {
      domain: 'agri.bpp',
      action: 'on_search',
      timestamp: new Date().toISOString()
    },
    message: {
      catalog: {
        items: products.map(prod => ({
          id: prod.id.toString(),
          name: prod.name,
          quantity: { available: { count: prod.stock } },
          price: { currency: 'INR', value: prod.price_per_unit.toString() },
          tags: { organic: prod.organic }
        }))
      }
    }
  };
};

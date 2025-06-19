const productModel = require('../models/productModel');
const priceListModel = require('../models/priceListModel');

exports.getAvailableProducts = async () => {
  const products = await productModel.getAll();
  const prices = await priceListModel.getLatestValidPrices();

  // Merge prices with products where product_id matches
  const today = new Date();

  return products
    .filter(p => p.stock > 0)
    .map(product => {
      const price = prices.find(
        pr =>
          pr.product_id === product.id &&
          new Date(pr.valid_from) <= today &&
          new Date(pr.valid_to) >= today
      );
      return price 
        ? {
            id: product.id,
            name: product.name,
            stock: product.stock,
            unit: product.unit,                     // ✅ Include unit
            price_per_unit: price.price_per_unit,
            organic: product.organic                // ✅ Include organic flag
          }
        : null;
    })
    .filter(Boolean); 
};

// services/inventoryService.js
const db = require('../config/db'); // ✅ Adjusted path to PostgreSQL client

/**
 * Fetch products with metadata needed for ONDC on_search response
 */
exports.getAvailableProductsWithMeta = async () => {
  const query = `
    SELECT 
      p.id AS product_id,
      p.name AS product_name,
      p.unit,
      p.stock,
      p.organic,
      p.image_url,
      
      f.id AS farmer_id,
      f.name AS farmer_name,
      
      l.location_code,
      l.gps AS location_gps,
      l.address AS location_address,
      
      cf.fulfillment_code,
      cf.gps AS fulfillment_gps,
      cf.address AS fulfillment_address,
      
      pl.price_per_unit
      
    FROM products p
    INNER JOIN farmers f ON p.farmer_id = f.id
    INNER JOIN locations l ON f.id = l.farmer_id
    INNER JOIN catalog_fulfillments cf ON f.id = cf.farmer_id
    INNER JOIN price_list pl ON p.id = pl.product_id
    WHERE 
      CURRENT_DATE BETWEEN pl.valid_from AND pl.valid_to
      AND p.stock > 0;
  `;

  try {
    const { rows } = await db.query(query);
    return rows;
  } catch (error) {
    console.error('Error fetching products with meta:', error);
    throw error;
  }
};

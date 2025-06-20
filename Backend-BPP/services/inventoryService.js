const db = require('../config/db'); // ✅ Adjusted path to PostgreSQL client


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
      cf.type AS fulfillment_type,
      cf.estimated_delivery,
      
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

    // 🔁 Add ISO 8601 formatting to estimated_delivery
    return rows.map(row => ({
      ...row,
      estimated_delivery: row.estimated_delivery
        ? new Date(row.estimated_delivery).toISOString()
        : null
    }));
  } catch (error) {
    console.error('Error fetching products with meta:', error);
    throw error;
  }
};

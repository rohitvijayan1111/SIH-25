const db = require('../config/db'); // ✅ Adjusted path to PostgreSQL client


exports.getAvailableProductsWithMeta = async ({ productName, userLocation, radiusKm }) => {
   const values = [productName, userLocation.latitude, userLocation.longitude, radiusKm];
  const query = `
   SELECT 
  p.id AS product_id,
  p.name AS product_name,
  p.type,
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
  AND p.stock > 0
  AND p.name ILIKE '%' || $1 || '%'
  AND (
    6371 * acos(
      cos(radians($2)) * cos(radians(SPLIT_PART(l.gps, ',', 1)::double precision)) * 
      cos(radians(SPLIT_PART(l.gps, ',', 2)::double precision) - radians($3)) +
      sin(radians($2)) * sin(radians(SPLIT_PART(l.gps, ',', 1)::double precision))
    )
  ) <= $4;
  `;

 try {
  const { rows: products } = await db.query(query,values);

  // Format estimated_delivery to ISO 8601
  const formattedProducts = products.map(product => ({
    ...product,
    estimated_delivery: product.estimated_delivery
      ? new Date(product.estimated_delivery).toISOString()
      : null
  }));

  return formattedProducts;

} catch (error) {
  console.error('🔴 Error fetching products with meta:', error.message);
  throw new Error('Failed to fetch product metadata');
}

};

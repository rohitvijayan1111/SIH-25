const db = require('../config/db');

const getAvailableProductsWithMeta = async ({ keyword = '', category = '', userLocation, radiusKm }) => {
  if (
    !userLocation ||
    typeof userLocation.latitude !== 'number' ||
    typeof userLocation.longitude !== 'number'
  ) {
    throw new Error('Missing or invalid user location');
  }

 const keywordFilter = keyword?.trim() ? `%${keyword.trim()}%` : '';
const categoryFilter = category?.trim() ? `%${category.trim()}%` : '';

const values = [
  keywordFilter,         // $1: p.name
  keywordFilter,         // $2: p.description
  categoryFilter,        // $3: p.type
  userLocation.latitude, // $4
  userLocation.longitude,// $5
  radiusKm || 50         // $6
];


  const query = `
  SELECT
    p.id AS product_id,
    p.name AS product_name,
    p.description,
    p.type,
    p.unit,
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

    pb.id AS batch_id,
    pb.price_per_unit,
    pb.quantity AS available_quantity,
    pb.manufactured_on,
    pb.expiry_date

  FROM products p
  INNER JOIN farmers f ON p.farmer_id = f.id
  INNER JOIN locations l ON f.id = l.farmer_id
  INNER JOIN catalog_fulfillments cf ON f.id = cf.farmer_id
  INNER JOIN product_batches pb ON p.id = pb.product_id

  WHERE
    pb.quantity > 0
    AND CURRENT_DATE <= pb.expiry_date

    AND (
      $1 = '' OR p.name ILIKE $1 OR p.description ILIKE $2
    )

    AND (
      $3 = '' OR p.type::TEXT ILIKE $3
    )

    AND (
      6371 * acos(
        cos(radians($4)) * cos(radians(SPLIT_PART(l.gps, ',', 1)::double precision)) *
        cos(radians(SPLIT_PART(l.gps, ',', 2)::double precision) - radians($5)) +
        sin(radians($4)) * sin(radians(SPLIT_PART(l.gps, ',', 1)::double precision))
      )
    ) <= $6
`;



  try {
  
    const { rows } = await db.query(query, values);

    return rows.map(product => ({
      ...product,
      estimated_delivery: product.estimated_delivery
        ? new Date(product.estimated_delivery).toISOString()
        : null
    }));

  } catch (error) {
    console.error('❌ DB Error in handleSearch:', error.message);
    throw new Error('Search failed');
  }
};

module.exports = {
  getAvailableProductsWithMeta
};

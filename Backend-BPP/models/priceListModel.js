const db = require('../config/db');

exports.getLatestValidPrices = async () => {
  const today = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
  const result = await db.query(
    'SELECT * FROM price_list WHERE valid_from <= $1 AND valid_to >= $1',
    [today]
  );
  return result.rows;
};

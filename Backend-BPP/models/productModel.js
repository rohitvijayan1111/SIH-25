// models/productModel.js
const db = require('../config/db');

exports.getAll = async () => {
  const result = await db.query('SELECT * FROM products');
  return result.rows;
};

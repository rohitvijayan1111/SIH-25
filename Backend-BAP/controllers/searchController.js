// controllers/searchController.js
const axios = require('axios');
const { v4: uuidv4 } = require('uuid');
const pool = require('../config/db');

exports.handleSearch = async (req, res) => {
  try {
    const { productName = '', lat, lon, radius } = req.body;

    if (!lat || !lon) {
      return res.status(400).json({ error: 'Latitude and longitude are required.' });
    }

    const latitude = parseFloat(lat);
    const longitude = parseFloat(lon);
    const radiusKm = parseFloat(radius) || 50;

    if (isNaN(latitude) || isNaN(longitude) || isNaN(radiusKm)) {
      return res.status(400).json({ error: 'Invalid coordinates or radius.' });
    }

   const txnId = req.transaction_id;

    // await pool.query(
    //   'INSERT INTO search_requests (user_id, query, category, timestamp) VALUES ($1, $2, $3, NOW())',
    //   [null, productName, 'CROP']
    // );

    // Call BPP `/on_search`
    const bppUrl = 'http://localhost:3000/bpp/on_search';
    const bppResponse = await axios.post(bppUrl, {
      transaction_id: txnId,
      productName,
      lat,
      lon,
      radius: radiusKm
    },{
  headers: {
    'x-transaction-id': txnId  // <== send it explicitly
  }});

    res.json({
      message: '✅ BPP /on_search called successfully',
      transaction_id: txnId,
      catalog: bppResponse.data
    });

  } catch (error) {
    console.error('❌ Error in handleSearch:', error.message);
    res.status(500).json({ error: 'Search failed' });
  }
};

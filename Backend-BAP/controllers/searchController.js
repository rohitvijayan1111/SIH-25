const axios = require('axios');
const { v4: uuidv4 } = require('uuid');
// const logBlockchainEvent = require("../middlewares/blockchainLogger");
const { SERVER_URL } = 'react-native-dotenv';
exports.handleSearch = async (req, res) => {
  try {
    const {
      productName = '',
      category = '', // added category input
      lat,
      lon,
      radius,
    } = req.body;

    if (!lat || !lon) {
      return res
        .status(400)
        .json({ error: 'Latitude and longitude are required.' });
    }
    // await pool.query(
    //   'INSERT INTO search_requests (user_id, query, category, timestamp) VALUES ($1, $2, $3, NOW())',
    //   [null, productName, 'CROP']
    // );
    const latitude = parseFloat(lat);
    const longitude = parseFloat(lon);
    const radiusKm = parseFloat(radius) || 50;

    if (isNaN(latitude) || isNaN(longitude) || isNaN(radiusKm)) {
      return res.status(400).json({ error: 'Invalid coordinates or radius.' });
    }

    const txnId = req.transaction_id || uuidv4();

    console.log(txnId); //for using in postman
    console.log(process.env.SERVER_URL);
    const bppUrl = `${process.env.SERVER_URL}/bpp/on_search`;
    console.log('BPP URL:', bppUrl);

    const payload = {
      context: {
        domain: 'agri.bpp',
        action: 'search',
        country: 'IND',
        city: 'std:080',
        timestamp: new Date().toISOString(),
        transaction_id: txnId,
      },
      intent: {
        item: {
          descriptor: {
            name: productName,
          },
        },
        category: {
          id: category || '',
        },
        fulfillment: {
          end: {
            location: {
              gps: `${latitude},${longitude}`,
            },
          },
        },
      },
      radius: radiusKm,
    };
    // console.log('Search Payload:', JSON.stringify(payload, null, 2));

    const bppResponse = await axios.post(bppUrl, payload, {
      headers: {
        'x-transaction-id': txnId,
      },
    });
    // writing blockchain
    // ✅ Call blockchain logger (store the search request on blockchain ledger)
    // await logBlockchainEvent(
    //   "SEARCH",     // entity type
    //   txnId,        // entity id (transaction_id is unique)
    //   "CREATE",     // action
    //   payload       // full payload being hashed
    // );
    console.log(bppResponse.data.message.catalog.items);
    res.json({
      message: '✅ BPP /on_search called successfully',
      transaction_id: txnId,
      catalog: bppResponse.data.message.catalog,
    });
    console.log('runnig');
  } catch (error) {
    console.error('❌ Error in handleSearch:', error.message);

    // 🔗 Log failed attempt in blockchain ledger too
    // await logBlockchainEvent("SEARCH", uuidv4(), "FAILED", { error: error.message });
    res.status(500).json({ error: 'Search failed' });
  }
};

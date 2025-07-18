const express = require('express');
const bodyParser = require('body-parser');
require('dotenv').config();

// const adminRoutes = require('./routes/adminRoutes');
// const becknRoutes = require('./routes/becknRoutes');

const app = express();
app.use(bodyParser.json());

// Mount your routes
// app.use('/admin', adminRoutes);
// app.use('/bpp', becknRoutes);
const farmerRoutes = require('./routes/farmerRoutes');

const locationRoutes = require('./routes/locationRoutes');
const productBatchRoutes = require('./routes/productBatchRoutes');

app.use('/bpp-farmers', farmerRoutes);  
app.use('/locations', locationRoutes);
app.use('/api/products', productBatchRoutes);
const port = process.env.PORT || 5000;
app.listen(port, () => console.log(`BPP server running on port ${port}`));

// sync.js

const { DataTypes } = require('sequelize'); // ✅ Import DataTypes
const sequelize = require('./config/sequelize');

// ✅ Manually import each model
const Farmer = require('./model/farmer')(sequelize, DataTypes);
const Location = require('./model/location')(sequelize, DataTypes);
const Product = require('./model/product')(sequelize, DataTypes);
// const PriceList = require('./model/priceList')(sequelize, DataTypes);
const CatalogFulfillment = require('./model/catalogFulfillment')(sequelize, DataTypes);
const OrderFulfillment = require('./model/orderFulfillment')(sequelize, DataTypes);
const LogisticsProvider = require('./model/logisticsProvider')(sequelize, DataTypes);
const InventoryLog = require('./model/inventoryLog')(sequelize, DataTypes);
const Order = require('./model/order')(sequelize, DataTypes);
const Rating = require('./model/rating')(sequelize, DataTypes);
const ProductBatch = require('./model/productBatch')(sequelize, DataTypes); // ✅ Now works

// ✅ Set up associations
const db = {
  Farmer,
  Location,
  Product,
  // PriceList,
  CatalogFulfillment,
  OrderFulfillment,
  LogisticsProvider,
  InventoryLog,
  Order,
  Rating,
  ProductBatch
};

Object.keys(db).forEach((modelName) => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

// ✅ Sync the database
const syncDB = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Connected to PostgreSQL');

    // Enable UUID extension
    await sequelize.query(`CREATE EXTENSION IF NOT EXISTS "pgcrypto";`);

    await sequelize.sync({ alter: true }); // Use force: true if needed
    console.log('📦 All models synced successfully!');
  } catch (error) {
    console.error('❌ Sync failed:', error.message);
  } finally {
    await sequelize.close();
    console.log('🔌 Connection closed.');
  }
};

syncDB();

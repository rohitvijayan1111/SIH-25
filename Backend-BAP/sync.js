const sequelize = require('./config/sequelize');

// 🧩 Import all models
const User = require('./models/User');
const SearchRequest = require('./models/SearchRequest');
const Order = require('./models/Order');
const OrderItem = require('./models/OrderItem');
const LogisticsPreference = require('./models/LogisticsPreference');
const PaymentTransaction = require('./models/PaymentTransaction');
const OrderTracking = require('./models/OrderTracking');
const Rating = require('./models/Rating');
const Notification = require('./models/Notification');
const UserCart = require('./models/UserCart');

// ✅ Define associations (if not already inside models)
User.hasMany(SearchRequest, { foreignKey: 'user_id', onDelete: 'CASCADE' });
SearchRequest.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(Order, { foreignKey: 'user_id' });
Order.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(Rating, { foreignKey: 'user_id' });
Rating.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(Notification, { foreignKey: 'user_id' });
Notification.belongsTo(User, { foreignKey: 'user_id' });

User.hasMany(UserCart, { foreignKey: 'user_id' });
UserCart.belongsTo(User, { foreignKey: 'user_id' });

Order.hasMany(OrderItem, { foreignKey: 'order_id', onDelete: 'CASCADE' });
OrderItem.belongsTo(Order, { foreignKey: 'order_id' });

Order.hasOne(LogisticsPreference, { foreignKey: 'order_id', onDelete: 'CASCADE' });
LogisticsPreference.belongsTo(Order, { foreignKey: 'order_id' });

Order.hasMany(PaymentTransaction, { foreignKey: 'order_id', onDelete: 'CASCADE' });
PaymentTransaction.belongsTo(Order, { foreignKey: 'order_id' });

Order.hasMany(OrderTracking, { foreignKey: 'order_id', onDelete: 'CASCADE' });
OrderTracking.belongsTo(Order, { foreignKey: 'order_id' });

Order.hasMany(Rating, { foreignKey: 'order_id' });
Rating.belongsTo(Order, { foreignKey: 'order_id' });

const syncDB = async () => {
  try {
    await sequelize.authenticate();
    console.log('✅ Sequelize connected to DB.');

    // 🧱 Sync all tables & auto-update columns
    await sequelize.sync({ alter: true });

    console.log('✅ All models synced successfully.');
  } catch (err) {
    console.error('❌ Sync failed:', err.message);
  } finally {
    await sequelize.close();
  }
};

syncDB();

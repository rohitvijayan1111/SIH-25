const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./User'); // For foreign key relationship

const UserCart = sequelize.define('UserCart', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  bpp_id: {
    type: DataTypes.STRING(100),
    allowNull: false,
  },
  bpp_product_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  provider_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  provider_name: {
    type: DataTypes.TEXT,
  },
  provider_address: {
    type: DataTypes.TEXT,
  },
  fulfillment_id: {
    type: DataTypes.STRING(100),
  },
  item_name: {
    type: DataTypes.TEXT,
  },
  quantity: {
    type: DataTypes.INTEGER,
    allowNull: false,
    validate: {
      min: 1,
    },
  },
  unit_price: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  added_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'user_cart',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: user_cart.user_id → users.id
UserCart.belongsTo(User, {
  foreignKey: 'user_id',
});

module.exports = UserCart;

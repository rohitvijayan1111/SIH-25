const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./User');

const Order = sequelize.define('Order', {
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
  farmer_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  fulfillment_id: {
    type: DataTypes.STRING(100),
  },
  status: {
    type: DataTypes.ENUM('INITIATED', 'CONFIRMED', 'FULFILLED', 'CANCELLED'),
    defaultValue: 'INITIATED',
  },
  total_amount: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  delivery_address: {
    type: DataTypes.TEXT,
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
  updated_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'orders',
  timestamps: false,
  underscored: true,
});

Order.belongsTo(User, { foreignKey: 'user_id' });

module.exports = Order;

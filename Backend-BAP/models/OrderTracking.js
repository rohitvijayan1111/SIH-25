const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const Order = require('./Order'); // To set up foreign key association

const OrderTracking = sequelize.define('OrderTracking', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  order_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  current_status: {
    type: DataTypes.STRING(100),
  },
  remarks: {
    type: DataTypes.TEXT,
  },
  updated_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'order_tracking',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: order_tracking.order_id → orders.id
OrderTracking.belongsTo(Order, {
  foreignKey: 'order_id',
  onDelete: 'CASCADE',
});

module.exports = OrderTracking;

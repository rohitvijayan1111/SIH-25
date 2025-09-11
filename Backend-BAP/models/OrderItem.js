const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const Order = require('./Order'); // Import Order to define foreign key relationship

const OrderItem = sequelize.define('OrderItem', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  order_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  bpp_product_id: {
    type: DataTypes.UUID,
    allowNull: false,
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
}, {
  tableName: 'order_items',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: order_items.order_id → orders.id
OrderItem.belongsTo(Order, {
  foreignKey: 'order_id',
  onDelete: 'CASCADE',
});

module.exports = OrderItem;

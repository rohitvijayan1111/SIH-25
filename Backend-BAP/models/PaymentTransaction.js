const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const Order = require('./Order'); // Import Order to define foreign key

const PaymentTransaction = sequelize.define('PaymentTransaction', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  order_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  method: {
    type: DataTypes.STRING(20),
  },
  amount: {
    type: DataTypes.DECIMAL(10, 2),
    allowNull: false,
  },
  payment_status: {
    type: DataTypes.ENUM('PENDING', 'SUCCESS', 'FAILED'),
    defaultValue: 'PENDING',
  },
  transaction_ref: {
    type: DataTypes.STRING(100),
  },
  timestamp: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'payment_transactions',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: payment_transactions.order_id → orders.id
PaymentTransaction.belongsTo(Order, {
  foreignKey: 'order_id',
  onDelete: 'CASCADE',
});

module.exports = PaymentTransaction;

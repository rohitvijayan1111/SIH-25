const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const Order = require('./Order'); // To define foreign key association

const LogisticsPreference = sequelize.define('LogisticsPreference', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  order_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  preferred_mode: {
    type: DataTypes.STRING(50),
  },
  pickup_location: {
    type: DataTypes.TEXT,
  },
  drop_location: {
    type: DataTypes.TEXT,
  },
  scheduled_time: {
    type: DataTypes.DATE,
  },
}, {
  tableName: 'logistics_preferences',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: logistics_preferences.order_id → orders.id
LogisticsPreference.belongsTo(Order, {
  foreignKey: 'order_id',
  onDelete: 'CASCADE',
});

module.exports = LogisticsPreference;

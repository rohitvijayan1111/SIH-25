const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./User');
const Order = require('./Order');

const Rating = sequelize.define('Rating', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  order_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  bpp_id: {
    type: DataTypes.STRING(100),
  },
  product_id: {
    type: DataTypes.UUID,
  },
  rating: {
    type: DataTypes.INTEGER,
    validate: {
      min: 1,
      max: 5,
    },
  },
  feedback: {
    type: DataTypes.TEXT,
  },
  submitted_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'ratings',
  timestamps: false,
  underscored: true,
});

// 🔗 Associations
Rating.belongsTo(User, {
  foreignKey: 'user_id',
});

Rating.belongsTo(Order, {
  foreignKey: 'order_id',
});

module.exports = Rating;

// models/User.js
const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');

const User = sequelize.define('User', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4, // generates UUID like gen_random_uuid()
    primaryKey: true,
  },
  name: {
    type: DataTypes.STRING(100),
    allowNull: false,
  },
  phone: {
    type: DataTypes.STRING(15),
    allowNull: false,
    unique: true,
  },
  email: {
    type: DataTypes.STRING(100),
    unique: true,
  },
  role: {
    type: DataTypes.ENUM('farmer', 'buyer', 'logistics', 'admin'),
    allowNull: false,
  },
  kyc_id: {
    type: DataTypes.STRING(50),
  },
  address: {
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
  tableName: 'users',         // matches your raw SQL table name
  timestamps: false,          // disables automatic createdAt/updatedAt
  underscored: true,          // maps snake_case DB columns
});

module.exports = User;

const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./User'); // Required for foreign key association

const Notification = sequelize.define('Notification', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  message: {
    type: DataTypes.TEXT,
  },
  type: {
    type: DataTypes.ENUM('ORDER', 'PAYMENT', 'PROMOTION', 'SYSTEM'),
    defaultValue: 'ORDER',
  },
  status: {
    type: DataTypes.ENUM('SENT', 'PENDING', 'FAILED'),
    defaultValue: 'PENDING',
  },
  created_at: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
}, {
  tableName: 'notifications',
  timestamps: false,
  underscored: true,
});

// 🔗 Association: notifications.user_id → users.id
Notification.belongsTo(User, {
  foreignKey: 'user_id',
});

module.exports = Notification;

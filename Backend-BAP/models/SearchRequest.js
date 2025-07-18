const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const User = require('./User'); // To associate user_id foreign key

const SearchRequest = sequelize.define('SearchRequest', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },
  user_id: {
    type: DataTypes.UUID,
    allowNull: false,
  },
  query: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  category: {
    type: DataTypes.STRING(50),
  },
  timestamp: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
  },
  transaction_id: {
    type: DataTypes.UUID,
  },
}, {
  tableName: 'search_requests',
  timestamps: false,
  underscored: true,
});


// 🔗 Association: search_requests.user_id → users.id
SearchRequest.belongsTo(User, {
  foreignKey: 'user_id',
  onDelete: 'CASCADE',
});

module.exports = SearchRequest;

// models/inventoryLog.js
module.exports = (sequelize, DataTypes) => {
  const InventoryLog = sequelize.define('InventoryLog', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    product_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    change_type: {
      type: DataTypes.ENUM('IN', 'OUT'),
      allowNull: false
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    reason: {
      type: DataTypes.TEXT
    },
    timestamp: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'inventory_logs',
    timestamps: false
  });

  InventoryLog.associate = (models) => {
    InventoryLog.belongsTo(models.Product, {
      foreignKey: 'product_id',
      as: 'product',
      onDelete: 'CASCADE'
    });
  };

  return InventoryLog;
};

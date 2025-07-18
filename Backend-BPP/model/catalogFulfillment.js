// models/catalogFulfillment.js
module.exports = (sequelize, DataTypes) => {
  const CatalogFulfillment = sequelize.define('CatalogFulfillment', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    fulfillment_code: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true
    },
    farmer_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    type: {
      type: DataTypes.STRING(50),
      defaultValue: 'Self-Pickup'
    },
    gps: {
      type: DataTypes.STRING(50)
    },
    address: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    estimated_delivery: {
      type: DataTypes.DATE
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'catalog_fulfillments',
    timestamps: false
  });

  CatalogFulfillment.associate = (models) => {
    CatalogFulfillment.belongsTo(models.Farmer, {
      foreignKey: 'farmer_id',
      as: 'farmer',
      onDelete: 'CASCADE'
    });
  };

  return CatalogFulfillment;
};

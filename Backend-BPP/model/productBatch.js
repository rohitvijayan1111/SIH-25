// models/productBatch.js
module.exports = (sequelize, DataTypes) => {
  const ProductBatch = sequelize.define('ProductBatch', {
    id: {
      type: DataTypes.UUID,
      primaryKey: true,
      defaultValue: DataTypes.UUIDV4
    },
    product_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    price_per_unit: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    quantity: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    manufactured_on: {
      type: DataTypes.DATEONLY
    },
    expiry_date: {
      type: DataTypes.DATEONLY
    }
  }, {
    tableName: 'product_batches',
    timestamps: false
  });

  // Define associations
  ProductBatch.associate = (models) => {
    ProductBatch.belongsTo(models.Product, {
      foreignKey: 'product_id',
      onDelete: 'CASCADE'
    });
  };

  return ProductBatch;
};

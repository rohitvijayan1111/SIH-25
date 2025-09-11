module.exports = (sequelize,DataTypes) => {
  const Product = sequelize.define('Product', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    farmer_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    type: {
  type: DataTypes.ENUM(
    'crop',
    'dairy',
    'livestock',
    'tool',
    'fertilizer',
    'seed',
    'micro_nutrient',
    'fungicide',
    'growth_promoter',
    'growth_regulator',
    'herbicide'
  ),
  allowNull: false
}
,
    unit: {
      type: DataTypes.STRING(20)
    },
    stock: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
    organic: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    description: {
      type: DataTypes.TEXT
    },
    image_url: {
      type: DataTypes.TEXT
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'products',
    timestamps: false
  });

  Product.associate = (models) => {
    // Product belongs to Farmer
    Product.belongsTo(models.Farmer, {
      foreignKey: 'farmer_id',
      as: 'farmer',
      onDelete: 'CASCADE'
    });

    // Product has many PriceList entries
    if (models.PriceList) {
      Product.hasMany(models.PriceList, {
        foreignKey: 'product_id',
        as: 'prices',
        onDelete: 'CASCADE'
      });
    }

    // ✅ Product has many ProductBatches
    if (models.ProductBatch) {
      Product.hasMany(models.ProductBatch, {
        foreignKey: 'product_id',
        as: 'batches',
        onDelete: 'CASCADE'
      });
    }
  };

  return Product;
};

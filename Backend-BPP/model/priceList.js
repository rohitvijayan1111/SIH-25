// models/priceList.js
module.exports = (sequelize, DataTypes) => {
  const PriceList = sequelize.define('PriceList', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    product_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    price_per_unit: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    valid_from: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    valid_to: {
      type: DataTypes.DATEONLY,
      allowNull: false
    }
  }, {
    tableName: 'price_list',
    timestamps: false
  });

  PriceList.associate = (models) => {
    PriceList.belongsTo(models.Product, {
      foreignKey: 'product_id',
      as: 'product',
      onDelete: 'CASCADE'
    });
  };

  return PriceList;
};

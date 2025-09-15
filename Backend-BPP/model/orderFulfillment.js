// models/orderFulfillment.js
module.exports = (sequelize, DataTypes) => {
  const OrderFulfillment = sequelize.define('OrderFulfillment', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    order_id: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    bpp_product_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    farmer_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    status: {
      type: DataTypes.ENUM('RECEIVED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED'),
      defaultValue: 'RECEIVED'
    },
    estimated_delivery: {
      type: DataTypes.DATE
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'order_fulfillments',
    timestamps: false
  });

  OrderFulfillment.associate = (models) => {
    OrderFulfillment.belongsTo(models.Product, {
      foreignKey: 'bpp_product_id',
      as: 'product'
    });

    OrderFulfillment.belongsTo(models.Farmer, {
      foreignKey: 'farmer_id',
      as: 'farmer'
    });
  };

  return OrderFulfillment;
};

// models/order.js
module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define('Order', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    bap_order_id: {
      type: DataTypes.TEXT,
      unique: true
    },
    farmer_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    total_price: {
      type: DataTypes.DECIMAL(10, 2)
    },
    payment_status: {
      type: DataTypes.STRING(20)
    },
    delivery_address: {
      type: DataTypes.TEXT
    },
    buyer_contact: {
      type: DataTypes.TEXT
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'orders',
    timestamps: false
  });

  Order.associate = (models) => {
    Order.belongsTo(models.Farmer, {
      foreignKey: 'farmer_id',
      as: 'farmer'
    });
  };

  return Order;
};

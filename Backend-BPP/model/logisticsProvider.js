// models/logisticsProvider.js
module.exports = (sequelize, DataTypes) => {
  const LogisticsProvider = sequelize.define('LogisticsProvider', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    vehicle_type: {
      type: DataTypes.STRING(50)
    },
    capacity_kg: {
      type: DataTypes.INTEGER
    },
    base_price: {
      type: DataTypes.DECIMAL(10, 2)
    },
    location: {
      type: DataTypes.TEXT
    },
    availability: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'logistics_providers',
    timestamps: false
  });

  return LogisticsProvider;
};

// models/location.js
module.exports = (sequelize, DataTypes) => {
  const Location = sequelize.define('Location', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    farmer_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    location_code: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true
    },
    gps: {
      type: DataTypes.STRING(50)
    },
    address: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'locations',
    timestamps: false
  });

  Location.associate = (models) => {
    Location.belongsTo(models.Farmer, {
      foreignKey: 'farmer_id',
      as: 'farmer'
    });
  };

  return Location;
};

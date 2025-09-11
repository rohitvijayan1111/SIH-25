// models/farmer.js
module.exports = (sequelize, DataTypes) => {
  const Farmer = sequelize.define('Farmer', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    phone: {
      type: DataTypes.STRING(15),
      allowNull: false,
      unique: true
    },
    farm_location: {
      type: DataTypes.TEXT
    },
    organic_certified: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    kyc_id: {
      type: DataTypes.STRING(50)
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'farmers',
    timestamps: false
  });

  Farmer.associate = (models) => {
    Farmer.hasMany(models.Location, {
      foreignKey: 'farmer_id',
      as: 'locations',
      onDelete: 'CASCADE'
    });
  };

  return Farmer;
};

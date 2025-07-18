// models/rating.js
module.exports = (sequelize, DataTypes) => {
  const Rating = sequelize.define('Rating', {
    id: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    user_id: {
      type: DataTypes.UUID,
      allowNull: false
    },
    bpp_id: {
      type: DataTypes.STRING(100)
    },
    product_id: {
      type: DataTypes.UUID
    },
    rating: {
      type: DataTypes.INTEGER,
      validate: {
        min: 1,
        max: 5
      }
    },
    review: {
      type: DataTypes.TEXT
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'ratings',
    timestamps: false
  });

  Rating.associate = (models) => {
    Rating.belongsTo(models.Product, {
      foreignKey: 'product_id',
      as: 'product',
      onDelete: 'CASCADE'
    });

    // You can optionally add:
    // Rating.belongsTo(models.User, { foreignKey: 'user_id', as: 'user' });
  };

  return Rating;
};

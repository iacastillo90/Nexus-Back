/**
 * @fileoverview Modelo de Like.
 * @module models/like
 */
// /Nexus-Back/src/models/like.model.js
const { DataTypes } = require('sequelize');

/**
 * @typedef {object} LikeAttributes
 * @property {string} id - UUID del like (PK)
 * @property {string} userId - UUID del usuario que da like (FK)
 * @property {string} postId - UUID del post que recibe el like (FK)
 * @property {Date} createdAt - Fecha de creación
 * @property {Date} updatedAt - Fecha de última actualización
 */

module.exports = (sequelize, DataTypes) => {
  const Like = sequelize.define(
    'Like',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'user_id',
        references: {
          model: 'users',
          key: 'id',
        },
      },
      postId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'post_id',
        references: {
          model: 'posts',
          key: 'id',
        },
      },
    },
    {
      tableName: 'likes',
      timestamps: true,
      underscored: true,
      indexes: [
        {
          unique: true,
          fields: ['user_id', 'post_id'],
        },
      ],
    }
  );

  Like.associate = (models) => {
    Like.belongsTo(models.User, { foreignKey: 'userId', as: 'user' });
    Like.belongsTo(models.Post, { foreignKey: 'postId', as: 'post' });
  };

  return Like;
};


/**
 * @fileoverview Modelo de Post.
 * @module models/post
 */
// src/models/post.model.js
const { DataTypes, Model } = require('sequelize');

/**
 * Define el modelo 'Post'.
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @returns {import('sequelize').ModelCtor<Model>} El modelo Post definido.
 */
module.exports = (sequelize) => {
  const Post = sequelize.define(
    'Post', // Nombre del modelo en JS
    {
      // --- Atributos del Modelo ---
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
        allowNull: false,
      },
      content: {
        type: DataTypes.STRING(1000), // Límite generoso, podemos validarlo en Zod
        allowNull: false,
      },
      mediaUrls: {
        type: DataTypes.JSON,
        allowNull: true,
        field: 'media_urls',
      },
      visibility: {
        type: DataTypes.ENUM('PUBLIC', 'FOLLOWERS', 'PRIVATE'),
        defaultValue: 'PUBLIC',
        allowNull: false,
      },
      sentiment: {
        type: DataTypes.ENUM('positive', 'neutral', 'negative'),
        allowNull: true,
        comment: 'AI analyzed sentiment'
      },
      emotionalTone: {
        type: DataTypes.JSON, // Stores detailed emotions e.g. { joy: 0.8, anger: 0.1 }
        allowNull: true,
        field: 'emotional_tone',
        comment: 'Detailed emotional analysis'
      },
      geolocation: {
        type: DataTypes.GEOMETRY('POINT'),
        allowNull: true,
        comment: 'Spatial location (lat/lng)'
      },
      arMetadata: {
        type: DataTypes.JSON,
        allowNull: true,
        field: 'ar_metadata',
        comment: 'AR anchor data e.g. { anchorType: "plane", orientation: ... }'
      },
      // El 'userId' se definirá automáticamente por la asociación,
      // pero me gusta ser explícito aquí para que el modelo sea claro.
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'user_id', // Nombre explícito de la columna snake_case
        references: {
          // Esto define la restricción de clave foránea
          model: 'users', // Nombre de la tabla a la que referencia
          key: 'id', // Columna a la que referencia
        },
      },
    },
    {
      // --- Opciones del Modelo ---
      tableName: 'posts',
      timestamps: true,
      underscored: true, // Mapea userId a user_id
      paranoid: true, // Habilita borrado lógico
    }
  );

  /**
   * Define las asociaciones del modelo Post.
   * @param {Object} models - Todos los modelos (db)
   */
  Post.associate = (models) => {
    // Relación: Post pertenece a un User (Autor)
    Post.belongsTo(models.User, {
      foreignKey: 'userId', // Ya no necesitas 'field: user_id' si usas 'underscored: true'
      as: 'author',
    });

    // Relación: Post tiene muchos Comments
    Post.hasMany(models.Comment, {
      foreignKey: 'postId',
      as: 'comments',
      onDelete: 'CASCADE',
    });

    // Relación: Post tiene muchos Likes
    Post.hasMany(models.Like, {
      foreignKey: 'postId',
      as: 'likes',
      onDelete: 'CASCADE',
    });
  };

  return Post;
};

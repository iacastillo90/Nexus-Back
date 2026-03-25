/**
 * @fileoverview Modelo de Marcadores (Bookmarks).
 * @module models/bookmark
 */

/**
 * Define el modelo Bookmark para que los usuarios guarden posts.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Bookmark.
 */
module.exports = (sequelize, DataTypes) => {
  // Tabla intermedia para que los usuarios guarden posts
  const Bookmark = sequelize.define(
    'Bookmark',
    {
      userId: {
        type: DataTypes.UUID,
        field: 'user_id',
        references: {
          model: 'users',
          key: 'id',
        },
        primaryKey: true,
      },
      postId: {
        type: DataTypes.UUID,
        field: 'post_id',
        references: {
          model: 'posts',
          key: 'id',
        },
        primaryKey: true,
      },
    },
    {
      tableName: 'bookmarks',
      timestamps: true, // Útil para ordenar los posts guardados por fecha
      underscored: true,
    }
  );

  Bookmark.associate = (models) => {
    Bookmark.belongsTo(models.User, { foreignKey: 'userId', as: 'user' });
    Bookmark.belongsTo(models.Post, { foreignKey: 'postId', as: 'post' });
  };

  return Bookmark;
};

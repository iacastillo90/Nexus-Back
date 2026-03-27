/**
 * @fileoverview Modelo de Etiqueta de Post.
 * @module models/postTag
 */

/**
 * Define el modelo PostTag para la relación N:M entre Posts y Tags.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo PostTag.
 */
module.exports = (sequelize, DataTypes) => {
  // Esta es la tabla intermedia para la relación Muchos a Muchos
  const PostTag = sequelize.define(
    'PostTag',
    {
      postId: {
        type: DataTypes.UUID,
        field: 'post_id',
        references: {
          model: 'posts',
          key: 'id',
        },
        primaryKey: true,
      },
      tagId: {
        type: DataTypes.INTEGER,
        field: 'tag_id',
        references: {
          model: 'tags',
          key: 'id',
        },
        primaryKey: true,
      },
    },
    {
      tableName: 'post_tags',
      timestamps: false,
    },
  );

  return PostTag;
};

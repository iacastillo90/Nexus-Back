/**
 * @fileoverview Modelo de Etiqueta (Tag).
 * @module models/tag
 */

/**
 * Define el modelo Tag para categorizar posts.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Tag.
 */
module.exports = (sequelize, DataTypes) => {
  const Tag = sequelize.define(
    'Tag',
    {
      id: {
        type: DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true,
      },
      name: {
        type: DataTypes.STRING(50),
        allowNull: false,
        unique: true, // No puede haber dos tags con el mismo nombre
      },
    },
    {
      tableName: 'tags',
      timestamps: false, // Generalmente no se necesita saber cuándo se creó un tag
    }
  );

  Tag.associate = (models) => {
    Tag.belongsToMany(models.Post, {
      through: models.PostTag,
      foreignKey: 'tagId',
      otherKey: 'postId',
      as: 'posts'
    });
  };

  return Tag;
};

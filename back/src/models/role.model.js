// src/models/role.model.js

const { DataTypes, Model } = require('sequelize');

/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'Role'.
 * @module models/role
 */

/**
 * Define el modelo 'Role' para la base de datos.
 *
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @returns {import('sequelize').ModelCtor<Model>} El modelo Role definido.
 */
module.exports = (sequelize) => {
  /**
   * @class Role
   * @classdesc Modelo de Sequelize que representa un rol de usuario (e.j., admin, user).
   * @property {string} id - ID UUID (PK)
   * @property {string} name - Nombre único del rol ('admin', 'user', 'moderator')
   * @property {string} [description] - Descripción opcional del rol
   */
  const Role = sequelize.define(
    'Role',
    {
      /**
       * Clave primaria UUID.
       * @type {string}
       */
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
        allowNull: false
      },

      /**
       * Nombre único del rol.
       * @type {string}
       */
      name: {
        type: DataTypes.STRING(50),
        allowNull: false,
        unique: {
          name: 'unique_role_name',
          msg: 'Role name must be unique.',
        },
      },

      /**
       * Descripción opcional de los permisos o propósito del rol.
       * @type {string}
       */
      description: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
    },
    {
      /**
       * Opciones del modelo
       */

      // Nombre explícito de la tabla en la base de datos
      tableName: 'roles',

      // Activamos timestamps (createdAt, updatedAt)
      timestamps: true,

      // Usamos snake_case para las columnas (created_at, updated_at)
      underscored: true,
    }
  );

  /**
   * Define las asociaciones del modelo Role.
   * @param {Object} models - Todos los modelos definidos en Sequelize.
   */
  Role.associate = (models) => {
    // Un Rol puede pertenecer a muchos Usuarios
    Role.hasMany(models.User, {
      foreignKey: 'roleId',
      as: 'users',
    });
  };

  return Role;
};

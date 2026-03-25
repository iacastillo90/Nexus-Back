/**
 * @fileoverview Modelo de Bloqueo de Usuarios.
 * @module models/block
 */

/**
 * Define el modelo Block para gestionar bloqueos entre usuarios.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Block.
 */
module.exports = (sequelize, DataTypes) => {
  // Tabla intermedia para registrar los bloqueos entre usuarios
  const Block = sequelize.define(
    'Block',
    {
      // El usuario que inicia el bloqueo
      blockerId: {
        type: DataTypes.UUID,
        field: 'blocker_id',
        references: {
          model: 'users',
          key: 'id',
        },
        primaryKey: true,
      },
      // El usuario que es bloqueado
      blockedId: {
        type: DataTypes.UUID,
        field: 'blocked_id',
        references: {
          model: 'users',
          key: 'id',
        },
        primaryKey: true,
      },
    },
    {
      tableName: 'blocks',
      timestamps: true, // Para saber cuándo se realizó el bloqueo
      underscored: true,
    },
  );

  Block.associate = (models) => {
    Block.belongsTo(models.User, { foreignKey: 'blockerId', as: 'blocker' });
    Block.belongsTo(models.User, { foreignKey: 'blockedId', as: 'blocked' });
  };

  return Block;
};

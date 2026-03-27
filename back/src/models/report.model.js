/**
 * @fileoverview Modelo de Reporte.
 * @module models/report
 */

/**
 * Define el modelo Report para gestionar reportes de usuarios y contenido.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Report.
 */
module.exports = (sequelize, DataTypes) => {
  const Report = sequelize.define(
    'Report',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      // Quién hace el reporte
      reporterId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'reporter_id',
        references: { model: 'users', key: 'id' },
      },
      // Motivo del reporte
      reason: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      // Estado del reporte: pendiente, revisado, resuelto, etc.
      status: {
        type: DataTypes.ENUM('pending', 'reviewed', 'resolved'),
        defaultValue: 'pending',
        allowNull: false,
      },
      // --- Contenido Reportado (solo uno de estos tendrá valor) ---
      reportedUserId: {
        type: DataTypes.UUID,
        allowNull: true,
        field: 'reported_user_id',
        references: { model: 'users', key: 'id' },
      },
      reportedPostId: {
        type: DataTypes.UUID,
        allowNull: true,
        field: 'reported_post_id',
        references: { model: 'posts', key: 'id' },
      },
      // Podrías añadir reportedCommentId, etc.
    },
    {
      tableName: 'reports',
      timestamps: true,
      underscored: true,
    }
  );

  Report.associate = (models) => {
    Report.belongsTo(models.User, { foreignKey: 'reporterId', as: 'reporter' });
    Report.belongsTo(models.User, { foreignKey: 'reportedUserId', as: 'reportedUser' });
    Report.belongsTo(models.Post, { foreignKey: 'reportedPostId', as: 'reportedPost' });
  };

  return Report;
};

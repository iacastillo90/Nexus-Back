/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'Notification'.
 * @module models/notification
 */

/**
 * @typedef {object} NotificationAttributes
 * @property {string} id - UUID de la notificación (PK)
 * @property {string} recipientId - Usuario que recibe la notificación (FK)
 * @property {string} senderId - Usuario que origina la acción (FK)
 * @property {'follow'|'like'|'comment'} type - Tipo de notificación
 * @property {string} [postId] - Post asociado (si aplica, para likes/comments) (FK)
 * @property {boolean} read - Si la notificación ha sido leída
 * @property {Date} createdAt - Fecha de creación
 * @property {Date} updatedAt - Fecha de última actualización
 */

/**
 * Define el modelo 'Notification'.
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').ModelCtor<import('sequelize').Model<NotificationAttributes>>} El modelo Notification definido.
 */
module.exports = (sequelize, DataTypes) => {
  const Notification = sequelize.define(
    'Notification',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      // Usuario que recibe la notificación
      recipientId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'recipient_id',
        references: { model: 'users', key: 'id' },
      },
      // Usuario que generó la notificación (quien te siguió, dio like, etc.)
      senderId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'sender_id',
        references: { model: 'users', key: 'id' },
      },
      type: {
        type: DataTypes.ENUM('follow', 'like', 'comment'),
        allowNull: false,
      },
      // El post relacionado con la notificación (opcional, no aplica para 'follow')
      postId: {
        type: DataTypes.UUID,
        allowNull: true,
        field: 'post_id',
        references: { model: 'posts', key: 'id' },
      },
      read: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
        allowNull: false,
      },
    },
    {
      tableName: 'notifications',
      timestamps: true,
      underscored: true,
    },
  );

  /**
   * Define las asociaciones del modelo Notification.
   * @param {Object} models - Todos los modelos (db)
   */
  Notification.associate = (models) => {
    Notification.belongsTo(models.User, { foreignKey: 'recipientId', as: 'recipient' });
    Notification.belongsTo(models.User, { foreignKey: 'senderId', as: 'sender' });
    Notification.belongsTo(models.Post, { foreignKey: 'postId', as: 'post' });
  };

  return Notification;
};

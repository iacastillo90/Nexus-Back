/**
 * @fileoverview Modelo de Mensaje.
 * @module models/message
 */

/**
 * Define el modelo Message para mensajes en una conversación.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Message.
 */
module.exports = (sequelize, DataTypes) => {
  // Representa un mensaje individual dentro de una conversación
  const Message = sequelize.define(
    'Message',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      content: {
        type: DataTypes.TEXT, // TEXT para mensajes más largos
        allowNull: false,
      },
      senderId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'sender_id',
        references: { model: 'users', key: 'id' },
      },
      conversationId: {
        type: DataTypes.UUID,
        allowNull: false,
        field: 'conversation_id',
        references: { model: 'conversations', key: 'id' },
      },
    },
    {
      tableName: 'messages',
      timestamps: true,
      underscored: true,
    }
  );

  Message.associate = (models) => {
    Message.belongsTo(models.User, { foreignKey: 'senderId', as: 'sender' });
    Message.belongsTo(models.Conversation, { foreignKey: 'conversationId', as: 'conversation' });
  };

  return Message;
};

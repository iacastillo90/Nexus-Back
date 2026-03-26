/**
 * @fileoverview Modelo de Conversación.
 * @module models/conversation
 */

/**
 * Define el modelo Conversation para chats entre usuarios.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo Conversation.
 */
module.exports = (sequelize, DataTypes) => {
  // Representa una conversación entre dos o más usuarios
  const Conversation = sequelize.define(
    'Conversation',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      // Podrías añadir un nombre para chats grupales en el futuro
      // name: { type: DataTypes.STRING, allowNull: true }
    },
    {
      tableName: 'conversations',
      timestamps: true,
      underscored: true,
    }
  );

  Conversation.associate = (models) => {
    Conversation.hasMany(models.Message, { foreignKey: 'conversationId', as: 'messages' });
    Conversation.belongsToMany(models.User, {
      through: models.ConversationParticipant,
      foreignKey: 'conversationId',
      otherKey: 'userId',
      as: 'participants'
    });
  };

  return Conversation;
};

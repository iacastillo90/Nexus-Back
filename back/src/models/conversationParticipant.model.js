/**
 * @fileoverview Modelo de Participante de Conversación.
 * @module models/conversationParticipant
 */

/**
 * Define el modelo ConversationParticipant para la relación N:M entre Usuarios y Conversaciones.
 * @param {import('sequelize').Sequelize} sequelize - Instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').Model} Modelo ConversationParticipant.
 */
module.exports = (sequelize, DataTypes) => {
  const ConversationParticipant = sequelize.define(
    'ConversationParticipant',
    {
      userId: {
        type: DataTypes.UUID,
        field: 'user_id',
        references: { model: 'users', key: 'id' },
        primaryKey: true,
      },
      conversationId: {
        type: DataTypes.UUID,
        field: 'conversation_id',
        references: { model: 'conversations', key: 'id' },
        primaryKey: true,
      },
    },
    {
      tableName: 'conversation_participants',
      timestamps: true, // Útil para saber cuándo se unió
      underscored: true,
    },
  );

  return ConversationParticipant;
};

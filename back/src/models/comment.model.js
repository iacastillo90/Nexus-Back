const { DataTypes, Model } = require('sequelize');

/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'Comment'.
 * @module models/comment
 */

/**
 * @typedef {object} CommentAttributes
 * @property {string} id - UUID del comentario (PK)
 * @property {string} content - Contenido del comentario
 * @property {string} userId - UUID del autor (FK)
 * @property {string} postId - UUID del post (FK)
 * @property {Date} createdAt - Fecha de creación
 * @property {Date} updatedAt - Fecha de última actualización
 * @property {Date} [deletedAt] - Fecha de borrado lógico
 */

/**
 * Define el modelo 'Comment'.
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @returns {import('sequelize').ModelCtor<import('sequelize').Model<CommentAttributes>>} El modelo Comment definido.
 */
module.exports = (sequelize) => {
    const Comment = sequelize.define('Comment', {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true,
            allowNull: false,
        },
        content: {
            type: DataTypes.STRING(500),
            allowNull: false,
        },
        userId: {
            type: DataTypes.UUID,
            allowNull: false,
            field: 'user_id',
        },
        postId: {
            type: DataTypes.UUID,
            allowNull: false,
            field: 'post_id',
        },
    }, {
        tableName: 'comments',
        timestamps: true,
        underscored: true,
        paranoid: true,
    });

    /**
     * Define las asociaciones del modelo Comment.
     * @param {Object} models - Todos los modelos (db)
     */
    Comment.associate = (models) => {
        Comment.belongsTo(models.User, { foreignKey: 'userId', as: 'author' });
        Comment.belongsTo(models.Post, { foreignKey: 'postId', as: 'post' });
    };

    return Comment;
};


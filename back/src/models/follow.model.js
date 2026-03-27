const { DataTypes } = require('sequelize');

/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'Follow'.
 * @module models/follow
 */

/**
 * @typedef {object} FollowAttributes
 * @property {string} id - UUID de la relación (PK)
 * @property {string} followerId - UUID del seguidor (FK)
 * @property {string} followingId - UUID del seguido (FK)
 * @property {Date} createdAt - Fecha de creación
 */

/**
 * Define el modelo 'Follow'.
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @returns {import('sequelize').ModelCtor<import('sequelize').Model<FollowAttributes>>} El modelo Follow definido.
 */
module.exports = (sequelize) => {
    const Follow = sequelize.define(
        'Follow',
        {
            id: {
                type: DataTypes.UUID,
                defaultValue: DataTypes.UUIDV4,
                primaryKey: true,
                allowNull: false,
            },
            followerId: {
                type: DataTypes.UUID,
                allowNull: false,
                field: 'follower_id',
                references: {
                    model: 'users',
                    key: 'id',
                },
            },
            followingId: {
                type: DataTypes.UUID,
                allowNull: false,
                field: 'following_id',
                references: {
                    model: 'users',
                    key: 'id',
                },
            },
            createdAt: {
                type: DataTypes.DATE,
                allowNull: false,
                defaultValue: DataTypes.NOW,
                field: 'created_at',
            },
        },
        {
            tableName: 'follows',
            timestamps: false,
            underscored: true,
            indexes: [
                {
                    unique: true,
                    fields: ['follower_id', 'following_id'],
                },
                {
                    fields: ['follower_id'],
                },
                {
                    fields: ['following_id'],
                },
            ],
        }
    );

    /**
     * Define las asociaciones del modelo Follow.
     * @param {Object} models - Todos los modelos (db)
     */
    Follow.associate = (models) => {
        // Follower (el que sigue)
        Follow.belongsTo(models.User, {
            foreignKey: 'followerId',
            as: 'follower',
        });

        // Following (el que es seguido)
        Follow.belongsTo(models.User, {
            foreignKey: 'followingId',
            as: 'following',
        });
    };

    return Follow;
};


/**
 * @fileoverview Modelo de Dream (Sueño Colectivo).
 * @module models/dream
 */
const { DataTypes, Model } = require('sequelize');

module.exports = (sequelize) => {
    const Dream = sequelize.define(
        'Dream',
        {
            id: {
                type: DataTypes.UUID,
                defaultValue: DataTypes.UUIDV4,
                primaryKey: true,
                allowNull: false,
            },
            title: {
                type: DataTypes.STRING,
                allowNull: false,
            },
            theme: {
                type: DataTypes.STRING,
                allowNull: false,
                comment: 'Theme or prompt for the dream (e.g., "Cyberpunk City")',
            },
            currentState: {
                type: DataTypes.JSON,
                allowNull: true,
                field: 'current_state',
                comment: 'Current AI-generated state (text, image url, etc.)',
            },
            status: {
                type: DataTypes.ENUM('ACTIVE', 'COMPLETED'),
                defaultValue: 'ACTIVE',
                allowNull: false,
            },
            createdBy: {
                type: DataTypes.UUID,
                allowNull: false,
                field: 'created_by',
            },
        },
        {
            tableName: 'dreams',
            timestamps: true,
            underscored: true,
        }
    );

    Dream.associate = (models) => {
        Dream.belongsTo(models.User, {
            foreignKey: 'createdBy',
            as: 'creator',
        });
        Dream.hasMany(models.DreamContribution, {
            foreignKey: 'dreamId',
            as: 'contributions',
        });
    };

    return Dream;
};


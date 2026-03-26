/**
 * @fileoverview Modelo de DreamContribution (Contribución a un Sueño).
 * @module models/dreamContribution
 */
const { DataTypes, Model } = require('sequelize');

module.exports = (sequelize) => {
    const DreamContribution = sequelize.define(
        'DreamContribution',
        {
            id: {
                type: DataTypes.UUID,
                defaultValue: DataTypes.UUIDV4,
                primaryKey: true,
                allowNull: false,
            },
            content: {
                type: DataTypes.STRING(1000),
                allowNull: false,
                comment: 'User contribution text',
            },
            sentiment: {
                type: DataTypes.STRING,
                allowNull: true,
                comment: 'Analyzed sentiment of the contribution',
            },
            dreamId: {
                type: DataTypes.UUID,
                allowNull: false,
                field: 'dream_id',
            },
            userId: {
                type: DataTypes.UUID,
                allowNull: false,
                field: 'user_id',
            },
        },
        {
            tableName: 'dream_contributions',
            timestamps: true,
            underscored: true,
        }
    );

    DreamContribution.associate = (models) => {
        DreamContribution.belongsTo(models.Dream, {
            foreignKey: 'dreamId',
            as: 'dream',
        });
        DreamContribution.belongsTo(models.User, {
            foreignKey: 'userId',
            as: 'contributor',
        });
    };

    return DreamContribution;
};


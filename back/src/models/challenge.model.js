const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    /**
     * Modelo de Desafío Social.
     * 
     * Representa un reto o misión que los usuarios pueden completar
     * para ganar recompensas y mejorar su estatus.
     * 
     * @typedef {Object} Challenge
     * @property {string} id - UUID único del desafío
     * @property {string} title - Título descriptivo
     * @property {string} description - Descripción detallada
     * @property {string} type - Tipo ('daily', 'weekly', 'special')
     * @property {Object} requirements - Criterios de completitud (JSON)
     * @property {Object} reward - Recompensa por completar (JSON)
     * @property {Date} startDate - Fecha de inicio
     * @property {Date} endDate - Fecha de fin
     * @property {boolean} isActive - Si el desafío está activo
     */
    const Challenge = sequelize.define('Challenge', {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true,
            allowNull: false
        },
        title: {
            type: DataTypes.STRING,
            allowNull: false
        },
        description: {
            type: DataTypes.TEXT,
            allowNull: true
        },
        type: {
            type: DataTypes.ENUM('daily', 'weekly', 'special'),
            defaultValue: 'daily',
            allowNull: false
        },
        requirements: {
            type: DataTypes.JSON,
            allowNull: false,
            comment: 'Criteria to complete challenge e.g. { type: "post_sentiment", value: "positive", count: 3 }'
        },
        reward: {
            type: DataTypes.JSON,
            allowNull: false,
            comment: 'Reward for completion e.g. { points: 100, badge: "positivity_guru" }'
        },
        startDate: {
            type: DataTypes.DATE,
            allowNull: false,
            defaultValue: DataTypes.NOW,
            field: 'start_date'
        },
        endDate: {
            type: DataTypes.DATE,
            allowNull: false,
            field: 'end_date'
        },
        isActive: {
            type: DataTypes.BOOLEAN,
            defaultValue: true,
            field: 'is_active'
        }
    }, {
        tableName: 'challenges',
        timestamps: true,
        underscored: true
    });

    Challenge.associate = (models) => {
        Challenge.belongsToMany(models.User, {
            through: models.ChallengeParticipant,
            foreignKey: 'challengeId',
            as: 'participants'
        });
    };

    return Challenge;
};


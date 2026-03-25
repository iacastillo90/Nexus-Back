const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    /**
     * Modelo de Participación en Desafío.
     * 
     * Tabla pivote que registra el progreso de un usuario en un desafío específico.
     * 
     * @typedef {Object} ChallengeParticipant
     * @property {string} id - UUID único de la participación
     * @property {string} userId - ID del usuario participante
     * @property {string} challengeId - ID del desafío
     * @property {number} progress - Progreso actual (contador)
     * @property {string} status - Estado ('active', 'completed', 'failed')
     * @property {Date} completedAt - Fecha de completitud
     * 
     * Relaciones:
     * @property {User} user - Usuario (belongsTo)
     * @property {Challenge} challenge - Desafío (belongsTo)
     */
    const ChallengeParticipant = sequelize.define('ChallengeParticipant', {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true,
            allowNull: false
        },
        userId: {
            type: DataTypes.UUID,
            allowNull: false,
            references: {
                model: 'users',
                key: 'id'
            },
            field: 'user_id'
        },
        challengeId: {
            type: DataTypes.UUID,
            allowNull: false,
            references: {
                model: 'challenges',
                key: 'id'
            },
            field: 'challenge_id'
        },
        progress: {
            type: DataTypes.INTEGER,
            defaultValue: 0,
            allowNull: false,
            comment: 'Current progress count'
        },
        status: {
            type: DataTypes.ENUM('active', 'completed', 'failed'),
            defaultValue: 'active',
            allowNull: false
        },
        completedAt: {
            type: DataTypes.DATE,
            allowNull: true,
            field: 'completed_at'
        }
    }, {
        tableName: 'challenge_participants',
        timestamps: true,
        underscored: true,
        indexes: [
            {
                unique: true,
                fields: ['user_id', 'challenge_id']
            }
        ]
    });

    ChallengeParticipant.associate = (models) => {
        ChallengeParticipant.belongsTo(models.User, {
            foreignKey: 'userId',
            as: 'user'
        });
        ChallengeParticipant.belongsTo(models.Challenge, {
            foreignKey: 'challengeId',
            as: 'challenge'
        });
    };

    return ChallengeParticipant;
};


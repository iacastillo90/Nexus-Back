const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    /**
     * Modelo de Perfil de Voz.
     * 
     * Almacena la información necesaria para clonar y usar la voz de un usuario.
     * 
     * @typedef {Object} VoiceProfile
     * @property {string} id - UUID único del perfil
     * @property {string} userId - ID del usuario propietario
     * @property {string} elevenLabsVoiceId - ID de la voz en ElevenLabs
     * @property {string} status - Estado ('pending', 'processing', 'ready', 'failed')
     * @property {string[]} samples - URLs de las muestras de audio usadas
     * 
     * Relaciones:
     * @property {User} user - Usuario propietario (belongsTo)
     */
    const VoiceProfile = sequelize.define('VoiceProfile', {
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
        elevenLabsVoiceId: {
            type: DataTypes.STRING,
            allowNull: true,
            comment: 'Voice ID returned by ElevenLabs',
            field: 'eleven_labs_voice_id'
        },
        status: {
            type: DataTypes.ENUM('pending', 'processing', 'ready', 'failed'),
            defaultValue: 'pending',
            allowNull: false
        },
        samples: {
            type: DataTypes.JSON, // Array of URLs
            defaultValue: [],
            allowNull: false,
            comment: 'List of sample audio URLs used for cloning'
        }
    }, {
        tableName: 'voice_profiles',
        timestamps: true,
        underscored: true,
        indexes: [
            {
                unique: true,
                fields: ['user_id']
            }
        ]
    });

    VoiceProfile.associate = (models) => {
        VoiceProfile.belongsTo(models.User, {
            foreignKey: 'userId',
            as: 'user'
        });
    };

    return VoiceProfile;
};


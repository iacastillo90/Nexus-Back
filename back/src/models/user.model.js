const { DataTypes, Model } = require('sequelize');
const logger = require('../utils/logger');

/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'User'.
 * @module models/user
 */

module.exports = (sequelize) => {
  const User = sequelize.define(
    'User',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
        allowNull: false,
      },
      username: {
        type: DataTypes.STRING(50),
        allowNull: false,
        unique: {
          name: 'unique_username',
          msg: 'Username is already taken.',
        },
      },
      firstName: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      lastName: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      avatarUrl: {
        type: DataTypes.STRING(500),
        allowNull: true,
        comment: 'URL of the user profile picture'
      },
      email: {
        type: DataTypes.STRING(255),
        allowNull: false,
        unique: {
          name: 'unique_email',
          msg: 'Email is already registered.',
        },
        validate: {
          isEmail: {
            msg: 'Must be a valid email address.',
          },
        },
      },
      passwordHash: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      isVerified: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      isActive: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: true,
      },
      lastLoginAt: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      emailVerifiedAt: {
        type: DataTypes.DATE,
        allowNull: true,
      },
      echoEnabled: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
        field: 'echo_enabled',
        comment: 'Whether user has Echo (AI twin) enabled'
      },
      echoPlan: {
        type: DataTypes.ENUM('free', 'premium', 'creator'),
        defaultValue: 'free',
        field: 'echo_plan',
        comment: 'Echo subscription plan'
      },
      karmaPoints: {
        type: DataTypes.INTEGER,
        defaultValue: 0,
        field: 'karma_points',
        comment: 'Total karma points earned from challenges and engagement'
      },
    },
    {
      timestamps: true,
      paranoid: true,
      underscored: true,
      defaultScope: {
        attributes: { exclude: ['passwordHash'] },
      },
    }
  );

  User.associate = (models) => {
    // Un usuario pertenece a un Rol
    if (models.Role) {
      User.belongsTo(models.Role, {
        foreignKey: 'roleId',
        as: 'role',
      });
    }

    // Un usuario puede tener muchos Posts
    if (models.Post) {
      User.hasMany(models.Post, {
        foreignKey: 'userId',
        as: 'posts',
      });
    }

    // Un usuario puede seguir a muchos usuarios (followers)
    if (models.Follow) {
      User.hasMany(models.Follow, {
        foreignKey: 'followerId',
        as: 'following',
      });
    }

    // Un usuario puede ser seguido por muchos usuarios (following)
    if (models.Follow) {
      User.hasMany(models.Follow, {
        foreignKey: 'followingId',
        as: 'followers',
      });
    }

    // Un usuario tiene un perfil de voz (Voice Cloning)
    if (models.VoiceProfile) {
      User.hasOne(models.VoiceProfile, {
        foreignKey: 'userId',
        as: 'voiceProfile'
      });
    }

    // Un usuario participa en retos
    if (models.Challenge && models.ChallengeParticipant) {
      User.belongsToMany(models.Challenge, {
        through: models.ChallengeParticipant,
        foreignKey: 'userId',
        as: 'challenges'
      });
    }
  };

  User.beforeCreate((user, options) => {
    logger.info(`[User.model] Creating new user: ${user.username}`);
  });

  User.prototype.toJSON = function () {
    const values = { ...this.get() };
    delete values.passwordHash;
    delete values.deletedAt;
    return values;
  };

  return User;
};

/**
 * @fileoverview Define el modelo de Sequelize para la entidad 'Profile'.
 * @module models/profile
 */

/**
 * @typedef {object} ProfileAttributes
 * @property {string} userId - UUID del usuario (PK, FK)
 * @property {string} [bio] - Biografía del usuario
 * @property {string} [location] - Ubicación del usuario
 * @property {string} [website] - Sitio web del usuario
 * @property {string} [profilePictureUrl] - URL de la foto de perfil
 * @property {string} [coverPhotoUrl] - URL de la foto de portada
 */

/**
 * Define el modelo 'Profile'.
 * @param {import('sequelize').Sequelize} sequelize - La instancia de Sequelize.
 * @param {import('sequelize').DataTypes} DataTypes - Tipos de datos de Sequelize.
 * @returns {import('sequelize').ModelCtor<import('sequelize').Model<ProfileAttributes>>} El modelo Profile definido.
 */
module.exports = (sequelize, DataTypes) => {
  const Profile = sequelize.define(
    'Profile',
    {
      // Usamos el userId como clave primaria para forzar una relación 1 a 1
      userId: {
        type: DataTypes.UUID,
        primaryKey: true,
        allowNull: false,
        field: 'user_id',
        references: {
          model: 'users',
          key: 'id',
        },
      },
      bio: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      location: {
        type: DataTypes.STRING(100),
        allowNull: true,
      },
      website: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      profilePictureUrl: {
        type: DataTypes.STRING(255),
        allowNull: true,
        field: 'profile_picture_url',
      },
      coverPhotoUrl: {
        type: DataTypes.STRING(255),
        allowNull: true,
        field: 'cover_photo_url',
      },
    },
    {
      tableName: 'profiles',
      timestamps: true, // Para saber cuándo se actualizó el perfil por última vez
      underscored: true,
    }
  );

  /**
   * Define las asociaciones del modelo Profile.
   * @param {Object} models - Todos los modelos (db)
   */
  Profile.associate = (models) => {
    Profile.belongsTo(models.User, { foreignKey: 'userId', as: 'user' });
  };

  return Profile;
};

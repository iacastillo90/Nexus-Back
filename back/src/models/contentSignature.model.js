const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
    /**
     * Content Signature Model (Content DNA).
     * 
     * Stores cryptographic signatures of all content created in Nexus,
     * allowing for authenticity verification and stolen content detection.
     * 
     * @typedef {Object} ContentSignature
     * @property {string} id - Unique UUID
     * @property {string} dnaHash - SHA-256 hash (64 hex chars) - UNIQUE
     * @property {string} authorId - Original author UUID (Foreign Key -> User)
     * @property {string} [contentText] - Content text (nullable if only media)
     * @property {string} [mediaHash] - SHA-256 hash of media file
     * @property {string} contentType - Type: 'post' | 'comment' | 'message' | 'audio' | 'dream'
     * @property {string} [parentId] - Parent content ID (if comment/reply)
     * @property {Date} timestamp - Exact creation time (milliseconds)
     * @property {string} algorithm - Cryptographic algorithm used ('sha256')
     * @property {string} payload - Data used to generate hash (without secret)
     * @property {Date} createdAt - DB registration date
     * @property {Date} updatedAt - Last update
     */
    const ContentSignature = sequelize.define('ContentSignature', {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true
        },
        dnaHash: {
            type: DataTypes.STRING(64),
            allowNull: false,
            unique: true,
            validate: {
                is: /^[a-f0-9]{64}$/i
            },
            comment: 'Unique SHA-256 hash of content (Content DNA)'
        },
        authorId: {
            type: DataTypes.UUID,
            allowNull: false,
            references: {
                model: 'users',
                key: 'id'
            },
            onDelete: 'CASCADE',
            comment: 'User who created the original content'
        },
        contentText: {
            type: DataTypes.TEXT,
            allowNull: true,
            comment: 'Content text (can be null if only media)'
        },
        mediaHash: {
            type: DataTypes.STRING(64),
            allowNull: true,
            validate: {
                is: /^[a-f0-9]{64}$/i
            },
            comment: 'SHA-256 hash of media file (if exists)'
        },
        contentType: {
            type: DataTypes.ENUM('post', 'comment', 'message', 'audio', 'dream'),
            allowNull: false,
            comment: 'Type of certified content'
        },
        parentId: {
            type: DataTypes.UUID,
            allowNull: true,
            comment: 'Parent content ID (if comment or reply)'
        },
        timestamp: {
            type: DataTypes.DATE(3), // Millisecond precision
            allowNull: false,
            comment: 'Exact moment of content creation'
        },
        algorithm: {
            type: DataTypes.STRING(20),
            allowNull: false,
            defaultValue: 'sha256',
            comment: 'Cryptographic algorithm used'
        },
        payload: {
            type: DataTypes.TEXT,
            allowNull: false,
            comment: 'Data used to generate hash (without server secret)'
        }
    }, {
        tableName: 'content_signatures',
        timestamps: true,
        indexes: [
            {
                unique: true,
                fields: ['dnaHash']
            },
            {
                fields: ['authorId']
            },
            {
                fields: ['mediaHash']
            },
            {
                fields: ['contentType', 'timestamp']
            }
        ]
    });

    /**
     * Model associations
     */
    ContentSignature.associate = (models) => {
        ContentSignature.belongsTo(models.User, {
            foreignKey: 'authorId',
            as: 'author'
        });
    };

    return ContentSignature;
};


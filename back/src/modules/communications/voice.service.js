const { VoiceProfile, User } = require('../../models');
const AIFactory = require('./ai/ai.factory');
const { NotFoundError, ValidationError, ExternalAPIError } = require('../../utils/errors');
const logger = require('../../utils/logger');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const util = require('util');

const writeFile = util.promisify(fs.writeFile);
const readFile = util.promisify(fs.readFile);
const exists = util.promisify(fs.exists);
const mkdir = util.promisify(fs.mkdir);

class VoiceService {
    constructor() {
        this.cacheDir = path.join(__dirname, '../../uploads/audio_cache');
        this.ensureCacheDir();
    }

    async ensureCacheDir() {
        if (!fs.existsSync(this.cacheDir)) {
            await mkdir(this.cacheDir, { recursive: true });
        }
    }

    /**
     * Creates or updates a voice profile for a user.
     * @param {string} userId - User ID
     * @param {string} name - Name for the voice
     * @param {string[]} samplePaths - Paths to audio samples
     * @returns {Promise<Object>} VoiceProfile
     */
    async createVoiceProfile(userId, name, samplePaths) {
        try {
            const user = await User.findByPk(userId);
            if (!user) throw new NotFoundError('User not found');

            // Check if profile exists
            let profile = await VoiceProfile.findOne({ where: { userId } });

            // Get Audio Provider (ElevenLabs)
            const provider = AIFactory.getProvider('audio');

            logger.info(`[VoiceService] Cloning voice "${name}" for user ${userId}`);
            const voiceId = await provider.addVoice(name, samplePaths);

            if (profile) {
                profile.elevenLabsVoiceId = voiceId;
                profile.samples = samplePaths;
                profile.status = 'ready';
                await profile.save();
            } else {
                profile = await VoiceProfile.create({
                    userId,
                    elevenLabsVoiceId: voiceId,
                    status: 'ready',
                    samples: samplePaths
                });
            }

            return profile;
        } catch (error) {
            logger.error(`[VoiceService] Failed to create voice profile: ${error.message}`);
            // Fail-Closed: Propagate error to prevent invalid state
            throw error;
        }
    }



    /**
     * Generates audio using the user's cloned voice or a default voice.
     * @param {string} userId - User ID
     * @param {string} text - Text to speak
     * @returns {Promise<Buffer>} Audio buffer
     */
    async generateAudio(userId, text) {
        try {
            // 1. Obtener perfil
            const profile = await VoiceProfile.findOne({ where: { userId } });
            const voiceId = profile && profile.status === 'ready' ? profile.elevenLabsVoiceId : null;

            // 2. Check Cache
            const cacheKey = this.getCacheKey(voiceId || 'default', text);
            try {
                const cachedAudio = await this.getFromCache(cacheKey);
                if (cachedAudio) {
                    logger.info('[VoiceService] Cache hit');
                    return cachedAudio;
                }
            } catch (cacheError) {
                logger.warn(`[VoiceService] Cache read error (ignoring): ${cacheError.message}`);
            }

            // 3. Generar
            const provider = AIFactory.getProvider('audio');
            const options = voiceId ? { voiceId } : {};

            logger.info(`[VoiceService] Generating audio...`);
            const audioBuffer = await provider.generateAudio(text, options);

            // 4. Guardar Cache (Fire & Forget o Await seguro)
            this.saveToCache(cacheKey, audioBuffer).catch(e =>
                logger.warn(`[VoiceService] Cache write error: ${e.message}`)
            );

            return audioBuffer;

        } catch (error) {
            logger.error(`[VoiceService] Critical generation error: ${error.message}`);
            throw error; // Re-lanzar para que el controller mande 500
        }
    }

    getCacheKey(voiceId, text) {
        return crypto.createHash('md5').update(`${voiceId}:${text}`).digest('hex');
    }

    async getFromCache(key) {
        const filePath = path.join(this.cacheDir, `${key}.mp3`);
        if (fs.existsSync(filePath)) {
            return await readFile(filePath);
        }
        return null;
    }

    async saveToCache(key, buffer) {
        const filePath = path.join(this.cacheDir, `${key}.mp3`);
        await writeFile(filePath, buffer);
    }
}

module.exports = new VoiceService();


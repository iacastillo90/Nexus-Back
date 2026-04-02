const voiceService = require('./voice.service');
const logger = require('../../utils/logger');

class VoiceController {
    /**
     * Clona la voz del usuario.
     * 
     * Recibe muestras de audio (archivos) y crea un perfil de voz
     * utilizando el proveedor de IA configurado (ej. ElevenLabs).
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async cloneVoice(req, res, next) {
        try {
            const { name } = req.body;
            const userId = req.user.id;

            // Assuming files are uploaded via multer and available in req.files
            const samplePaths = req.files ? req.files.map(f => f.path) : [];

            if (samplePaths.length === 0) {
                return res.status(400).json({ error: 'No audio samples provided' });
            }

            const profile = await voiceService.createVoiceProfile(userId, name || 'My Voice', samplePaths);

            res.status(200).json({
                success: true,
                data: profile
            });
        } catch (error) {
            next(error);
        }
    }

    /**
     * Genera audio a partir de texto (TTS) usando la voz clonada.
     * 
     * @param {Object} req - Express request
     * @param {Object} res - Express response
     * @param {Function} next - Express next middleware
     */
    async speak(req, res, next) {
        try {
            const { text } = req.body;
            const userId = req.user.id;

            if (!text) {
                return res.status(400).json({ error: 'Text is required' });
            }

            const audioBuffer = await voiceService.generateAudio(userId, text);

            res.set({
                'Content-Type': 'audio/mpeg',
                'Content-Length': audioBuffer.length
            });
            res.send(audioBuffer);
        } catch (error) {
            next(error);
        }
    }
}

module.exports = new VoiceController();


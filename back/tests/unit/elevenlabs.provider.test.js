const ElevenLabsProvider = require('../../src/services/ai/providers/elevenlabs.provider');
const axios = require('axios');
const fs = require('fs');
const path = require('path');

jest.mock('axios');
jest.mock('fs');
jest.mock('form-data');

describe('ElevenLabsProvider', () => {
    let provider;
    const mockApiKey = 'test-api-key';

    beforeEach(() => {
        process.env.ELEVENLABS_API_KEY = mockApiKey;
        provider = new ElevenLabsProvider();
        jest.clearAllMocks();
    });

    describe('addVoice', () => {
        const mockName = 'Test Voice';
        const mockSamplePaths = ['/path/to/sample1.mp3', '/path/to/sample2.wav'];

        it('should successfully clone a voice', async () => {
            // Mock fs.existsSync to return true
            fs.existsSync.mockReturnValue(true);
            // Mock fs.createReadStream
            fs.createReadStream.mockReturnValue('mock-stream');

            // Mock axios response
            const mockVoiceId = 'generated-voice-id';
            axios.post.mockResolvedValue({
                data: { voice_id: mockVoiceId }
            });

            // Mock FormData
            const mockFormData = {
                append: jest.fn(),
                getHeaders: jest.fn().mockReturnValue({ 'content-type': 'multipart/form-data' })
            };
            require('form-data').mockImplementation(() => mockFormData);

            const result = await provider.addVoice(mockName, mockSamplePaths);

            expect(result).toBe(mockVoiceId);
            expect(fs.existsSync).toHaveBeenCalledTimes(2);
            expect(mockFormData.append).toHaveBeenCalledWith('name', mockName);
            expect(mockFormData.append).toHaveBeenCalledWith('files', 'mock-stream');
            expect(axios.post).toHaveBeenCalledWith(
                expect.stringContaining('/voices/add'),
                mockFormData,
                expect.objectContaining({
                    headers: expect.objectContaining({
                        'xi-api-key': mockApiKey
                    })
                })
            );
        });

        it('should throw ValidationError if no samples provided', async () => {
            await expect(provider.addVoice(mockName, [])).rejects.toThrow('At least one audio sample is required');
        });

        it('should throw ValidationError if file does not exist', async () => {
            fs.existsSync.mockReturnValue(false);
            await expect(provider.addVoice(mockName, ['/invalid/path.mp3'])).rejects.toThrow('Audio sample not found');
        });

        it('should throw ValidationError if invalid file extension', async () => {
            fs.existsSync.mockReturnValue(true);
            await expect(provider.addVoice(mockName, ['/path/to/text.txt'])).rejects.toThrow('Invalid audio format');
        });
    });
});


const http = require('http');
const { Server } = require('socket.io');
const Client = require('socket.io-client');
const jwt = require('jsonwebtoken');
const app = require('../../src/app');
const { sequelize } = require('../../src/models');
const { initSocketIO } = require('../../src/config/socket');
const setupSocketHandlers = require('../../src/socket');

// Mock Redis
jest.mock('../../src/config/redis', () => {
    const mRedisClient = {
        connect: jest.fn(),
        duplicate: jest.fn().mockReturnThis(),
        sAdd: jest.fn(),
        sRem: jest.fn(),
        sCard: jest.fn().mockResolvedValue(0),
        sMembers: jest.fn().mockResolvedValue([]),
        sIsMember: jest.fn().mockResolvedValue(false),
        del: jest.fn(),
        json: { set: jest.fn() },
        ft: {
            search: jest.fn(),
            info: jest.fn(),
            create: jest.fn()
        },
        on: jest.fn(),
    };
    return {
        getRedisClient: jest.fn(() => Promise.resolve(mRedisClient)),
        initVectorIndex: jest.fn()
    };
});

describe('Socket.IO Integration', () => {
    let httpServer;
    let io;
    let clientSocket;
    let token;
    let userId;

    beforeAll(async () => {
        await sequelize.sync({ alter: true });
        const { User, Role, Post, Comment, Like } = require('../../src/models');

        // Clean up
        await Like.destroy({ where: {}, truncate: false, force: true });
        await Comment.destroy({ where: {}, truncate: false, force: true });
        await Post.destroy({ where: {}, truncate: false, force: true });
        await User.destroy({ where: {}, truncate: false, force: true });
        await Role.destroy({ where: {}, truncate: false, force: true });

        const [role] = await Role.findOrCreate({
            where: { name: 'user' },
            defaults: { description: 'Standard user' }
        });

        const [user] = await User.findOrCreate({
            where: { username: 'socketuser' },
            defaults: {
                email: 'socket@example.com',
                passwordHash: 'hashedpassword',
                roleId: role.id
            }
        });
        userId = user.id;

        token = jwt.sign({ id: userId, username: 'socketuser' }, process.env.JWT_SECRET || 'default_secret_do_not_use_in_prod');

        // Setup HTTP server and Socket.IO
        httpServer = http.createServer(app);
        io = await initSocketIO(httpServer);
        setupSocketHandlers(io);

        await new Promise((resolve) => {
            httpServer.listen(0, () => resolve());
        });
    }, 30000);

    afterAll(async () => {
        if (clientSocket) clientSocket.close();
        if (io) io.close();
        if (httpServer) httpServer.close();
        await sequelize.close();
    });

    beforeEach(() => {
        jest.clearAllMocks();
    });

    it('should connect with valid JWT token', (done) => {
        const port = httpServer.address().port;
        clientSocket = Client(`http://localhost:${port}`, {
            auth: { token }
        });

        clientSocket.on('connect', () => {
            expect(clientSocket.connected).toBe(true);
            clientSocket.close();
            done();
        });

        clientSocket.on('connect_error', (error) => {
            done(error);
        });
    });

    it('should reject connection without token', (done) => {
        const port = httpServer.address().port;
        const badClient = Client(`http://localhost:${port}`);

        badClient.on('connect', () => {
            badClient.close();
            done(new Error('Should not connect without token'));
        });

        badClient.on('connect_error', (error) => {
            expect(error.message).toContain('Authentication error');
            badClient.close();
            done();
        });
    });

    it('should join and leave feed room', (done) => {
        const port = httpServer.address().port;
        clientSocket = Client(`http://localhost:${port}`, {
            auth: { token }
        });

        clientSocket.on('connect', () => {
            clientSocket.emit('join:feed');

            setTimeout(() => {
                clientSocket.emit('leave:feed');
                clientSocket.close();
                done();
            }, 100);
        });
    });
});


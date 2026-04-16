const GraphService = require('../../src/services/graph.service');
const { buildGraphFromDB } = require('../../src/services/graph.builder');
const { runGraphCalculation } = require('../../src/services/graph.worker.service');
const { getRedisClient } = require('../../src/config/redis');
const { User } = require('../../src/models');
const logger = require('../../src/utils/logger');
const { pageRank } = require('../../src/utils/graph/pageRank');

// Mock Dependencies
jest.mock('../../src/services/graph.builder');
jest.mock('../../src/services/graph.worker.service');
jest.mock('../../src/config/redis');
jest.mock('../../src/models');
jest.mock('../../src/utils/logger');
jest.mock('../../src/utils/graph/pageRank', () => ({
    pageRank: jest.fn()
}));

describe('GraphService', () => {
    let mRedisClient;

    beforeEach(() => {
        jest.clearAllMocks();
        mRedisClient = {
            get: jest.fn(),
            setEx: jest.fn()
        };
        getRedisClient.mockResolvedValue(mRedisClient);
    });

    describe('getNetworkGraph', () => {
        it('should return cached graph if available', async () => {
            const cachedGraph = { nodes: [], edges: [] };
            mRedisClient.get.mockResolvedValue(JSON.stringify(cachedGraph));

            const result = await GraphService.getNetworkGraph();

            expect(result).toEqual(cachedGraph);
            expect(buildGraphFromDB).not.toHaveBeenCalled();
        });

        it('should generate graph if cache miss', async () => {
            mRedisClient.get.mockResolvedValue(null);

            // Mock Build
            const mockNodes = [{ id: 1, username: 'u1' }];
            const mockEdges = [];
            buildGraphFromDB.mockResolvedValue({ nodes: mockNodes, edges: mockEdges });

            // Mock Worker
            runGraphCalculation.mockResolvedValue({
                pageRankScores: { 1: 0.5 },
                communities: { 1: 0 },
                centrality: { degree: { 1: 1 } },
                stats: {}
            });

            const result = await GraphService.getNetworkGraph();

            expect(result.nodes).toHaveLength(1);
            expect(result.nodes[0].metadata.influence).toBe(0.5);
            expect(mRedisClient.setEx).toHaveBeenCalled();
        });

        it('should handle errors', async () => {
            mRedisClient.get.mockRejectedValue(new Error('Redis Error'));
            // Should catch Redis error and proceed to generate
            buildGraphFromDB.mockRejectedValue(new Error('DB Error'));

            await expect(GraphService.getNetworkGraph())
                .rejects.toThrow('DB Error');
        });
    });

    describe('getInfluentialUsers', () => {
        it('should return ranked users', async () => {
            // Mock getNetworkGraph internal call
            // Since getNetworkGraph is in the same module, we can't easily mock it if it's called directly.
            // But we can mock the dependencies it uses.

            mRedisClient.get.mockResolvedValue(null);
            buildGraphFromDB.mockResolvedValue({ nodes: [{ id: 'u1' }, { id: 'u2' }], edges: [] });
            runGraphCalculation.mockResolvedValue({
                pageRankScores: { 'u1': 0.8, 'u2': 0.2 },
                communities: {},
                centrality: { degree: {} },
                stats: {}
            });

            User.findAll.mockResolvedValue([
                { id: 'u1', username: 'User 1' },
                { id: 'u2', username: 'User 2' }
            ]);

            pageRank.mockReturnValue({ 'u1': 0.8, 'u2': 0.2 });

            const influential = await GraphService.getInfluentialUsers(2);

            expect(influential).toHaveLength(2);
            expect(influential[0].userId).toBe('u1');
            expect(influential[0].influenceScore).toBe(0.8);
        });
    });
});


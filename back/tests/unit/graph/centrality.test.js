const { centralityMetrics } = require('../../../src/utils/graph/centrality');

describe('Centrality Metrics', () => {
    it('should calculate metrics for a simple line graph A->B->C', () => {
        const nodes = [{ id: 'A' }, { id: 'B' }, { id: 'C' }];
        const edges = [
            { source: 'A', target: 'B' },
            { source: 'B', target: 'C' }
        ];
        const graph = { nodes, edges };

        const metrics = centralityMetrics(graph);

        // Degree
        // A: 1, B: 2, C: 1. Max=2.
        expect(metrics.degree['A']).toBe(0.5);
        expect(metrics.degree['B']).toBe(1);
        expect(metrics.degree['C']).toBe(0.5);

        // Betweenness
        // Only B is on a shortest path (A->C).
        // Unnormalized: B=1. Normalized (N=3): 1/2 = 0.5
        expect(metrics.betweenness['A']).toBe(0);
        expect(metrics.betweenness['B']).toBe(0.5);
        expect(metrics.betweenness['C']).toBe(0);

        // Closeness
        // A -> B(1), C(2). Sum=3. Reachable=2. C(A) = 2/3 * 1 = 0.666...
        expect(metrics.closeness['A']).toBeCloseTo(2 / 3);
        // B -> C(1). Sum=1. Reachable=1. C(B) = 1/1 * 0.5 = 0.5
        expect(metrics.closeness['B']).toBe(0.5);
        // C -> 0.
        expect(metrics.closeness['C']).toBe(0);
    });

    it('should handle disconnected graph', () => {
        const nodes = [{ id: 'A' }, { id: 'B' }];
        const edges = [];
        const graph = { nodes, edges };

        const metrics = centralityMetrics(graph);

        expect(metrics.betweenness['A']).toBe(0);
        expect(metrics.betweenness['B']).toBe(0);
        expect(metrics.closeness['A']).toBe(0);
        expect(metrics.closeness['B']).toBe(0);
    });

    it('should handle star graph (center A, leaves B,C,D)', () => {
        // A -> B, A -> C, A -> D (Directed out-star)
        // Betweenness of A should be 0 because it's a source, not a bridge?
        // Wait, if edges are A->B, A->C... paths are A->B, A->C. No path goes THROUGH A.
        // So A's betweenness is 0.
        // If edges were B->A, C->A, D->A (In-star), same.
        // If edges were B->A, A->C (Line B->A->C), then A is bridge.

        // Let's try B->A->C
        const nodes = [{ id: 'A' }, { id: 'B' }, { id: 'C' }];
        const edges = [
            { source: 'B', target: 'A' },
            { source: 'A', target: 'C' }
        ];
        const graph = { nodes, edges };

        const metrics = centralityMetrics(graph);

        // A is between B and C.
        expect(metrics.betweenness['A']).toBe(0.5);
        expect(metrics.betweenness['B']).toBe(0);
        expect(metrics.betweenness['C']).toBe(0);
    });
});


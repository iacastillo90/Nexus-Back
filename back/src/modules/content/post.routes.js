const express = require('express');
const postController = require('./post.controller');
const { authenticate } = require('../../middleware/auth');

/**
 * @fileoverview Rutas para la gestión de posts.
 * @module routes/postRoutes
 */

const router = express.Router();

/**
 * @route POST /api/v1/posts
 * @desc Crea un nuevo post.
 * @access Private
 */
// POST /api/v1/posts - Crear un nuevo post
router.post('/', authenticate, postController.createPost);

// GET /api/v1/posts/feed - Alias para el feed (compatibilidad con app móvil)
// IMPORTANTE: Esta ruta debe ir ANTES de /:id para evitar que 'feed' sea interpretado como un ID
const feedController = require('./feed.controller');
router.get('/feed', authenticate, feedController.getFeed);

// GET /api/v1/posts/nearby - Buscar posts cercanos
router.get('/nearby', authenticate, postController.getPostsNearby);

// GET /api/v1/posts/:id - Obtener un post
router.get('/:id', authenticate, postController.getPost);

// DELETE /api/v1/posts/:id - Eliminar un post
router.delete('/:id', authenticate, postController.deletePost);

module.exports = router;


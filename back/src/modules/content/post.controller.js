const postService = require('./post.service');
const logger = require('../../utils/logger');

/**
 * @fileoverview Controlador para las peticiones HTTP de Posts.
 * @module controllers/postController
 */

/**
 * Crea un nuevo post.
 * @param {import('express').Request} req - Objeto de solicitud de Express.
 * @param {import('express').Response} res - Objeto de respuesta de Express.
 * @param {import('express').NextFunction} next - Función middleware 'next' de Express.
 */
async function createPost(req, res, next) {
    try {
        const { content, mediaUrl, location, arMetadata } = req.body;
        // Asumimos que req.user existe gracias al authMiddleware (que debemos asegurar que esté)
        // Si no hay authMiddleware aún, usaremos un ID dummy o fallará.
        const authorId = req.user ? req.user.id : req.body.authorId;

        if (!authorId) {
            return res.status(401).json({ error: 'Unauthorized: User ID required' });
        }

        const post = await postService.createPost(authorId, content, mediaUrl, location, arMetadata);

        res.status(201).json(post);
    } catch (error) {
        next(error);
    }
}

/**
 * Obtiene un post por ID.
 */
async function getPost(req, res, next) {
    try {
        const { id } = req.params;
        const post = await require('../repositories/post.repository').findById(id);

        if (!post) {
            return res.status(404).json({ error: 'Post not found' });
        }

        res.status(200).json(post);
    } catch (error) {
        next(error);
    }
}

/**
 * Elimina un post.
 */
async function deletePost(req, res, next) {
    try {
        const { id } = req.params;
        const userId = req.user.id;
        const isAdmin = req.user.role === 'admin';

        const post = await require('../repositories/post.repository').findById(id);

        if (!post) {
            return res.status(404).json({ error: 'Post not found' });
        }

        if (post.userId !== userId && !isAdmin) {
            return res.status(403).json({ error: 'Unauthorized' });
        }

        // Usamos el repositorio o modelo directamente para eliminar
        // Idealmente debería ser un servicio, pero para MVP:
        const { Post } = require('../../models');
        await Post.destroy({ where: { id } });

        res.status(204).send();
    } catch (error) {
        next(error);
    }
}

/**
 * Busca posts cercanos.
 */
async function getPostsNearby(req, res, next) {
    try {
        const lat = parseFloat(req.query.lat);
        const lng = parseFloat(req.query.lng);
        const radius = parseInt(req.query.radius) || 1000;

        if (isNaN(lat) || isNaN(lng)) {
            return res.status(400).json({ error: 'Latitude and Longitude are required' });
        }

        const posts = await postService.getPostsByLocation(lat, lng, radius);

        res.status(200).json({
            success: true,
            data: posts
        });
    } catch (error) {
        next(error);
    }
}

module.exports = {
    createPost,
    getPost,
    deletePost,
    getPostsNearby
};


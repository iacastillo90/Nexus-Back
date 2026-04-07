// src/repositories/roleRepository.js
const { Role } = require('../models');
const logger = require('../utils/logger');

/**
 * @fileoverview Repositorio para la entidad Role.
 * @module repositories/roleRepository
 */

/**
 * Busca un rol por su nombre.
 *
 * @param {string} name - El nombre del rol (ej. 'user', 'admin').
 * @returns {Promise<Role|null>} El modelo del rol o null si no se encuentra.
 * @throws {Error} Si hay un error en la consulta.
 */
async function findByName(name) {
  logger.debug(`[RoleRepository] Finding role by name: ${name}`);
  try {
    const role = await Role.findOne({ where: { name } });
    return role;
  } catch (error) {
    logger.error(`[RoleRepository] Error finding role by name: ${error.message}`);
    throw error; // Re-lanzamos para que el servicio lo maneje
  }
}

module.exports = {
  findByName,
};

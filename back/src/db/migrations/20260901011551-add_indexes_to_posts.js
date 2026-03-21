'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    // Index for fast feed pagination
    await queryInterface.addIndex('posts', ['created_at', 'id'], {
      name: 'idx_posts_created_at_id'
    });

    // Index for fast user timeline
    await queryInterface.addIndex('posts', ['user_id', 'created_at'], {
      name: 'idx_posts_user_id_created_at'
    });

    // Spatial Index for geolocation (Reality Layers)
    await queryInterface.addIndex('posts', ['geolocation'], {
      name: 'idx_posts_geolocation',
      type: 'SPATIAL'
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.removeIndex('posts', 'idx_posts_created_at_id');
    await queryInterface.removeIndex('posts', 'idx_posts_user_id_created_at');
    await queryInterface.removeIndex('posts', 'idx_posts_geolocation');
  }
};

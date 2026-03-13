module.exports = {
  apps: [{
    name: 'nexus-api',
    script: 'server.js',
    instances: 'max', // Scale to max CPU cores
    exec_mode: 'cluster', // Enables clustering
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }]
};

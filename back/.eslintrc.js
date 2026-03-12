// /nexus-back/.eslintrc.js
module.exports = {
  env: {
    node: true,
    commonjs: true,
    es2021: true,
    jest: true, // Importante para que reconozca globals de Jest
  },
  extends: [
    'eslint:recommended',
    'plugin:node/recommended',
    'prettier', // Añade Prettier al final
  ],
  parserOptions: {
    ecmaVersion: 12,
  },
  rules: {
    'node/no-unpublished-require': 'off', // Lo desactivamos por ahora
    'no-unused-vars': ['warn', { argsIgnorePattern: '^_' }], // Advierte de variables no usadas
  },
};

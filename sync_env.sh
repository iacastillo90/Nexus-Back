#!/bin/bash
# sync_env.sh
# Copies the root .env file to the respective backend and mobile folders

echo "🔄 Sincronizando variables de entorno..."

ROOT_ENV=".env"

if [ ! -f "$ROOT_ENV" ]; then
    echo "❌ No se encontró el archivo $ROOT_ENV en la raíz."
    exit 1
fi

# Copiar a Backend
cp "$ROOT_ENV" "back/.env"
echo "✅ Copiado a back/.env"

# Copiar a App Móvil
cp "$ROOT_ENV" "app_mobile/.env"
echo "✅ Copiado a app_mobile/.env"

echo "✨ ¡Sincronización completada!"

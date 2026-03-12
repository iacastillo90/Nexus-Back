FROM node:20-alpine

# Set working directory
WORKDIR /usr/src/app

# Install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Start application with PM2 in production
RUN npm install -g pm2
CMD ["pm2-runtime", "ecosystem.config.js"]

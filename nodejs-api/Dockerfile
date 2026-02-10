FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY server.js .

# Expose port
EXPOSE 8080

# Set user to non-root
USER node

# Start the application
CMD ["node", "server.js"]
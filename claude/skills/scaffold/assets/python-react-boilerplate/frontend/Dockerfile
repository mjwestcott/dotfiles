FROM node:22-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source
COPY . .

# Default command (overridden in docker-compose)
CMD ["npm", "run", "dev", "--", "--host"]

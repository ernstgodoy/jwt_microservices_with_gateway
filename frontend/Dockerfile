# Use official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Install build dependencies for compiling native modules
RUN apt-get update && apt-get install -y build-essential

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the frontend files
COPY . .

# Expose the frontend port
EXPOSE 5173

# Start Vite dev server
CMD ["npm", "run", "dev", "--", "--host"]

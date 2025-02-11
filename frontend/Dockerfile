# Use an official Node.js runtime as a parent image
FROM node:16-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app with verification for BACKEND_URL
CMD ["sh", "-c", "if [ -z \"$BACKEND_URL\" ]; then echo 'Error: BACKEND_URL is not set'; exit 1; fi; npm start"]

# Use an official Node.js runtime as a parent image for the backend
FROM node:20 AS backend

# Set the working directory for the backend
WORKDIR /app/backend

# Copy the backend package.json and package-lock.json
COPY backend/package*.json ./

# Install backend dependencies
RUN npm install

# Copy the backend source code
COPY backend/ .

# Build the backend
RUN npm run build

# Use an official Node.js runtime as a parent image for the frontend
FROM node:20 AS frontend

# Set the working directory for the frontend
WORKDIR /app/frontend

# Copy the frontend package.json and package-lock.json
COPY frontend/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the frontend source code
COPY frontend/ .

# Build the frontend
RUN npm run build

# Use an official MySQL runtime as a parent image for the database
FROM mysql:5.7 AS database

# Set environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=rootpassword
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

# Expose the MySQL port
EXPOSE 3306

# Copy the backend and frontend build outputs to the final image
FROM node:20 AS final

# Set the working directory for the final image
WORKDIR /app

# Copy the backend build output
COPY --from=backend /app/backend/dist ./backend

# Copy the frontend build output
COPY --from=frontend /app/frontend/build ./frontend

# Install serve to serve the frontend
RUN npm install -g serve

# Expose the application port
EXPOSE 3000

# Start the backend and frontend
CMD ["sh", "-c", "node backend/index.js & serve -s frontend -l 3000"]

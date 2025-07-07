FROM node:20-alpine

# Create an app directory
WORKDIR /app

# Install app dependecies
COPY package*.json ./

# Run npm install
RUN npm install --verbose

# Bundle app source
COPY . .

EXPOSE 8080

CMD ["npm", "start"]

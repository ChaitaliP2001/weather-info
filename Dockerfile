# Use the official Node.js image to build the project
FROM node:16 AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json files into the container
# This step ensures only these files are copied, preventing unnecessary changes.
COPY package.json  ./

COPY . ./

# Install dependencies
RUN npm install
# Copy the rest of the application code

# Build the project for production
RUN npm run build

# Use the official Nginx image to serve the built files
FROM nginx:alpine

# Copy the built files from the previous stage to the Nginx web server directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to access the application
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

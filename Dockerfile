# Builder stage
FROM node:22-alpine as builder
RUN apk --no-cache add --virtual builds-deps build-base

WORKDIR /usr/src/app
COPY package*.json ./

# Install dependencies
RUN npm install --silent
COPY . .

# Build application
RUN npm run build

# Production stage
FROM node:22-alpine

WORKDIR /usr/src/app

# Copy the built application files from the builder stage
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules ./node_modules

EXPOSE 4949

CMD [ "node", "./dist/main" ]

FROM node:alpine as builder
    WORKDIR '/app'
    COPY package.json .
    COPY package-lock.json .
    RUN npm config set unsafe-prm true
    RUN npm install
    COPY . .
    RUN chown -R node:node /app
    USER node
    RUN npm run build

FROM nginx
    COPY --from=builder /app/build /usr/share/nginx/html
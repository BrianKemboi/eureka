# Builder
FROM node:slim as builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
RUN npm install -g typescript
COPY . .
RUN npm run build

# Runner
FROM node:16
WORKDIR /usr/app
COPY --from=builder /usr/src/app/package*.json ./
COPY --from=builder /usr/src/app/dist ./dist
RUN npm install

EXPOSE 5000
CMD [ "node", "dist/index.js" ]

FROM node:20-bookworm-slim AS deps
RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install
FROM node:20-bookworm-slim AS builder
RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*
WORKDIR /app
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build
FROM node:20-bookworm-slim AS runner
RUN apt-get update && apt-get install -y chromium && rm -rf /var/lib/apt/lists/*
WORKDIR /app
ENV NODE_ENV=production PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
EXPOSE 3000
CMD ["npm","start"]

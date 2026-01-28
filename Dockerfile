FROM node:22-bookworm

RUN apt-get update && apt-get install -y socat git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone moltbot repository
RUN git clone --depth 1 https://github.com/moltbot/moltbot.git .

RUN corepack enable
RUN pnpm install --frozen-lockfile

RUN pnpm build
RUN pnpm ui:install
RUN pnpm ui:build

ENV NODE_ENV=production

CMD ["node","dist/index.js"]

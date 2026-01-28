FROM node:22-bookworm

RUN apt-get update && apt-get install -y socat git && rm -rf /var/lib/apt/lists/*

# Optional binaries (uncomment if needed)
# RUN curl -L https://github.com/steipete/gog/releases/latest/download/gog_Linux_x86_64.tar.gz \
#   | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/gog
# RUN curl -L https://github.com/steipete/wacli/releases/latest/download/wacli_Linux_x86_64.tar.gz \
#   | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/wacli

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
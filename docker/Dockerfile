FROM node:18-slim

# pandoc + Chromium（mermaid レンダリングに必要）
RUN apt-get update && apt-get install -y \
    pandoc \
    chromium \
    fonts-noto-cjk \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libasound2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# インストール済み Chromium を puppeteer に使わせる
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# mermaid-filter インストール
RUN npm install -g mermaid-filter

# Root で Chromium を動かすために --no-sandbox が必要
RUN echo '{"args":["--no-sandbox","--disable-setuid-sandbox"]}' > /root/puppeteer-config.json
ENV MERMAID_FILTER_PUPPETEER_CONFIG=/root/puppeteer-config.json

WORKDIR /docs

CMD ["bash"]

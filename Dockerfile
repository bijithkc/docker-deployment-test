# We use Node 16 specifically to avoid the PostCSS export error
FROM node:16-alpine

WORKDIR /usr/src/app

# Copy package files first
COPY package*.json ./

# The --legacy-peer-deps flag helps bypass version conflicts
RUN npm install --legacy-peer-deps

COPY . .

# CI=false ignores warnings that might stop the build
RUN CI=false npm run build

RUN npm install -g serve

EXPOSE 5000

CMD ["serve", "-s", "-l", "5000", "build"]
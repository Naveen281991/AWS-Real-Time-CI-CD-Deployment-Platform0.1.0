FROM public.ecr.aws/docker/library/node:22-alpine

WORKDIR /app

COPY application/package.json application/package-lock.json ./

RUN npm ci --omit=dev

COPY application/src ./src

EXPOSE 3000

CMD ["node", "src/server.js"]
FROM node:lts-alpine3.14

WORKDIR /app

RUN npm install express express-prometheus-middleware prom-client

COPY ./index.js /app

CMD ["node","index.js"]

EXPOSE 9091
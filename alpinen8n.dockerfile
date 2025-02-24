FROM alpine:latest
RUN apk update
RUN apk add openssh
RUN apk add --no-cache nodejs npm

ENV N8N_VERSION="1.79.3"
ENV N8N_VERSION=80

RUN npm install -g n8n@${N8N_VERSION}

WORKDIR /data

CMD ["n8n"]
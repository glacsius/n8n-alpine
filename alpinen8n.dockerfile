FROM alpine:latest
RUN apk update
RUN apk add htop
RUN apk add openssh
RUN apk add --no-cache nodejs npm

# Timezone
RUN apk add tzdata
ENV TZ=America/Sao_Paulo
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" > /etc/timezone

# copia o arquivo de backup
COPY export_backup.sh /home/export_backup.sh
RUN chmod +x /home/export_backup.sh

ENV N8N_VERSION="1.79.3"
ENV N8N_PORT=80

RUN npm install -g n8n@${N8N_VERSION}

WORKDIR /data

CMD ["n8n"]
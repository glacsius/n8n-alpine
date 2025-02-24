FROM alpine:latest
RUN apk update
RUN apk add htop
RUN apk add openssh
RUN apk add --no-cache nodejs npm

# Timezone
RUN apk add --no-cache tzdata && \
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" > /etc/timezone
ENV TZ=America/Sao_Paulo

# Copia o arquivo de backup
COPY export_backup.sh /home/export_backup.sh
RUN chmod +x /home/export_backup.sh

# Edita o arquivo /etc/ssh/sshd_config
RUN sed -i 's/^HostKeyAlgorithms.*/HostKeyAlgorithms ssh-rsa/' /etc/ssh/sshd_config && \
    sed -i 's/^PubkeyAcceptedKeyTypes.*/PubkeyAcceptedKeyTypes +ssh-rsa/' /etc/ssh/sshd_config

ENV N8N_VERSION="1.79.3"
ENV N8N_PORT=80

RUN npm install -g n8n@${N8N_VERSION}

WORKDIR /data

CMD ["n8n"]
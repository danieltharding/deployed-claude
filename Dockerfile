FROM alpine:latest

RUN apk add --no-cache \
        nodejs npm \
        openssh-server openssh-client \
        tmux bash \
        git curl jq vim \
        github-cli && \
    npm install -g @anthropic-ai/claude-code && \
    ssh-keygen -A && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

VOLUME /root

WORKDIR /root

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

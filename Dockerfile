FROM alpine:latest

RUN apk add --no-cache nodejs npm && \
    npm install -g @anthropic-ai/claude-code

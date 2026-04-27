#!/bin/sh
set -e

if [ -z "$AUTHORIZED_KEY" ]; then
    echo "ERROR: AUTHORIZED_KEY env var is required" >&2
    exit 1
fi

echo "$AUTHORIZED_KEY" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

exec /usr/sbin/sshd -D -e

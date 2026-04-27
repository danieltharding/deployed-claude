#!/bin/sh
set -e

if [ -z "$AUTHORIZED_KEY" ]; then
    echo "ERROR: AUTHORIZED_KEY env var is required" >&2
    exit 1
fi

# Ensure .ssh dir exists on the persistent volume
mkdir -p /root/.ssh
chmod 700 /root/.ssh
echo "$AUTHORIZED_KEY" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

/usr/sbin/sshd -e

# Start Claude in a persistent tmux session so it survives SSH disconnects
tmux new-session -d -s claude claude

# Keep container alive
tail -f /dev/null

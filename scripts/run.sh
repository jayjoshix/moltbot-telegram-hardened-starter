#!/usr/bin/env bash
set -euo pipefail

# Moltbot Telegram Hardened Starter - Run Script
# Starts the Moltbot gateway.

# Ensure moltbot is installed
# Force IPv4 preference (fixes 'fetch failed' on networks with partial IPv6)
export NODE_OPTIONS="--dns-result-order=ipv4first"

if command -v moltbot >/dev/null; then
    MOLTBOT_BIN="moltbot"
elif command -v clawdbot >/dev/null; then
    MOLTBOT_BIN="clawdbot"
else
    echo "Error: moltbot (or clawdbot) CLI not found."
    echo "Please install it via: curl -fsSL https://molt.bot/install.sh | bash"
    exit 1
fi

echo "Starting Moltbot Gateway (using $MOLTBOT_BIN)..."
# Using canonical 'moltbot gateway' command
# This respects CLAWDBOT_STATE_DIR and CLAWDBOT_CONFIG_PATH automatically from env.
exec $MOLTBOT_BIN gateway "$@"

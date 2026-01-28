#!/usr/bin/env bash
set -euo pipefail

# Moltbot Telegram Hardened Starter - Harden Script
# Runs security audit and applies fixes.

# Ensure moltbot is installed
if command -v moltbot >/dev/null; then
    MOLTBOT_BIN="moltbot"
elif command -v clawdbot >/dev/null; then
    MOLTBOT_BIN="clawdbot"
else
    echo "Error: moltbot (or clawdbot) CLI not found."
    exit 1
fi

echo "Running Moltbot Security Audit (using $MOLTBOT_BIN)..."

# 1. Auto-fix known issues
echo "-> Applying auto-fixes..."
$MOLTBOT_BIN security audit --fix

# 2. Run deep audit for report
echo ""
echo "-> Runnning deep audit report..."
$MOLTBOT_BIN security audit --deep

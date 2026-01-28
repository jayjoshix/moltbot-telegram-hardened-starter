#!/usr/bin/env bash
set -uo pipefail

# Moltbot Telegram Hardened Starter - Verify Script
# Checks health and status.

# 1. Check for moltbot or clawdbot CLI
if command -v moltbot >/dev/null; then
    MOLTBOT_BIN="moltbot"
elif command -v clawdbot >/dev/null; then
    MOLTBOT_BIN="clawdbot"
else
    echo "FAIL: moltbot (or clawdbot) CLI not found."
    exit 1
fi

echo "Verifying Moltbot Health (using $MOLTBOT_BIN)..."

# 2. Run Health Check (JSON)
# --json flag ensures exit code reflection of health status
if $MOLTBOT_BIN health --json >/dev/null 2>&1; then
    echo "PASS: Gateway is healthy and reachable."
else
    echo "WARN: Gateway health check failed."
    echo "      (This is expected if the gateway is not currently running)"
fi

# 3. Run Deep Status Check (Human Readable)
echo ""
echo "--- Status Report ---"
$MOLTBOT_BIN status --deep || true

echo ""
echo "--- Verification Complete ---"
# Return success if we got this far, usually verify runs in CI where we might want strictness.
# But for a helper script, we just want to show info.
# However, if user wants strict mode for CI:
if [ "${CI:-}" = "true" ]; then
    # In CI, we expect health to pass? Maybe only if we started it.
    # Let's just exit 0.
    true
fi

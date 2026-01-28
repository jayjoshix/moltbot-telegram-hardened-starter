#!/usr/bin/env bash
set -euo pipefail

# Moltbot Telegram Hardened Starter - Bootstrap Script
#
# Sets up valid Moltbot configuration in ~/.clawdbot (or CLAWDBOT_STATE_DIR).
# Respects CLAWDBOT_CONFIG_PATH if set.

# 1. Determine State Directory
STATE_DIR="${CLAWDBOT_STATE_DIR:-$HOME/.clawdbot}"
CONFIG_SRC="configs/moltbot.telegram.hardened.json5"

# Determine where the config should go
# If CLAWDBOT_CONFIG_PATH is set, use that. Otherwise use default in STATE_DIR.
CONFIG_DEST="${CLAWDBOT_CONFIG_PATH:-$STATE_DIR/moltbot.json}"

echo "bootstrapping moltbot..."
echo "  state dir:  $STATE_DIR"
echo "  config:     $CONFIG_DEST"

# 2. Ensure State Directory Exists
if [ ! -d "$STATE_DIR" ]; then
    echo "  -> creating state directory..."
    mkdir -p "$STATE_DIR"
fi

# 3. Install Config (if missing)
if [ -f "$CONFIG_DEST" ]; then
    echo "  -> config already exists at $CONFIG_DEST. skipping copy."
else
    echo "  -> installing hardened config..."
    # Ensure parent dir of config exists (in case CLAWDBOT_CONFIG_PATH is weird)
    mkdir -p "$(dirname "$CONFIG_DEST")"
    cp "$CONFIG_SRC" "$CONFIG_DEST"
    echo "     installed."
fi

# 4. Install .env (if missing)
ENV_DEST="$STATE_DIR/.env"
if [ -f "$ENV_DEST" ]; then
    echo "  -> .env already exists at $ENV_DEST. skipping copy."
else
    if [ -f ".env.example" ]; then
        echo "  -> creating .env from example..."
        cp ".env.example" "$ENV_DEST"
        echo "     created."
    else
        echo "  ! warning: .env.example not found in current dir."
    fi
fi

# 5. Check if we need to run wizard
# We assume if config exists, we are "set up".
# But if verify.sh would fail immediately, maybe we should prompt?
# For now, per plan: run setup --wizard ONLY if no state existed (simplification: if we just installed config).
# Actually, better heuristic: if we just created the config, suggest editing it.

echo ""
echo "Setup complete!"
echo "Next steps:"
echo "  1. Edit $ENV_DEST and set your TELEGRAM_BOT_TOKEN"
echo "  2. Run ./scripts/run.sh"
echo "  3. Validating installation..."

# Run a quick check (not wizard, because that's interactive and might be annoying in scripts)
# If user wants wizard, they can run `moltbot setup --wizard` manually.
if command -v moltbot >/dev/null; then
    echo "  -> moltbot CLI found."
elif command -v clawdbot >/dev/null; then
    echo "  -> clawdbot CLI found."
else
    echo "  -> moltbot CLI not found. Please install it first."
fi

# Moltbot Telegram Hardened Starter

A secure-by-default starter template for running [Moltbot](https://molt.bot) on Telegram. This repository provides a hardened configuration to ensure your bot is safe for personal use while remaining extensible for power users.

## 🔒 Secure by Default
We prioritize security over convenience. Out of the box, this configuration enforces:

- **Strict Pairing Required**: The bot ignores all messages until you explicitly approve a user via a pairing code.
- **Groups Disabled**: The bot will not join or respond in group chats by default.
- **Browser Automation Disabled**: The browser tool is turned off to reduce the attack surface.
- **Localhost Binding**: The gateway binds only to `127.0.0.1`.
- **Read-Only Config**: The bot cannot modify its own configuration via chat commands.

## 🚀 Quick Start (5 Minutes)

### 1. Prerequisites
- **Telegram Bot Token**: Create a new bot with [@BotFather](https://t.me/BotFather) and get your token.
- **Moltbot CLI (or Clawdbot)**: [Install Moltbot](https://docs.molt.bot/install). The scripts automatically detect if you are running `moltbot` or `clawdbot`.

### 2. Setup
Clone this repo and enter the directory:
```bash
git clone https://github.com/yourusername/moltbot-telegram-hardened-starter.git
cd moltbot-telegram-hardened-starter
```

Run the bootstrap script:
```bash
./scripts/bootstrap.sh
```
This creates `~/.clawdbot/clawdbot.json` (or `moltbot.json`) and `~/.clawdbot/.env`.

### 3. Configure
Edit `~/.clawdbot/.env` and add your tokens:
```bash
TELEGRAM_BOT_TOKEN="your-bot-token-here"
MOLTBOT_GATEWAY_TOKEN="generate-a-secure-random-token"
```

### 4. Run
Start the gateway using the provided script (recommended):
```bash
./scripts/run.sh
```
*Note: This script includes automatic fixes for common network issues.*

### 5. Pair with your Bot
1. Open a DM with your bot in Telegram.
2. Send any message (e.g., "hello").
3. In your terminal, check for proper pairing:
   ```bash
   # If installed as clawdbot
   clawdbot pairing list telegram
   ```
4. You will see a pending request with a CODE. Approve it:
   ```bash
   clawdbot pairing approve telegram <CODE>
   ```

## ❓ Troubleshooting

### Telegram "Fetch Failed"
If logs show `fetch failed` errors, your network likely has partial IPv6 support.
**Fix:** Always run the bot using `./scripts/run.sh`, which forces IPv4 preference (`--dns-result-order=ipv4first`).

### "Gateway already running"
If you see this error, you likely have a background instance or zombie process.
**Fix:**
```bash
clawdbot gateway stop
./scripts/run.sh
```

## 🛠️ Power User Configuration

### Environment Overrides
You can customize the storage location using environment variables:
- `CLAWDBOT_STATE_DIR`: Defaults to `~/.clawdbot`.
- `CLAWDBOT_CONFIG_PATH`: Defaults to `$CLAWDBOT_STATE_DIR/moltbot.json`.

### Enabling Groups or Tools (⚠️ Risk Warning)
To enable groups or the browser tool, edit your config at `~/.clawdbot/moltbot.json`.

> [!WARNING]
> COMPOSITE RISK: Enabling tools (like Browser) AND widening access (like Groups or Open DMs) significantly increases your risk profile. We strongly recommend keeping sensitive tools disabled if you enable group access.

## 📦 Scripts
- `scripts/bootstrap.sh`: Sets up the environment and config.
- `scripts/run.sh`: Starts the Moltbot gateway.
- `scripts/verify.sh`: Checks health and status (`moltbot health --json`).
- `scripts/harden.sh`: Runs security audit and applies fixes (`moltbot security audit --fix`).

## 🛡️ Security
See [SECURITY.md](SECURITY.md) for our security policy and reporting guidelines.

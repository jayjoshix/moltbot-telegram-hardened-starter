# Security Policy

## Secure by Default
This starter template is designed to be "secure by default". This means:
1.  **Pairing Required**: You must strictly pair with the bot to chat. Random DMs are ignored.
2.  **Groups Disabled**: The bot will not respond in groups unless explicitly enabled.
3.  **Browser Disabled**: Browser automation tools are disabled to minimize attack surface.
4.  **Localhost Binding**: The gateway binds to `127.0.0.1`. Do not expose this port publicly.

## Secrets Management
- **Never commit `.env` files.**
- Rotate your `TELEGRAM_BOT_TOKEN` and `MOLTBOT_GATEWAY_TOKEN` regularly.
- Ensure your `~/.clawdbot` directory (or wherever config is stored) is readable only by your user (`chmod 700`).

## Reporting Vulnerabilities
If you find a vulnerability in Moltbot itself, please refer to the official [Moltbot Security Policy](https://molt.bot/security).
If you find a flaw in this template's configuration, please open an issue in this repository.

## Auditing
Run `./scripts/harden.sh` to perform a security audit of your current configuration.

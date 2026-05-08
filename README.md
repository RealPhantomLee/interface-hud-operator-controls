# Interface, HUD & Operator Controls

**A bash-driven operator HUD for a portable cyberdeck — tmux dashboard, structured KEY=VALUE status feeds, and one-line controls for network mode, logging, and capture.**

This is **Brick #3** of a portable Kali Live USB security platform. See [Related projects](#related-projects).

---

## What it does

When you're operating a Pi-based cyberdeck in the field, you need a glanceable operator interface — what's the host doing, which interface is up, what mode is the radio in, is logging on, is a capture running? This brick gives you that, with no GUI dependencies and no surprises.

It's three things:

1. **Status producers** — small bash scripts that emit `KEY=VALUE` blocks (host, CPU%, memory%, temperature, uptime, interface state, IPv4, channel, active tool count).
2. **A tmux dashboard** — splits a terminal into four live panes that re-run those producers on a watch interval.
3. **Operator controls** — one-line commands to toggle network mode (managed / monitor / lab), logging, and capture.

---

## Quick start

```bash
# Run the CLI dashboard (refreshes every 2s)
./interface/dashboards/cli_dashboard.sh

# Or load the tmux layout (4 panes: render, tools, net, status)
tmux new-session -d -s HUD
tmux source-file ./interface/dashboards/tmux_dashboard.conf
tmux attach -t HUD

# Operator controls
./interface/controls/set_iface.sh wlan0
./interface/controls/net_mode.sh monitor    # or managed / lab
./interface/controls/log_toggle.sh on
./interface/controls/capture_toggle.sh on
```

---

## Sample status output

`hud_status.sh` and friends emit machine-readable `KEY=VALUE` blocks that the renderer composes into a HUD:

```
HOST=cyberdeck01
MODE=monitor
LOGGING=on
CAPTURE=off
CPU_PCT=14
MEM_PCT=38
TEMP_C=51
UPTIME_MIN=42
IFACE=wlan0
STATE=up
IPV4=10.0.0.42/24
CHANNEL=6
TOOLS_ACTIVE=2
```

Anything that consumes the HUD (renderer, log shipper, OLED display) just parses these blocks — no JSON, no dependencies, no surprises.

---

## Repository layout

| Path | Purpose |
|------|---------|
| `interface/hud/` | Status producers: `hud_status.sh`, `hud_net.sh`, `hud_tools.sh`, `hud_render.sh`, shared `hud_common.sh` |
| `interface/dashboards/` | `cli_dashboard.sh` (single-pane watch loop) and `tmux_dashboard.conf` (4-pane tmux layout) |
| `interface/controls/` | Operator toggles: `set_iface.sh`, `net_mode.sh`, `log_toggle.sh`, `capture_toggle.sh` |
| `interface/systemd/` | Optional systemd units to start the HUD on boot |
| `interface/oled/` | Optional 128×64 OLED display driver layer |
| `docs/` | Workflow notes |
| `assets/` | Diagrams and reference images |
| `logs/` | Runtime logs (when logging is on) |

---

## Design choices

- **Bash-only.** No Python runtime, no Node, no compiled deps — runs anywhere the cyberdeck does.
- **`set -euo pipefail` everywhere.** Failures fail loudly.
- **`KEY=VALUE` over JSON.** Trivially parseable with `awk`, no jq needed.
- **State files in a single state dir.** Mode and toggle state survive a reboot via the persistent partition from [Brick #1](https://github.com/RealPhantomLee/live-usb-encrypted-persistence).
- **`sudo`-aware.** Controls that need root (interface mode changes) detect EUID and degrade gracefully — they save state without applying it if not root.

---

## Brick Stack relationship

- **Depends on** Brick #1 (encrypted persistence) and Brick #2 (cyberdeck hardware).
- **Surfaces** runtime state from Brick #4 (toolchain) and Brick #5 (SIEM agents).

---

## Related projects

- [live-usb-encrypted-persistence](https://github.com/RealPhantomLee/live-usb-encrypted-persistence) — Brick #1
- [cyberdeck-platform](https://github.com/RealPhantomLee/cyberdeck-platform) — Brick #2
- **interface-hud-operator-controls** (this repo) — Brick #3
- [toolchain-layer](https://github.com/RealPhantomLee/toolchain-layer) — Brick #4
- [logging-siem-wazuh](https://github.com/RealPhantomLee/logging-siem-wazuh) — Brick #5
- [vulnerability-management-lab](https://github.com/RealPhantomLee/vulnerability-management-lab) — Brick #6

---

## Author

**Charles Tucker** — [github.com/RealPhantomLee](https://github.com/RealPhantomLee)

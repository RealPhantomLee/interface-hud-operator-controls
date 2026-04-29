#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v tmux >/dev/null 2>&1; then
  echo "tmux not installed. Install tmux or run: scripts/run_cli_dashboard.sh"
  exit 1
fi

chmod +x interface/hud/*.sh interface/controls/*.sh 2>/dev/null || true

# If HUD exists, attach. If not, create it.
if tmux has-session -t HUD 2>/dev/null; then
  tmux attach -t HUD
  exit 0
fi

tmux start-server
tmux new-session -d -s HUD -c "$(pwd)"
tmux source-file interface/dashboards/tmux_dashboard.conf
tmux attach -t HUD

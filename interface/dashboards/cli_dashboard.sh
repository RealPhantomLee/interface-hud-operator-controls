#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
HUD="${ROOT}/interface/hud/hud_render.sh"

while true; do
  clear
  "${HUD}"
  echo ""
  echo "Controls:"
  echo "  ./interface/controls/set_iface.sh <iface>"
  echo "  ./interface/controls/net_mode.sh managed|monitor|lab"
  echo "  ./interface/controls/log_toggle.sh on|off"
  echo "  ./interface/controls/capture_toggle.sh on|off"
  echo ""
  echo "Tip: run 'ip link' to see interface names."
  sleep 2
done

#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/../hud/hud_common.sh"

VAL="${1:-}"
if [[ "${VAL}" != "on" && "${VAL}" != "off" ]]; then
  echo "Usage: $0 {on|off}"
  exit 1
fi

set_logging "${VAL}"
echo "LOGGING=${VAL}"

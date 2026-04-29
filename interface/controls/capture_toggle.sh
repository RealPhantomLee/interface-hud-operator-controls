#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/../hud/hud_common.sh"

VAL="${1:-}"
CAPTURE_FLAG="${STATE_DIR}/capture_on"

if [[ "${VAL}" != "on" && "${VAL}" != "off" ]]; then
  echo "Usage: $0 {on|off}"
  exit 1
fi

if [[ "${VAL}" == "on" ]]; then
  : > "${CAPTURE_FLAG}"
else
  rm -f "${CAPTURE_FLAG}"
fi

echo "CAPTURE=${VAL}"

#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/../hud/hud_common.sh"

IFACE="${1:-}"
if [[ -z "${IFACE}" ]]; then
  echo "Usage: $0 <iface>   (example: $0 wlan1)"
  exit 1
fi

set_iface "${IFACE}"
echo "IFACE=${IFACE}"

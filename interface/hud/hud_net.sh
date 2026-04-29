#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/hud_common.sh"

IFACE="$(read_iface)"

STATE="down"
IP="none"
CHANNEL=""

if has_cmd ip; then
  if ip link show "${IFACE}" >/dev/null 2>&1; then
    if ip link show "${IFACE}" | grep -q "state UP"; then
      STATE="up"
    else
      STATE="down"
    fi

    IP="$(ip -4 addr show "${IFACE}" | awk '/inet / {print $2}' | head -n1 || true)"
    [[ -z "${IP}" ]] && IP="none"
  else
    STATE="missing"
  fi
fi

# Best-effort: show frequency from iw (if available)
if has_cmd iw && iw dev "${IFACE}" info >/dev/null 2>&1; then
  FREQ="$(iw dev "${IFACE}" link 2>/dev/null | awk -F'[:, ]+' '/freq/ {print $3}' | head -n1 || true)"
  [[ -n "${FREQ}" ]] && CHANNEL="${FREQ}MHz"
fi

echo "IFACE=${IFACE}"
echo "STATE=${STATE}"
echo "IPV4=${IP}"
echo "CHANNEL=${CHANNEL}"

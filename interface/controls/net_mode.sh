#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/../hud/hud_common.sh"

MODE="${1:-}"
if [[ -z "${MODE}" ]]; then
  echo "Usage: $0 {managed|monitor|lab}"
  exit 1
fi

set_mode "${MODE}"
IFACE="$(read_iface)"

# If not root, only save state (still useful)
if [[ "${EUID}" -ne 0 ]]; then
  echo "MODE=${MODE} (state saved only; run with sudo to apply interface changes)"
  exit 0
fi

case "${MODE}" in
  managed)
    if has_cmd ip; then ip link set "${IFACE}" down || true; fi
    if has_cmd iw; then iw dev "${IFACE}" set type managed 2>/dev/null || true; fi
    if has_cmd ip; then ip link set "${IFACE}" up || true; fi
    ;;
  monitor)
    if has_cmd ip; then ip link set "${IFACE}" down || true; fi
    if has_cmd iw; then iw dev "${IFACE}" set type monitor 2>/dev/null || true; fi
    if has_cmd ip; then ip link set "${IFACE}" up || true; fi
    ;;
  lab)
    # semantic mode; don't force interface type
    ;;
  *)
    echo "Unknown mode: ${MODE}"
    exit 1
    ;;
esac

echo "MODE=${MODE} (applied to ${IFACE})"

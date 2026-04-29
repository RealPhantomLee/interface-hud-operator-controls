#!/bin/bash
set -euo pipefail

source "$(dirname "$0")/hud_common.sh"

MODE="$(read_mode)"
LOGGING="$(read_logging)"
HOST="$(get_hostname)"
CPU="$(get_cpu_pct)"
MEM="$(get_mem_pct)"
TEMP="$(get_temp_c)"
UPMIN="$(get_uptime_min)"

# Simple capture flag file (created by capture_toggle.sh later)
CAPTURE_FLAG="${STATE_DIR}/capture_on"
CAPTURE="off"
[[ -f "${CAPTURE_FLAG}" ]] && CAPTURE="on"

echo "HOST=${HOST}"
echo "MODE=${MODE}"
echo "LOGGING=${LOGGING}"
echo "CAPTURE=${CAPTURE}"
echo "CPU_PCT=${CPU}"
echo "MEM_PCT=${MEM}"
echo "TEMP_C=${TEMP}"
echo "UPTIME_MIN=${UPMIN}"

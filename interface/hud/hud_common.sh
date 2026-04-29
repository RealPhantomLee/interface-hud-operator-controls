#!/bin/bash
set -euo pipefail

# Brick 3-03 HUD Common
# Shared helpers + simple state files (mode/logging/iface)

BRICK_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
STATE_DIR="${BRICK_ROOT}/interface/hud/.state"
mkdir -p "${STATE_DIR}"

MODE_FILE="${STATE_DIR}/mode"
LOG_FILE="${STATE_DIR}/logging"
IFACE_FILE="${STATE_DIR}/iface"

# Defaults
[[ -f "${MODE_FILE}" ]] || echo "managed" > "${MODE_FILE}"
[[ -f "${LOG_FILE}"  ]] || echo "off"     > "${LOG_FILE}"
[[ -f "${IFACE_FILE}" ]] || echo "wlan0"  > "${IFACE_FILE}"

read_mode()    { tr -d "\n" < "${MODE_FILE}" 2>/dev/null || echo "managed"; }
read_logging() { tr -d "\n" < "${LOG_FILE}"  2>/dev/null || echo "off"; }
read_iface()   { tr -d "\n" < "${IFACE_FILE}" 2>/dev/null || echo "wlan0"; }

set_mode()     { echo "$1" > "${MODE_FILE}"; }
set_logging()  { echo "$1" > "${LOG_FILE}"; }
set_iface()    { echo "$1" > "${IFACE_FILE}"; }

has_cmd() { command -v "$1" >/dev/null 2>&1; }

get_hostname() { hostname 2>/dev/null || echo "host"; }

get_uptime_min() {
  awk '{printf "%.0f", $1/60}' /proc/uptime 2>/dev/null || echo ""
}

get_temp_c() {
  if [[ -f /sys/class/thermal/thermal_zone0/temp ]]; then
    awk '{printf "%.0f", $1/1000}' /sys/class/thermal/thermal_zone0/temp
  else
    echo ""
  fi
}

get_cpu_pct() {
  # Lightweight CPU% from /proc/stat (two reads)
  local a b c d idle1 total1 idle2 total2
  read -r _ a b c d _ < /proc/stat
  idle1=$d
  total1=$((a+b+c+d))
  sleep 0.2
  read -r _ a b c d _ < /proc/stat
  idle2=$d
  total2=$((a+b+c+d))
  local idle_delta=$((idle2-idle1))
  local total_delta=$((total2-total1))
  if (( total_delta > 0 )); then
    echo $(( (100*(total_delta-idle_delta)) / total_delta ))
  else
    echo ""
  fi
}

get_mem_pct() {
  # Mem% from /proc/meminfo (MemTotal/MemAvailable)
  local total avail
  total=$(awk '/MemTotal:/ {print $2}' /proc/meminfo 2>/dev/null || echo "")
  avail=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo 2>/dev/null || echo "")
  if [[ -n "${total}" && -n "${avail}" && "${total}" -gt 0 ]]; then
    echo $(( (100*(total-avail)) / total ))
  else
    echo ""
  fi
}

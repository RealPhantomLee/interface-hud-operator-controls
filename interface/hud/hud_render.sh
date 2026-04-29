#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

STATUS="$("${DIR}/hud_status.sh")"
NET="$("${DIR}/hud_net.sh")"
TOOLS="$("${DIR}/hud_tools.sh")"

# helper to fetch VALUE by KEY from a KEY=VALUE block
kv() {
  echo "$1" | awk -F= -v k="$2" '$1==k {print substr($0, index($0,k"=")+length(k)+1)}'
}

HOST="$(kv "${STATUS}" HOST)"
MODE="$(kv "${STATUS}" MODE)"
LOGGING="$(kv "${STATUS}" LOGGING)"
CAPTURE="$(kv "${STATUS}" CAPTURE)"
CPU="$(kv "${STATUS}" CPU_PCT)"
MEM="$(kv "${STATUS}" MEM_PCT)"
TEMP="$(kv "${STATUS}" TEMP_C)"

IFACE="$(kv "${NET}" IFACE)"
STATE="$(kv "${NET}" STATE)"
IPV4="$(kv "${NET}" IPV4)"
CHAN="$(kv "${NET}" CHANNEL)"

ACTIVE="$(kv "${TOOLS}" TOOLS_ACTIVE)"

printf "CYBERDECK HUD\n"
printf "HOST: %s\n" "${HOST:-unknown}"
printf "MODE: %s | LOG: %s | CAP: %s\n" "${MODE:-?}" "${LOGGING:-?}" "${CAPTURE:-?}"
printf "CPU: %s%% | MEM: %s%% | TEMP: %sC\n" "${CPU:-?}" "${MEM:-?}" "${TEMP:-?}"
printf "NET: %s (%s) | IP: %s\n" "${IFACE:-?}" "${STATE:-?}" "${IPV4:-?}"
if [[ -n "${CHAN}" ]]; then
  printf "CHAN: %s\n" "${CHAN}"
fi
printf "TOOLS ACTIVE: %s\n" "${ACTIVE:-0}"

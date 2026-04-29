#!/bin/bash
set -euo pipefail

# Detect tool activity via running processes.
# Add/remove tools as your stack evolves.

TOOLS=(
  airodump-ng
  airmon-ng
  aireplay-ng
  bettercap
  wireshark
  tshark
  tcpdump
  nmap
  mitmproxy
  burpsuite
  openvpn
)

count=0

for t in "${TOOLS[@]}"; do
  if pgrep -x "${t}" >/dev/null 2>&1; then
    echo "${t}=on"
    count=$((count+1))
  else
    echo "${t}=off"
  fi
done

echo "TOOLS_ACTIVE=${count}"

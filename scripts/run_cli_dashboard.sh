#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
chmod +x interface/hud/*.sh interface/controls/*.sh interface/dashboards/cli_dashboard.sh 2>/dev/null || true
./interface/dashboards/cli_dashboard.sh

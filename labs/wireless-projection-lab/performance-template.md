# Performance Measurement Template
Wireless Projection Lab — Brick 3

Use this template to record repeatable Miracast performance tests.
Fill in values for each test run so results can be compared across systems.

---

## Test Metadata

Date:
Tester:
System / Hostname:
OS / Distro:
Kernel Version:

CPU:
RAM:
GPU (optional):

WiFi Adapter:
Driver / Module:
Notes (anything unusual about hardware or drivers):

How to capture:
- uname -a
- lsb_release -a (or cat /etc/os-release)
- lscpu
- free -h
- lspci -k | grep -A 3 -i network
- lsusb (if USB adapter)

---

## Network Configuration

LAN Backhaul:
[ ] WiFi
[ ] Ethernet

SSID:
WiFi Band:
[ ] 2.4 GHz
[ ] 5 GHz

Channel:
BSSID (optional):
IP Address (source):
Signal Strength (RSSI):
Rx/Tx Bitrate:

WiFi Power Save:
[ ] On
[ ] Off

How to capture:
- nmcli device status
- ip addr
- iw dev wlan0 link
- nmcli -f ACTIVE,SSID,BSSID,CHAN,RATE,SIGNAL dev wifi list
- iw dev wlan0 get power_save

---

## Display Configuration

Display Output:
Resolution:
Refresh Rate:

Power Profile:
[ ] Balanced
[ ] Performance
[ ] Power Saver
[ ] Not available

How to capture:
- xrandr
- powerprofilesctl get (if installed)

---

## Miracast Session Details

Target Device:
Target Mode Enabled:
[ ] Yes
[ ] No

Connection Time (seconds):
Disconnects Observed:
[ ] None
[ ] Occasional
[ ] Frequent

How to capture:
- stopwatch or timestamp notes

---

## Measured Performance

Average Latency Estimate (ms):
Latency Measurement Method:
- (example: on-screen timer mirrored to TV, recorded video comparison)

Frame Stability:
[ ] Smooth
[ ] Minor Stutter
[ ] Frequent Drops

Audio Sync:
[ ] In Sync
[ ] Slight Delay
[ ] Noticeable Delay

CPU Usage During Stream (%):
Memory Usage During Stream (optional):

Network Throughput During Stream:
- Average:
- Peak:

How to capture (during mirroring):
- mpstat 1 10
- top
- sudo iftop -i wlan0
- nload wlan0 (optional)

---

## Observed Issues

Describe any of the following:
- Jitter:
- Frame drops:
- Visual artifacts:
- Audio distortion:
- Resolution changes:
- Black screens / reconnect behavior:

---

## Root Cause Analysis (Hypothesis)

Layer Most Likely Impacted:
[ ] Application
[ ] OS / Drivers
[ ] Network
[ ] Physical / RF

Suspected Cause:
Notes:

---

## Optimizations Attempted

List each optimization attempted and whether it improved performance.

Optimization:
Command/Change:
Result:
Notes:

Examples:
- Disable WiFi power save: sudo iw dev wlan0 set power_save off
- Use Ethernet backhaul for LAN traffic
- Switch to 5GHz SSID
- Lower resolution to 720p: xrandr --output <DISPLAY> --mode 1280x720

---

## Final Stability Rating (1–10)

Score:
Justification:

---

## Comparison Log (Optional)

Baseline Configuration:
Optimized Configuration:
Performance Difference:
Conclusion:

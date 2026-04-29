# Wireless Projection Lab
Brick 3 — Interface & Wireless Control Testing

## Objective
Test Linux Miracast projection to Fire TV Stick.
Compare WiFi-only vs Ethernet-backhaul performance.

## Install Dependencies
sudo apt update
sudo apt install -y gnome-network-displays gstreamer1.0-plugins-bad gstreamer1.0-libav pipewire wireplumber

## Prepare WiFi Adapter
sudo ip link set wlan0 down
sudo iw wlan0 set type managed
sudo ip link set wlan0 up
sudo iw dev wlan0 set power_save off

## Set Performance Mode
powerprofilesctl set performance

## Launch Miracast
gnome-network-displays

## Result
WiFi-only produced jitter and frame drops.
Using Ethernet for LAN traffic improved stability significantly.

Conclusion:
Miracast works best when WiFi is dedicated to WiFi Direct.

# Lessons Learned — Wireless Projection Lab
Brick 3 — Interface & Wireless Control Testing

---

## 1. Transport Architecture Matters More Than Software

Miracast instability was not primarily an application issue.
Using WiFi for both LAN traffic and WiFi Direct created RF contention.

Switching the source system to Ethernet significantly improved stability.

Conclusion:
Network topology directly impacts real-time streaming performance.

---

## 2. WiFi Direct Requires Proper Adapter State

Miracast requires:
- Managed mode
- Power saving disabled
- Stable driver support

Monitor mode or power saving introduced instability.

Lesson:
Wireless configuration must align with protocol requirements.

---

## 3. Shared Wireless Airtime Causes Jitter

When one adapter handled:
- Internet connectivity
- Miracast streaming

Observed effects:
- Frame drops
- Stutter
- Latency spikes under CPU load

Lesson:
WiFi is a shared medium with limited airtime.

---

## 4. Encoding Load Impacts Performance

Miracast uses H.264 encoding.
Lowering display resolution improved stability by reducing CPU encoding load.

Lesson:
Real-time streaming performance depends on both:
- Network throughput
- System encoding capacity

---

## 5. Layered Troubleshooting Is Critical

Initial assumption:
Software instability.

Actual root cause:
Transport layer congestion.

Lesson:
Troubleshoot layer-by-layer:
Application → OS → Network → Physical.

---

## Final Takeaway

Optimal configuration:
Ethernet for LAN traffic.
WiFi reserved exclusively for WiFi Direct (P2P).

This lab reinforced:
- Transport isolation principles
- RF awareness
- Performance profiling
- Structured troubleshooting methodology

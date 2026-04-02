# Haptic Pulse

Sends periodic POST requests to a haptic feedback endpoint at a configurable BPM. Drift-corrected timing ensures precise tempo regardless of network latency.

## Web UI

Open `haptic-pulse.html` in a browser. Features:

- BPM slider (30–240)
- Timed sessions: 1h / 2h / 3h with progress bar
- Infinite mode via START/STOP
- Fire-and-forget `fetch()` so requests never block the beat

## PowerShell

```powershell
.\haptic-pulse.ps1              # 82 BPM (default)
.\haptic-pulse.ps1 -BPM 120    # 120 BPM
.\haptic-pulse.ps1 -BPM 60 -Count 10  # stop after 10 pulses
```

Uses `Stopwatch` + `HttpClient` with `DangerousAcceptAnyServerCertificateValidator` for precise, non-blocking requests.

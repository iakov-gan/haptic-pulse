# Haptic Pulse

Sends periodic POST requests to a haptic feedback endpoint at a configurable BPM. Drift-corrected timing ensures precise tempo regardless of network latency.

## Requirements

- [Logitech MX Master 4](https://www.logitech.com/products/mice/mx-master-4.html) mouse
- [Haptic Feedback for the Web](https://haptics.jmw.nz/) browser extension installed

## Web UI

Open `index.html` in a browser or visit the [GitHub Pages site](https://iakov-gan.github.io/haptic-pulse/). Features:

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

## Credits

Powered by [Haptic Feedback for the Web](https://haptics.jmw.nz/) by JMW.

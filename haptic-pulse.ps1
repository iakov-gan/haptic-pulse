<#
.SYNOPSIS
    Sends POST requests to the haptic collision endpoint at a precise BPM.
.EXAMPLE
    .\haptic-pulse.ps1              # 82 BPM (default)
    .\haptic-pulse.ps1 -BPM 120    # 120 BPM
    .\haptic-pulse.ps1 -BPM 60 -Count 10  # 60 BPM, stop after 10 hits
#>
param(
    [int]$BPM = 82,
    [int]$Count = 0  # 0 = infinite
)

$uri = "https://local.jmw.nz:41443/haptic/subtle_collision"
$intervalMs = 60000.0 / $BPM

Write-Host "Pulsing at $BPM BPM (every $([math]::Round($intervalMs,1))ms) → $uri" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop." -ForegroundColor DarkGray

# HttpClient with cert validation fully disabled via built-in .NET validator
Add-Type -AssemblyName System.Net.Http
$handler = [System.Net.Http.HttpClientHandler]::new()
$handler.ServerCertificateCustomValidationCallback =
    [System.Net.Http.HttpClientHandler]::DangerousAcceptAnyServerCertificateValidator
$http = [System.Net.Http.HttpClient]::new($handler)
$http.Timeout = [TimeSpan]::FromSeconds(5)

$sw = [System.Diagnostics.Stopwatch]::StartNew()
$nextTickMs = 0.0
$i = 0

while ($Count -eq 0 -or $i -lt $Count) {
    while ($sw.Elapsed.TotalMilliseconds -lt $nextTickMs) {
        Start-Sleep -Milliseconds 1
    }

    $null = $http.PostAsync($uri, $null)  # fire-and-forget, returns Task

    $i++
    $nextTickMs += $intervalMs
    Write-Host "." -NoNewline
}

$http.Dispose()
Write-Host "`nDone. Sent $i requests."

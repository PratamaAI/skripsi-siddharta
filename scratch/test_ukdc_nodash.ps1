$headers = @{'User-Agent' = 'Mozilla/5.0'}
try {
    $res = Invoke-WebRequest -Uri "https://ejournal.ukdc.ac.id/index.php/bips/article/view/171" -Headers $headers -TimeoutSec 10
    Write-Host "Status: $($res.StatusCode)"
    $matches = [regex]::Matches($res.Content, 'href="([^"]+download[^"]+)"')
    foreach ($m in $matches) {
        Write-Host "Download: $($m.Groups[1].Value)"
    }
} catch {
    Write-Host "Error: $_"
}

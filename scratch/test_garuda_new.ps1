$headers = @{'User-Agent' = 'Mozilla/5.0'}
try {
    $res = Invoke-WebRequest -Uri "https://garuda.kemdiktisaintek.go.id/documents?q=continuance+intention+game" -Headers $headers -TimeoutSec 10
    Write-Host "Garuda Status: $($res.StatusCode)"
    $matches = [regex]::Matches($res.Content, '<a class="title-cite" href="([^"]+)">([^<]+)</a>')
    foreach ($m in $matches) {
        Write-Host "Title: $($m.Groups[2].Value.Trim())"
        Write-Host "  Link: https://garuda.kemdiktisaintek.go.id$($m.Groups[1].Value)"
    }
} catch {
    Write-Host "Error: $_"
}

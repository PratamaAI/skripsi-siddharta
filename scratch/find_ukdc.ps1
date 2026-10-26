$headers = @{'User-Agent' = 'Mozilla/5.0'}
$url = "https://e-journal.ukdc.ac.id/index.php/bips/article/view/171" # let's search or test UKDC
try {
    $res = Invoke-WebRequest -Uri "https://e-journal.ukdc.ac.id/index.php/bips/issue/view/28" -Headers $headers -TimeoutSec 10
    Write-Host "Status: $($res.StatusCode)"
    $matches = [regex]::Matches($res.Content, 'href="([^"]+article/view/[^"]+)"')
    foreach ($m in $matches) {
        Write-Host "Article: $($m.Groups[1].Value)"
    }
} catch {
    Write-Host "Error: $_"
}

$headers = @{'User-Agent' = 'Mozilla/5.0'}
$url = "https://doi.org/10.30738/jm.v16i1.4841"
try {
    $res = Invoke-WebRequest -Uri $url -Headers $headers -MaximumRedirection 5
    Write-Host "Resolved URL: $($res.BaseResponse.ResponseUri)"
    $matches = [regex]::Matches($res.Content, 'href="([^"]+download[^"]+)"')
    foreach ($m in $matches) {
        Write-Host "Download link: $($m.Groups[1].Value)"
    }
} catch {
    Write-Host "Error: $_"
}

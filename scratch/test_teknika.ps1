$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$doi = "10.34148/teknika.v14i1.1163"
$url = "https://api.crossref.org/works/$doi"
try {
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    $res.message | Select-Object title, container-title, published, score, URL | Format-List
    Write-Host "Links:"
    $res.message.link | Format-Table
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

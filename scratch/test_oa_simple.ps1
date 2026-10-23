$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity@gmail.com'}
$url = "https://api.openalex.org/works?search=continuance+intention+play+game&filter=is_oa:true&per-page=10"
$res = Invoke-RestMethod -Uri $url -Headers $headers
Write-Host "Count: $($res.results.Count)"
foreach ($item in $res.results) {
    Write-Host "Title: $($item.title)"
    Write-Host "DOI: $($item.doi)"
    Write-Host "PDF: $($item.open_access.oa_url)"
    Write-Host "---"
}

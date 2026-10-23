$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}
$url = "https://api.crossref.org/works?query=continuance+intention+play+game&rows=5&mailto=antigravity.student@gmail.com"
$res = Invoke-RestMethod -Uri $url -Headers $headers
Write-Host "Total items: $($res.message.items.Count)"
foreach ($item in $res.message.items) {
    Write-Host "Title: $($item.title[0])"
    Write-Host "DOI: $($item.DOI)"
}

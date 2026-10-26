$headers = @{'User-Agent' = 'Mozilla/5.0; mailto:antigravity.student@gmail.com'}
$url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString('"perceived safety" "purchase" "vehicle"') + "&rows=5&mailto=antigravity.student@gmail.com"
$res = Invoke-RestMethod -Uri $url -Headers $headers
foreach ($item in $res.message.items) {
    Write-Host "Title: $($item.title[0])"
    Write-Host "DOI: $($item.DOI)"
    Write-Host "Journal: $($item.'container-title'[0]) ($($item.published.'date-parts'[0][0]))"
    Write-Host "---"
}

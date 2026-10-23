$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
$url = "https://api.crossref.org/works/10.1109/access.2025.3559632"
$resp = $wc.DownloadString($url) | ConvertFrom-Json
$item = $resp.message
Write-Output "Title: $($item.title -join ' ')"
Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
Write-Output "Container: $($item.'container-title' -join ' ')"
Write-Output "Volume: $($item.volume)"
Write-Output "Page: $($item.page)"
Write-Output "DOI: $($item.DOI)"
Write-Output "Issued: $($item.issued.'date-parts'[0] -join '-')"

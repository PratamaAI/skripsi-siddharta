$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
$url = "https://api.crossref.org/works/10.2991/978-94-6463-226-2_34"
$resp = $wc.DownloadString($url) | ConvertFrom-Json
$item = $resp.message
Write-Output "URL: $($item.URL)"
Write-Output "Link: $($item.link | ConvertTo-Json)"
Write-Output "Resource: $($item.resource.primary.URL)"

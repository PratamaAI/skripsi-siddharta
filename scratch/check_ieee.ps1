[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)')

Write-Output "=== Checking IEEE Access LoL Paper ==="
try {
    # Let's search Crossref for this title
    $q = "Examining the Mediating Effects of Game User Experience Satisfaction on Continuance Intention: A Case Study of League of Legends"
    $crUrl = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString($q) + "&rows=1"
    $crResp = $wc.DownloadString($crUrl) | ConvertFrom-Json
    $item = $crResp.message.items[0]
    $doi = $item.DOI
    Write-Output "DOI: $doi"
    
    # Query unpaywall
    $upUrl = "https://api.unpaywall.org/v2/$doi?email=unpaywall_research@gmail.com"
    $upResp = $wc.DownloadString($upUrl) | ConvertFrom-Json
    Write-Output "OA Status: $($upResp.is_oa)"
    Write-Output "Best OA URL: $($upResp.best_oa_location.url_for_pdf)"
    Write-Output "Landing: $($upResp.best_oa_location.url)"
} catch {
    Write-Output "Error: $_"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

Write-Output "=== Search Atlantis Press: Mobile Legends / Online Game Intention ==="
$url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("Mobile Legends intention atlantis press") + "&filter=prefix:10.2991&rows=10"
try {
    $resp = $wc.DownloadString($url) | ConvertFrom-Json
    foreach ($item in $resp.message.items) {
        $title = $item.title -join " "
        $doi = $item.DOI
        $year = $item.issued.'date-parts'[0][0]
        Write-Output "Title: $title | Year: $year | DOI: $doi"
    }
} catch {
    Write-Output "Error: $_"
}

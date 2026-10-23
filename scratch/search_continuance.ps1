[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)')

Write-Output "=== Atlantis Press Search: Continuance Intention Mobile Game ==="
$url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("continuance intention mobile games online games atlantis press") + "&filter=prefix:10.2991&rows=10"
try {
    $resp = $wc.DownloadString($url)
    $json = $resp | ConvertFrom-Json
    foreach ($item in $json.message.items) {
        $title = $item.title -join " "
        $doi = $item.DOI
        $year = $item.issued.'date-parts'[0][0]
        Write-Output "Title: $title | Year: $year | DOI: $doi"
    }
} catch {
    Write-Output "Crossref error: $_"
}

Write-Output "`n=== DOAJ Search: Continuance Intention Online Game / Mobile ==="
$doajUrl = "https://doaj.org/api/search/articles/continuance%20intention%20mobile%20game?page=1&pageSize=10"
try {
    $resp2 = $wc.DownloadString($doajUrl)
    $json2 = $resp2 | ConvertFrom-Json
    foreach ($item in $json2.results) {
        $b = $item.bibjson
        $title = $b.title
        $year = $b.year
        $journal = $b.journal.title
        $fulltext = ($b.link | Where-Object { $_.type -eq 'fulltext' }).url
        Write-Output "Title: $title | Year: $year | Journal: $journal | Link: $fulltext"
    }
} catch {
    Write-Output "DOAJ error: $_"
}

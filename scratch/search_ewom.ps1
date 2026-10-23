[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)')

# Search 1: Atlantis Press for eWOM purchase intention
Write-Output "=== Atlantis Press Search: eWOM ==="
$query = "eWOM purchase intention"
$url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("electronic word of mouth purchase intention atlantis press") + "&filter=prefix:10.2991&rows=10"
try {
    $resp = $wc.DownloadString($url)
    $json = $resp | ConvertFrom-Json
    foreach ($item in $json.message.items) {
        $title = $item.title -join " "
        $doi = $item.DOI
        $year = $item.issued.'date-parts'[0][0]
        $pdfUrl = ""
        if ($item.link) {
            $pdfUrl = ($item.link | Where-Object { $_.'content-type' -eq 'application/pdf' }).URL
        }
        Write-Output "Title: $title | Year: $year | DOI: $doi | PDF: $pdfUrl"
    }
} catch {
    Write-Output "Crossref error: $_"
}

# Search 2: DOAJ for electronic word of mouth continuance intention or purchase intention
Write-Output "`n=== DOAJ Search: eWOM Intention ==="
$doajUrl = "https://doaj.org/api/search/articles/electronic%20word%20of%20mouth%20purchase%20intention?page=1&pageSize=10"
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

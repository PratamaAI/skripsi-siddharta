[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

$doajUrl = "https://doaj.org/api/search/articles/mobile%20game%20intention?page=1&pageSize=15"
try {
    $resp2 = $wc.DownloadString($doajUrl)
    $json2 = $resp2 | ConvertFrom-Json
    foreach ($item in $json2.results) {
        $b = $item.bibjson
        $title = $b.title
        $year = $b.year
        $journal = $b.journal.title
        $doi = ($b.identifier | Where-Object { $_.type -eq 'doi' }).id
        $fulltext = ($b.link | Where-Object { $_.type -eq 'fulltext' }).url
        Write-Output "Title: $title | Year: $year | Journal: $journal | DOI: $doi | Link: $fulltext"
    }
} catch {
    Write-Output "DOAJ error: $_"
}

$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

# Check Fauzan 2025
Write-Output "=== Checking Fauzan IIJSE ==="
try {
    $htmlF = $wc.DownloadString("https://e-journal.uac.ac.id/index.php/iijse/article/view/9606")
    if ($htmlF -match 'href="([^"]+download/[^"]+)"') {
        Write-Output "Fauzan PDF: $($matches[1])"
    } else {
        Write-Output "No direct download regex match"
    }
} catch {
    Write-Output "Fauzan Error: $_"
}

# Search Atlantis Press for influencer purchase intention
Write-Output "`n=== Search Atlantis Press for Influencer Purchase Intention ==="
$url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("influencer purchase intention atlantis press") + "&filter=prefix:10.2991&rows=8"
try {
    $resp = $wc.DownloadString($url) | ConvertFrom-Json
    foreach ($item in $resp.message.items) {
        $title = $item.title -join " "
        $doi = $item.DOI
        $year = $item.issued.'date-parts'[0][0]
        $author = ($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; '
        Write-Output "Title: $title | Year: $year | Author: $author | DOI: $doi"
    }
} catch {
    Write-Output "Crossref Error: $_"
}

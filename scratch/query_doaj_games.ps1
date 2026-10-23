$headers = @{'User-Agent' = 'Mozilla/5.0'}

function Query-DOAJ($q) {
    Write-Host "=== DOAJ Query: $q ===" -ForegroundColor Cyan
    $url = "https://doaj.org/api/v2/search/articles/" + [System.Uri]::EscapeDataString($q) + "?pageSize=10"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        Write-Host "Total DOAJ hits: $($res.total)"
        foreach ($r in $res.results) {
            $bib = $r.bibjson
            $title = $bib.title
            $journal = $bib.journal.title
            $year = $bib.year
            $doi = ($bib.identifier | Where-Object { $_.type -eq "doi" }).id
            $fulltext = ($bib.link | Where-Object { $_.type -eq "fulltext" }).url
            Write-Host "[$year] $title" -ForegroundColor Green
            Write-Host "   Journal: $journal | DOI: $doi"
            Write-Host "   FullText: $fulltext"
        }
    } catch {
        Write-Host "Error: $_"
    }
}

Query-DOAJ 'continuance intention game'
Query-DOAJ 'continuance intention mobile game'
Query-DOAJ 'streamer continuance intention'
Query-DOAJ 'influencer continuance intention'

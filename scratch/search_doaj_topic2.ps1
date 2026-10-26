$headers = @{'User-Agent' = 'Mozilla/5.0'}

function Query-DOAJ($q, $limit=5) {
    Write-Host "=== DOAJ: $q ===" -ForegroundColor Cyan
    $url = "https://doaj.org/api/v2/search/articles/" + [System.Uri]::EscapeDataString($q) + "?pageSize=$limit"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        Write-Host "Hits: $($res.total)"
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

Query-DOAJ '"brand image" "brand trust" "purchase decision"' 5
Query-DOAJ '"brand trust" "perceived safety"' 5
Query-DOAJ '"perceived safety" "purchase decision"' 5
Query-DOAJ '"brand image" "purchase decision" transportation' 5

$headers = @{'User-Agent' = 'Mozilla/5.0'}

function Query-S2($q, $limit=5) {
    Write-Host "=== S2 Query: $q ===" -ForegroundColor Cyan
    $url = "https://api.semanticscholar.org/graph/v1/paper/search?query=" + [System.Uri]::EscapeDataString($q) + "&limit=$limit&fields=title,authors,year,venue,openAccessPdf,citationStyles"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($p in $res.data) {
            $pdfUrl = if ($p.openAccessPdf) { $p.openAccessPdf.url } else { "NO_OA_PDF" }
            Write-Host "Title: $($p.title)" -ForegroundColor Green
            Write-Host "  Year: $($p.year) | Venue: $($p.venue)"
            Write-Host "  PDF: $pdfUrl"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Query-S2 '"continuance intention to play"' 5
Query-S2 'influencer "continuance intention"' 5
Query-S2 '"electronic word of mouth" "continuance intention"' 5
Query-S2 '"mobile legends" "continuance intention"' 5

$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Search-CrossrefQuery($q, $limit=8) {
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "Query: $q" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=$limit"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $title = $item.title[0]
            $doi = $item.DOI
            $journal = $item.'container-title'[0]
            $year = if ($item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            Write-Host "[$year] $title" -ForegroundColor Green
            Write-Host "  Journal: $journal"
            Write-Host "  DOI: $doi"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Search-CrossrefQuery '"continuance intention to play" game' 6
Search-CrossrefQuery 'influencer "continuance intention" game' 6
Search-CrossrefQuery '"electronic word of mouth" "continuance intention" game' 6
Search-CrossrefQuery '"social influence" "continuance intention to play" online' 6

$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:siddharta.student@gmail.com'}

function Search-CrossrefPolite($q, $limit=5) {
    Write-Host "=== Query: $q ===" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=$limit&mailto=siddharta.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $title = $item.title[0]
            $doi = $item.DOI
            $journal = $item.'container-title'[0]
            $year = if ($item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            Write-Host "[$year] $title" -ForegroundColor Green
            Write-Host "  Journal: $journal | DOI: $doi"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Start-Sleep -Seconds 1
Search-CrossrefPolite '"social influence" "continuance intention to play" game' 5
Search-CrossrefPolite '"word-of-mouth" "continuance intention" game' 5
Search-CrossrefPolite '"influencer" "continuance intention" gaming' 5
Search-CrossrefPolite '"electronic word-of-mouth" "continuance intention"' 5

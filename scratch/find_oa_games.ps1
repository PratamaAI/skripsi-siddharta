$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}

function Find-OAPapers($query, $rows=10) {
    Write-Host "Searching: $query" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($query) + "&rows=$rows&mailto=antigravity.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $doi = $item.DOI
            $title = if ($item.title) { $item.title[0] } else { "No Title" }
            $journal = if ($item.'container-title') { $item.'container-title'[0] } else { "No Journal" }
            $year = if ($item.published -and $item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            
            # Check Unpaywall
            $unpUrl = "https://api.unpaywall.org/v2/$doi?email=antigravity.student@gmail.com"
            try {
                $unp = Invoke-RestMethod -Uri $unpUrl -Headers $headers -TimeoutSec 5
                if ($unp.is_oa -and $unp.best_oa_location.url_for_pdf) {
                    Write-Host "[$year] $title" -ForegroundColor Green
                    Write-Host "  Journal: $journal | DOI: $doi"
                    Write-Host "  PDF: $($unp.best_oa_location.url_for_pdf)" -ForegroundColor Yellow
                }
            } catch {}
        }
    } catch {
        Write-Host "Error: $_"
    }
}

Find-OAPapers 'continuance intention to play online games' 20
Find-OAPapers 'social influence continuance intention mobile game' 20
Find-OAPapers 'streamer continuance intention' 20

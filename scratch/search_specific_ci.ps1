$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:siddharta.student@gmail.com'}

function Search-Crossref($query, $rows=5) {
    Write-Host "=== Query: $query ===" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($query) + "&rows=$rows&mailto=siddharta.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $t = $item.title[0]
            $d = $item.DOI
            $j = $item.'container-title'[0]
            $y = if ($item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            Write-Host "[$y] $t" -ForegroundColor Green
            Write-Host "    Journal: $j | DOI: $d"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Start-Sleep -Seconds 1
Search-Crossref '"eWOM" "continuance intention" game' 5
Search-Crossref '"electronic word of mouth" "continuance intention"' 5
Search-Crossref '"influencer" "continuance intention to play"' 5
Search-Crossref '"streamer" "continuance intention to play"' 5
Search-Crossref '"continuance intention to play" "social influence"' 5

$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Search-Crossref($query, $rows=5) {
    Write-Host "=== Query: $query ===" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($query) + "&rows=$rows"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        $res.message.items | ForEach-Object {
            [PSCustomObject]@{
                Title = $_.title[0]
                DOI = $_.DOI
                Journal = $_.'container-title'[0]
                Year = $_.published.'date-parts'[0][0]
                Score = $_.score
            }
        } | Format-Table -Wrap
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Search-Crossref '"influencer marketing" "continuance intention" game' 5
Search-Crossref '"electronic word of mouth" "perceived enjoyment" "continuance intention"' 5
Search-Crossref '"electronic word of mouth" "perceived enjoyment" "mobile legends"' 5
Search-Crossref '"influencer" "electronic word of mouth" "mobile legends"' 5

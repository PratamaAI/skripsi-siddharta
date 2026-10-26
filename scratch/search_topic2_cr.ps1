$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}

function Search-Crossref($q, $limit=6) {
    Write-Host "=== Query: $q ===" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=$limit&mailto=antigravity.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $t = if ($item.title) { $item.title[0] } else { "No Title" }
            $d = $item.DOI
            $j = if ($item.'container-title') { $item.'container-title'[0] } else { "No Journal" }
            $y = if ($item.published -and $item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            Write-Host "[$y] $t" -ForegroundColor Green
            Write-Host "   Journal: $j | DOI: $d"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Search-Crossref '"Brand Image" "Brand Trust" "Keputusan Pembelian" taksi' 5
Search-Crossref '"Brand Image" "Brand Trust" "Keputusan Penggunaan" transportasi' 5
Search-Crossref '"Perceived Safety" "Brand Trust" transportasi' 5
Search-Crossref '"Perceived Safety" "Keputusan Pembelian" OR "Keputusan Penggunaan"' 5
Search-Crossref '"Brand Image" "Brand Trust" "Perceived Safety"' 5

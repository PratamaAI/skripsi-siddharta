$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}

function Get-PaperDetails($q, $limit=4) {
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "Query: $q" -ForegroundColor Yellow
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=$limit&mailto=antigravity.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $t = if ($item.title) { $item.title[0] } else { "No Title" }
            $d = $item.DOI
            $j = if ($item.'container-title') { $item.'container-title'[0] } else { "No Journal" }
            $y = if ($item.published -and $item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            $author = if ($item.author) { ($item.author | ForEach-Object { "$($_.family), $($_.given)" }) -join "; " } else { "No Author" }
            Write-Host "[$y] $t" -ForegroundColor Green
            Write-Host "   Authors: $author"
            Write-Host "   Journal: $j | DOI: $d"
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Get-PaperDetails '"Brand Image" "Brand Trust" "Keputusan Penggunaan" taksi' 4
Get-PaperDetails '"Brand Image" "Brand Trust" "Keputusan Penggunaan" Blue Bird' 4
Get-PaperDetails '"Brand Trust" "Perceived Safety" "Keputusan Penggunaan"' 4
Get-PaperDetails '"Persepsi Keamanan" "Kepercayaan Merek" "Keputusan Penggunaan" transportasi' 4
Get-PaperDetails '"Brand Image" "Perceived Safety" "Purchase Decision"' 4
Get-PaperDetails '"Brand Image" "Brand Trust" "Purchase Decision" electric vehicle' 4

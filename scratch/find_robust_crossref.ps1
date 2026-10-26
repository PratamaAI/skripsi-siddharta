[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$searchTerms = @(
    'citra merek kepercayaan merek harga keputusan pembelian',
    'brand image brand trust keputusan pembelian',
    'persepsi keamanan kepercayaan keputusan pembelian',
    'brand image perceived risk purchase decision'
)

foreach ($st in $searchTerms) {
    Write-Host "=============================================="
    Write-Host "TERM: $st"
    Write-Host "=============================================="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($st) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $title = if ($item.title) { $item.title[0] } else { "No Title" }
            $j = if ($item.'container-title') { $item.'container-title'[0] } else { "No Journal" }
            $doi = $item.DOI
            $auths = if ($item.author) { ($item.author | ForEach-Object { $_.family }) -join ", " } else { "No Authors" }
            Write-Host "Title: $title"
            Write-Host "Journal: $j | DOI: $doi | Authors: $auths"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

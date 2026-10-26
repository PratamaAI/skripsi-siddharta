[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$searchTerms = @(
    'citra merek kepercayaan merek kualitas produk keputusan pembelian',
    'brand image brand trust harga keputusan pembelian',
    'brand image brand trust kualitas pelayanan keputusan pembelian',
    'kepercayaan keamanan kemudahan keputusan pembelian',
    'kepercayaan persepsi keamanan persepsi risiko keputusan pembelian',
    'brand image brand trust perceived quality purchase decision'
)

foreach ($st in $searchTerms) {
    Write-Host "=============================================="
    Write-Host "TERM: $st"
    Write-Host "=============================================="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($st) + "&rows=4"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $title = $item.title[0]
            $j = $item.'container-title'[0]
            $y = $item.issued.'date-parts'[0][0]
            $doi = $item.DOI
            $auths = ($item.author | ForEach-Object { $_.family }) -join ", "
            Write-Host "Title: $title"
            Write-Host "Journal: $j ($y) | DOI: $doi | Authors: $auths"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

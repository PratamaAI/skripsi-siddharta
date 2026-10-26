[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$searchCombos = @(
    '"keamanan" "kepercayaan" "keputusan pembelian"',
    '"persepsi keamanan" "kepercayaan" "keputusan pembelian"',
    '"brand image" "keamanan" "keputusan pembelian"',
    '"perceived safety" "trust" "purchase decision"',
    '"brand image" "safety" "purchase decision"'
)

foreach ($sc in $searchCombos) {
    Write-Host "============================================="
    Write-Host "SEARCH: $sc"
    Write-Host "============================================="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($sc) + "&rows=6"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $title = $item.title[0]
            $container = $item.'container-title'[0]
            $year = $item.issued.'date-parts'[0][0]
            $doi = $item.DOI
            Write-Host "Title: $title"
            Write-Host "Journal: $container ($year) | DOI: $doi"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

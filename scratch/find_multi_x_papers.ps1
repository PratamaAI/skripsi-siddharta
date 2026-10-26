[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Search queries for Crossref
$queries = @(
    '"brand image" "brand trust" "keputusan pembelian"',
    '"brand image" "kepercayaan" "keputusan pembelian"',
    '"brand image" "perceived safety" "purchase decision"',
    '"brand trust" "perceived safety" "purchase decision"',
    '"brand image" "kepercayaan" "keamanan" "keputusan pembelian"',
    '"citra merek" "kepercayaan" "keamanan" "keputusan pembelian"'
)

foreach ($q in $queries) {
    Write-Host "============================================="
    Write-Host "Query: $q"
    Write-Host "============================================="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $authors = ($item.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
            Write-Host "Title: $($item.title[0])"
            Write-Host "Container: $($item.'container-title'[0])"
            Write-Host "Year: $($item.issued.'date-parts'[0][0])"
            Write-Host "DOI: $($item.DOI)"
            Write-Host "Authors: $authors"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

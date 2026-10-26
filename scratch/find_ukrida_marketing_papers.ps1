$queries = @(
    "ukrida 'keputusan pembelian'",
    "ukrida 'brand image'",
    "ukrida 'kualitas pelayanan'",
    "ukrida 'purchase decision'",
    "ukrida 'consumer behavior'",
    "ukrida 'tecoalu'"
)

foreach ($q in $queries) {
    Write-Host "=== Query: $q ==="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $authors = ($item.author | ForEach-Object { $_.given + " " + $_.family + " (" + ($_.affiliation.name -join "; ") + ")" }) -join ", "
            Write-Host ("Title: " + $item.title[0])
            Write-Host ("Container: " + $item.'container-title'[0])
            Write-Host ("Year: " + $item.issued.'date-parts'[0][0])
            Write-Host ("DOI: " + $item.DOI)
            Write-Host ("Authors: " + $authors)
            Write-Host ""
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$transportQueries = @(
    '"keamanan" "kepercayaan" "keputusan pembelian" transportasi',
    '"keamanan" "kepercayaan" "keputusan pembelian" tiket',
    '"citra merek" "keamanan" "kepercayaan" "keputusan pembelian"',
    '"brand image" "keamanan" "kepercayaan" "purchase decision"'
)

foreach ($tq in $transportQueries) {
    Write-Host "============================================="
    Write-Host "QUERY: $tq"
    Write-Host "============================================="
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($tq) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $auths = ($item.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
            Write-Host "Title: $($item.title[0])"
            Write-Host "Journal: $($item.'container-title'[0]) ($($item.issued.'date-parts'[0][0]))"
            Write-Host "DOI: $($item.DOI)"
            Write-Host "Authors: $auths"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

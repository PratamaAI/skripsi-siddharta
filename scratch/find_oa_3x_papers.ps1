[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$openAlexQueries = @(
    'https://api.openalex.org/works?search="brand+image"+"kepercayaan"+"keputusan+pembelian"&filter=is_oa:true&per_page=10',
    'https://api.openalex.org/works?search="citra+merek"+"kepercayaan+merek"+"keputusan+pembelian"&filter=is_oa:true&per_page=10',
    'https://api.openalex.org/works?search="keamanan"+"kepercayaan"+"keputusan+pembelian"&filter=is_oa:true&per_page=10',
    'https://api.openalex.org/works?search="brand+image"+"keamanan"+"keputusan+pembelian"&filter=is_oa:true&per_page=10'
)

foreach ($u in $openAlexQueries) {
    try {
        $resp = Invoke-RestMethod -Uri $u -Method Get -TimeoutSec 15
        Write-Host "URL: $u -> Total: $($resp.meta.count)"
        foreach ($w in $resp.results) {
            Write-Host "Title: $($w.title)"
            Write-Host "Source: $($w.primary_location.source.display_name) ($($w.publication_year))"
            Write-Host "DOI: $($w.doi)"
            Write-Host "PDF: $($w.open_access.oa_url)"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $($_.Exception.Message)"
    }
}

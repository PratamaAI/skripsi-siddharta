$q = "brand image brand trust purchase decision"
$url = "https://api.openalex.org/works?search=" + [Uri]::EscapeDataString($q) + "&per-page=5"
Write-Host "URL: $url"
try {
    $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
    Write-Host "Count: $($resp.meta.count)"
    foreach ($w in $resp.results) {
        Write-Host "Title: $($w.title)"
        Write-Host "Year: $($w.publication_year)"
        Write-Host "DOI: $($w.doi)"
        Write-Host "PDF: $($w.open_access.oa_url)"
        Write-Host "---"
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

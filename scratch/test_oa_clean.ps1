[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$u = "https://api.openalex.org/works?filter=title.search:keputusan%20pembelian,is_oa:true&search=brand%20image%20kepercayaan&per_page=15"
$resp = Invoke-RestMethod -Uri $u -Method Get
Write-Host "Total: $($resp.meta.count)"
foreach ($w in $resp.results) {
    Write-Host "Title: $($w.title)"
    Write-Host "Source: $($w.primary_location.source.display_name) ($($w.publication_year))"
    Write-Host "DOI: $($w.doi)"
    Write-Host "PDF: $($w.open_access.oa_url)"
    Write-Host "---"
}

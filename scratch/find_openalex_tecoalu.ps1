[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://api.openalex.org/works?search=Melitina+Tecoalu&per_page=20"
$resp = Invoke-RestMethod -Uri $url -Method Get
Write-Host "Total matches for Melitina Tecoalu: $($resp.meta.count)"
foreach ($w in $resp.results) {
    [PSCustomObject]@{
        Year = $w.publication_year
        Title = $w.title
        Journal = $w.primary_location.source.display_name
        DOI = $w.doi
        IsOA = $w.open_access.is_oa
        PdfUrl = $w.open_access.oa_url
    } | Format-List
}

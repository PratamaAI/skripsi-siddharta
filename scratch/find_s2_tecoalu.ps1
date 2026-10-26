[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Search Semantic Scholar for Tecoalu online transport
$url = "https://api.semanticscholar.org/graph/v1/paper/search?query=Melitina+Tecoalu+Online+Transport+Jakarta&fields=title,authors,year,openAccessPdf"
try {
    $resp = Invoke-RestMethod -Uri $url -Method Get
    Write-Host "Semantic Scholar found: $($resp.total)"
    foreach ($p in $resp.data) {
        Write-Host "Title: $($p.title)"
        Write-Host "Year: $($p.year)"
        Write-Host "OA PDF: $($p.openAccessPdf.url)"
        Write-Host "---"
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

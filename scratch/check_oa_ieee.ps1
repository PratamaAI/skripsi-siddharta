[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)')

$oaUrl = "https://api.openalex.org/works/https://doi.org/10.1109/access.2025.3559632?select=id,doi,title,publication_year,open_access,primary_location,locations"
try {
    $resp = $wc.DownloadString($oaUrl) | ConvertFrom-Json
    Write-Output "Title: $($resp.title)"
    Write-Output "OA: $($resp.open_access.is_oa)"
    Write-Output "PDF URL: $($resp.open_access.oa_url)"
    Write-Output "Locations count: $($resp.locations.Count)"
    foreach ($loc in $resp.locations) {
        Write-Output "Loc: $($loc.pdf_url) | $($loc.landing_page_url)"
    }
} catch {
    Write-Output "Error: $_"
}

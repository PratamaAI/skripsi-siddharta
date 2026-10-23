$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

# Search for open access versions of Lee 2014 or related papers
$doi = "10.1108/intr-02-2012-0025"
$url = "https://api.openalex.org/works/https://doi.org/$doi"
try {
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    Write-Host "OpenAlex OA for Lee 2014:"
    Write-Host "Is OA: $($res.open_access.is_oa)"
    Write-Host "OA URL: $($res.open_access.oa_url)"
    foreach ($loc in $res.locations) {
        if ($loc.pdf_url) { Write-Host "Location PDF: $($loc.pdf_url)" }
    }
} catch {
    Write-Host "Error: $_"
}

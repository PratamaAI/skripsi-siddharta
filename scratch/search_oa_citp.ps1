$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity@gmail.com'}
$url = "https://api.openalex.org/works?filter=is_oa:true&search=" + [System.Uri]::EscapeDataString('"continuance intention to play"') + "&per-page=10"
try {
    $res = Invoke-RestMethod -Uri $url -Headers $headers
    foreach ($item in $res.results) {
        $pdf = $item.open_access.oa_url
        $title = $item.title
        $journal = $item.primary_location.source.display_name
        $year = $item.publication_year
        $doi = $item.doi
        Write-Host "[$year] $title" -ForegroundColor Green
        Write-Host "  Journal: $journal | DOI: $doi"
        Write-Host "  PDF: $pdf"
    }
} catch {
    Write-Host "Error: $_"
}

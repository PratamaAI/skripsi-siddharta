$url = "https://api.openalex.org/works?filter=author.id:https://openalex.org/A5086884698|raw_affiliation_strings.search:ukrida,authorships.author.display_name.search:colline&per-page=20"
try {
    $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
    Write-Host ("Total works found for Colline: " + $resp.meta.count)
    foreach ($w in $resp.results) {
        Write-Host ("Title: " + $w.title)
        Write-Host ("Year: " + $w.publication_year + " | Source: " + $w.primary_location.source.display_name)
        Write-Host ("DOI: " + $w.doi)
        Write-Host "---"
    }
} catch {
    Write-Host "Error querying OpenAlex: $($_.Exception.Message)"
}

$resp = Invoke-RestMethod -Uri "https://api.openalex.org/works?search=Fredella+Colline" -Method Get
Write-Host ("Count: " + $resp.meta.count)
foreach ($w in $resp.results) {
    Write-Host ("Title: " + $w.title)
    Write-Host ("Year: " + $w.publication_year + " | Venue: " + $w.primary_location.source.display_name + " | DOI: " + $w.doi)
    Write-Host "---"
}

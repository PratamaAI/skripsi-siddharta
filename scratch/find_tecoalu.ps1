$url = "https://api.crossref.org/works?query.author=Melitina+Tecoalu&rows=10"
try {
    $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 15
    Write-Host ("Total found: " + $resp.message.'total-results')
    foreach ($item in $resp.message.items) {
        $authors = ($item.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
        Write-Host ("Title: " + $item.title[0])
        Write-Host ("Container: " + $item.'container-title'[0])
        Write-Host ("Year: " + $item.issued.'date-parts'[0][0])
        Write-Host ("DOI: " + $item.DOI)
        Write-Host ("Authors: " + $authors)
        Write-Host "---"
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

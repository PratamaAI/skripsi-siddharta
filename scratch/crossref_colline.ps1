$resp = Invoke-RestMethod -Uri "https://api.crossref.org/works?query.author=Fredella+Colline&rows=10" -Method Get
Write-Host ("Count: " + $resp.message.'total-results')
foreach ($item in $resp.message.items) {
    Write-Host ("Title: " + $item.title[0])
    Write-Host ("Container: " + $item.'container-title'[0])
    Write-Host ("DOI: " + $item.DOI)
    $authors = ($item.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
    Write-Host ("Authors: " + $authors)
    Write-Host "---"
}

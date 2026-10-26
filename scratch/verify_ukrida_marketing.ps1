$dois = @(
    "10.47059/revistageintec.v11i3.1918",
    "10.33258/siasat.v6i4.105",
    "10.54443/ijset.v1i9.50",
    "10.31539/costing.v5i1.2596"
)

foreach ($d in $dois) {
    try {
        $resp = Invoke-RestMethod -Uri ("https://api.crossref.org/works/" + $d) -Method Get -TimeoutSec 10
        $item = $resp.message
        Write-Host "DOI: $d"
        Write-Host ("Title: " + $item.title[0])
        Write-Host ("Container: " + $item.'container-title'[0])
        Write-Host ("Volume/Issue/Page: Vol. " + $item.volume + ", No. " + $item.issue + ", pp. " + $item.page)
        Write-Host ("Year: " + $item.issued.'date-parts'[0][0])
        $auths = ($item.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
        Write-Host ("Authors: " + $auths)
        Write-Host "---"
    } catch {
        Write-Host "Error for $d : $($_.Exception.Message)"
    }
}

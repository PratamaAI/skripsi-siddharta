$q = "brand image brand trust purchase decision taxi"
$url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString($q) + "&rows=5"
Write-Host "Crossref URL: $url"
try {
    $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
    Write-Host "Total results: $($resp.message.'total-results')"
    foreach ($item in $resp.message.items) {
        $title = $item.title -join " "
        Write-Host "Title: $title"
        Write-Host "DOI: $($item.DOI)"
        Write-Host "Container: $($item.'container-title' -join ' ')"
        Write-Host "URL: $($item.URL)"
        if ($item.link) {
            $pdfLinks = $item.link | Where-Object { $_.'content-type' -match 'pdf' } | Select-Object -ExpandProperty URL
            Write-Host "PDF Link: $pdfLinks"
        }
        Write-Host "---"
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

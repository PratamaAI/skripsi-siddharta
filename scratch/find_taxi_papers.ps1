$queries = @(
    "brand trust taksi keputusan penggunaan",
    "kepercayaan brand image blue bird keputusan",
    "persepsi keamanan taksi online keputusan"
)

foreach ($q in $queries) {
    Write-Host "Querying: $q"
    $url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString($q) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $pdf = $null
            if ($item.link) {
                $p = $item.link | Where-Object { $_.'content-type' -match 'pdf' } | Select-Object -First 1 -ExpandProperty URL
                if ($p) { $pdf = $p }
            }
            Write-Host "Title: $($item.title -join ' ')"
            Write-Host "DOI: $($item.DOI)"
            Write-Host "Journal: $($item.'container-title' -join ' ')"
            Write-Host "PDF: $pdf"
            Write-Host "---"
        }
    } catch {
        Write-Host "Error: $_"
    }
}

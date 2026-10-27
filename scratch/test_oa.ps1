$headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }
try {
    $res = Invoke-RestMethod -Uri "https://api.openalex.org/works?search=brand+image&per_page=3&mailto=siddharta@ukrida.ac.id" -Headers $headers
    Write-Host "Count: " $res.results.Count
    foreach ($r in $res.results) {
        Write-Host "Title: " $r.title
        Write-Host "DOI: " $r.doi
    }
} catch {
    Write-Host "Error: " $_.Exception.Message
}

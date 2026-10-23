$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Search-OpenAlex($query, $filter="") {
    Write-Host "=== OpenAlex Search: $query ===" -ForegroundColor Cyan
    $url = "https://api.openalex.org/works?search=" + [System.Uri]::EscapeDataString($query) + "&per-page=5"
    if ($filter) { $url += "&filter=" + $filter }
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        $res.results | ForEach-Object {
            [PSCustomObject]@{
                Title = $_.title
                DOI = $_.doi
                Journal = $_.primary_location.source.display_name
                Year = $_.publication_year
                OA = $_.open_access.is_oa
                PDF = $_.open_access.oa_url
            }
        } | Format-List
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Search-OpenAlex "influencer continuance intention game"
Search-OpenAlex "influencer continuance intention"
Search-OpenAlex "electronic word of mouth continuance intention game"
Search-OpenAlex "word of mouth continuance intention online game"

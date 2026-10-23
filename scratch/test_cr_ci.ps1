$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString('"influencer" "continuance intention"') + "&rows=5"
$res = Invoke-RestMethod -Uri $url -Headers $headers
$res.message.items | ForEach-Object {
    [PSCustomObject]@{
        Title = $_.title[0]
        DOI = $_.DOI
        Container = $_.'container-title'[0]
        Year = $_.published.'date-parts'[0][0]
    }
} | Format-List

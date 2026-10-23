$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$q = '"Influencer Marketing" "Electronic Word of Mouth" "Perceived Enjoyment"'
$url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=10"
$res = Invoke-RestMethod -Uri $url -Headers $headers
$res.message.items | ForEach-Object {
    [PSCustomObject]@{
        Title = $_.title[0]
        Year = $_.published.'date-parts'[0][0]
        Journal = $_.'container-title'[0]
        Score = $_.score
        DOI = $_.DOI
    }
} | Format-List

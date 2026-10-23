$dois = @(
    "10.2991/aebmr.k.220501.075",
    "10.2991/978-94-6463-340-5_24",
    "10.2991/aebmr.k.200131.008"
)

$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

foreach ($doi in $dois) {
    try {
        $url = "https://api.crossref.org/works/$doi"
        $resp = $wc.DownloadString($url) | ConvertFrom-Json
        $item = $resp.message
        Write-Output "=== DOI: $doi ==="
        Write-Output "Title: $($item.title -join ' ')"
        Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
        Write-Output "Container: $($item.'container-title' -join ' ')"
        Write-Output "Year: $($item.issued.'date-parts'[0][0])"
        Write-Output "URL: $($item.URL)"
    } catch {
        Write-Output "Error for $doi : $_"
    }
}

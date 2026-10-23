$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

# Ahmad
Write-Output "=== Ahmad metadata ==="
$respA = $wc.DownloadString("https://api.crossref.org/works/10.2991/978-94-6463-372-6_22") | ConvertFrom-Json
$itemA = $respA.message
Write-Output "Title: $($itemA.title -join ' ')"
Write-Output "Authors: $(($itemA.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
Write-Output "Container: $($itemA.'container-title' -join ' ')"
Write-Output "Year: $($itemA.issued.'date-parts'[0][0])"
Write-Output "DOI: $($itemA.DOI)"

# Search Crossref for Martiningsih
Write-Output "`n=== Martiningsih search ==="
$respM = $wc.DownloadString("https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("Martiningsih Setyawan influencer credibility ICOEBS") + "&rows=3") | ConvertFrom-Json
foreach ($item in $respM.message.items) {
    Write-Output "Title: $($item.title -join ' ')"
    Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
    Write-Output "Container: $($item.'container-title' -join ' ')"
    Write-Output "Year: $($item.issued.'date-parts'[0][0])"
    Write-Output "DOI: $($item.DOI)"
}

# Search Crossref for Asmawati IIJSE
Write-Output "`n=== Asmawati search ==="
$respAs = $wc.DownloadString("https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("The Influence of Digital Marketing, Influencer Marketing on Purchase Intention Through Consumer Attitude Mediation") + "&rows=3") | ConvertFrom-Json
foreach ($item in $respAs.message.items) {
    Write-Output "Title: $($item.title -join ' ')"
    Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
    Write-Output "Container: $($item.'container-title' -join ' ')"
    Write-Output "Year: $($item.issued.'date-parts'[0][0])"
    Write-Output "DOI: $($item.DOI)"
}

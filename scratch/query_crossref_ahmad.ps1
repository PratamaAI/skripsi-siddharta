$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

# Ahmad ICGMSI
$respA = $wc.DownloadString("https://api.crossref.org/works?query=" + [Uri]::EscapeDataString("Ahmad Suwarsi Siswanti Influencer ICGMSI") + "&rows=3") | ConvertFrom-Json
Write-Output "=== Ahmad Search ==="
foreach ($item in $respA.message.items) {
    Write-Output "Title: $($item.title -join ' ')"
    Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
    Write-Output "Container: $($item.'container-title' -join ' ')"
    Write-Output "Year: $($item.issued.'date-parts'[0][0])"
    Write-Output "DOI: $($item.DOI)"
}

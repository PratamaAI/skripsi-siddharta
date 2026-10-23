$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
$html = $wc.DownloadString("https://www.atlantis-press.com/article/125975283")
if ($html -match '<title>(.*?)</title>') {
    Write-Output "Title: $($matches[1])"
}
if ($html -match 'citation_doi"\s+content="([^"]+)"') {
    Write-Output "DOI: $($matches[1])"
}
if ($html -match 'citation_author"\s+content="([^"]+)"') {
    Write-Output "Author: $($matches[1])"
}

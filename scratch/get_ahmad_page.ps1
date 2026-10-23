$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
$html = $wc.DownloadString("https://www.atlantis-press.com/article/125997931")
if ($html -match '<title>(.*?)</title>') {
    Write-Output "Title: $($matches[1])"
}
if ($html -match 'citation_doi"\s+content="([^"]+)"') {
    Write-Output "DOI: $($matches[1])"
}
if ($html -match 'citation_author"\s+content="([^"]+)"') {
    Write-Output "Author: $($matches[1])"
}
if ($html -match 'citation_publication_date"\s+content="([^"]+)"') {
    Write-Output "Date: $($matches[1])"
}

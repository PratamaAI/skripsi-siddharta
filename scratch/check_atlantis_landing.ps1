$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')
$html = $wc.DownloadString("https://www.atlantis-press.com/doi/10.2991/978-94-6463-226-2_34")
if ($html -match 'href="([^"]+download[^"]+)"' -or $html -match 'href="([^"]+\.pdf)"') {
    Write-Output "Matched: $($matches[1])"
}
if ($html -match 'citation_pdf_url"\s+content="([^"]+)"') {
    Write-Output "PDF: $($matches[1])"
}
if ($html -match '<title>(.*?)</title>') {
    Write-Output "Title: $($matches[1])"
}

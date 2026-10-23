[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')

# Check SIJDEB PDF
try {
    $html1 = $wc.DownloadString("https://sijdeb.unsri.ac.id/index.php/SIJDEB/article/view/178")
    if ($html1 -match 'href="([^"]+download[^"]+)"' -or $html1 -match 'href="([^"]+article/view/178/[0-9]+)"') {
        $pdfLink1 = $matches[1]
        Write-Output "SIJDEB PDF page: $pdfLink1"
    } else {
        Write-Output "SIJDEB link not matched directly"
    }
} catch {
    Write-Output "SIJDEB Error: $_"
}

# Check IPB IJBE
try {
    $html2 = $wc.DownloadString("https://journal.ipb.ac.id/ijbe/article/view/50000")
    if ($html2 -match 'href="([^"]+download[^"]+)"' -or $html2 -match 'href="([^"]+article/view/50000/[0-9]+)"') {
        $pdfLink2 = $matches[1]
        Write-Output "IPB IJBE PDF page: $pdfLink2"
    } else {
        Write-Output "IPB IJBE link not matched directly"
    }
} catch {
    Write-Output "IPB IJBE Error: $_"
}

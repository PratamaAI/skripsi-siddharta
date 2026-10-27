[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
try {
    $url = "https://revistageintec.net/index.php/revista/article/view/1918"
    $html = $wc.DownloadString($url)
    Write-Host "Success! Length: $($html.Length)"
    if ($html -match 'href="([^"]+/download/[^"]+)"') {
        Write-Host "Found PDF URL: $($matches[1])"
        $pdfUrl = $matches[1]
        if ($pdfUrl.StartsWith("/")) { $pdfUrl = "https://revistageintec.net" + $pdfUrl }
        $wc.DownloadFile($pdfUrl, "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Geintec_Transportasi_Online.pdf")
        Write-Host "Downloaded PDF successfully!"
        $info = Get-Item "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Geintec_Transportasi_Online.pdf"
        Write-Host "File size: $($info.Length) bytes"
    } else {
        Write-Host "No PDF link matched."
        $html | Out-File "scratch/geintec_page.html" -Encoding utf8
    }
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}

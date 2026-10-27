[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

$downUrl = "https://siasatjournal.id/index.php/siasat/article/download/105/93"
Write-Host "Trying: $downUrl"
try {
    $wc.DownloadFile($downUrl, "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Saparso_Fernandes_SIASAT.pdf")
    Write-Host "Success downloading from siasatjournal.id!"
    $info = Get-Item "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Saparso_Fernandes_SIASAT.pdf"
    Write-Host "File size: $($info.Length) bytes"
} catch {
    Write-Host "siasatjournal.id failed: $($_.Exception.Message)"
}

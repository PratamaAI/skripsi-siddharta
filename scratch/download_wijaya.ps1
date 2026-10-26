[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url = "https://jurnal.ukdc.ac.id/index.php/BIP/article/download/241/178"
$out = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$wc.DownloadFile($url, $out)
$fi = Get-Item $out
Write-Host "Downloaded Wijaya Gojek: $($fi.Length) bytes"

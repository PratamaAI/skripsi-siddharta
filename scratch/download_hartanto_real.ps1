[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')
$url = "https://www.atlantis-press.com/article/125990512.pdf"
$dest = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2023_Hartanto_Influencer_Purchase_Intention_GIEBM.pdf"

try {
    $wc.DownloadFile($url, $dest)
    $len = (Get-Item $dest).Length
    $stream = [System.IO.File]::OpenRead($dest)
    $bytes = New-Object byte[] 5
    $null = $stream.Read($bytes, 0, 5)
    $stream.Close()
    $header = [System.Text.Encoding]::ASCII.GetString($bytes)
    Write-Output "Downloaded Hartanto: Length: $len, Header: $header"
} catch {
    Write-Output "Error: $_"
}

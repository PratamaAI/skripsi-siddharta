[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')

# File 1: Halim & Keni (2022)
$url1 = "https://www.atlantis-press.com/article/125974169.pdf"
$out1 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2022_Halim_Keni_eWOM_Purchase_Intention_ICEBM.pdf"
try {
    $wc.DownloadFile($url1, $out1)
    $len1 = (Get-Item $out1).Length
    $stream1 = [System.IO.File]::OpenRead($out1)
    $bytes1 = New-Object byte[] 5
    $null = $stream1.Read($bytes1, 0, 5)
    $stream1.Close()
    $header1 = [System.Text.Encoding]::ASCII.GetString($bytes1)
    Write-Output "Halim 2022 -> Length: $len1, Header: $header1"
} catch {
    Write-Output "Error 1: $_"
}

# File 2: Utami et al. (2023)
$url2 = "https://www.atlantis-press.com/article/125996200.pdf"
$out2 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2023_Utami_Dewi_eWOM_Intention_ICOEINS.pdf"
try {
    $wc.DownloadFile($url2, $out2)
    $len2 = (Get-Item $out2).Length
    $stream2 = [System.IO.File]::OpenRead($out2)
    $bytes2 = New-Object byte[] 5
    $null = $stream2.Read($bytes2, 0, 5)
    $stream2.Close()
    $header2 = [System.Text.Encoding]::ASCII.GetString($bytes2)
    Write-Output "Utami 2023 -> Length: $len2, Header: $header2"
} catch {
    Write-Output "Error 2: $_"
}

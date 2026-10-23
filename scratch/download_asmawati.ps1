[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = 'https://e-journal.uac.ac.id/index.php/iijse/article/download/6144/2482'
$out = '06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2025_Asmawati_Influencer_GenZ_IIJSE.pdf'

$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')
try {
    $wc.DownloadFile($url, $out)
    if (Test-Path $out) {
        $len = (Get-Item $out).Length
        $stream = [System.IO.File]::OpenRead($out)
        $bytes = New-Object byte[] 5
        $null = $stream.Read($bytes, 0, 5)
        $stream.Close()
        $header = [System.Text.Encoding]::ASCII.GetString($bytes)
        Write-Output "SUCCESS: Length: $len, Header: $header"
    } else {
        Write-Output "File not created"
    }
} catch {
    Write-Output "ERROR: $_"
}

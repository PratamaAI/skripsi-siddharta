[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')
$url = "https://ieeexplore.ieee.org/stampPDF/getPDF.jsp?tp=&arnumber=10962154"
$out = "scratch/test_ieee.pdf"
try {
    $wc.DownloadFile($url, $out)
    $len = (Get-Item $out).Length
    $stream = [System.IO.File]::OpenRead($out)
    $bytes = New-Object byte[] 5
    $null = $stream.Read($bytes, 0, 5)
    $stream.Close()
    $header = [System.Text.Encoding]::ASCII.GetString($bytes)
    Write-Output "Len: $len Header: $header"
} catch {
    Write-Output "Error: $_"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

$doi = "https://doi.org/10.2991/aebmr.k.200131.008"
$req = [System.Net.WebRequest]::Create($doi)
$req.UserAgent = 'Mozilla/5.0'
$resp = $req.GetResponse()
$landing = $resp.ResponseUri.AbsoluteUri
$resp.Close()
Write-Output "Landing: $landing"

# Atlantis Press PDF URL
if ($landing -match '/([0-9]+)$') {
    $id = $matches[1]
    $pdfUrl = "https://www.atlantis-press.com/article/$id.pdf"
    $out = "scratch/test_zahratu.pdf"
    $wc.DownloadFile($pdfUrl, $out)
    $len = (Get-Item $out).Length
    $stream = [System.IO.File]::OpenRead($out)
    $bytes = New-Object byte[] 5
    $null = $stream.Read($bytes, 0, 5)
    $stream.Close()
    $header = [System.Text.Encoding]::ASCII.GetString($bytes)
    Write-Output "Zahratu -> Len: $len Header: $header"
}

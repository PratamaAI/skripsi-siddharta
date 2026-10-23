[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

# Paper 1: Hartanto et al. 2023
$doi1 = "https://doi.org/10.2991/978-94-6463-226-2_34"
$req1 = [System.Net.WebRequest]::Create($doi1)
$req1.UserAgent = 'Mozilla/5.0'
$resp1 = $req1.GetResponse()
$landing1 = $resp1.ResponseUri.AbsoluteUri
$resp1.Close()
Write-Output "Landing 1: $landing1"

if ($landing1 -match '/([0-9]+)$') {
    $id1 = $matches[1]
    $pdfUrl1 = "https://www.atlantis-press.com/article/$id1.pdf"
    $out1 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2023_Hartanto_Influencer_Purchase_Intention_GIEBM.pdf"
    $wc.DownloadFile($pdfUrl1, $out1)
    $len1 = (Get-Item $out1).Length
    $stream1 = [System.IO.File]::OpenRead($out1)
    $bytes1 = New-Object byte[] 5
    $null = $stream1.Read($bytes1, 0, 5)
    $stream1.Close()
    $header1 = [System.Text.Encoding]::ASCII.GetString($bytes1)
    Write-Output "Hartanto -> Len: $len1, Header: $header1"
}

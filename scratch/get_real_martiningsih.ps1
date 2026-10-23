[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$doi = "https://doi.org/10.2991/aebmr.k.220602.025"
$req = [System.Net.WebRequest]::Create($doi)
$req.UserAgent = 'Mozilla/5.0'
$resp = $req.GetResponse()
$landing = $resp.ResponseUri.AbsoluteUri
$resp.Close()
Write-Output "Martiningsih Landing: $landing"

if ($landing -match '/([0-9]+)$') {
    $id = $matches[1]
    $pdfUrl = "https://www.atlantis-press.com/article/$id.pdf"
    Write-Output "PDF URL: $pdfUrl"
    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add('User-Agent', 'Mozilla/5.0')
    $out = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf"
    $wc.DownloadFile($pdfUrl, $out)
    $len = (Get-Item $out).Length
    Write-Output "Downloaded Martiningsih: $len bytes"
}

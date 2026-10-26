[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$u = "https://journal.ipm2kpe.or.id/index.php/COSTING/article/view/2596"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("User-Agent", "Mozilla/5.0")
$html = $wc.DownloadString($u)
$lines = $html -split "`n"
foreach ($l in $lines) {
    if ($l -match 'galley' -or $l -match 'download') {
        Write-Host $l.Trim()
    }
}

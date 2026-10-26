[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$urls = @(
    "https://journal.ipm2kpe.or.id/index.php/COSTING/article/view/2596",
    "https://jurnal.ubd.ac.id/index.php/PE/article/view/586",
    "https://jurnal.syntax-idea.co.id/index.php/syntax-idea/article/view/3107"
)

foreach ($u in $urls) {
    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
        $html = $wc.DownloadString($u)
        Write-Host "URL: $u"
        $lines = $html -split "`n"
        foreach ($line in $lines) {
            if ($line -match 'href="([^"]+)"' -and ($line -match 'pdf' -or $line -match 'download' -or $line -match 'galley')) {
                Write-Host "  -> $($matches[1])"
            }
        }
    } catch {
        Write-Host "Error for $u : $($_.Exception.Message)"
    }
}

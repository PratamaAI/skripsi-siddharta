[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$testList = @(
    @{ Name = "Fitriyono_Toyota"; DOI = "10.30738/jm.v16i1.4841" },
    @{ Name = "Devananda_JIIP"; DOI = "10.54371/jiip.v6i10.2183" },
    @{ Name = "Wijaya_Gojek"; DOI = "10.37477/bip.v14i1.241" },
    @{ Name = "Alfano_Traveloka"; DOI = "10.51277/keb.v21i1.310" },
    @{ Name = "Alfarezzy_UlilAlbab"; DOI = "10.56799/jim.v5i9.19474" },
    @{ Name = "Aurelia_JakartaBarat"; DOI = "10.24912/jmk.v7i2.33917" },
    @{ Name = "Febriyanto_UB"; DOI = "10.21776/jmppk.2024.03.3.10" }
)

foreach ($t in $testList) {
    try {
        $doiUrl = "https://doi.org/" + $t.DOI
        $req = [System.Net.HttpWebRequest]::Create($doiUrl)
        $req.AllowAutoRedirect = $true
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $req.Timeout = 10000
        $resp = $req.GetResponse()
        $landUrl = $resp.ResponseUri.AbsoluteUri
        Write-Host "$($t.Name) landed at: $landUrl"
        
        $reader = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $reader.ReadToEnd()
        $reader.Close()
        $resp.Close()
        
        if ($html -match 'citation_pdf_url" content="([^"]+)"') {
            Write-Host "  -> PDF direct link: $($matches[1])"
        } elseif ($html -match 'href="([^"]+/article/download/[^"]+)"') {
            Write-Host "  -> OJS download link: $($matches[1])"
        } else {
            Write-Host "  -> No meta PDF link found"
        }
    } catch {
        Write-Host "$($t.Name) error: $($_.Exception.Message)"
    }
}

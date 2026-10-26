[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dois = @(
    @{ Name = "JIGE_Risk_Image_Trust"; DOI = "10.55681/jige.v6i3.3842" },
    @{ Name = "Scientia_Safety_Trust"; DOI = "10.33884/scientiajournal.v7i4.10513" },
    @{ Name = "Patria_Image_Trust"; DOI = "10.30743/jmb.v5i2.7683" },
    @{ Name = "Putri_Dimensi_Image_Trust"; DOI = "10.33373/dms.v11i2.4143" },
    @{ Name = "UlilAlbab_Safety_Trust"; DOI = "10.56799/jim.v5i9.19474" },
    @{ Name = "Manajerial_Safety_Trust"; DOI = "10.30587/manajerial.v4i1.310" }
)

foreach ($d in $dois) {
    try {
        $url = "https://doi.org/" + $d.DOI
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.AllowAutoRedirect = $true
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $req.Timeout = 10000
        $resp = $req.GetResponse()
        $land = $resp.ResponseUri.AbsoluteUri
        Write-Host "$($d.Name) -> $land"
        
        $reader = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $reader.ReadToEnd()
        $reader.Close()
        $resp.Close()
        
        if ($html -match 'citation_pdf_url" content="([^"]+)"') {
            Write-Host "   Found PDF: $($matches[1])"
            $pdfUrl = $matches[1]
            $outFile = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\$($d.Name).pdf"
            $wc = New-Object System.Net.WebClient
            $wc.Headers.Add("User-Agent", "Mozilla/5.0")
            $wc.DownloadFile($pdfUrl, $outFile)
            $fi = Get-Item $outFile
            Write-Host "   DOWNLOADED: $($fi.Length) bytes"
        } elseif ($html -match 'href="([^"]+/article/download/[^"]+)"') {
            Write-Host "   Found OJS download: $($matches[1])"
            $pdfUrl = $matches[1]
            $outFile = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\$($d.Name).pdf"
            $wc = New-Object System.Net.WebClient
            $wc.Headers.Add("User-Agent", "Mozilla/5.0")
            $wc.DownloadFile($pdfUrl, $outFile)
            $fi = Get-Item $outFile
            Write-Host "   DOWNLOADED: $($fi.Length) bytes"
        } else {
            Write-Host "   No direct PDF link found in HTML"
        }
    } catch {
        Write-Host "$($d.Name) Error: $($_.Exception.Message)"
    }
}

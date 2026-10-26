[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$testArticles = @(
    @{ Name = "Costing_Shopee_Decision"; Url = "https://journal.ipm2kpe.or.id/index.php/COSTING/article/view/2596" },
    @{ Name = "Primanomics_Okeped_Decision"; Url = "https://doi.org/10.31253/pe.v19i2.586" },
    @{ Name = "JMPJ_Quality"; Url = "https://doi.org/10.25105/jmpj.v15i1.10719" },
    @{ Name = "Syntax_Idea_Wahyoedi"; Url = "https://doi.org/10.46799/syntax-idea.v6i3.3107" }
)

foreach ($a in $testArticles) {
    try {
        $req = [System.Net.HttpWebRequest]::Create($a.Url)
        $req.AllowAutoRedirect = $true
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $req.Timeout = 10000
        $resp = $req.GetResponse()
        Write-Host "$($a.Name) redirected to: $($resp.ResponseUri.AbsoluteUri)"
        $reader = New-Object System.IO.StreamReader($resp.GetResponseStream())
        $html = $reader.ReadToEnd()
        $reader.Close()
        $resp.Close()
        
        # Search for PDF links
        if ($html -match 'href="([^"]+\.pdf[^"]*)"') {
            Write-Host "  Found PDF match: $($matches[1])"
        } elseif ($html -match 'href="([^"]+/article/download/[^"]+)"') {
            Write-Host "  Found OJS download match: $($matches[1])"
        } elseif ($html -match 'href="([^"]+/viewFile/[^"]+)"') {
            Write-Host "  Found viewFile match: $($matches[1])"
        } else {
            Write-Host "  No obvious PDF match in HTML (length $($html.Length))"
        }
    } catch {
        Write-Host "$($a.Name) Error: $($_.Exception.Message)"
    }
}

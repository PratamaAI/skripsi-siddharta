[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dois = @(
    @{ Key = "tecoalu_geintec"; DOI = "10.47059/revistageintec.v11i3.1918" },
    @{ Key = "tecoalu_siasat"; DOI = "10.33258/siasat.v6i4.105" },
    @{ Key = "sundah_ijset"; DOI = "10.54443/ijset.v1i9.50" },
    @{ Key = "tecoalu_costing"; DOI = "10.31539/costing.v5i1.2596" }
)

foreach ($item in $dois) {
    try {
        $url = "https://doi.org/" + $item.DOI
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.AllowAutoRedirect = $true
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
        $req.Timeout = 10000
        $resp = $req.GetResponse()
        Write-Host "$($item.Key) redirected to: $($resp.ResponseUri.AbsoluteUri)"
        $resp.Close()
    } catch {
        Write-Host "$($item.Key) error: $($_.Exception.Message)"
    }
}

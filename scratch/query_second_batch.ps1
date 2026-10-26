$headers = @{ "User-Agent" = "AcademicResearchBot/1.0 (mailto:student@ukrida.ac.id)" }

$queries = @(
    "Mariza Pengaruh Kepercayaan, Keamanan Dan Promosi Terhadap Keputusan Pembelian",
    "Fransiska Pengaruh e-WOM, Keamanan, Kepercayaan Terhadap Keputusan Pembelian",
    "Agustiningrum Pengaruh Kepercayaan, Kemudahan, dan Keamanan terhadap Keputusan Pembelian",
    "Dahlia Pengaruh Kepercayaan, Kemudahan Dan Keamanan Terhadap Keputusan Pembelian",
    "Rahmani Pengaruh Celebrity Endorsement, Brand Image dan Brand Trust Terhadap Keputusan",
    "Inggasari Pengaruh Celebrity Endorser, Brand Image, dan Brand Trust terhadap Keputusan",
    "Rahmatika Pengaruh Green Marketing, Brand Image Dan Brand Trust Terhadap Keputusan"
)

$found = foreach ($q in $queries) {
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=1"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        if ($res.message.items.Count -gt 0) {
            $it = $res.message.items[0]
            [PSCustomObject]@{
                Query = $q
                DOI = $it.DOI
                Title = $it.title[0]
                Container = if ($it.'container-title') { $it.'container-title'[0] } else { "" }
                URL = if ($it.resource.primary.URL) { $it.resource.primary.URL } else { "" }
                Link = if ($it.link) { $it.link[0].URL } else { "" }
            }
        }
    } catch {
        Write-Host "Err: $_"
    }
}

$found | Format-List

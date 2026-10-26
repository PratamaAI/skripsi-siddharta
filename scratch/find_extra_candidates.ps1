$headers = @{ "User-Agent" = "AcademicResearchBot/1.0 (mailto:student@ukrida.ac.id)" }

$queries = @(
    "Pengaruh Brand Image, Brand Trust, dan Kualitas Produk terhadap Keputusan Pembelian",
    "Pengaruh Kepercayaan, Keamanan, dan Kualitas Pelayanan terhadap Keputusan Pembelian",
    "Pengaruh Persepsi Keamanan, Kepercayaan, dan Kepuasan terhadap Keputusan Pembelian"
)

foreach ($q in $queries) {
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=3&filter=type:journal-article"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($it in $res.message.items) {
            $link = if ($it.link) { $it.link[0].URL } else { "" }
            [PSCustomObject]@{
                Title = $it.title[0]
                DOI = $it.DOI
                Container = if ($it.'container-title') { $it.'container-title'[0] } else { "" }
                PDF = $link
                URL = if ($it.resource.primary.URL) { $it.resource.primary.URL } else { "" }
            } | Format-List
        }
    } catch {
        Write-Host "Err: $_"
    }
}

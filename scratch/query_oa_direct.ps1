function Query-OpenAlex {
    param([string]$query)
    $url = "https://api.openalex.org/works?search=" + [System.Uri]::EscapeDataString($query) + "&filter=is_oa:true,type:article&per_page=10"
    try {
        $res = Invoke-RestMethod -Uri $url -TimeoutSec 15
        return $res.results
    } catch {
        return @()
    }
}

Write-Host "Querying OpenAlex..."
$oa1 = Query-OpenAlex "brand image brand trust keputusan pembelian"
$oa2 = Query-OpenAlex "keamanan kepercayaan keputusan pembelian"

$items = @($oa1) + @($oa2)
foreach ($it in $items) {
    $pdf = $it.best_oa_location.pdf_url
    if (-not $pdf) { continue }
    $title = $it.title
    $doi = $it.doi
    $year = $it.publication_year
    [PSCustomObject]@{
        Year = $year
        Title = $title
        DOI = $doi
        PDF = $pdf
    } | Format-List
}

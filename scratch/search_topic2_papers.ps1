# Query OpenAlex for relevant empirical papers
$queries = @(
    "brand image brand trust purchase decision taxi",
    "brand image perceived safety purchase decision transport",
    "brand trust perceived safety purchase decision ride hailing",
    "brand image brand trust purchase decision mobil listrik",
    "perceived safety purchase decision taxi online",
    "citra merek kepercayaan keputusan pembelian transportasi"
)

$results = @()

foreach ($q in $queries) {
    Write-Host "Searching OpenAlex for: $q"
    $encoded = [System.Web.HttpUtility]::UrlEncode($q)
    $url = "https://api.openalex.org/works?search=$encoded&filter=is_oa:true,type:article&per-page=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
        foreach ($work in $resp.results) {
            $pdfUrl = $work.open_access.oa_url
            if (-not $pdfUrl -and $work.best_oa_location) {
                $pdfUrl = $work.best_oa_location.pdf_url
            }
            $results += [PSCustomObject]@{
                Title = $work.title
                Year = $work.publication_year
                Doi = $work.doi
                PdfUrl = $pdfUrl
                HostVenue = $work.primary_location.source.display_name
            }
        }
    } catch {
        Write-Host "Error querying $q : $_"
    }
}

$unique = $results | Sort-Object Title -Unique
Write-Host "Total unique found: $($unique.Count)"
$unique | Select-Object Year, Title, PdfUrl, HostVenue | Format-Table -Wrap -AutoSize | Out-File "scratch/openalex_topic2_results.txt" -Encoding utf8
Write-Host "Saved to scratch/openalex_topic2_results.txt"

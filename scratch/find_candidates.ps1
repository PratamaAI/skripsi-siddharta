$queries = @(
    "pengaruh brand image brand trust keputusan penggunaan transportasi",
    "pengaruh persepsi keamanan brand trust keputusan penggunaan",
    "pengaruh brand image persepsi keamanan keputusan pembelian",
    "pengaruh brand trust persepsi keamanan keputusan penggunaan jasa taksi",
    "pengaruh persepsi keselamatan keputusan penggunaan ride hailing",
    "brand image brand trust purchase decision electric vehicle",
    "perceived safety brand trust purchase decision ride-hailing",
    "perceived safety brand image adoption electric taxi"
)

$foundList = @()

foreach ($q in $queries) {
    Write-Host "Querying Crossref: $q"
    $url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString($q) + "&rows=8"
    try {
        $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $title = ($item.title -join " ")
            $doi = $item.DOI
            $journal = ($item.'container-title' -join " ")
            $itemUrl = $item.URL
            $pdfUrl = $null
            if ($item.link) {
                $p = $item.link | Where-Object { $_.'content-type' -match 'pdf' } | Select-Object -First 1 -ExpandProperty URL
                if ($p) { $pdfUrl = $p }
            }
            $foundList += [PSCustomObject]@{
                Query = $q
                Title = $title
                DOI = $doi
                Journal = $journal
                URL = $itemUrl
                PdfUrl = $pdfUrl
            }
        }
    } catch {
        Write-Host "Error querying $q : $_"
    }
}

$unique = $foundList | Sort-Object Title -Unique
Write-Host "Total unique papers found: $($unique.Count)"

$unique | Export-Clixml -Path "scratch/crossref_candidates.xml"
$unique | Select-Object Title, DOI, Journal, URL, PdfUrl | Format-List | Out-File "scratch/crossref_candidates.txt" -Encoding utf8
Write-Host "Written to scratch/crossref_candidates.txt"

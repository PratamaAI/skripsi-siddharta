$qList = @(
    "persepsi keamanan keputusan penggunaan transportasi online",
    "persepsi keselamatan keputusan penggunaan ride hailing",
    "perceived safety purchase intention electric vehicle",
    "perceived safety usage decision ride hailing taxi",
    "kepercayaan persepsi keamanan keputusan penggunaan grab",
    "brand trust persepsi keamanan keputusan penggunaan blue bird"
)

$moreCandidates = @()
foreach ($q in $qList) {
    Write-Host "Querying: $q"
    $url = "https://api.crossref.org/works?query=" + [Uri]::EscapeDataString($q) + "&rows=5"
    try {
        $resp = Invoke-RestMethod -Uri $url -TimeoutSec 15
        foreach ($item in $resp.message.items) {
            $title = ($item.title -join " ")
            $doi = $item.DOI
            $journal = ($item.'container-title' -join " ")
            $pdfUrl = $null
            if ($item.link) {
                $p = $item.link | Where-Object { $_.'content-type' -match 'pdf' } | Select-Object -First 1 -ExpandProperty URL
                if ($p) { $pdfUrl = $p }
            }
            $moreCandidates += [PSCustomObject]@{
                Query = $q
                Title = $title
                DOI = $doi
                Journal = $journal
                URL = $item.URL
                PdfUrl = $pdfUrl
            }
        }
    } catch {
        Write-Host "Error querying $q : $_"
    }
    Start-Sleep -Milliseconds 800
}

$u = $moreCandidates | Sort-Object Title -Unique
$u | Select-Object Title, DOI, Journal, URL, PdfUrl | Format-List | Out-File "scratch/crossref_safety_candidates.txt" -Encoding utf8
Write-Host "Done. Found $($u.Count) safety papers."

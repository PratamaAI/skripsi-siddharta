$headers = @{ "User-Agent" = "AcademicResearchBot/1.0 (mailto:student@ukrida.ac.id)" }

function Search-Crossref {
    param([string]$query, [int]$rows = 15)
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($query) + "&rows=$rows&filter=type:journal-article"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        return $res.message.items
    } catch {
        Write-Host "Error: $_"
        return @()
    }
}

Write-Host "Searching 1: kepercayaan keamanan keputusan pembelian..."
$items1 = Search-Crossref "kepercayaan keamanan keputusan pembelian" 20

Write-Host "Searching 2: brand image keamanan keputusan pembelian..."
$items2 = Search-Crossref "brand image keamanan keputusan pembelian" 20

Write-Host "Searching 3: brand image brand trust keputusan pembelian..."
$items3 = Search-Crossref "brand image brand trust keputusan pembelian" 20

$all = @($items1) + @($items2) + @($items3)

$results = foreach ($it in $all) {
    if (-not $it.title) { continue }
    $t = $it.title[0]
    $doi = $it.DOI
    $container = if ($it.'container-title') { $it.'container-title'[0] } else { "" }
    $year = if ($it.issued.'date-parts') { $it.issued.'date-parts'[0][0] } else { "" }
    $author = if ($it.author) { $it.author[0].family } else { "" }
    
    # Check title relevance
    $tl = $t.ToLower()
    $hasY = ($tl -match "keputusan" -or $tl -match "purchase")
    $hasTrust = ($tl -match "kepercayaan" -or $tl -match "trust")
    $hasImage = ($tl -match "citra" -or $tl -match "image")
    $hasSafety = ($tl -match "keamanan" -or $tl -match "safety" -or $tl -match "risiko" -or $tl -match "risk")
    
    $matchesCount = 0
    if ($hasTrust) { $matchesCount++ }
    if ($hasImage) { $matchesCount++ }
    if ($hasSafety) { $matchesCount++ }
    
    if ($hasY -and $matchesCount -ge 2) {
        [PSCustomObject]@{
            Year = $year
            Author = $author
            Title = $t
            DOI = $doi
            Journal = $container
            HasImage = $hasImage
            HasTrust = $hasTrust
            HasSafety = $hasSafety
        }
    }
}

$unique = $results | Sort-Object DOI -Unique
Write-Host "Found $($unique.Count) candidates matching criteria!"
$unique | Select-Object Year, Author, Title, DOI, HasImage, HasTrust, HasSafety | Format-Table -AutoSize

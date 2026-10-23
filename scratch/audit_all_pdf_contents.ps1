$files = Get-ChildItem -Path "06_Referensi_Jurnal_PDF" -Recurse -Filter "*.pdf"
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    
    # Extract Title if in PDF metadata /Info
    $metaTitle = ""
    if ($text -match '/Title\s*\(([^)]+)\)') {
        $metaTitle = $matches[1]
    } elseif ($text -match '<dc:title>[\s\S]*?<rdf:li[^>]*>([^<]+)</rdf:li>') {
        $metaTitle = $matches[1]
    }
    
    # Check some keywords in text
    $hasInfluencer = $text -match 'influencer|endorse'
    $hasEWOM = $text -match 'word of mouth|word-of-mouth|ewom|e-wom'
    $hasEnjoyment = $text -match 'enjoyment|game|gaming|flow'
    $hasInvestor = $text -match 'investor|investment'
    $hasTPB = $text -match 'planned behavior|ajzen'
    $hasHedonic = $text -match 'hedonic'
    
    Write-Output "$($f.Name) | MetaTitle: $metaTitle | Inf: $hasInfluencer | eWOM: $hasEWOM | Enj: $hasEnjoyment | Inv: $hasInvestor | TPB: $hasTPB | Hed: $hasHedonic"
}

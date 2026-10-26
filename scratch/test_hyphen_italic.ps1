$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Layanan ride-hailing dan armada eco-friendly didasarkan pada riset Manurung et al. (2025) secara online."
    $p.Range.InsertParagraphAfter()
    
    $terms = @("ride-hailing", "eco-friendly", "et al.", "online")
    foreach ($term in $terms) {
        $find = $doc.Content.Find
        $find.ClearFormatting()
        $find.Replacement.ClearFormatting()
        $find.Text = $term
        $find.Replacement.Text = "^&"
        $find.Replacement.Font.Italic = 1
        $find.Forward = $true
        $find.Wrap = 1
        $find.MatchCase = $false
        $find.MatchWholeWord = $false
        $find.Execute($term, $false, $false, $false, $false, $false, $true, 1, $true, "^&", 2) | Out-Null
    }
    
    for ($w = 1; $w -le $doc.Words.Count; $w++) {
        $wo = $doc.Words.Item($w)
        if ($wo.Italic -eq 1 -or $wo.Italic -eq -1) {
            Write-Host ("Italic word: " + $wo.Text.Trim())
        }
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

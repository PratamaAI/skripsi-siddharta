$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Pengaruh Brand Image, Brand Trust dan Perceived Safety terhadap Purchase Decision Green SM."
    $p.Range.InsertParagraphAfter()
    
    # Test Find & Replace with Italic
    $terms = @("Brand Image", "Brand Trust", "Perceived Safety", "Purchase Decision", "Green SM")
    foreach ($term in $terms) {
        $find = $doc.Content.Find
        $find.ClearFormatting()
        $find.Replacement.ClearFormatting()
        $find.Text = $term
        $find.Replacement.Text = "^&" # ^& means find what text was matched
        $find.Replacement.Font.Italic = 1
        $find.Forward = $true
        $find.Wrap = 1 # wdFindContinue
        $find.MatchCase = $true
        $find.MatchWholeWord = $true
        # Execute(FindText, MatchCase, MatchWholeWord, MatchWildcards, MatchSoundsLike, MatchAllWordForms, Forward, Wrap, Format, ReplaceWith, Replace)
        # wdReplaceAll = 2
        $find.Execute($term, $true, $true, $false, $false, $false, $true, 1, $true, "^&", 2) | Out-Null
    }
    
    # Check if text became italic
    for ($w = 1; $w -le $doc.Words.Count; $w++) {
        $wordObj = $doc.Words.Item($w)
        if ($wordObj.Italic -eq 1 -or $wordObj.Italic -eq -1) {
            Write-Host ("Italic word: " + $wordObj.Text.Trim())
        }
    }
    Write-Host "Success testing Word Italic Find & Replace!"
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

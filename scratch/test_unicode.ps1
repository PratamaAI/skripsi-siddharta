$testChars = "n = [ Z² × P(1 – P) ] / d² | α = [ k / (k – 1) ] × [ 1 – (Σσb² / σt²) ] | Y = α + β₁X₁ + β₂X₂ + β₃X₃ + e | r_hitung > r_tabel | 0 ≤ R² ≤ 1 | 96,04 ≈ 100 responden"

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $p = $doc.Paragraphs.Add()
    $p.Range.Font.Name = "Times New Roman"
    $p.Range.Font.Size = 12
    $p.Range.Text = $testChars
    $p.Range.InsertParagraphAfter()
    
    $outPdf = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\test_unicode_math.pdf"
    $doc.ExportAsFixedFormat($outPdf, 17)
    Write-Host "Success! Created $outPdf with text length: $($p.Range.Text.Length)"
} finally {
    $doc.Close($false)
    $word.Quit()
}

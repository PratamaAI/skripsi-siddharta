$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    
    # Test 1: Clean typographic Unicode text
    $p1 = $doc.Paragraphs.Add()
    $p1.Range.Text = "Rumus Lemeshow:"
    $p1.Range.InsertParagraphAfter()
    
    $p2 = $doc.Paragraphs.Add()
    $p2.Alignment = 1 # Center
    $p2.Range.Text = "n = [ Z² · P(1 – P) ] / d²"
    $p2.Range.Font.Name = "Times New Roman"
    $p2.Range.Font.Size = 12
    $p2.Range.Font.Bold = 1
    $p2.Range.InsertParagraphAfter()
    
    # Test 2: OMaths build up
    $p3 = $doc.Paragraphs.Add()
    $p3.Range.Text = "n = (Z^2 \cdot P(1-P))/(d^2)"
    try {
        $om = $doc.OMaths.Add($p3.Range)
        $doc.OMaths.BuildUp()
        Write-Host "OMaths BuildUp succeeded!"
    } catch {
        Write-Host "OMaths failed: $($_.Exception.Message)"
    }
    
    $testPdf = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\test_math.pdf"
    $doc.ExportAsFixedFormat($testPdf, 17)
    Write-Host "Exported to $testPdf"
} finally {
    $doc.Close($false)
    $word.Quit()
}

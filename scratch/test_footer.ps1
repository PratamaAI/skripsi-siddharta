$ErrorActionPreference = "Stop"

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    
    # Section 1, Page 1: Cover
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Halaman Cover (i, hidden)"
    $p.Range.InsertParagraphAfter()
    
    # Section 1, Page 2: Approval
    $doc.Paragraphs.Add().Range.InsertBreak(7) # 7 = wdPageBreak
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Lembar Persetujuan (ii)"
    $p.Range.InsertParagraphAfter()
    
    # Section 1, Page 3: TOC
    $doc.Paragraphs.Add().Range.InsertBreak(7) # 7 = wdPageBreak
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Daftar Isi (iii)"
    $p.Range.InsertParagraphAfter()
    
    # Section break next page: 2 = wdSectionBreakNextPage
    $pBreak = $doc.Paragraphs.Add()
    $pBreak.Range.InsertBreak(2)
    
    # Section 2, Page 1: Bab I
    $p2 = $doc.Paragraphs.Add()
    $p2.Range.Text = "Bab I Pendahuluan (1)"
    $p2.Range.InsertParagraphAfter()
    
    # Section 2, Page 2: Bab I lanjut
    $doc.Paragraphs.Add().Range.InsertBreak(7)
    $p3 = $doc.Paragraphs.Add()
    $p3.Range.Text = "Bab I Halaman 2"
    $p3.Range.InsertParagraphAfter()
    
    # Setup Section 1: Roman numerals, center bottom, DifferentFirstPage = true
    $sec1 = $doc.Sections.Item(1)
    $sec1.PageSetup.DifferentFirstPageHeaderFooter = $true
    
    $footer1 = $sec1.Footers.Item(1) # wdHeaderFooterPrimary
    $footer1.PageNumbers.RestartNumberingAtSection = $true
    $footer1.PageNumbers.StartingNumber = 1
    $footer1.PageNumbers.NumberStyle = 2 # 2 = wdPageNumberStyleLowercaseRoman
    
    $fRange1 = $footer1.Range
    $fRange1.ParagraphFormat.Alignment = 1 # Center
    $fRange1.Font.Name = "Times New Roman"
    $fRange1.Font.Size = 10
    $field1 = $footer1.Range.Fields.Add($fRange1, 33) # 33 = wdFieldPage
    
    # Setup Section 2: Arabic numbers, right bottom, Universitas Kristen Krida Wacana | [Page]
    $sec2 = $doc.Sections.Item(2)
    $sec2.PageSetup.DifferentFirstPageHeaderFooter = $false
    
    $footer2 = $sec2.Footers.Item(1)
    $footer2.LinkToPrevious = $false
    $footer2.PageNumbers.RestartNumberingAtSection = $true
    $footer2.PageNumbers.StartingNumber = 1
    $footer2.PageNumbers.NumberStyle = 0 # 0 = wdPageNumberStyleArabic
    
    $fRange2 = $footer2.Range
    $fRange2.Text = "Universitas Kristen Krida Wacana | "
    $fRange2.Font.Name = "Times New Roman"
    $fRange2.Font.Size = 10
    $fRange2.Font.Bold = 1
    $fRange2.ParagraphFormat.Alignment = 2 # 2 = wdAlignParagraphRight
    
    $fRange2.Collapse(0) # 0 = wdCollapseEnd
    $field2 = $footer2.Range.Fields.Add($fRange2, 33) # 33 = wdFieldPage
    
    $testDocx = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch\test_footer_out.docx"
    $doc.SaveAs([ref]$testDocx)
    Write-Host "Success full multi-section test! Saved to $testDocx"
}
finally {
    $doc.Close([ref]$false)
    $word.Quit()
}

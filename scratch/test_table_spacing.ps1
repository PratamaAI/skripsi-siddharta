$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $p1 = $doc.Paragraphs.Add()
    $p1.Range.Text = "Tabel 2.1 Judul Tabel"
    $p1.Range.InsertParagraphAfter()
    
    $end = $doc.Content.End - 1
    $rng = $doc.Range($end, $end)
    $tbl = $doc.Tables.Add($rng, 2, 2)
    $tbl.Cell(1,1).Range.Text = "Col 1"
    $tbl.Cell(1,2).Range.Text = "Col 2"
    $tbl.Cell(2,1).Range.Text = "Val 1"
    $tbl.Cell(2,2).Range.Text = "Val 2"
    
    # Check paragraph after table
    Write-Host "Paragraphs count before adding source:" $doc.Paragraphs.Count
    
    # Try adding source paragraph
    $pSrc = $doc.Paragraphs.Add()
    $pSrc.Range.Text = "Sumber: Data diolah oleh penulis (2026)"
    $pSrc.Range.Font.Size = 10
    $pSrc.Range.Font.Italic = 1
    $pSrc.Format.SpaceBefore = 2
    $pSrc.Format.SpaceAfter = 14
    $pSrc.Range.InsertParagraphAfter()
    
    Write-Host "Paragraphs count after adding source:" $doc.Paragraphs.Count
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $t = $doc.Paragraphs.Item($i).Range.Text -replace "`r", "\r" -replace "`a", "\a"
        Write-Host "P$i : $t"
    }
} finally {
    $doc.Close($false)
    $word.Quit()
}

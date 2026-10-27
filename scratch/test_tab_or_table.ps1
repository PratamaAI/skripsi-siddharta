$ErrorActionPreference = "Stop"
Stop-Process -Name WINWORD -Force -ErrorAction SilentlyContinue

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $doc = $word.Documents.Add()
    $doc.PageSetup.TopMargin = 4 * 28.3465
    $doc.PageSetup.BottomMargin = 3 * 28.3465
    $doc.PageSetup.LeftMargin = 4 * 28.3465
    $doc.PageSetup.RightMargin = 3 * 28.3465

    # Title
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "LEMBAR PERSETUJUAN PROPOSAL SKRIPSI"
    $p.Range.Font.Name = "Times New Roman"
    $p.Range.Font.Size = 14
    $p.Range.Font.Bold = 1
    $p.Alignment = 1
    $p.Range.ParagraphFormat.SpaceAfter = 24
    $p.Range.InsertParagraphAfter()

    # Borderless table for perfectly aligned colons
    $rng = $doc.Range($doc.Content.End - 1, $doc.Content.End - 1)
    $table = $doc.Tables.Add($rng, 6, 3)
    $table.Borders.Enable = 0
    $table.Range.Font.Name = "Times New Roman"
    $table.Range.Font.Size = 12
    $table.Range.ParagraphFormat.SpaceBefore = 0
    $table.Range.ParagraphFormat.SpaceAfter = 4
    $table.Range.ParagraphFormat.LineSpacingRule = 0 # single line spacing

    # Column widths (in points)
    # Total available text width = 14.0 cm = 396.85 pt
    $col1Width = 3.8 * 28.3465 # ~107.7 pt
    $col2Width = 0.4 * 28.3465 # ~11.3 pt
    $col3Width = 9.8 * 28.3465 # ~277.8 pt

    $table.Columns.Item(1).Width = $col1Width
    $table.Columns.Item(2).Width = $col2Width
    $table.Columns.Item(3).Width = $col3Width
    $table.Rows.LeftIndent = 0

    $data = @(
        @("Judul Proposal", ":", "Pengaruh Brand Image, Brand Trust dan Perceived Safety terhadap Purchase Decision dalam Penggunaan Jasa Taksi Green SM di Wilayah Jakarta Barat"),
        @("Nama Mahasiswa", ":", "Siddharta Pratama Budiono"),
        @("NIM", ":", "312023017"),
        @("Program Studi", ":", "S1 Manajemen"),
        @("Konsentrasi", ":", "Manajemen Pemasaran"),
        @("Fakultas", ":", "Ekonomi dan Bisnis")
    )

    for ($i = 0; $i -lt $data.Count; $i++) {
        $row = $i + 1
        $table.Cell($row, 1).Range.Text = $data[$i][0]
        $table.Cell($row, 2).Range.Text = $data[$i][1]
        $table.Cell($row, 3).Range.Text = $data[$i][2]

        $table.Cell($row, 1).Range.ParagraphFormat.Alignment = 0
        $table.Cell($row, 2).Range.ParagraphFormat.Alignment = 0
        $table.Cell($row, 3).Range.ParagraphFormat.Alignment = 0
    }

    # Format italics in Judul Proposal cell if needed
    $cellTitle = $table.Cell(1, 3).Range
    # Italicize foreign terms
    $terms = @("Brand Image", "Brand Trust", "Perceived Safety", "Purchase Decision", "Green SM")
    foreach ($term in $terms) {
        $find = $cellTitle.Find
        $find.ClearFormatting()
        $find.Replacement.ClearFormatting()
        $find.Text = $term
        $find.Replacement.Text = "^&"
        $find.Replacement.Font.Italic = 1
        $find.Forward = $true
        $find.Wrap = 0
        $find.MatchCase = $false
        $find.Execute($term, $false, $false, $false, $false, $false, $true, 0, $true, "^&", 2) | Out-Null
    }

    # Add approval statement
    $pAfter = $doc.Paragraphs.Add()
    $pAfter.Range.Text = "Proposal Skripsi ini telah diperiksa, disetujui, dan dinyatakan layak untuk diajukan dalam Seminar Proposal Skripsi Fakultas Ekonomi dan Bisnis Universitas Kristen Krida Wacana (UKRIDA)."
    $pAfter.Range.Font.Name = "Times New Roman"
    $pAfter.Range.Font.Size = 12
    $pAfter.Alignment = 3
    $pAfter.Range.ParagraphFormat.FirstLineIndent = 1.25 * 28.3465
    $pAfter.Range.ParagraphFormat.SpaceBefore = 18
    $pAfter.Range.ParagraphFormat.SpaceAfter = 36

    $outDocx = (Resolve-Path "scratch").Path + "\test_approval.docx"
    $outPdf  = (Resolve-Path "scratch").Path + "\test_approval.pdf"
    if (Test-Path $outDocx) { Remove-Item $outDocx -Force }
    if (Test-Path $outPdf)  { Remove-Item $outPdf -Force }

    $doc.SaveAs2($outDocx)
    $doc.ExportAsFixedFormat($outPdf, 17)
    Write-Host "Success! Created $outDocx and $outPdf"
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

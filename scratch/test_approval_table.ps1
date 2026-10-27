Write-Host "Step 1: Starting Word..."
$word = New-Object -ComObject Word.Application
$word.Visible = $false
Write-Host "Step 2: Word started. Adding doc..."
try {
    $doc = $word.Documents.Add()
    Write-Host "Step 3: Document added. Setting margins..."
    $doc.PageSetup.TopMargin = 4 * 28.3465
    $doc.PageSetup.BottomMargin = 3 * 28.3465
    $doc.PageSetup.LeftMargin = 4 * 28.3465
    $doc.PageSetup.RightMargin = 3 * 28.3465

    Write-Host "Step 4: Adding title..."
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "LEMBAR PERSETUJUAN PROPOSAL SKRIPSI"
    $p.Range.Font.Name = "Times New Roman"
    $p.Range.Font.Size = 14
    $p.Range.Font.Bold = 1
    $p.Alignment = 1
    $p.Range.ParagraphFormat.SpaceAfter = 24
    $p.Range.InsertParagraphAfter()

    Write-Host "Step 5: Adding table..."
    $rng = $doc.Range($doc.Content.End - 1, $doc.Content.End - 1)
    $table = $doc.Tables.Add($rng, 6, 3)
    Write-Host "Step 6: Table added. Setting properties..."
    $table.Borders.Enable = 0
    $table.Range.Font.Name = "Times New Roman"
    $table.Range.Font.Size = 12

    $col1Width = 3.6 * 28.3465
    $col2Width = 0.4 * 28.3465
    $col3Width = 10.0 * 28.3465

    $table.Columns.Item(1).Width = $col1Width
    $table.Columns.Item(2).Width = $col2Width
    $table.Columns.Item(3).Width = $col3Width

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
        $table.Cell($row, 2).Range.ParagraphFormat.Alignment = 1
        $table.Cell($row, 3).Range.ParagraphFormat.Alignment = 0
    }

    Write-Host "Step 7: Saving doc..."
    $testPath = Join-Path (Get-Location) "scratch\test_approval.docx"
    if (Test-Path $testPath) { Remove-Item $testPath -Force }
    $doc.SaveAs2($testPath)
    Write-Host "Saved test approval docx to $testPath"
} catch {
    Write-Host "ERROR: $_"
} finally {
    Write-Host "Closing..."
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
    Write-Host "Done!"
}

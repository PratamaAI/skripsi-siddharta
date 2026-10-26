$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $end = $doc.Content.End - 1
    $rng = $doc.Range($end, $end)
    
    # 3 rows, 3 cols
    $table = $doc.Tables.Add($rng, 3, 3)
    $table.Borders.Enable = 1
    $table.Range.Font.Name = "Times New Roman"
    $table.Range.Font.Size = 10
    
    # Header
    $headers = @("No", "Variabel", "Indikator")
    for ($c = 1; $c -le 3; $c++) {
        $cell = $table.Cell(1, $c)
        $cell.Range.Text = $headers[$c - 1]
        $cell.Range.Font.Bold = 1
    }
    
    # Data row 1
    $table.Cell(2, 1).Range.Text = "1"
    $table.Cell(2, 2).Range.Text = "Brand Image (X1)"
    $table.Cell(2, 2).Range.Font.Italic = 1
    $table.Cell(2, 3).Range.Text = "Corporate Image, User Image"
    
    # Data row 2
    $table.Cell(3, 1).Range.Text = "2"
    $table.Cell(3, 2).Range.Text = "Brand Trust (X2)"
    $table.Cell(3, 2).Range.Font.Italic = 1
    $table.Cell(3, 3).Range.Text = "Brand Reliability, Financial Integrity"
    
    $table.AutoFitBehavior(2) # wdAutoFitWindow = 2
    
    Write-Host ("Table created successfully with rows: " + $table.Rows.Count)
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

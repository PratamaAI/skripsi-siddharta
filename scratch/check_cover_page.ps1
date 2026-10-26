$word = New-Object -ComObject Word.Application
$word.Visible = $false
$docPath = [string](Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
$doc = $word.Documents.Open($docPath, $false, $true)

$pageCount = $doc.ComputeStatistics(2) # 2 = wdStatisticPages
Write-Host "Total pages in Word Document: $pageCount"

# Check page number of Lembar Persetujuan
$found = $doc.Content.Find.Execute("LEMBAR PERSETUJUAN PROPOSAL SKRIPSI")
if ($found) {
    $sel = $doc.Range($doc.Content.Find.Parent.Start, $doc.Content.Find.Parent.End)
    $pageNum = $sel.Information(3) # 3 = wdActiveEndPageNumber
    Write-Host "Page number of LEMBAR PERSETUJUAN: $pageNum"
}

# Check inline shapes on cover
Write-Host "Total inline shapes in document: $($doc.InlineShapes.Count)"
if ($doc.InlineShapes.Count -gt 0) {
    $shape = $doc.InlineShapes.Item(1)
    Write-Host "First inline shape: Width=$($shape.Width), Height=$($shape.Height)"
}

$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

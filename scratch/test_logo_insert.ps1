$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

$logoPath = [string](Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images\ukrida_pentagram.png").Path
Write-Host "Logo path: $logoPath"

$p = $doc.Paragraphs.Add()
$p.Alignment = 1 # Center
$p.Format.SpaceBefore = 0
$p.Format.SpaceAfter = 18
$shape = $p.Range.InlineShapes.AddPicture($logoPath, $false, $true)
$shape.Width = 3.2 * 28.3465
$shape.Height = 3.2 * 28.3465

Write-Host "Picture inserted: Width=$($shape.Width), Height=$($shape.Height)"

$testOut = "$((Get-Location).Path)\scratch\test_logo_cover.docx"
$doc.SaveAs2($testOut)
$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
Write-Host "Saved test document: $testOut"

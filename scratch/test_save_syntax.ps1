$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()
$p = $doc.Paragraphs.Add()
$p.Range.Text = "Hello World"
$testPath = "$((Get-Location).Path)\scratch\test_save.docx"
Write-Host "Saving to $testPath"
$doc.SaveAs2($testPath)
Write-Host "Saved!"
$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
Write-Host "File exists: $(Test-Path $testPath)"

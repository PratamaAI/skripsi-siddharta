$word = New-Object -ComObject Word.Application
$word.Visible = $false
$doc = $word.Documents.Add()

$p = $doc.Paragraphs.Add()
$p.Alignment = 1
$p.Format.SpaceBefore = 0
$p.Format.SpaceAfter = 18

$runs = @(
    @{ Text = "PENGARUH "; Bold = $true; Italic = $false },
    @{ Text = "BRAND IMAGE"; Bold = $true; Italic = $true },
    @{ Text = ", "; Bold = $true; Italic = $false },
    @{ Text = "BRAND TRUST"; Bold = $true; Italic = $true },
    @{ Text = " DAN "; Bold = $true; Italic = $false },
    @{ Text = "PERCEIVED SAFETY"; Bold = $true; Italic = $true },
    @{ Text = " TERHADAP "; Bold = $true; Italic = $false },
    @{ Text = "PURCHASE DECISION"; Bold = $true; Italic = $true },
    @{ Text = " DALAM PENGGUNAAN JASA TAKSI "; Bold = $true; Italic = $false },
    @{ Text = "GREEN SM"; Bold = $true; Italic = $true },
    @{ Text = " DI WILAYAH JAKARTA BARAT"; Bold = $true; Italic = $false }
)

foreach ($r in $runs) {
    $end = $p.Range.End - 1
    $rng = $doc.Range($end, $end)
    $rng.Text = $r.Text
    $rng.Font.Name = "Times New Roman"
    $rng.Font.Size = 14
    $rng.Font.Bold = [int]$r.Bold
    $rng.Font.Italic = [int]$r.Italic
}

$testPath = "$((Get-Location).Path)\scratch\test_runs_title.docx"
$doc.SaveAs2($testPath)
$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
Write-Host "Runs test succeeded: $testPath"

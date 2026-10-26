$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

$pdfPath = (Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf").Path
Write-Host "Opening PDF in Word: $pdfPath"
$doc = $word.Documents.Open($pdfPath, $false, $true)
$text = $doc.Content.Text

Write-Host "Total length: $($text.Length)"

# Look for theoretical sections
$lines = $text -split "`r?`n"
$found = @()
for ($i = 0; $i -lt $lines.Count; $i++) {
    $l = $lines[$i]
    if ($l -match "Citra Merek" -or $l -match "Kepercayaan" -or $l -match "Keamanan" -or $l -match "Keputusan Pengguna") {
        $snippet = ($lines[[Math]::Max(0, $i-1)..[Math]::Min($lines.Count-1, $i+3)] -join " ")
        if ($snippet.Length -gt 50 -and $snippet.Length -lt 400) {
            $found += $snippet
        }
    }
}

$found | Select-Object -First 6 | ForEach-Object { Write-Host "`n--- SNIPPET ---`n$_" }

$doc.Close($false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

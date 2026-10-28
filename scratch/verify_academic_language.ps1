$docxPath = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx"

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open($docxPath)
    Write-Host "Opened DOCX successfully."
    
    Write-Host "`n=== Section 2.4 Text in DOCX ==="
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $t = $p.Range.Text.Trim()
        if ($t -match 'Kerangka Pemikiran Konseptual' -and -not ($t -match '^Gambar')) {
            for ($j = $i; $j -le $i + 3; $j++) {
                Write-Host "P${j}: $($doc.Paragraphs.Item($j).Range.Text.Trim())"
            }
            break
        }
    }
    
    Write-Host "`n=== Section 3.5.5 Text in DOCX ==="
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $t = $p.Range.Text.Trim()
        if ($t -match 'Evaluasi Model dan Pengujian Hipotesis') {
            for ($j = $i; $j -le [Math]::Min($doc.Paragraphs.Count, $i + 15); $j++) {
                Write-Host "P${j}: $($doc.Paragraphs.Item($j).Range.Text.Trim())"
            }
            break
        }
    }
    
    Write-Host "`n=== Checking for any leftover informal keywords ==="
    $bad = @('arahan dosen', 'dosen pembimbing', 'ditiadakan', 'nyeleneh', '\frac', 'Z_')
    $foundBad = $false
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $t = $p.Range.Text.Trim()
        # Exclude approval page where dosen pembimbing is legitimate
        if ($i -gt 25) {
            foreach ($b in $bad) {
                if ($t.Contains($b)) {
                    Write-Host "WARNING in Para ${i}: Contains '$b' -> $t"
                    $foundBad = $true
                }
            }
        }
    }
    if (-not $foundBad) {
        Write-Host "SUCCESS: Clean! Zero informal keywords or LaTeX found in body text." -ForegroundColor Green
    }
} finally {
    $doc.Close($false)
    $word.Quit()
}

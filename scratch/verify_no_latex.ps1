$docxPath = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx"

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open($docxPath)
    Write-Host "Opened DOCX successfully. Paragraphs: $($doc.Paragraphs.Count)"
    
    # Check for any backslashes or latex keywords in the document
    $latexMatches = @()
    $keywords = @('\frac', '\cdot', '\alpha', '\beta', '\sigma', '\sum', '\sqrt', '\approx', 'Z_', 'r_{')
    
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $t = $p.Range.Text
        foreach ($kw in $keywords) {
            if ($t.Contains($kw)) {
                $latexMatches += "Para ${i}: contains '$kw' -> $($t.Trim())"
            }
        }
    }
    
    if ($latexMatches.Count -eq 0) {
        Write-Host "PERFECT! Zero LaTeX commands found in the entire document." -ForegroundColor Green
    } else {
        Write-Host "Found remaining LaTeX:" -ForegroundColor Red
        $latexMatches | ForEach-Object { Write-Host $_ }
    }
    
    # Print the sample size section paragraphs
    Write-Host "`n--- Sample Size Section (Lemeshow) in Word ---"
    $foundLemeshow = $false
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $t = $p.Range.Text.Trim()
        if ($t -match 'Lemeshow') {
            $foundLemeshow = $true
            for ($j = $i; $j -le [Math]::Min($doc.Paragraphs.Count, $i + 14); $j++) {
                $pj = $doc.Paragraphs.Item($j)
                Write-Host "P${j}: $($pj.Range.Text.Trim())"
            }
            break
        }
    }
} finally {
    $doc.Close($false)
    $word.Quit()
}

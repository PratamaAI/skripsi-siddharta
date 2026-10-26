$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open("c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx")
    
    # Find paragraph containing "Faktor ketiga yang sangat krusial"
    $found = $false
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $txt = $p.Range.Text
        if ($txt -match "Faktor ketiga yang sangat krusial") {
            $found = $true
            Write-Host ("Paragraph found at index " + $i + ":")
            $words = $p.Range.Words
            $italicList = @()
            $normalList = @()
            for ($w = 1; $w -le $words.Count; $w++) {
                $wo = $words.Item($w)
                $t = $wo.Text.Trim()
                if ($t -eq "") { continue }
                if ($wo.Italic -eq 1 -or $wo.Italic -eq -1) {
                    $italicList += $t
                } else {
                    $normalList += $t
                }
            }
            Write-Host ("Total Italic Words in this paragraph: " + $italicList.Count)
            Write-Host ("Italic Words: " + ($italicList -join ", "))
            Write-Host ("Total Normal/Tegak Words: " + $normalList.Count)
            Write-Host ("Sample Normal/Tegak Words: " + (($normalList | Select-Object -First 20) -join " "))
            break
        }
    }
    if (-not $found) {
        Write-Host "Target paragraph not found!"
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

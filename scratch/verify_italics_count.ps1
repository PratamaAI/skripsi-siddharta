$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open("c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx")
    
    Write-Host "Sample checking italicized phrases in docx..."
    $termsToCheck = @("Brand Image", "Brand Trust", "Perceived Safety", "Purchase Decision", "Green SM", "ride-hailing", "eco-friendly", "et al.")
    
    foreach ($term in $termsToCheck) {
        $find = $doc.Content.Find
        $find.ClearFormatting()
        $find.Text = $term
        $foundCount = 0
        $italicCount = 0
        while ($find.Execute()) {
            $foundCount++
            if ($find.Parent.Font.Italic -eq -1 -or $find.Parent.Font.Italic -eq 1) {
                $italicCount++
            }
        }
        Write-Host "Term '$term' -> Found: $foundCount | Italic: $italicCount"
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open("c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx")
    $text = $doc.Content.Text
    
    Write-Host "Total characters in DOCX: $($text.Length)"
    
    # Check Colline matches
    $collineMatches = [regex]::Matches($text, "Colline")
    Write-Host "Colline occurrences count: $($collineMatches.Count)"
    
    # Check Tecoalu matches
    $tecoaluMatches = [regex]::Matches($text, "Tecoalu")
    Write-Host "Tecoalu occurrences count: $($tecoaluMatches.Count)"
    
    # Check Saparso matches
    $saparsoMatches = [regex]::Matches($text, "Saparso")
    Write-Host "Saparso occurrences count: $($saparsoMatches.Count)"
    
    # Check Wahyoedi matches
    $wahyoediMatches = [regex]::Matches($text, "Wahyoedi")
    Write-Host "Wahyoedi occurrences count: $($wahyoediMatches.Count)"
    
    # Check section 2.1.6
    if ($text -match "2\.1\.6 [^\r\n]+") {
        Write-Host "Match for 2.1.6: $($matches[0])"
    }

} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

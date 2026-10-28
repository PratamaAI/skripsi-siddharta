$docxPath = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx"

$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Open($docxPath)
    Write-Host "Total Paragraphs in DOCX:" $doc.Paragraphs.Count
    Write-Host "Total Tables in DOCX:" $doc.Tables.Count
    
    # Check paragraphs containing "Sumber:"
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $txt = $p.Range.Text.Trim()
        if ($txt -match '^Sumber:') {
            $alignStr = switch ($p.Alignment) {
                0 { "Left" }
                1 { "Center" }
                2 { "Right" }
                3 { "Justify" }
                default { $p.Alignment }
            }
            Write-Host "Found at Para ${i}:"
            Write-Host "  Text      : $txt"
            Write-Host "  Font Size : $($p.Range.Font.Size)"
            Write-Host "  Italic    : $($p.Range.Font.Italic)"
            Write-Host "  Bold      :" $p.Range.Font.Bold
            Write-Host "  Alignment :" $alignStr
            Write-Host "  SpaceBefore:" $p.Format.SpaceBefore
            Write-Host "  SpaceAfter :" $p.Format.SpaceAfter
            Write-Host "-------------------------------------------"
        }
    }
} finally {
    $doc.Close($false)
    $word.Quit()
}

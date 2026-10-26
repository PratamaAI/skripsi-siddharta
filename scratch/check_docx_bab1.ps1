$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $docPath = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx"
    $doc = $word.Documents.Open($docPath)
    Write-Host ("Total Paragraphs: " + $doc.Paragraphs.Count)
    for ($i = 1; $i -le [Math]::Min(120, $doc.Paragraphs.Count); $i++) {
        $text = $doc.Paragraphs.Item($i).Range.Text.Trim()
        if ($text -match '^BAB|^[0-9]\.[0-9]|Batasan|Rumusan|Perumusan|Tujuan|Manfaat|Green SM') {
            Write-Host ("Para " + $i + " [" + $doc.Paragraphs.Item($i).Range.Information(3) + "]: " + $text)
        }
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

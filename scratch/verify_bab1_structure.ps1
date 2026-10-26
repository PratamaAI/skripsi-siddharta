$word = New-Object -ComObject Word.Application
$word.Visible = $false
$docPath = [string](Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
$doc = $word.Documents.Open($docPath, $false, $true)

Write-Host "Scanning paragraphs for BAB 1 headings..."
foreach ($p in $doc.Paragraphs) {
    $text = $p.Range.Text.Trim()
    if ($text -match '^(BAB I|1\.[0-9]|1\.[0-9]\.[0-9]|Identifikasi|Batasan|Perumusan|Tujuan|Manfaat)') {
        $page = $p.Range.Information(3)
        Write-Host "Page $page : $text"
    }
    if ($text -match '^BAB II') {
        break
    }
}

$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$docPath = [string](Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
$doc = $word.Documents.Open($docPath, $false, $true)

for ($i = 1; $i -le 15; $i++) {
    $p = $doc.Paragraphs.Item($i)
    $text = $p.Range.Text.Trim()
    $page = $p.Range.Information(3) # wdActiveEndPageNumber
    if ($text.Length -gt 40) { $text = $text.Substring(0, 40) + "..." }
    Write-Host "Para $i (Page $page): $text"
}

$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

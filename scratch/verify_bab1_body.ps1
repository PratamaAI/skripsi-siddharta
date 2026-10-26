$word = New-Object -ComObject Word.Application
$word.Visible = $false
$docPath = [string](Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
$doc = $word.Documents.Open($docPath, $false, $true)

Write-Host "Scanning body paragraphs for BAB I headings..."
$inBody = $false
foreach ($p in $doc.Paragraphs) {
    $text = $p.Range.Text.Trim()
    if ($text -eq "BAB I") {
        $inBody = $true
    }
    if ($inBody) {
        if ($text -match '^(BAB I|PENDAHULUAN|1\.[0-9]|1\.[0-9]\.[0-9])' -and -not ($text -match '\.{5,}')) {
            $page = $p.Range.Information(3)
            Write-Host "Page $page : $text"
        }
        if ($text -eq "BAB II" -and -not ($text -match '\.{5,}')) {
            break
        }
    }
}

$doc.Close([ref]$false)
$word.Quit()
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null

$ErrorActionPreference = "Stop"
Stop-Process -Name WINWORD -Force -ErrorAction SilentlyContinue

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $docxPath = (Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
    $doc = $word.Documents.Open($docxPath)
    
    $ps = $doc.PageSetup
    $topCm = [Math]::Round($ps.TopMargin / 28.3465, 2)
    $bottomCm = [Math]::Round($ps.BottomMargin / 28.3465, 2)
    $leftCm = [Math]::Round($ps.LeftMargin / 28.3465, 2)
    $rightCm = [Math]::Round($ps.RightMargin / 28.3465, 2)
    $widthCm = [Math]::Round($ps.PageWidth / 28.3465, 2)
    $heightCm = [Math]::Round($ps.PageHeight / 28.3465, 2)

    Write-Host "DOCX Actual Margin Verification:"
    Write-Host " - Left Margin   : $leftCm cm"
    Write-Host " - Right Margin  : $rightCm cm"
    Write-Host " - Top Margin    : $topCm cm"
    Write-Host " - Bottom Margin : $bottomCm cm"
    Write-Host " - Paper Size    : $widthCm cm x $heightCm cm (A4 standard: 21.0 x 29.7 cm)"

} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

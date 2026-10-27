$ErrorActionPreference = "Stop"
Stop-Process -Name WINWORD -Force -ErrorAction SilentlyContinue

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $docxPath = (Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
    $doc = $word.Documents.Open($docxPath)
    
    # Check page of Lembar Persetujuan
    $find = $doc.Range().Find
    $find.Text = "LEMBAR PERSETUJUAN PROPOSAL SKRIPSI"
    $find.Execute()
    $pPage = $find.Parent.Information(3) # 3 = wdActiveEndPageNumber
    Write-Host "LEMBAR PERSETUJUAN title is on page: $pPage"

    # Check page of Mengetahui
    $find2 = $doc.Range().Find
    $find2.Text = "Ketua Program Studi S1 Manajemen FEB UKRIDA"
    $find2.Execute()
    $sigPage = $find2.Parent.Information(3)
    Write-Host "Ketua Program Studi signature is on page: $sigPage"

    # Check page of DAFTAR ISI
    $find3 = $doc.Range().Find
    $find3.Text = "DAFTAR ISI"
    $find3.Execute()
    $tocPage = $find3.Parent.Information(3)
    Write-Host "DAFTAR ISI is on page: $tocPage"

} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

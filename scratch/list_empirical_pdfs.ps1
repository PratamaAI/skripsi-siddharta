$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"

$folders = Get-ChildItem -Directory $base
foreach ($f in $folders) {
    Write-Host "=================================================="
    Write-Host "FOLDER: $($f.Name)"
    Write-Host "=================================================="
    $files = Get-ChildItem $f.FullName -Filter "*.pdf"
    foreach ($file in $files) {
        Write-Host "  File: $($file.Name)"
        Write-Host "  Size: $($file.Length) bytes"
    }
}

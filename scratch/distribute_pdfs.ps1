$dup = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Untar_2025_Brand_Image_Purchase_Intention_EV.pdf"
if (Test-Path $dup) {
    Remove-Item $dup -Force
    Write-Host "Deleted duplicate file: $dup"
}
$hera = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf"
$destHera = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\02_X2_Brand_Trust\Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf"
if (Test-Path $hera) {
    Move-Item $hera $destHera -Force
    Write-Host "Moved Hera to 02_X2_Brand_Trust"
}
$wik = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\04_Kombinasi_Variabel_&_Y\Wikantara_2021_Brand_Image_Transportasi.pdf"
$destWik = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Wikantara_2021_Brand_Image_Transportasi.pdf"
if (Test-Path $wik) {
    Move-Item $wik $destWik -Force
    Write-Host "Moved Wikantara to 01_X1_Brand_Image"
}
Get-ChildItem -Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris" -Recurse -File | Select-Object Name, Length, @{N='Folder';E={$_.Directory.Name}} | Format-Table -AutoSize

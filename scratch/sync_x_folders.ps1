$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$kombinasi = Join-Path $base "04_Kombinasi_Variabel_&_Y"
$x2Dir = Join-Path $base "02_X2_Brand_Trust"
$x3Dir = Join-Path $base "03_X3_Perceived_Safety"

# Copy papers testing X2 to 02_X2_Brand_Trust
Copy-Item (Join-Path $kombinasi "EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf") $x2Dir -Force
Copy-Item (Join-Path $kombinasi "JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf") $x2Dir -Force
Copy-Item (Join-Path $kombinasi "IJSR_2025_Brand_Image_Trust_EV.pdf") $x2Dir -Force
Copy-Item (Join-Path $x3Dir "Patricia_2026_Keamanan_Kepercayaan_Keputusan.pdf") $x2Dir -Force

# Copy Stekom safety paper to 03_X3_Perceived_Safety
Copy-Item (Join-Path $kombinasi "Stekom_2024_Ride_Hailing_GrabCar_Keputusan_Penggunaan.pdf") $x3Dir -Force

# Print full inventory
Get-ChildItem -Directory $base | ForEach-Object {
    Write-Host "=================================================="
    Write-Host "FOLDER: $($_.Name)"
    Write-Host "=================================================="
    Get-ChildItem $_.FullName -Filter "*.pdf" | ForEach-Object { 
        Write-Host "  - $($_.Name) ($([math]::Round($_.Length/1KB, 1)) KB)" 
    }
}

$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$scratch = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\scratch"

$x1Dir = Join-Path $base "01_X1_Brand_Image"
$x2Dir = Join-Path $base "02_X2_Brand_Trust"
$x3Dir = Join-Path $base "03_X3_Perceived_Safety"
$kombDir = Join-Path $base "04_Kombinasi_Variabel_&_Y"

# Clean out old single-X PDFs that did not meet the 3X & 1Y (at least 2 matching X) criteria
# Namely: Manurung (only 1X, Y=Intention), Fitriana/Visioner (only 1X), Wikantara (only 1X), Undip_2020_Persepsi_Keamanan (only 1X), Undip_2020_Keputusan_Penggunaan_Taksi (only 1X), Stekom_2024 (only 1X)
$toRemove = @(
    "Manurung_2025_Brand_Image_Mobil_Listrik.pdf",
    "Visioner_2024_Brand_Image_InDrive_Transportasi.pdf",
    "Wikantara_2021_Brand_Image_Transportasi.pdf",
    "Undip_2020_Persepsi_Keamanan_Keputusan_Penggunaan.pdf",
    "Undip_2020_Keputusan_Penggunaan_Taksi.pdf",
    "Stekom_2024_Ride_Hailing_GrabCar_Keputusan_Penggunaan.pdf",
    "IJSR_2025_Brand_Image_Trust_EV.pdf"
)

foreach ($f in (Get-ChildItem -Recurse $base -Filter "*.pdf")) {
    if ($toRemove -contains $f.Name) {
        Remove-Item $f.FullName -Force
        Write-Host "Removed non-compliant: $($f.Name)"
    }
}

# Now place the newly downloaded 100% compliant 3X & 1Y PDFs into the relevant folders:

# 1. Wijaya & Pahar (2022) - Gojek: Citra Merek (X1), Kepercayaan Merek (X2), Keamanan (X3) -> Keputusan Pengguna (Y)
Copy-Item (Join-Path $scratch "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") (Join-Path $x1Dir "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") -Force
Copy-Item (Join-Path $scratch "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") (Join-Path $x2Dir "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") -Force
Copy-Item (Join-Path $scratch "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") (Join-Path $x3Dir "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") -Force
Copy-Item (Join-Path $scratch "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") (Join-Path $kombDir "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf") -Force

# 2. Asnawir & Simanjuntak (2024): Brand Image (X1), Brand Trust (X2), Perceived Risk (X3) -> Purchase Decision (Y)
Copy-Item (Join-Path $scratch "JIGE_Risk_Image_Trust.pdf") (Join-Path $x1Dir "Asnawir_2024_Brand_Image_Trust_Risk_Purchase_Decision.pdf") -Force
Copy-Item (Join-Path $scratch "JIGE_Risk_Image_Trust.pdf") (Join-Path $x2Dir "Asnawir_2024_Brand_Image_Trust_Risk_Purchase_Decision.pdf") -Force
Copy-Item (Join-Path $scratch "JIGE_Risk_Image_Trust.pdf") (Join-Path $x3Dir "Asnawir_2024_Brand_Image_Trust_Risk_Purchase_Decision.pdf") -Force
Copy-Item (Join-Path $scratch "JIGE_Risk_Image_Trust.pdf") (Join-Path $kombDir "Asnawir_2024_Brand_Image_Trust_Risk_Purchase_Decision.pdf") -Force

# 3. Vivi & Hikmah (2024): Kualitas Produk, Persepsi Keamanan (X3), Kepercayaan (X2) -> Keputusan Pembelian (Y)
Copy-Item (Join-Path $scratch "Scientia_Safety_Trust.pdf") (Join-Path $x2Dir "Vivi_2024_Keamanan_Kepercayaan_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Scientia_Safety_Trust.pdf") (Join-Path $x3Dir "Vivi_2024_Keamanan_Kepercayaan_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Scientia_Safety_Trust.pdf") (Join-Path $kombDir "Vivi_2024_Keamanan_Kepercayaan_Keputusan_Pembelian.pdf") -Force

# 4. Wulandari (2021): Kepercayaan (X2), Keamanan (X3), Persepsi Resiko -> Keputusan Pembelian (Y)
Copy-Item (Join-Path $scratch "Manajerial_Safety_Trust.pdf") (Join-Path $x2Dir "Wulandari_2021_Kepercayaan_Keamanan_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Manajerial_Safety_Trust.pdf") (Join-Path $x3Dir "Wulandari_2021_Kepercayaan_Keamanan_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Manajerial_Safety_Trust.pdf") (Join-Path $kombDir "Wulandari_2021_Kepercayaan_Keamanan_Keputusan_Pembelian.pdf") -Force

# 5. Patria & Susila (2023): Kualitas Layanan, Brand Image (X1), Brand Trust (X2) -> Keputusan Pembelian (Y)
Copy-Item (Join-Path $scratch "Patria_Image_Trust.pdf") (Join-Path $x1Dir "Patria_2023_Brand_Image_Trust_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Patria_Image_Trust.pdf") (Join-Path $x2Dir "Patria_2023_Brand_Image_Trust_Keputusan_Pembelian.pdf") -Force

# 6. Putri & Harti (2022): Brand Image (X1), Brand Ambassador, Kepercayaan (X2) -> Keputusan Pembelian (Y)
Copy-Item (Join-Path $scratch "Putri_Dimensi_Image_Trust.pdf") (Join-Path $x1Dir "Putri_2022_Brand_Image_Kepercayaan_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $scratch "Putri_Dimensi_Image_Trust.pdf") (Join-Path $x2Dir "Putri_2022_Brand_Image_Kepercayaan_Keputusan_Pembelian.pdf") -Force

# Ensure Nurlita, Hera, and Adha are in both X1 and X2 folders
# Hera (2023)
Copy-Item (Join-Path $x2Dir "Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf") (Join-Path $x1Dir "Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf") -Force
# Nurlita (2025)
Copy-Item (Join-Path $kombDir "EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf") (Join-Path $x1Dir "Nurlita_2025_Brand_Image_Trust_Keputusan_Pembelian.pdf") -Force
Copy-Item (Join-Path $kombDir "EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf") (Join-Path $x2Dir "Nurlita_2025_Brand_Image_Trust_Keputusan_Pembelian.pdf") -Force
# Adha (2025) - EV Purchase Decisions
Copy-Item (Join-Path $kombDir "JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf") (Join-Path $x1Dir "Adha_2025_Brand_Image_Trust_EV_Purchase.pdf") -Force
Copy-Item (Join-Path $kombDir "JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf") (Join-Path $x2Dir "Adha_2025_Brand_Image_Trust_EV_Purchase.pdf") -Force
# Patricia (2026) in X2 and X3
Copy-Item (Join-Path $x3Dir "Patricia_2026_Keamanan_Kepercayaan_Keputusan.pdf") (Join-Path $x2Dir "Patricia_2026_Keamanan_Kepercayaan_Keputusan.pdf") -Force

# Remove redundant names if needed
Remove-Item (Join-Path $kombDir "EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf") -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $kombDir "JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf") -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $x2Dir "EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf") -Force -ErrorAction SilentlyContinue
Remove-Item (Join-Path $x2Dir "JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf") -Force -ErrorAction SilentlyContinue

Write-Host "Synchronization completed successfully!"

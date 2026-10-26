$base = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$x1Dir = Join-Path $base "01_X1_Brand_Image"
$x2Dir = Join-Path $base "02_X2_Brand_Trust"
$x3Dir = Join-Path $base "03_X3_Perceived_Safety"
$sourceDir = "scratch\downloads_test"

# 1. Copy to X1 (3 files)
$x1Files = @(
    "Devananda_2023_Kepercayaan_Brand_Image_Keamanan_Keputusan.pdf",
    "Fadila_2025_Environmental_Awareness_Brand_Trust_Brand_Image_Keputusan.pdf",
    "Inggasari_2022_Brand_Image_Trust_Endorser_Keputusan.pdf"
)
foreach ($f in $x1Files) {
    Copy-Item (Join-Path $sourceDir $f) (Join-Path $x1Dir $f) -Force
    Write-Host "Copied to X1: $f"
}

# 2. Copy to X3 (5 files)
$x3Files = @(
    "Devananda_2023_Kepercayaan_Brand_Image_Keamanan_Keputusan.pdf",
    "Afendi_2026_Kepercayaan_Keamanan_Kemudahan_GrabFood_Keputusan.pdf",
    "Agustiningrum_2021_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf",
    "Ardialis_2023_Kepercayaan_Keamanan_Resiko_Keputusan.pdf",
    "Dahlia_2024_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf"
)
foreach ($f in $x3Files) {
    Copy-Item (Join-Path $sourceDir $f) (Join-Path $x3Dir $f) -Force
    Write-Host "Copied to X3: $f"
}

# 3. Copy to X2 (all 7 files because all test Kepercayaan/Trust!)
$x2Files = @(
    "Devananda_2023_Kepercayaan_Brand_Image_Keamanan_Keputusan.pdf",
    "Fadila_2025_Environmental_Awareness_Brand_Trust_Brand_Image_Keputusan.pdf",
    "Inggasari_2022_Brand_Image_Trust_Endorser_Keputusan.pdf",
    "Afendi_2026_Kepercayaan_Keamanan_Kemudahan_GrabFood_Keputusan.pdf",
    "Agustiningrum_2021_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf",
    "Ardialis_2023_Kepercayaan_Keamanan_Resiko_Keputusan.pdf",
    "Dahlia_2024_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf"
)
foreach ($f in $x2Files) {
    Copy-Item (Join-Path $sourceDir $f) (Join-Path $x2Dir $f) -Force
    Write-Host "Copied to X2: $f"
}

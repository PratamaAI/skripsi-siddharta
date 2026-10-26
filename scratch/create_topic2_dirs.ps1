$base = "TOPIK_2_TAKSI_GREEN_SM"
$folders = @(
    "$base\01_Naskah_Utama",
    "$base\02_Persiapan_Sidang",
    "$base\03_Instrumen_&_Data_Survei",
    "$base\04_Riset_&_Metodologi",
    "$base\05_Pedoman_&_Referensi",
    "$base\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image",
    "$base\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\02_X2_Brand_Trust",
    "$base\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\03_X3_Perceived_Safety",
    "$base\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\04_Kombinasi_Variabel_&_Y",
    "$base\06_Referensi_Jurnal_PDF\02_Karya_Dosen_FEB_UKRIDA",
    "$base\06_Referensi_Jurnal_PDF\03_Landasan_Teori_&_Metodologi",
    "$base\07_Review_&_Audit"
)
foreach ($f in $folders) {
    if (-not (Test-Path $f)) {
        New-Item -ItemType Directory -Path $f -Force | Out-Null
        Write-Host "Created: $f"
    } else {
        Write-Host "Exists: $f"
    }
}
Write-Host "Folder structure created successfully!" -ForegroundColor Green

Add-Type -AssemblyName System.IO.Compression.FileSystem

# Let's inspect some of the empirical papers using Word or iText or basic string extraction
$papers = @(
    "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf",
    "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image\Devananda_2023_Brand_Image_Trust_Purchase_Decision.pdf",
    "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\02_X2_Brand_Trust\Putri_2022_Brand_Image_Kepercayaan_Keputusan_Pembelian.pdf",
    "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\03_X3_Perceived_Safety\Vivi_2024_Keamanan_Kepercayaan_Keputusan_Pembelian.pdf"
)

foreach ($p in $papers) {
    if (Test-Path $p) {
        $name = [System.IO.Path]::GetFileName($p)
        Write-Host "Checking: $name"
        # Let's see if we can read strings from the PDF
        $bytes = [System.IO.File]::ReadAllBytes($p)
        $text = [System.Text.Encoding]::ASCII.GetString($bytes)
        # Search for occurrences of keywords
        $hasBI = $text -match "Brand Image|Citra Merek|citra merek"
        $hasBT = $text -match "Brand Trust|Kepercayaan Merek|kepercayaan"
        $hasPS = $text -match "Safety|Keamanan|keamanan"
        $hasKP = $text -match "Keputusan Pembelian|keputusan pembelian|Purchase Decision"
        Write-Host "  Citra Merek: $hasBI | Kepercayaan: $hasBT | Keamanan: $hasPS | Keputusan: $hasKP"
    }
}

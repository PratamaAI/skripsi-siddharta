Add-Type -AssemblyName System.IO.Compression.FileSystem

$pdfFiles = Get-ChildItem -Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris" -Recurse -File | Sort-Object Name -Unique

Write-Host "Checking definition content inside empirical journals..."

# Let's inspect text from a few key papers
$sample = @(
    "Wijaya_2022_Citra_Kepercayaan_Keamanan_Gojek.pdf",
    "Devananda_2023_Kepercayaan_Brand_Image_Keamanan_Keputusan.pdf",
    "Nurlita_2025_Brand_Image_Trust_Keputusan_Pembelian.pdf",
    "Vivi_2024_Keamanan_Kepercayaan_Keputusan_Pembelian.pdf"
)

foreach ($s in $sample) {
    $f = $pdfFiles | Where-Object { $_.Name -eq $s } | Select-Object -First 1
    if ($f) {
        Write-Host "Found file: $($f.FullName)"
    }
}

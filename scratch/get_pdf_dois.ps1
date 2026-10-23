Add-Type -AssemblyName System.IO.Compression.FileSystem

function Get-PdfFirstPageText($pdfPath) {
    # Simple regex extraction of text chunks from uncompressed or stream parts
    $bytes = [System.IO.File]::ReadAllBytes($pdfPath)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    return $text.Substring(0, [Math]::Min(3000, $text.Length))
}

$pdf1 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf"
$pdf2 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2024_Ahmad_Influencer_GenZ_ICGMSI.pdf"
$pdf3 = "06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2025_Asmawati_Influencer_GenZ_IIJSE.pdf"

Write-Output "=== Reading Martiningsih ==="
# Let's search for DOI pattern in Martiningsih
$content1 = [System.IO.File]::ReadAllText($pdf1)
if ($content1 -match '10\.2991/[^\s>\)]+') {
    Write-Output "Martiningsih DOI: $($matches[0])"
}
if ($content1 -match 'Title|title') {
    Write-Output "Found Title keyword"
}

# Let's also check Ahmad
Write-Output "=== Reading Ahmad ==="
$content2 = [System.IO.File]::ReadAllText($pdf2)
if ($content2 -match '10\.2991/[^\s>\)]+') {
    Write-Output "Ahmad DOI: $($matches[0])"
}

# Let's check Asmawati
Write-Output "=== Reading Asmawati ==="
$content3 = [System.IO.File]::ReadAllText($pdf3)
if ($content3 -match 'doi|DOI') {
    Write-Output "Found DOI in Asmawati"
}

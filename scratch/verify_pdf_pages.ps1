$pdfPath = "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfPath)
$magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
Write-Host "PDF Magic: $magic"
Write-Host "PDF File Size: $($bytes.Length) bytes"

# Find page count in PDF stream
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
$matches = [regex]::Matches($text, "/Type\s*/Page[^s]")
Write-Host "Total Estimated Pages in PDF: $($matches.Count)"

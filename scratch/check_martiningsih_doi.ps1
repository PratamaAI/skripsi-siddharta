$bytes = [System.IO.File]::ReadAllBytes("06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf")
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
if ($text -match '10\.2991/[0-9a-z\._\-]+') {
    Write-Output "Martiningsih DOI: $($matches[0])"
}

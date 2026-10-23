$bytes = [System.IO.File]::ReadAllBytes("06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf")
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
Write-Output "Header: $($text.Substring(0, 8))"
if ($text -match 'The Impact of Influencers.*Credibility') {
    Write-Output "SUCCESS: Title matched!"
}
if ($text -match 'Martiningsih') {
    Write-Output "SUCCESS: Author matched!"
}

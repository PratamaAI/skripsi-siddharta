$bytes = [System.IO.File]::ReadAllBytes("06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2024_Ahmad_Influencer_GenZ_ICGMSI.pdf")
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
# find words like Abstract, Influencer, Architectural
if ($text -match 'Architecture|Bio-Safety') {
    Write-Output "WARNING: Contains Architecture / Bio-Safety!"
}
if ($text -match 'Influencer|influencer') {
    Write-Output "Contains Influencer"
}

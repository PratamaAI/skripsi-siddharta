$bytes = [System.IO.File]::ReadAllBytes("06_Referensi_Jurnal_PDF\01_Empiris_Utama_2021-2025\2025_Asmawati_Influencer_GenZ_IIJSE.pdf")
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
Write-Output "Asmawati Length: $($bytes.Length)"
if ($text -match 'Asmawati|Wisnalmawati|Influencer|Purchase Intention') {
    Write-Output "Asmawati matched keywords!"
}

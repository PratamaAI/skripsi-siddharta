$file = "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Primanomics_Keputusan_Pembelian.pdf"
$stream = [System.IO.File]::OpenRead($file)
$bytes = New-Object byte[] 2000
$stream.Read($bytes, 0, 2000) | Out-Null
$stream.Close()
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
Write-Host "Content snippet:"
Write-Host $text.Substring(0, [Math]::Min(1000, $text.Length))

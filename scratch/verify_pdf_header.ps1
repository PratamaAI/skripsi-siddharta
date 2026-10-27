$file = "TOPIK_2_TAKSI_GREEN_SM/06_Referensi_Jurnal_PDF/02_Karya_Dosen_FEB_UKRIDA/S-FEB_2021_Tecoalu_Saparso_Fernandes_SIASAT.pdf"
$stream = [System.IO.File]::OpenRead($file)
$bytes = New-Object byte[] 400
$read = $stream.Read($bytes, 0, 400)
$stream.Close()
$text = [System.Text.Encoding]::ASCII.GetString($bytes)
Write-Host "Header: $text"

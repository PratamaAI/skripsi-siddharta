$pdfBytes = [System.IO.File]::ReadAllBytes("01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ.pdf")
$pdfStr = [System.Text.Encoding]::ASCII.GetString($pdfBytes)
Write-Output ("Contains 'wajib dikunci': " + $pdfStr.Contains("wajib dikunci"))
Write-Output ("Contains 'Perangkat lunak': " + $pdfStr.Contains("Perangkat lunak"))

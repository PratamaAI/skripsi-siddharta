$pdfBytes = [System.IO.File]::ReadAllBytes("01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ.pdf")
$pdfStr = [System.Text.Encoding]::ASCII.GetString($pdfBytes)
$idx = 0
while (($idx = $pdfStr.IndexOf("P04", $idx)) -ge 0) {
    $start = [Math]::Max(0, $idx - 50)
    $len = [Math]::Min($pdfStr.Length - $start, 120)
    Write-Output ("Match at " + $idx + ": " + $pdfStr.Substring($start, $len).Replace("`n", " ").Replace("`r", " "))
    $idx += 3
}

$content = Get-Content "01_Naskah_Utama\DAFTAR_PUSTAKA_SEMENTARA.md" -Raw
$matches = [regex]::Matches($content, '`06_Referensi_Jurnal_PDF/([^`]+)`')
$missing = @()
$found = 0
foreach ($m in $matches) {
    $rel = $m.Groups[1].Value.Replace('/', '\')
    $full = Join-Path "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\06_Referensi_Jurnal_PDF" $rel
    if (Test-Path $full) {
        $found++
    } else {
        $missing += $full
    }
}
Write-Output "Checked DAFTAR_PUSTAKA: Found $found paths, Missing $($missing.Count)"
if ($missing.Count -gt 0) {
    $missing | ForEach-Object { Write-Output "MISSING: $_" }
}

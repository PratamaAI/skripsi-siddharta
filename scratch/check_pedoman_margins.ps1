$path = "TOPIK_2_TAKSI_GREEN_SM\05_Pedoman_&_Referensi\Buku Pedoman Penyusunan Tugas Akhir 2023.md"
$lines = Get-Content $path
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match "margin|batas|kiri|kanan|atas|bawah|4 cm|3 cm|4cm|3cm|spasi") {
        Write-Host "Line $($i+1): $line"
    }
}

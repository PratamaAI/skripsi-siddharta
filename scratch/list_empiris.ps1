$files = Get-ChildItem -Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris" -Recurse -File
foreach ($f in $files) {
    [PSCustomObject]@{
        SubFolder = $f.Directory.Name
        Name = $f.Name
        SizeKB = [math]::Round($f.Length / 1KB, 1)
    } | Format-Table -AutoSize
}

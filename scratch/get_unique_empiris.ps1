$files = Get-ChildItem -Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris" -Recurse -File
$uniqueFiles = $files | Sort-Object Name -Unique
$res = foreach ($u in $uniqueFiles) {
    [PSCustomObject]@{
        Name = $u.Name
        Length = $u.Length
        Path = $u.FullName
    }
}
$res | Format-Table -AutoSize

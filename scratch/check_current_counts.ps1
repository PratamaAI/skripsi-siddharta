$dirs = Get-ChildItem -Path "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris" -Directory
foreach ($d in $dirs) {
    $files = Get-ChildItem -Path $d.FullName -File
    [PSCustomObject]@{
        Folder = $d.Name
        Count = $files.Count
        Files = ($files.Name -join ", ")
    } | Format-List
}

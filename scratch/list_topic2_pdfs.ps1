Get-ChildItem -Recurse "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF" -File | 
    Select-Object Name, Length, @{N="Folder";E={$_.Directory.Name}} | 
    Format-Table -Wrap

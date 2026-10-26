$base = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$allPdfs = Get-ChildItem -Path $base -Recurse -File
$unique = $allPdfs | Sort-Object Name -Unique

$table = foreach ($f in $unique) {
    [PSCustomObject]@{
        Name = $f.Name
        SizeKB = [math]::Round($f.Length / 1KB, 1)
        In_X1 = (Test-Path (Join-Path $base "01_X1_Brand_Image\$($f.Name)"))
        In_X2 = (Test-Path (Join-Path $base "02_X2_Brand_Trust\$($f.Name)"))
        In_X3 = (Test-Path (Join-Path $base "03_X3_Perceived_Safety\$($f.Name)"))
    }
}

$table | Format-Table -AutoSize

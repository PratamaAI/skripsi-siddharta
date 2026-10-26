$base = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$dup = Join-Path $base "Untar_2025_Brand_Image_Purchase_Intention_EV.pdf"
if (Test-Path $dup) {
    Remove-Item $dup -Force
    Write-Host "Removed duplicate: $dup"
}

# Ensure subfolders exist
$fX1 = Join-Path $base "01_X1_Brand_Image"
$fX2 = Join-Path $base "02_X2_Brand_Trust"
$fX3 = Join-Path $base "03_X3_Perceived_Safety"
$fKomb = Join-Path $base "04_Kombinasi_Variabel_&_Y"

New-Item -ItemType Directory -Path $fX1 -Force | Out-Null
New-Item -ItemType Directory -Path $fX2 -Force | Out-Null
New-Item -ItemType Directory -Path $fX3 -Force | Out-Null
New-Item -ItemType Directory -Path $fKomb -Force | Out-Null

# Move any loose files in root $base
Get-ChildItem -Path $base -File | ForEach-Object {
    if ($_.Name -match 'Manurung|Visioner|Wikantara') {
        Move-Item $_.FullName $fX1 -Force
        Write-Host "Moved $($_.Name) to 01_X1_Brand_Image"
    } elseif ($_.Name -match 'Undip_2020_Persepsi_Keamanan') {
        Move-Item $_.FullName $fX3 -Force
        Write-Host "Moved $($_.Name) to 03_X3_Perceived_Safety"
    } else {
        Move-Item $_.FullName $fKomb -Force
        Write-Host "Moved $($_.Name) to 04_Kombinasi_Variabel_&_Y"
    }
}

Write-Host "=== Current Files in 01_Penelitian_Terdahulu_Empiris ==="
Get-ChildItem -Path $base -Recurse -File | Select-Object Name, Length, @{N='Folder';E={$_.Directory.Name}} | Format-Table -AutoSize

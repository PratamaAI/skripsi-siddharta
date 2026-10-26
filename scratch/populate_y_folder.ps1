$base = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$yDir = Join-Path $base "04_Y_Purchase_Decision"

if (-not (Test-Path $yDir)) {
    New-Item -ItemType Directory -Path $yDir | Out-Null
    Write-Host "Created directory: $yDir"
}

# Get all unique files from X1, X2, X3
$allPdfs = Get-ChildItem -Path $base -Recurse -File | Where-Object { $_.DirectoryName -ne $yDir }
$uniqueFiles = $allPdfs | Sort-Object Name -Unique

foreach ($f in $uniqueFiles) {
    $dest = Join-Path $yDir $f.Name
    Copy-Item $f.FullName $dest -Force
    Write-Host "Copied to Y folder: $($f.Name)"
}

$yFiles = Get-ChildItem -Path $yDir -File
Write-Host "Total files in 04_Y_Purchase_Decision: $($yFiles.Count)"

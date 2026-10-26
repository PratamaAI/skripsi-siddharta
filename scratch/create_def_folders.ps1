$destDir = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\04_Pengertian_&_Teori_Variabel"
if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir | Out-Null }

$x1Dir = Join-Path $destDir "01_Definisi_X1_Brand_Image"
$x2Dir = Join-Path $destDir "02_Definisi_X2_Brand_Trust"
$x3Dir = Join-Path $destDir "03_Definisi_X3_Perceived_Safety"
$yDir  = Join-Path $destDir "04_Definisi_Y_Purchase_Decision"

New-Item -ItemType Directory -Path $x1Dir -Force | Out-Null
New-Item -ItemType Directory -Path $x2Dir -Force | Out-Null
New-Item -ItemType Directory -Path $x3Dir -Force | Out-Null
New-Item -ItemType Directory -Path $yDir -Force | Out-Null

Write-Host "Created subfolders for each variable definition successfully!"

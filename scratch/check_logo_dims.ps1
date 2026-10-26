Add-Type -AssemblyName System.Drawing

$img1 = [System.Drawing.Image]::FromFile("TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images\ukrida_pentagram.png")
Write-Host "ukrida_pentagram.png: Width=$($img1.Width), Height=$($img1.Height)"
$img1.Dispose()

$img2 = [System.Drawing.Image]::FromFile("TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images\Logo_UKRIDA_300x300.png")
Write-Host "Logo_UKRIDA_300x300.png: Width=$($img2.Width), Height=$($img2.Height)"
$img2.Dispose()

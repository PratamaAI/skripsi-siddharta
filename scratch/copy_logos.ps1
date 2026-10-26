$dest = "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\images"
New-Item -ItemType Directory -Path $dest -Force | Out-Null
Copy-Item "01_Naskah_Utama\images\*ukrida*" $dest -Force
Copy-Item "01_Naskah_Utama\images\*Logo_UKRIDA*" $dest -Force
Get-ChildItem -Path $dest | Select-Object Name, Length

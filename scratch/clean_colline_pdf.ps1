$p = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\02_Karya_Dosen_FEB_UKRIDA"
Get-ChildItem -Path $p -Filter "S-FEB_2024_Colline*.pdf" | Remove-Item -Force
Get-ChildItem -Path $p | Select-Object Name, Length

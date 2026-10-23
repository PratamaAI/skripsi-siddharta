$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\06_Referensi_Jurnal_PDF"
$dirs = Get-ChildItem -Path $base -Directory -Recurse
foreach ($d in $dirs) {
    $count = (Get-ChildItem -Path $d.FullName -Filter "*.pdf").Count
    Write-Output "[$count PDFs] $($d.FullName.Replace($base, ''))"
}

$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\06_Referensi_Jurnal_PDF"
$subfolders = @(
    "01_Penelitian_Terdahulu_Empiris\01_X1_Influencer_Marketing",
    "01_Penelitian_Terdahulu_Empiris\02_X2_Electronic_Word_of_Mouth",
    "01_Penelitian_Terdahulu_Empiris\03_X3_Perceived_Enjoyment",
    "01_Penelitian_Terdahulu_Empiris\04_Y_Continuance_Intention",
    "02_Karya_Dosen_FEB_UKRIDA",
    "03_Landasan_Teori_&_Metodologi"
)

$allFiles = @()
foreach ($sf in $subfolders) {
    $p = Join-Path $base $sf
    $files = Get-ChildItem -Path $p -Filter "*.pdf"
    foreach ($f in $files) {
        $stream = [System.IO.File]::OpenRead($f.FullName)
        $bytes = New-Object byte[] 5
        $null = $stream.Read($bytes, 0, 5)
        $stream.Close()
        $header = [System.Text.Encoding]::ASCII.GetString($bytes)
        $hash = (Get-FileHash -Path $f.FullName -Algorithm SHA256).Hash
        
        $allFiles += [PSCustomObject]@{
            Folder = $sf
            Name = $f.Name
            Size = $f.Length
            Header = $header
            SHA256 = $hash
        }
    }
}

Write-Output "Total verified files in new organized structure: $($allFiles.Count)"
$allFiles | Format-Table Folder, Name, Size, Header -AutoSize

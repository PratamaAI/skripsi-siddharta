$files = Get-ChildItem -Path "06_Referensi_Jurnal_PDF" -Recurse -Filter "*.pdf"
foreach ($f in $files) {
    $stream = [System.IO.File]::OpenRead($f.FullName)
    $bytes = New-Object byte[] 8
    $null = $stream.Read($bytes, 0, 8)
    $stream.Close()
    $header = [System.Text.Encoding]::ASCII.GetString($bytes)
    $hash = (Get-FileHash -Path $f.FullName -Algorithm SHA256).Hash
    Write-Output "$($f.Name) | $($f.Length) | $header | $hash"
}

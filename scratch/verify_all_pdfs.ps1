$files = Get-ChildItem -Path "06_Referensi_Jurnal_PDF" -Recurse -Filter "*.pdf"
$results = @()

foreach ($f in $files) {
    $stream = [System.IO.File]::OpenRead($f.FullName)
    $bytes = New-Object byte[] 5
    $null = $stream.Read($bytes, 0, 5)
    $stream.Close()
    $header = [System.Text.Encoding]::ASCII.GetString($bytes)
    $hash = (Get-FileHash -Path $f.FullName -Algorithm SHA256).Hash
    
    $results += [PSCustomObject]@{
        Name = $f.Name
        Folder = $f.Directory.Name
        Length = $f.Length
        Header = $header
        SHA256 = $hash
        Valid = ($header -match '^%PDF-') -and ($f.Length -gt 20000)
    }
}

$results | Format-Table -AutoSize
$invalid = $results | Where-Object { -not $_.Valid }
Write-Output "`nInvalid count: $($invalid.Count)"

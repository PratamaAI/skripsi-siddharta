$items = Get-ChildItem -Path "scratch\downloads_test" -File
foreach ($it in $items) {
    $hdr = Get-Content -Path $it.FullName -TotalCount 1
    [PSCustomObject]@{
        Name = $it.Name
        SizeKB = [math]::Round($it.Length / 1KB, 1)
        IsPDF = $hdr.StartsWith("%PDF")
        Header = $hdr
    } | Format-Table -AutoSize
}

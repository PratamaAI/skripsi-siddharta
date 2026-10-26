try {
    $word = New-Object -ComObject Word.Application
    Write-Host "Word COM Available: Version $($word.Version)"
    $word.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
} catch {
    Write-Host "Word COM not available: $($_.Exception.Message)"
}

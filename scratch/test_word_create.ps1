try {
    $word = New-Object -ComObject Word.Application
    Write-Output ("Word COM created successfully. Version: " + $word.Version)
    $word.Quit()
} catch {
    Write-Output ("Create COM error: " + $_.Exception.Message)
}

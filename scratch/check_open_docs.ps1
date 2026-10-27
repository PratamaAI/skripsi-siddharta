try {
    $word = [System.Runtime.InteropServices.Marshal]::GetActiveObject("Word.Application")
    Write-Host "Word is running! Open documents:"
    foreach ($d in $word.Documents) {
        Write-Host " - " $d.Name
    }
} catch {
    Write-Host "Could not get active Word object: $_"
}

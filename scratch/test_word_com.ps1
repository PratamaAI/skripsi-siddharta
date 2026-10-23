try {
    $word = [System.Runtime.InteropServices.Marshal]::GetActiveObject("Word.Application")
    Write-Output ("Word Active: " + $word.Documents.Count + " documents open")
    for ($i=1; $i -le $word.Documents.Count; $i++) {
        Write-Output ("Doc: " + $word.Documents.Item($i).FullName)
    }
} catch {
    Write-Output ("GetActiveObject error: " + $_.Exception.Message)
}

$headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }
try {
    $res = Invoke-RestMethod -Uri "https://api-frontend.kemdikbud.go.id/hit/Bernardus%20Wishman" -Headers $headers -TimeoutSec 15
    $res.dosen | ForEach-Object {
        Write-Host "Text: " $_.text
        Write-Host "Website Link: " $_."website-link"
    }
} catch {
    Write-Host "PDDIKTI hit failed: $_"
}

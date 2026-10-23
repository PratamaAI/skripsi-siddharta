$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$url = "https://indojurnal.com/index.php/jejakdigital/article/view/2294"
$res = Invoke-WebRequest -Uri $url -Headers $headers
$pdfLink = $res.Links | Where-Object { $_.href -match 'download|pdf' } | Select-Object -First 1 -ExpandProperty href
Write-Host "Found PDF link: $pdfLink"

if ($pdfLink) {
    $out = "scratch/alfatiy_2026_mobile_game_ci.pdf"
    Invoke-WebRequest -Uri $pdfLink -OutFile $out -Headers $headers
    $bytes = [System.IO.File]::ReadAllBytes($out)
    $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
    Write-Host "Success: Magic=$magic, Size=$($bytes.Length) bytes" -ForegroundColor Green
}

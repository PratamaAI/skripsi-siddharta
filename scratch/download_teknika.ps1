$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$url = "https://ejournal.ikado.ac.id/index.php/teknika/article/download/1163/392"
$out = "scratch/teknika_1163.pdf"
Invoke-WebRequest -Uri $url -OutFile $out -Headers $headers
$bytes = [System.IO.File]::ReadAllBytes($out)
$magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
Write-Host "Magic: $magic, Size: $($bytes.Length)"

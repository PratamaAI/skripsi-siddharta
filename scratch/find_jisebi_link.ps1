$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}
$res = Invoke-WebRequest -Uri 'https://e-journal.unair.ac.id/JISEBI/article/view/9375' -Headers $headers
$res.Links | Where-Object { $_.href -match 'download|pdf' } | ForEach-Object { $_.href }

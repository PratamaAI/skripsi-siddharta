$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Download-And-Verify($url, $outfile) {
    Write-Host "Downloading $url to $outfile" -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $url -OutFile $outfile -Headers $headers -TimeoutSec 30
        $bytes = [System.IO.File]::ReadAllBytes($outfile)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        Write-Host "SUCCESS: Magic=$magic, Size=$($bytes.Length) bytes" -ForegroundColor Green
    } catch {
        Write-Host "FAILED: $_" -ForegroundColor Red
    }
}

Download-And-Verify "https://www.frontiersin.org/articles/10.3389/fpsyg.2023.1073301/pdf" "scratch/lin_2023_stream_ci.pdf"
Download-And-Verify "https://downloads.hindawi.com/journals/hbet/2022/3684192.pdf" "scratch/influencer_ci_2022.pdf"
Download-And-Verify "https://www.richtmann.org/journal/index.php/mjss/article/download/1597/1606" "scratch/merhi_2013_mobile_ci.pdf"

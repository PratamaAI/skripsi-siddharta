$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Download-PDF($url, $file) {
    Write-Host "Downloading $url to $file" -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $url -OutFile $file -Headers $headers -TimeoutSec 30
        $bytes = [System.IO.File]::ReadAllBytes($file)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        Write-Host "Success: Magic=$magic, Size=$($bytes.Length)" -ForegroundColor Green
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

# 1. Unair JISEBI - Multiplayer Video Games Continuance Intention
Download-PDF "https://e-journal.unair.ac.id/JISEBI/article/download/9375/5732" "scratch/jisebi_unair_9375.pdf"

# 2. MDPI - Streaming Continuance Intention
Download-PDF "https://www.mdpi.com/2076-328X/12/5/124/pdf" "scratch/mdpi_stream_ci.pdf"

# 3. ScienceDirect - Gacha gaming intention
Download-PDF "https://api.elsevier.com/content/article/pii/S2451958824000381?httpAccept=application/pdf" "scratch/elsevier_gacha.pdf"

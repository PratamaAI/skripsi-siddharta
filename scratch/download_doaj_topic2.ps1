$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Download-PDF($url, $file) {
    Write-Host "Downloading $url to $file" -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $url -OutFile $file -Headers $headers -TimeoutSec 25
        $bytes = [System.IO.File]::ReadAllBytes($file)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        Write-Host "Success: Magic=$magic, Size=$($bytes.Length) bytes" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
        return $false
    }
}

$dest = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"

# 1. Maksipreneur - Brand Image, Brand Trust, Purchase Decision
$res1 = Invoke-WebRequest -Uri "https://ejournal.up45.ac.id/index.php/maksipreneur/article/view/2672" -Headers $headers
$link1 = $res1.Links | Where-Object { $_.href -match 'download|pdf' } | Select-Object -First 1 -ExpandProperty href
if ($link1) {
    Download-PDF $link1 "$dest\01_X1_Brand_Image\Maksipreneur_2026_Brand_Image_Trust_Purchase_Decision.pdf"
}

# 2. IIJSE - Brand Trust, Brand Image, Purchase Decision
$res2 = Invoke-WebRequest -Uri "https://www.e-journal.uac.ac.id/index.php/iijse/article/view/7350" -Headers $headers
$link2 = $res2.Links | Where-Object { $_.href -match 'download|pdf' } | Select-Object -First 1 -ExpandProperty href
if ($link2) {
    Download-PDF $link2 "$dest\02_X2_Brand_Trust\IIJSE_2025_Brand_Trust_Image_Purchase_Decision.pdf"
}

# 3. WEVJ - Electric Vehicle Purchase Intention, Brand Image, Safety
Download-PDF "https://www.mdpi.com/2032-6653/12/2/71/pdf?version=1622089228" "$dest\04_Kombinasi_Variabel_&_Y\MDPI_2021_Electric_Vehicle_Brand_Image_Safety.pdf"

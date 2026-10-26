$testCandidates = @(
    @{ Name = "Devananda_2023_Kepercayaan_Brand_Image_Keamanan_Keputusan.pdf"; Url = "https://www.jiip.stkipyapisdompu.ac.id/jiip/index.php/JIIP/article/download/2183/2457" },
    @{ Name = "Alfarezzy_2026_Kepercayaan_Keamanan_Resiko_Keputusan.pdf"; Url = "https://al-haramjournal.co.id/JIM/article/download/19474/12808" },
    @{ Name = "Afendi_2026_Kepercayaan_Keamanan_Kemudahan_GrabFood_Keputusan.pdf"; Url = "https://prin.or.id/index.php/JURRIE/article/download/7941/6601" },
    @{ Name = "Cahyani_2023_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf"; Url = "https://openjournal.unpam.ac.id/index.php/JPK/article/download/33386/16266" },
    @{ Name = "Ardialis_2023_Kepercayaan_Keamanan_Resiko_Keputusan.pdf"; Url = "https://journal.irpi.or.id/index.php/ijbem/article/download/470/244" },
    @{ Name = "Fadila_2025_Environmental_Awareness_Brand_Trust_Brand_Image_Keputusan.pdf"; Url = "https://jurnal.feb-umi.id/index.php/PARADOKS/article/download/1251/889" },
    @{ Name = "Pramesti_2023_Brand_Image_Brand_Awareness_Brand_Trust_Keputusan.pdf"; Url = "https://ejournal.undiksha.ac.id/index.php/EKU/article/download/61833/26490" },
    @{ Name = "Madeleine_2025_Brand_Image_Brand_Trust_Promosi_Keputusan.pdf"; Url = "https://journal.ukmc.ac.id/index.php/jkkjm/article/download/1370/1237" }
)

$tempDir = "scratch\downloads_test"
if (-not (Test-Path $tempDir)) { New-Item -ItemType Directory -Path $tempDir | Out-Null }

$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Accept" = "application/pdf,text/html,*/*"
}

foreach ($item in $testCandidates) {
    $outPath = Join-Path $tempDir $item.Name
    Write-Host "Downloading $($item.Name)..."
    try {
        Invoke-WebRequest -Uri $item.Url -OutFile $outPath -Headers $headers -TimeoutSec 30
        $bytes = [System.IO.File]::ReadAllBytes($outPath)
        $header = [System.Text.Encoding]::ASCII.GetString($bytes, 0, [Math]::Min(10, $bytes.Length))
        $isPdf = $header.StartsWith("%PDF")
        $sizeKB = [math]::Round($bytes.Length / 1KB, 1)
        Write-Host "Success: Size = $sizeKB KB, IsPDF = $isPdf, Header = $header" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $($item.Name) - $_" -ForegroundColor Red
    }
}

$batch2 = @(
    @{ Name = "Mariza_2024_Kepercayaan_Keamanan_Promosi_Keputusan.pdf"; Url = "https://jurnal.kdi.or.id/index.php/eb/article/download/799/654" },
    @{ Name = "Fransiska_2026_Keamanan_Kepercayaan_eWOM_Keputusan.pdf"; Url = "https://jurnal.kdi.or.id/index.php/eb/article/download/3632/1896" },
    @{ Name = "Agustiningrum_2021_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf"; Url = "https://journal.unesa.ac.id/index.php/jim/article/download/13905/pdf" },
    @{ Name = "Dahlia_2024_Kepercayaan_Kemudahan_Keamanan_Keputusan.pdf"; Url = "https://jurnal.umb.ac.id/index.php/jems/article/download/5977/3771" },
    @{ Name = "Rahmani_2022_Brand_Image_Trust_Endorsement_Keputusan.pdf"; Url = "http://jurnal.feb.unila.ac.id/index.php/jbm/article/download/408/186" },
    @{ Name = "Inggasari_2022_Brand_Image_Trust_Endorser_Keputusan.pdf"; Url = "https://journal.stimykpn.ac.id/index.php/cb/article/viewFile/298/153" }
)

$tempDir = "scratch\downloads_test"
$headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    "Accept" = "application/pdf,text/html,*/*"
}

foreach ($item in $batch2) {
    $outPath = Join-Path $tempDir $item.Name
    Write-Host "Downloading $($item.Name)..."
    try {
        Invoke-WebRequest -Uri $item.Url -OutFile $outPath -Headers $headers -TimeoutSec 30
        $firstLine = Get-Content -Path $outPath -TotalCount 1
        $fileInfo = Get-Item $outPath
        $sizeKB = [math]::Round($fileInfo.Length / 1KB, 1)
        $isPdf = $firstLine.StartsWith("%PDF")
        Write-Host "Success: Size = $sizeKB KB, IsPDF = $isPdf, Header = $firstLine" -ForegroundColor Green
    } catch {
        Write-Host "Failed: $($item.Name) - $_" -ForegroundColor Red
    }
}

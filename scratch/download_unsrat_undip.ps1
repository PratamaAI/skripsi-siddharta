$downloads = @(
    @{
        Name = "04_Kombinasi_Variabel_&_Y/Unsrat_2024_Brand_Image_Trust_Transportasi_Penggunaan.pdf"
        Url = "https://ejournal.unsrat.ac.id/v3/index.php/jmbi/article/download/53440/45910"
        Desc = "JMBI UNSRAT 2024: Brand Image & Brand Trust Keputusan Penggunaan Transportasi"
    },
    @{
        Name = "04_Kombinasi_Variabel_&_Y/Undip_2020_Keputusan_Penggunaan_Taksi.pdf"
        Url = "https://ejournal3.undip.ac.id/index.php/jiab/article/viewFile/28132/24361"
        Desc = "Undip JIAB 2020: Keputusan Penggunaan Jasa Taksi"
    }
)

$baseDir = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

foreach ($d in $downloads) {
    $targetPath = Join-Path $baseDir $d.Name
    Write-Host "Attempting: $($d.Desc)"
    try {
        Invoke-WebRequest -Uri $d.Url -OutFile $targetPath -Headers $headers -TimeoutSec 20
        $bytes = [System.IO.File]::ReadAllBytes($targetPath)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        if ($magic -eq "%PDF" -and $bytes.Length -gt 20000) {
            Write-Host "SUCCESS: Valid PDF, Size = $($bytes.Length) bytes" -ForegroundColor Green
        } else {
            Write-Host "FAILED: Not a valid PDF (Magic: $magic, Size: $($bytes.Length))" -ForegroundColor Red
            Remove-Item $targetPath -Force
        }
    } catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    }
}

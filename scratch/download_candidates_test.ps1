$downloads = @(
    @{
        Name = "04_Kombinasi_Variabel_&_Y/JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf"
        Url = "https://serambi.org/index.php/jemr/article/download/1474/1044"
        Desc = "JEMR 2025: Brand Image & Consumer Trust in Electric Vehicle Purchase Decisions"
    },
    @{
        Name = "04_Kombinasi_Variabel_&_Y/IJSR_2025_Brand_Image_Trust_EV.pdf"
        Url = "https://ijsr.internationaljournallabs.com/index.php/ijsr/article/download/2456/1359"
        Desc = "IJSR 2025: Brand Image and Trust Among Electric Vehicle Consumers"
    },
    @{
        Name = "01_X1_Brand_Image/Visioner_2024_Brand_Image_InDrive_Transportasi.pdf"
        Url = "https://jurnal.stiebalikpapan.ac.id/index.php/jmbv/article/download/102/72"
        Desc = "Visioner 2024: Brand Image Keputusan Penggunaan Layanan Jasa Transportasi Online"
    },
    @{
        Name = "04_Kombinasi_Variabel_&_Y/EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf"
        Url = "https://ejurnal.seminar-id.com/index.php/ekuitas/article/download/6975/3555"
        Desc = "EKUITAS 2025: Brand Image & Brand Trust Keputusan Pembelian"
    },
    @{
        Name = "03_X3_Perceived_Safety/Undip_2020_Persepsi_Keamanan_Keputusan_Penggunaan.pdf"
        Url = "https://ejournal3.undip.ac.id/index.php/jiab/article/viewFile/26225/23234"
        Desc = "Undip JIAB: Persepsi Keamanan terhadap Keputusan Penggunaan"
    },
    @{
        Name = "01_X1_Brand_Image/Untar_2025_Brand_Image_Purchase_Intention_EV.pdf"
        Url = "https://journal.untar.ac.id/index.php/jmbk/article/download/35326/21307"
        Desc = "Untar JMBK 2025: Brand Image Purchase Intention Mobil Listrik"
    },
    @{
        Name = "04_Kombinasi_Variabel_&_Y/Stekom_2024_Ride_Hailing_GrabCar_Keputusan_Penggunaan.pdf"
        Url = "https://journal.stekom.ac.id/index.php/Bisnis/article/download/2583/2045"
        Desc = "Stekom 2024: Layanan Ride-Hailing GrabCar Keputusan Penggunaan"
    }
)

$baseDir = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

foreach ($d in $downloads) {
    $targetPath = Join-Path $baseDir $d.Name
    Write-Host "Attempting download: $($d.Desc)"
    Write-Host "Target: $targetPath"
    try {
        Invoke-WebRequest -Uri $d.Url -OutFile $targetPath -Headers $headers -TimeoutSec 20
        $bytes = [System.IO.File]::ReadAllBytes($targetPath)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        if ($magic -eq "%PDF" -and $bytes.Length -gt 20000) {
            Write-Host "SUCCESS: Valid PDF, Size = $($bytes.Length) bytes" -ForegroundColor Green
        } else {
            Write-Host "FAILED: Not a valid PDF (Magic: $magic, Size: $($bytes.Length) bytes)" -ForegroundColor Red
            Remove-Item $targetPath -Force
        }
    } catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    }
    Write-Host "---"
}

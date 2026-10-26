$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}

function Try-DownloadDoi($doi, $outfile) {
    Write-Host "Checking DOI: $doi" -ForegroundColor Cyan
    $metaUrl = "https://api.crossref.org/works/$doi"
    try {
        $meta = Invoke-RestMethod -Uri $metaUrl -Headers $headers -TimeoutSec 15
        $t = $meta.message.title[0]
        $landing = $meta.message.URL
        Write-Host "Title: $t" -ForegroundColor Green
        Write-Host "Landing: $landing"
        
        # Check unpaywall
        $unpUrl = "https://api.unpaywall.org/v2/$doi" + "?email=antigravity.student@gmail.com"
        try {
            $unp = Invoke-RestMethod -Uri $unpUrl -Headers $headers -TimeoutSec 10
            if ($unp.is_oa -and $unp.best_oa_location.url_for_pdf) {
                $pdfUrl = $unp.best_oa_location.url_for_pdf
                Write-Host "Downloading OA PDF from: $pdfUrl" -ForegroundColor Yellow
                Invoke-WebRequest -Uri $pdfUrl -OutFile $outfile -Headers $headers -TimeoutSec 20
                $bytes = [System.IO.File]::ReadAllBytes($outfile)
                $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
                Write-Host "SUCCESS: Magic=$magic, Size=$($bytes.Length) bytes" -ForegroundColor Green
                return $true
            }
        } catch {
            Write-Host "Unpaywall error: $_" -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "Meta error: $_" -ForegroundColor Red
    }
    return $false
}

$dest = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris"
Try-DownloadDoi "10.30738/jm.v16i1.4841" "$dest\04_Kombinasi_Variabel_&_Y\Fitriyono_2026_Brand_Image_Trust_Risk_Purchase_Decision.pdf"
Try-DownloadDoi "10.47065/ekuitas.v4i3.2810" "$dest\01_X1_Brand_Image\Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf"
Try-DownloadDoi "10.24912/jmbk.v9i5.35326" "$dest\01_X1_Brand_Image\Manurung_2025_Brand_Image_Mobil_Listrik.pdf"
Try-DownloadDoi "10.24843/ejmunud.2021.v10.i05.p02" "$dest\04_Kombinasi_Variabel_&_Y\Wikantara_2021_Brand_Image_Transportasi.pdf"
Try-DownloadDoi "10.56799/jim.v5i9.19474" "$dest\03_X3_Perceived_Safety\Alfarezzy_2026_Kepercayaan_Keamanan_Keputusan.pdf"
Try-DownloadDoi "10.33395/jmp.v15i1.16085" "$dest\03_X3_Perceived_Safety\Patricia_2026_Keamanan_Kepercayaan_Keputusan.pdf"

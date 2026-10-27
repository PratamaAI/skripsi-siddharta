$headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }

function Test-ValidPdf($path) {
    if (Test-Path $path) {
        $len = (Get-Item $path).Length
        if ($len -gt 50000) {
            $bytes = [System.IO.File]::ReadAllBytes($path)
            $header = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
            if ($header -eq "%PDF") { return $true }
        }
    }
    return $false
}

# 1. Brand Image
$bi_dest = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\04_Pengertian_&_Teori_Variabel\01_Definisi_X1_Brand_Image\Keller_1993_Conceptualizing_Measuring_Brand_Equity.pdf"
if (-not (Test-ValidPdf $bi_dest)) {
    # Search OpenAlex for open-access PDF of Keller 1993 or seminal brand image paper
    try {
        $res = Invoke-RestMethod -Uri "https://api.openalex.org/works?filter=default.search:conceptualizing+measuring+managing+brand+equity+keller,is_oa:true&per-page=3" -Headers $headers -TimeoutSec 15
        foreach ($work in $res.results) {
            $pdfUrl = $work.open_access.oa_url
            if (-not $pdfUrl -and $work.best_oa_location) { $pdfUrl = $work.best_oa_location.pdf_url }
            if ($pdfUrl) {
                Write-Output "Found Brand Image OA URL: $pdfUrl"
                try {
                    Invoke-WebRequest -Uri $pdfUrl -OutFile $bi_dest -Headers $headers -TimeoutSec 25
                    if (Test-ValidPdf $bi_dest) {
                        Write-Output "Brand Image PDF downloaded successfully!"
                        break
                    }
                } catch { Write-Output "Download failed: $_" }
            }
        }
    } catch { Write-Output "OpenAlex search failed: $_" }
}

# 2. Brand Trust
$bt_dest = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\04_Pengertian_&_Teori_Variabel\02_Definisi_X2_Brand_Trust\Delgado_Ballester_2003_Development_Validation_Brand_Trust.pdf"
if (-not (Test-ValidPdf $bt_dest)) {
    try {
        $res = Invoke-RestMethod -Uri "https://api.openalex.org/works?filter=default.search:delgado-ballester+development+and+validation+of+a+brand+trust+scale,is_oa:true&per-page=3" -Headers $headers -TimeoutSec 15
        foreach ($work in $res.results) {
            $pdfUrl = $work.open_access.oa_url
            if (-not $pdfUrl -and $work.best_oa_location) { $pdfUrl = $work.best_oa_location.pdf_url }
            if ($pdfUrl) {
                Write-Output "Found Brand Trust OA URL: $pdfUrl"
                try {
                    Invoke-WebRequest -Uri $pdfUrl -OutFile $bt_dest -Headers $headers -TimeoutSec 25
                    if (Test-ValidPdf $bt_dest) {
                        Write-Output "Brand Trust PDF downloaded successfully!"
                        break
                    }
                } catch { Write-Output "Download failed: $_" }
            }
        }
    } catch { Write-Output "OpenAlex search failed: $_" }
}

# 3. Perceived Safety
$ps_dest = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\04_Pengertian_&_Teori_Variabel\03_Definisi_X3_Perceived_Safety\Safety_Perception_Electric_Mobility.pdf"
if (-not (Test-ValidPdf $ps_dest)) {
    try {
        $res = Invoke-RestMethod -Uri "https://api.openalex.org/works?filter=default.search:perceived+safety+electric+vehicle+or+ride-hailing,is_oa:true&per-page=5" -Headers $headers -TimeoutSec 15
        foreach ($work in $res.results) {
            $pdfUrl = $work.best_oa_location.pdf_url
            if (-not $pdfUrl) { $pdfUrl = $work.open_access.oa_url }
            if ($pdfUrl -and $pdfUrl -like "*.pdf*") {
                Write-Output "Found Perceived Safety OA URL: $pdfUrl"
                try {
                    Invoke-WebRequest -Uri $pdfUrl -OutFile $ps_dest -Headers $headers -TimeoutSec 25
                    if (Test-ValidPdf $ps_dest) {
                        Write-Output "Perceived Safety PDF downloaded successfully!"
                        break
                    }
                } catch { Write-Output "Download failed: $_" }
            }
        }
    } catch { Write-Output "OpenAlex search failed: $_" }
}

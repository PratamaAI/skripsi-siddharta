$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:antigravity.student@gmail.com'}

function Search-And-Download($q, $outDir, $prefix) {
    Write-Host "Searching: $q" -ForegroundColor Cyan
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($q) + "&rows=10&mailto=antigravity.student@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($item in $res.message.items) {
            $doi = $item.DOI
            $title = if ($item.title) { $item.title[0] } else { "No Title" }
            $journal = if ($item.'container-title') { $item.'container-title'[0] } else { "No Journal" }
            $year = if ($item.published -and $item.published.'date-parts') { $item.published.'date-parts'[0][0] } else { "N/A" }
            
            # Check Unpaywall
            $unpUrl = "https://api.unpaywall.org/v2/$doi?email=antigravity.student@gmail.com"
            try {
                $unp = Invoke-RestMethod -Uri $unpUrl -Headers $headers -TimeoutSec 5
                if ($unp.is_oa -and $unp.best_oa_location.url_for_pdf) {
                    $pdfUrl = $unp.best_oa_location.url_for_pdf
                    $safeTitle = ($title -replace '[^a-zA-Z0-9]', '_').Substring(0, [Math]::Min(35, $title.Length))
                    $fileName = "$outDir\${prefix}_${year}_${safeTitle}.pdf"
                    Write-Host "Downloading: [$year] $title" -ForegroundColor Green
                    Write-Host "  URL: $pdfUrl"
                    Invoke-WebRequest -Uri $pdfUrl -OutFile $fileName -Headers $headers -TimeoutSec 20
                    $bytes = [System.IO.File]::ReadAllBytes($fileName)
                    $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
                    if ($magic -eq "%PDF" -and $bytes.Length -gt 20000) {
                        Write-Host "SUCCESS: $fileName ($($bytes.Length) bytes)" -ForegroundColor Green
                        return
                    } else {
                        Remove-Item $fileName -Force -ErrorAction SilentlyContinue
                    }
                }
            } catch {}
        }
    } catch {
        Write-Host "Error: $_"
    }
}

$destX1 = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\01_X1_Brand_Image"
$destX2 = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\02_X2_Brand_Trust"
$destX3 = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\03_X3_Perceived_Safety"
$destComb = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\04_Kombinasi_Variabel_&_Y"

Search-And-Download '"Brand Trust" "Keputusan Pembelian" OR "Keputusan Penggunaan"' $destX2 "BT"
Search-And-Download '"Brand Image" "Brand Trust" "Keputusan Pembelian"' $destComb "BI_BT"
Search-And-Download '"Persepsi Keamanan" "Keputusan Penggunaan"' $destX3 "PS"
Search-And-Download '"Perceived Safety" "Purchase Decision"' $destX3 "PS_EN"
Search-And-Download '"Brand Image" "Keputusan Pembelian" taksi' $destX1 "BI_Taxi"
Search-And-Download '"Brand Trust" "Keputusan Penggunaan" transportasi' $destX2 "BT_Trans"

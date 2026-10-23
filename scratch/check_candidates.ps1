$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64); mailto:siddharta.student@gmail.com'}

function Check-DoiDownload($doi, $outfile) {
    Write-Host "Checking DOI: $doi" -ForegroundColor Cyan
    $metaUrl = "https://api.crossref.org/works/$doi"
    try {
        $meta = Invoke-RestMethod -Uri $metaUrl -Headers $headers -TimeoutSec 15
        $item = $meta.message
        Write-Host "Title: $($item.title[0])" -ForegroundColor Green
        Write-Host "Journal: $($item.'container-title'[0]) ($($item.published.'date-parts'[0][0]))"
        
        # Check unpaywall
        $unpUrl = "https://api.unpaywall.org/v2/$doi?email=siddharta.student@gmail.com"
        $unp = Invoke-RestMethod -Uri $unpUrl -Headers $headers -TimeoutSec 15
        if ($unp.is_oa) {
            Write-Host "OA Found via Unpaywall! URL: $($unp.best_oa_location.url_for_pdf)" -ForegroundColor Yellow
            $pdfUrl = $unp.best_oa_location.url_for_pdf
            if (-not $pdfUrl) { $pdfUrl = $unp.best_oa_location.url_for_landing_page }
            Write-Host "Best URL: $pdfUrl"
        } else {
            Write-Host "Not OA in unpaywall" -ForegroundColor DarkGray
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Check-DoiDownload "10.3389/fpsyg.2023.1073301" "scratch/frontiers_stream.pdf"
Check-DoiDownload "10.1155/2022/3684192" "scratch/hindawi_influencer.pdf"
Check-DoiDownload "10.1108/intr-02-2012-0025" "scratch/emerald_social.pdf"
Check-DoiDownload "10.33168/jliss.2024.0715" "scratch/jliss_genshin.pdf"
Check-DoiDownload "10.17961/jdmr.28.06.202510.21" "scratch/jdmr_mobile.pdf"
Check-DoiDownload "10.5901/mjss.2013.v4n14p237" "scratch/mjss_mobile.pdf"
Check-DoiDownload "10.34148/teknika.v14i1.1163" "scratch/teknika_game.pdf"

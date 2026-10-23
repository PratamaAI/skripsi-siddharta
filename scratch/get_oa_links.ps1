$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Test-Unpaywall($doi) {
    $url = "https://api.unpaywall.org/v2/$doi" + "?email=antigravity.researcher@gmail.com"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        Write-Host "DOI: $doi | Is_OA: $($res.is_oa)" -ForegroundColor Cyan
        if ($res.best_oa_location) {
            Write-Host "  PDF URL: $($res.best_oa_location.url_for_pdf)" -ForegroundColor Green
            Write-Host "  Landing: $($res.best_oa_location.url_for_landing_page)"
            return $res.best_oa_location.url_for_pdf
        }
    } catch {
        Write-Host "Error for $doi : $_" -ForegroundColor Red
    }
    return $null
}

Test-Unpaywall "10.3389/fpsyg.2023.1073301"
Test-Unpaywall "10.1155/2022/3684192"
Test-Unpaywall "10.1108/intr-02-2012-0025"
Test-Unpaywall "10.33168/jliss.2024.0715"
Test-Unpaywall "10.17961/jdmr.28.06.202510.21"
Test-Unpaywall "10.5901/mjss.2013.v4n14p237"

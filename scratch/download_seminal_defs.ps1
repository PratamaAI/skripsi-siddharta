$seminalDOIs = @(
    @{ Tag = "Keller_1993_Brand_Image_CBBE"; DOI = "10.1177/002224299305700101"; Folder = "01_Definisi_X1_Brand_Image" },
    @{ Tag = "Chaudhuri_2001_Brand_Trust"; DOI = "10.1509/jmkg.65.2.81.18255"; Folder = "02_Definisi_X2_Brand_Trust" },
    @{ Tag = "Delgado_2003_Brand_Trust_Scale"; DOI = "10.1177/147078530304500103"; Folder = "02_Definisi_X2_Brand_Trust" },
    @{ Tag = "Xu_2020_Electric_Vehicle_Safety_Willingness"; DOI = "10.1016/j.trd.2020.102434"; Folder = "03_Definisi_X3_Perceived_Safety" },
    @{ Tag = "Rayle_2016_Taxi_Ridesourcing_Purchase"; DOI = "10.1016/j.tranpol.2015.10.004"; Folder = "04_Definisi_Y_Purchase_Decision" }
)

$baseDir = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\04_Pengertian_&_Teori_Variabel"
$headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" }

foreach ($item in $seminalDOIs) {
    Write-Host "Querying OpenAlex for $($item.Tag) (DOI: $($item.DOI))..."
    $url = "https://api.openalex.org/works/https://doi.org/" + $item.DOI
    try {
        $res = Invoke-RestMethod -Uri $url -TimeoutSec 15
        $pdfUrl = $null
        if ($res.best_oa_location -and $res.best_oa_location.pdf_url) {
            $pdfUrl = $res.best_oa_location.pdf_url
        } elseif ($res.open_access.oa_url) {
            $pdfUrl = $res.open_access.oa_url
        }
        
        Write-Host "Found PDF URL: $pdfUrl"
        if ($pdfUrl) {
            $targetPath = Join-Path (Join-Path $baseDir $item.Folder) ($item.Tag + ".pdf")
            Invoke-WebRequest -Uri $pdfUrl -OutFile $targetPath -Headers $headers -TimeoutSec 30
            $hdr = Get-Content -Path $targetPath -TotalCount 1
            $len = (Get-Item $targetPath).Length
            Write-Host "Downloaded $($item.Tag): Size=$len, Header=$hdr" -ForegroundColor Green
        }
    } catch {
        Write-Host "Error fetching $($item.Tag): $_" -ForegroundColor Red
    }
}

$headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" }

$moreCandidates = @(
    @{ Name = "Aini_2021_Kepercayaan_Keamanan_Literasi_Keputusan.pdf"; Url = "https://jcsm.ejournal.unri.ac.id/index.php/JCSM/article/download/7936/pdf" },
    @{ Name = "Mutiara_2020_Kepercayaan_Keamanan_Kualitas_Keputusan.pdf"; Url = "http://ojs.ekonomi-unkris.ac.id/index.php/JMBK/article/download/419/pdf" },
    @{ Name = "Jefryansyah_2020_Kepercayaan_Keamanan_Keputusan.pdf"; Url = "https://journal.trunojoyo.ac.id/competence/article/download/8739/5063" },
    @{ Name = "Zulkarnain_2021_Brand_Image_Trust_Keputusan.pdf"; Url = "https://ejournal.upbatam.ac.id/index.php/dimension/article/download/3224/pdf" },
    @{ Name = "Karamang_2018_Brand_Image_Trust_Pricing_Keputusan.pdf"; Url = "https://journal.universitasbosowa.ac.id/index.php/profitability/article/download/129/106" }
)

foreach ($c in $moreCandidates) {
    $out = "scratch\downloads_test\" + $c.Name
    try {
        Invoke-WebRequest -Uri $c.Url -OutFile $out -Headers $headers -TimeoutSec 15
        $first = Get-Content -Path $out -TotalCount 1
        $sz = (Get-Item $out).Length
        Write-Host "$($c.Name): Size=$sz, Header=$first" -ForegroundColor Green
    } catch {
        Write-Host "$($c.Name) Failed: $_" -ForegroundColor Red
    }
}

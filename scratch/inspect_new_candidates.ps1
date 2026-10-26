$headers = @{ "User-Agent" = "AcademicResearchBot/1.0 (mailto:student@ukrida.ac.id)" }

$targetDOIs = @(
    "Devananda" # we will get DOI
)

$scriptCandidates = @(
    @{ Query = "Devananda Pengaruh Kepercayaan, Brand Image, Keamanan"; Tag = "Devananda_2023" },
    @{ Query = "Alfarezzy Pengaruh Kepercayaan, Persepsi Keamanan, dan Persepsi Resiko"; Tag = "Alfarezzy_2026" },
    @{ Query = "Afendi Pengaruh Kepercayaan, Keamanan, dan Kemudahan Penggunaan"; Tag = "Afendi_2026" },
    @{ Query = "Cahyani Pengaruh Kepercayaan, Kemudahan Dan Keamanan"; Tag = "Cahyani_2023" },
    @{ Query = "Dahlia Pengaruh Kepercayaan, Kemudahan Dan Keamanan Terhadap Keputusan"; Tag = "Dahlia_2024" },
    @{ Query = "Ardialis Pengaruh Kepercayaan, Keamanan, dan Persepsi Resiko"; Tag = "Ardialis_2023" },
    @{ Query = "Mutiara Pengaruh Kepercayaan, Keamanan Dan Kualitas Produk"; Tag = "Mutiara_2020" },
    @{ Query = "Fadila Pengaruh Environmental Awareness, Brand Trust, Dan Brand Image"; Tag = "Fadila_2025" },
    @{ Query = "Rahmatika Pengaruh Green Marketing, Brand Image Dan Brand Trust"; Tag = "Rahmatika_2022" },
    @{ Query = "Pramesti Pengaruh Brand Image, Brand Awareness Dan Brand Trust"; Tag = "Pramesti_2023" },
    @{ Query = "Madeleine Pengaruh Brand Image, Brand Trust Dan Promosi"; Tag = "Madeleine_2025" }
)

foreach ($c in $scriptCandidates) {
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($c.Query) + "&rows=1"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        if ($res.message.items.Count -gt 0) {
            $it = $res.message.items[0]
            $link = if ($it.link) { $it.link[0].URL } else { "" }
            [PSCustomObject]@{
                Tag = $c.Tag
                DOI = $it.DOI
                Title = $it.title[0]
                Container = if ($it.'container-title') { $it.'container-title'[0] } else { "" }
                ResourceURL = if ($it.resource.primary.URL) { $it.resource.primary.URL } else { "" }
                PDFLink = $link
            } | Format-List
        }
    } catch {
        Write-Host "Error for $($c.Tag): $_"
    }
}

$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

$papers = @(
    @{ Code = "S01"; DOI = "10.2991/978-94-6463-008-4_118"; Desc = "Martiningsih 2022" },
    @{ Code = "S02"; DOI = "10.2991/978-94-6463-525-6_34"; Desc = "Ahmad 2024" },
    @{ Code = "S05"; DOI = ""; File = "2025_Asmawati_Influencer_GenZ_IIJSE.pdf"; Desc = "Asmawati 2025" },
    @{ Code = "S07"; DOI = "10.2991/aebmr.k.220501.075"; Desc = "Halim & Keni 2022" },
    @{ Code = "S08"; DOI = "10.2991/978-94-6463-340-5_24"; Desc = "Utami Dewi 2023" },
    @{ Code = "S09"; DOI = "10.2991/aebmr.k.200131.008"; Desc = "Zahratu & Hurriyati 2020" },
    @{ Code = "S11"; DOI = "10.21512/bbr.v15i2.10697"; Desc = "Artadita & Firmialy 2024" },
    @{ Code = "S17"; DOI = "10.1109/access.2025.3559632"; Desc = "Peng & Bai 2025" }
)

foreach ($p in $papers) {
    if ($p.DOI -ne "") {
        try {
            $url = "https://api.crossref.org/works/" + $p.DOI
            $resp = $wc.DownloadString($url) | ConvertFrom-Json
            $item = $resp.message
            Write-Output "=== $($p.Code) - $($p.Desc) ==="
            Write-Output "Title: $($item.title -join ' ')"
            Write-Output "Authors: $(($item.author | ForEach-Object { $_.family + ', ' + $_.given }) -join '; ')"
            Write-Output "Container: $($item.'container-title' -join ' ')"
            Write-Output "Year: $($item.issued.'date-parts'[0][0])"
            Write-Output "DOI: $($item.DOI)"
        } catch {
            Write-Output "Error for $($p.Code): $_"
        }
    } else {
        Write-Output "=== $($p.Code) - $($p.Desc) ==="
        Write-Output "File: $($p.File)"
    }
}

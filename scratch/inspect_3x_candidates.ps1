[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Let's inspect the candidate DOIs we already found:
# 1. 10.30738/jm.v16i1.4841 -> PENGARUH BRAND IMAGE, BRAND TRUST, DAN PERCEIVED RISK TERHADAP PURCHASE DECISION MOBIL TOYOTA
# 2. 10.54371/jiip.v6i10.2183 -> Pengaruh Kepercayaan, Brand Image, Keamanan terhadap Keputusan Pembelian
# 3. 10.47065/ekuitas.v6i3.6975 -> Pengaruh Brand Awareness, Brand Image, dan Brand Trust Terhadap Keputusan Pembelian
# 4. 10.47065/ekuitas.v4i3.2810 -> Pengaruh Brand Image dan Brand Ambassador Terhadap Purchase Decision melalui Brand Trust sebagai Intervening
# 5. 10.61987/jemr.v4i6.1474 -> The Role of Influencers, Brand Image, Ease of Use, and Consumer Trust in Electric Vehicle Purchase Decisions
# 6. 10.24912/6anm9m28 -> Pengaruh Citra Merek, Kepercayaan Merek, dan Kesadaran Merek terhadap Keputusan Pembelian
# 7. 10.21776/jmppk.2024.03.3.10 -> Pengaruh Ewom, Citra Merek Dan Kepercayaan Merek Terhadap Keputusan Pembelian
# 8. 10.21776/jmppk.2023.02.1.20 -> Pengaruh Citra Merek, Kepercayaan Merek, dan Celebrity Endorsement terhadap Keputusan Pembelian
# 9. 10.56799/jim.v5i9.19474 -> PENGARUH KEPERCAYAAN, PERSEPSI KEAMANAN, DAN PERSEPSI RESIKO TERHADAP KEPUTUSAN PEMBELIAN ONLINE

$candidates = @(
    @{ Key = "Fitriyono_Toyota"; DOI = "10.30738/jm.v16i1.4841" },
    @{ Key = "Devananda_JIIP"; DOI = "10.54371/jiip.v6i10.2183" },
    @{ Key = "Nurlita_Ekuitas"; DOI = "10.47065/ekuitas.v6i3.6975" },
    @{ Key = "Hera_Ekuitas"; DOI = "10.47065/ekuitas.v4i3.2810" },
    @{ Key = "Adha_JEMR_EV"; DOI = "10.61987/jemr.v4i6.1474" },
    @{ Key = "Febriyanto_JMPPK"; DOI = "10.21776/jmppk.2024.03.3.10" },
    @{ Key = "Wardhana_JMPPK"; DOI = "10.21776/jmppk.2023.02.1.20" },
    @{ Key = "Ulil_Albab_Shopee"; DOI = "10.56799/jim.v5i9.19474" }
)

foreach ($c in $candidates) {
    try {
        $url = "https://api.crossref.org/works/" + $c.DOI
        $resp = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 10
        $m = $resp.message
        $auths = ($m.author | ForEach-Object { $_.given + " " + $_.family }) -join ", "
        Write-Host "KEY: $($c.Key)"
        Write-Host "Title: $($m.title[0])"
        Write-Host "Journal: $($m.'container-title'[0]) ($($m.issued.'date-parts'[0][0]))"
        Write-Host "DOI: $($m.DOI)"
        Write-Host "Authors: $auths"
        Write-Host "---"
    } catch {
        Write-Host "Error for $($c.Key): $($_.Exception.Message)"
    }
}

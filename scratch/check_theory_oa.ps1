$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0')

$queries = @(
    @{ Name = "Bhattacherjee_2001"; Query = "Bhattacherjee 2001 Understanding Information Systems Continuance filetype:pdf" },
    @{ Name = "van_der_Heijden_2004"; Query = "van der Heijden 2004 User Acceptance of Hedonic Information Systems filetype:pdf" },
    @{ Name = "Hsu_Lu_2004"; Query = "Hsu Lu 2004 Why do people play on-line games filetype:pdf" },
    @{ Name = "Ohanian_1990"; Query = "Ohanian 1990 Construction and Validation of a Scale to Measure Celebrity Endorsers filetype:pdf" },
    @{ Name = "Davis_1992"; Query = "Davis Bagozzi Warshaw 1992 Extrinsic and intrinsic motivation filetype:pdf" }
)

# Check Semantic Scholar API for open access pdf links for these DOIs:
# Bhattacherjee 2001: 10.2307/4132352
# van der Heijden 2004: 10.2307/25148660
# Hsu & Lu 2004: 10.1016/j.im.2003.08.014
# Ohanian 1990: 10.1080/00913367.1990.10673191

$dois = @(
    @{ Name = "Bhattacherjee_2001"; DOI = "10.2307/4132352" },
    @{ Name = "van_der_Heijden_2004"; DOI = "10.2307/25148660" },
    @{ Name = "Hsu_Lu_2004"; DOI = "10.1016/j.im.2003.08.014" },
    @{ Name = "Ohanian_1990"; DOI = "10.1080/00913367.1990.10673191" }
)

foreach ($d in $dois) {
    try {
        $s2url = "https://api.semanticscholar.org/graph/v1/paper/DOI:" + $d.DOI + "?fields=title,openAccessPdf"
        $resp = $wc.DownloadString($s2url) | ConvertFrom-Json
        Write-Output "$($d.Name) -> OA PDF: $($resp.openAccessPdf.url)"
    } catch {
        Write-Output "$($d.Name) -> Error: $_"
    }
}

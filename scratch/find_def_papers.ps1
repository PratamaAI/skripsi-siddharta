$headers = @{ "User-Agent" = "AcademicResearchBot/1.0 (mailto:student@ukrida.ac.id)" }

function Find-DefPapers {
    param([string]$query, [string]$tag, [string]$folder)
    $url = "https://api.crossref.org/works?query=" + [System.Uri]::EscapeDataString($query) + "&rows=3&filter=type:journal-article"
    try {
        $res = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 15
        foreach ($it in $res.message.items) {
            $link = if ($it.link) { $it.link[0].URL } else { "" }
            [PSCustomObject]@{
                Folder = $folder
                Tag = $tag
                Title = $it.title[0]
                DOI = $it.DOI
                Container = if ($it.'container-title') { $it.'container-title'[0] } else { "" }
                PDF = $link
                URL = if ($it.resource.primary.URL) { $it.resource.primary.URL } else { "" }
            }
        }
    } catch {
        Write-Host "Err: $_"
    }
}

$p1 = Find-DefPapers "Kajian Teori Citra Merek Brand Image dimensi" "Def_X1" "01_Definisi_X1_Brand_Image"
$p2 = Find-DefPapers "Kajian Teori Brand Trust Kepercayaan Merek dimensi" "Def_X2" "02_Definisi_X2_Brand_Trust"
$p3 = Find-DefPapers "Kajian Teori Persepsi Keamanan Perceived Safety transportasi" "Def_X3" "03_Definisi_X3_Perceived_Safety"
$p4 = Find-DefPapers "Kajian Teori Keputusan Pembelian Purchase Decision proses" "Def_Y" "04_Definisi_Y_Purchase_Decision"

$all = @($p1) + @($p2) + @($p3) + @($p4)
$all | Format-List

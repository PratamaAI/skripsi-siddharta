[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$targetDir = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\02_Karya_Dosen_FEB_UKRIDA"

# 1. Download COSTING (Tecoalu, Yonathan, & Winoto Tj, 2021)
$pdfUrl1 = "https://journal.ipm2kpe.or.id/index.php/COSTING/article/download/2596/1618"
$outFile1 = Join-Path $targetDir "S-FEB_2021_Tecoalu_Shopee_Keputusan_Pembelian.pdf"

try {
    $wc = New-Object System.Net.WebClient
    $wc.Headers.Add("User-Agent", "Mozilla/5.0")
    $wc.DownloadFile($pdfUrl1, $outFile1)
    $fi1 = Get-Item $outFile1
    Write-Host "COSTING PDF downloaded: $($fi1.Length) bytes"
} catch {
    Write-Host "Error downloading COSTING: $($_.Exception.Message)"
}

# 2. Check Primanomics (Tecoalu, Wahyoedi, & Kustiawan, 2021)
$primUrl = "https://jurnal.ubd.ac.id/index.php/PE/article/view/586"
try {
    $wc2 = New-Object System.Net.WebClient
    $wc2.Headers.Add("User-Agent", "Mozilla/5.0")
    $html2 = $wc2.DownloadString($primUrl)
    if ($html2 -match 'citation_pdf_url" content="([^"]+)"') {
        $pdfUrl2 = $matches[1]
        Write-Host "Primanomics PDF URL: $pdfUrl2"
        $outFile2 = Join-Path $targetDir "S-FEB_2021_Tecoalu_Primanomics_Keputusan_Pembelian.pdf"
        $wc2.DownloadFile($pdfUrl2, $outFile2)
        $fi2 = Get-Item $outFile2
        Write-Host "Primanomics PDF downloaded: $($fi2.Length) bytes"
    }
} catch {
    Write-Host "Error Primanomics: $($_.Exception.Message)"
}

# 3. Check Syntax Idea (Wahyoedi & Tecoalu, 2024)
$syntaxUrl = "https://jurnal.syntax-idea.co.id/index.php/syntax-idea/article/view/3107"
try {
    $wc3 = New-Object System.Net.WebClient
    $wc3.Headers.Add("User-Agent", "Mozilla/5.0")
    $html3 = $wc3.DownloadString($syntaxUrl)
    if ($html3 -match 'citation_pdf_url" content="([^"]+)"') {
        $pdfUrl3 = $matches[1]
        Write-Host "Syntax Idea PDF URL: $pdfUrl3"
        $outFile3 = Join-Path $targetDir "S-FEB_2024_Wahyoedi_Tecoalu_Syntax_Idea.pdf"
        $wc3.DownloadFile($pdfUrl3, $outFile3)
        $fi3 = Get-Item $outFile3
        Write-Host "Syntax Idea PDF downloaded: $($fi3.Length) bytes"
    }
} catch {
    Write-Host "Error Syntax Idea: $($_.Exception.Message)"
}

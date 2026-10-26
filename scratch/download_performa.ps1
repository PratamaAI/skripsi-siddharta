$headers = @{'User-Agent' = 'Mozilla/5.0'}
$url = "https://journal.uc.ac.id/index.php/performa/article/view/3993"
try {
    $res = Invoke-WebRequest -Uri $url -Headers $headers -TimeoutSec 15
    $pdfLink = $res.Links | Where-Object { $_.href -match 'download|pdf' } | Select-Object -First 1 -ExpandProperty href
    Write-Host "Found PDF link: $pdfLink"
    if ($pdfLink) {
        $out = "TOPIK_2_TAKSI_GREEN_SM\06_Referensi_Jurnal_PDF\01_Penelitian_Terdahulu_Empiris\04_Kombinasi_Variabel_&_Y\Performa_2024_Electric_Vehicle_Purchase_Intention.pdf"
        Invoke-WebRequest -Uri $pdfLink -OutFile $out -Headers $headers -TimeoutSec 20
        $bytes = [System.IO.File]::ReadAllBytes($out)
        $magic = [System.Text.Encoding]::ASCII.GetString($bytes[0..3])
        Write-Host "SUCCESS: Magic=$magic, Size=$($bytes.Length) bytes" -ForegroundColor Green
    }
} catch {
    Write-Host "Error: $_"
}

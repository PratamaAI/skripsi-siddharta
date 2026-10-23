$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# S11
$u11 = "https://www.mdpi.com/2073-8994/13/8/1545/pdf?version=1629881881"
$f11 = "06_Referensi_Jurnal_PDF/01_Empiris_Utama_2021-2025/2021_Perez_TAM_Mobile_Games_Symmetry_MDPI.pdf"

# S17
$u17 = "https://www.mdpi.com/2078-2489/11/10/478/pdf?version=1602146452"
$f17 = "06_Referensi_Jurnal_PDF/01_Empiris_Utama_2021-2025/2020_Khwaja_eWOM_Trust_Adoption_Info_MDPI.pdf"

function Download-And-Check($url, $file, $label) {
    Write-Output "Downloading $label from $url..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $file -UserAgent $ua -TimeoutSec 45
        if (Test-Path $file) {
            $bytes = [System.IO.File]::ReadAllBytes($file)
            $header = [System.Text.Encoding]::ASCII.GetString($bytes, 0, 5)
            Write-Output ("$label Success: " + $bytes.Length + " bytes | Magic: " + $header)
            if ($header -ne "%PDF-") {
                Write-Output "$label Warning: File is not a valid PDF (HTML response or blocked)."
            }
        }
    } catch {
        Write-Output ("$label Failed: " + $_.Exception.Message)
    }
}

Download-And-Check $u11 $f11 "S11 (Perez 2021)"
Download-And-Check $u17 $f17 "S17 (Khwaja 2020)"

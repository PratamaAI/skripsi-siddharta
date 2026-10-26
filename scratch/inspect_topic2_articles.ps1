Add-Type -AssemblyName System.Web

$papers = @(
    @{ File = "01_X1_Brand_Image/Manurung_2025_Brand_Image_Mobil_Listrik.pdf"; Doi = "10.24912/jmbk.v9i5.35326" },
    @{ File = "01_X1_Brand_Image/Visioner_2024_Brand_Image_InDrive_Transportasi.pdf"; Doi = "10.52630/jmbv.v14.i01.102" },
    @{ File = "01_X1_Brand_Image/Wikantara_2021_Brand_Image_Transportasi.pdf"; Doi = "10.24843/ejmunud.2021.v10.i05.p02" },
    @{ File = "02_X2_Brand_Trust/Hera_2023_Brand_Image_Trust_Purchase_Decision.pdf"; Doi = "10.47065/ekuitas.v4i3.2810" },
    @{ File = "03_X3_Perceived_Safety/Patricia_2026_Keamanan_Kepercayaan_Keputusan.pdf"; Doi = "10.33395/jmp.v15i1.16085" },
    @{ File = "03_X3_Perceived_Safety/Undip_2020_Persepsi_Keamanan_Keputusan_Penggunaan.pdf"; Doi = "10.14710/jiab.2020.26225" },
    @{ File = "04_Kombinasi_Variabel_&_Y/EKUITAS_2025_Brand_Image_Trust_Purchase_Decision.pdf"; Doi = "10.47065/ekuitas.v6i3.6975" },
    @{ File = "04_Kombinasi_Variabel_&_Y/IJSR_2025_Brand_Image_Trust_EV.pdf"; Doi = "10.55324/josr.v4i3.2456" },
    @{ File = "04_Kombinasi_Variabel_&_Y/JEMR_2025_Brand_Image_Trust_EV_Purchase.pdf"; Doi = "10.61987/jemr.v4i6.1474" },
    @{ File = "04_Kombinasi_Variabel_&_Y/Stekom_2024_Ride_Hailing_GrabCar_Keputusan_Penggunaan.pdf"; Doi = "10.51903/e-bisnis.v18i2.2583" },
    @{ File = "04_Kombinasi_Variabel_&_Y/Undip_2020_Keputusan_Penggunaan_Taksi.pdf"; Doi = "10.14710/jiab.2020.28132" }
)

$details = @()

foreach ($p in $papers) {
    Write-Host "Getting Crossref metadata for DOI: $($p.Doi)"
    try {
        $meta = Invoke-RestMethod -Uri "https://api.crossref.org/works/$($p.Doi)" -TimeoutSec 15
        $item = $meta.message
        $authorList = @()
        if ($item.author) {
            foreach ($a in $item.author) {
                $authorList += "$($a.family), $($a.given)"
            }
        }
        $year = $item.issued.'date-parts'[0][0]
        $title = $item.title -join " "
        $journal = $item.'container-title' -join " "
        $volume = $item.volume
        $issue = $item.issue
        $page = $item.page
        
        $details += [PSCustomObject]@{
            File = $p.File
            Title = $title
            Authors = ($authorList -join "; ")
            Year = $year
            Journal = $journal
            Volume = $volume
            Issue = $issue
            Page = $page
            DOI = $p.Doi
        }
    } catch {
        Write-Host "Error for $($p.Doi): $_"
    }
    Start-Sleep -Milliseconds 500
}

$details | Format-List | Out-File "scratch/topic2_metadata_extracted.txt" -Encoding utf8
Write-Host "Saved metadata to scratch/topic2_metadata_extracted.txt"

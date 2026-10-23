$base = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\06_Referensi_Jurnal_PDF"

# Define destination directories
$dirX1 = Join-Path $base "01_Penelitian_Terdahulu_Empiris\01_X1_Influencer_Marketing"
$dirX2 = Join-Path $base "01_Penelitian_Terdahulu_Empiris\02_X2_Electronic_Word_of_Mouth"
$dirX3 = Join-Path $base "01_Penelitian_Terdahulu_Empiris\03_X3_Perceived_Enjoyment"
$dirY  = Join-Path $base "01_Penelitian_Terdahulu_Empiris\04_Y_Continuance_Intention"
$dirDosen = Join-Path $base "02_Karya_Dosen_FEB_UKRIDA"
$dirTeori = Join-Path $base "03_Landasan_Teori_&_Metodologi"

# Create directories if not exist
New-Item -ItemType Directory -Force -Path $dirX1 | Out-Null
New-Item -ItemType Directory -Force -Path $dirX2 | Out-Null
New-Item -ItemType Directory -Force -Path $dirX3 | Out-Null
New-Item -ItemType Directory -Force -Path $dirY | Out-Null
New-Item -ItemType Directory -Force -Path $dirDosen | Out-Null
New-Item -ItemType Directory -Force -Path $dirTeori | Out-Null

# Mapping of source to new destination
$mappings = @(
    # X1
    @{
        Src = "01_Empiris_Utama_2021-2025\2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf"
        DestDir = $dirX1
        NewName = "S01_2022_Martiningsih_Influencer_Credibility_ICOEBS.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2023_Hartanto_Influencer_Purchase_Intention_GIEBM.pdf"
        DestDir = $dirX1
        NewName = "S02_2023_Hartanto_Influencer_Purchase_Intention_GIEBM.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2023_Bevan_Dye_GenY_Influencer_IM.pdf"
        DestDir = $dirX1
        NewName = "S03_2023_Bevan_Dye_GenY_Influencer_IM.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2021_Putri_Influencer_Brand_Image_IIJM.pdf"
        DestDir = $dirX1
        NewName = "S04_2021_Putri_Influencer_Brand_Image_IIJM.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2025_Asmawati_Influencer_GenZ_IIJSE.pdf"
        DestDir = $dirX1
        NewName = "S05_2025_Asmawati_Influencer_GenZ_IIJSE.pdf"
    },
    # X2
    @{
        Src = "01_Empiris_Utama_2021-2025\2022_Rahaman_eWOM_Purchase_PLOS_ONE.pdf"
        DestDir = $dirX2
        NewName = "S06_2022_Rahaman_eWOM_Purchase_PLOS_ONE.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2022_Halim_Keni_eWOM_Purchase_Intention_ICEBM.pdf"
        DestDir = $dirX2
        NewName = "S07_2022_Halim_Keni_eWOM_Purchase_Intention_ICEBM.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2023_Utami_Dewi_eWOM_Intention_ICOEINS.pdf"
        DestDir = $dirX2
        NewName = "S08_2023_Utami_Dewi_eWOM_Intention_ICOEINS.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2020_Zahratu_Hurriyati_eWOM_Intention_GCBME.pdf"
        DestDir = $dirX2
        NewName = "S09_2020_Zahratu_Hurriyati_eWOM_Intention_GCBME.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2023_Sastri_eWOM_Perceived_Quality_Ekobis.pdf"
        DestDir = $dirX2
        NewName = "S10_2023_Sastri_eWOM_Perceived_Quality_Ekobis.pdf"
    },
    # X3
    @{
        Src = "01_Empiris_Utama_2021-2025\2024_Artadita_Firmialy_Gamers_Enjoyment_BBR_Scopus.pdf"
        DestDir = $dirX3
        NewName = "S11_2024_Artadita_Firmialy_Gamers_Enjoyment_BBR_Scopus.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2021_Bongso_Dewi_Flow_Enjoyment_Abiwara.pdf"
        DestDir = $dirX3
        NewName = "S12_2021_Bongso_Dewi_Flow_Enjoyment_Abiwara.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2023_Kurnia_Enjoyment_Kontinuitas_Mobile_Game_JMBI.pdf"
        DestDir = $dirX3
        NewName = "S13_2023_Kurnia_Enjoyment_Kontinuitas_Mobile_Game_JMBI.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2022_Dewi_TAM_Enjoyment_PUBG_JBMS.pdf"
        DestDir = $dirX3
        NewName = "S14_2022_Dewi_TAM_Enjoyment_PUBG_JBMS.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2020_Gultom_Enjoyment_Continuance_JGGAG.pdf"
        DestDir = $dirX3
        NewName = "S15_2020_Gultom_Enjoyment_Continuance_JGGAG.pdf"
    },
    # Y
    @{
        Src = "01_Empiris_Utama_2021-2025\2022_Ranti_Determinant_Purchase_Intention_JMM.pdf"
        DestDir = $dirY
        NewName = "S16_2022_Ranti_Determinant_Purchase_Intention_JMM.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2025_Peng_Bai_Continuance_Intention_LoL_IEEE.pdf"
        DestDir = $dirY
        NewName = "S17_2025_Peng_Bai_Continuance_Intention_LoL_IEEE.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2020_Dyego_eWOM_Purchase_Intention_TICASH.pdf"
        DestDir = $dirY
        NewName = "S18_2020_Dyego_eWOM_Purchase_Intention_TICASH.pdf"
    },
    # Dosen
    @{
        Src = "01_Empiris_Utama_2021-2025\2024_Colline_Young_Investors_IMFI.pdf"
        DestDir = $dirDosen
        NewName = "S-FEB_2024_Colline_Young_Investors_IMFI.pdf"
    },
    @{
        Src = "01_Empiris_Utama_2021-2025\2024_Colline_Biases_Indonesian_Stock_Investor_AFS.pdf"
        DestDir = $dirDosen
        NewName = "S-FEB_2024_Colline_Biases_Indonesian_Stock_Investor_AFS.pdf"
    },
    # Teori
    @{
        Src = "02_Jurnal_Teori_&_Metodologi\1991_Ajzen_Theory_of_Planned_Behavior.pdf"
        DestDir = $dirTeori
        NewName = "Teori_1991_Ajzen_Theory_of_Planned_Behavior.pdf"
    },
    @{
        Src = "02_Jurnal_Teori_&_Metodologi\2012_Gueltekin_Ozer_Hedonic_Browsing_JEBS.pdf"
        DestDir = $dirTeori
        NewName = "Teori_2012_Gueltekin_Ozer_Hedonic_Browsing_JEBS.pdf"
    },
    @{
        Src = "02_Jurnal_Teori_&_Metodologi\2020_Tirtayasa_Nevianda_Syahrial_Hedonic_IJBE.pdf"
        DestDir = $dirTeori
        NewName = "Teori_2020_Tirtayasa_Nevianda_Syahrial_Hedonic_IJBE.pdf"
    }
)

foreach ($m in $mappings) {
    $srcPath = Join-Path $base $m.Src
    $destPath = Join-Path $m.DestDir $m.NewName
    Copy-Item -Path $srcPath -Destination $destPath -Force
    Write-Output "Copied: $($m.NewName) -> $(Test-Path $destPath)"
}

$baseDir = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA\TOPIK_2_TAKSI_GREEN_SM\08_Sumber_Artikel_&_Data_Industri"
$shortcutDir = Join-Path $baseDir "shortcuts_browser"

if (-not (Test-Path $shortcutDir)) {
    New-Item -ItemType Directory -Path $shortcutDir -Force | Out-Null
}

$shortcuts = @(
    @{
        Name = "01_Top_Brand_Award_2024_Transportasi_Online.url";
        Url  = "https://www.topbrand-award.com/top-brand-index/?tbi_find=Transportasi+Online"
    },
    @{
        Name = "02_Mirae_Asset_Sekuritas_Riset_Duopoli_Ride_Hailing.url";
        Url  = "https://www.cnbcindonesia.com/tech/20230206141520-37-411382/babak-baru-perang-gojek-vs-grab-siapa-paling-cuan"
    },
    @{
        Name = "03_Green_SM_Indonesia_Official_Website.url";
        Url  = "https://www.greensm.com/id"
    },
    @{
        Name = "04_CNN_Indonesia_Peluncuran_Taksi_Listrik_Green_SM_Jakarta.url";
        Url  = "https://www.cnnindonesia.com/otomotif/20241218151025-579-1178652/taksi-listrik-asal-vietnam-green-sm-resmi-beroperasi-di-indonesia"
    },
    @{
        Name = "05_Frontier_Research_Top_Brand_Index_Official.url";
        Url  = "https://frontier.co.id/"
    },
    @{
        Name = "06_BPS_DKI_Jakarta_Jumlah_Kendaraan_Bermotor_2023.url";
        Url  = "https://jakarta.bps.go.id/publication/2023/02/28/provinsi-dki-jakarta-dalam-angka-2023.html"
    },
    @{
        Name = "07_DLH_DKI_Jakarta_Inventarisasi_Emisi_Polusi_Udara.url";
        Url  = "https://lingkunganhidup.jakarta.go.id/"
    },
    @{
        Name = "08_IEA_Global_EV_Outlook_2023.url";
        Url  = "https://www.iea.org/reports/global-ev-outlook-2023"
    },
    @{
        Name = "09_JDIH_Perpres_55_2019_Kendaraan_Listrik_Baterai.url";
        Url  = "https://peraturan.bpk.go.id/Details/122045/perpres-no-55-tahun-2019"
    },
    @{
        Name = "10_JDIH_Pergub_DKI_90_2021_Rendah_Karbon_Daerah.url";
        Url  = "https://jdih.jakarta.go.id/dokumen/detail/10940"
    },
    @{
        Name = "11_Katadata_Survei_Pangsa_Pasar_Transportasi_Online.url";
        Url  = "https://databoks.katadata.co.id/datapublish/2023/03/08/survei-transportasi-online-paling-banyak-digunakan-di-indonesia"
    },
    @{
        Name = "12_Blue_Bird_Group_Official_Portal.url";
        Url  = "https://www.bluebirdgroup.com/"
    },
    @{
        Name = "13_Populix_Electric_Vehicle_Dynamics_Report.url";
        Url  = "https://populix.co/"
    },
    @{
        Name = "14_INDEF_Kajian_Persaingan_Transportasi_Online.url";
        Url  = "https://indef.or.id/"
    },
    @{
        Name = "15_Kompas_Otomotif_Evaluasi_Pengemudi_Taksi_Listrik.url";
        Url  = "https://otomotif.kompas.com/"
    }
)

foreach ($sc in $shortcuts) {
    $filePath = Join-Path $shortcutDir $sc.Name
    $content = "[InternetShortcut]`r`nURL=$($sc.Url)`r`n"
    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::ASCII)
    Write-Host "Created shortcut: $($sc.Name)"
}

# Create bookmarks.html
$bookmarkHtml = @"
<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file.
     It will be read and overwritten.
     DO NOT EDIT! -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks Skripsi Siddharta - Taksi Green SM</TITLE>
<H1>Bookmarks Skripsi Siddharta - Taksi Green SM</H1>
<DL><p>
    <DT><H3 ADD_DATE="1729900000" LAST_MODIFIED="1729900000">Referensi Riset Pasar & Artikel Topik 2 Taksi Green SM</H3>
    <DL><p>
        <DT><A HREF="https://www.topbrand-award.com/top-brand-index/?tbi_find=Transportasi+Online" ADD_DATE="1729900000">Top Brand Award 2024 - Transportasi Online (Frontier Group)</A>
        <DT><A HREF="https://www.cnbcindonesia.com/tech/20230206141520-37-411382/babak-baru-perang-gojek-vs-grab-siapa-paling-cuan" ADD_DATE="1729900000">CNBC Indonesia - Riset Duopoli Grab & Gojek (Mirae Asset Sekuritas)</A>
        <DT><A HREF="https://www.greensm.com/id" ADD_DATE="1729900000">Green SM Indonesia - Official Website (PT Xanh SM)</A>
        <DT><A HREF="https://www.cnnindonesia.com/otomotif/20241218151025-579-1178652/taksi-listrik-asal-vietnam-green-sm-resmi-beroperasi-di-indonesia" ADD_DATE="1729900000">CNN Indonesia - Peluncuran Taksi Listrik Green SM di Jakarta (18 Des 2024)</A>
        <DT><A HREF="https://frontier.co.id/" ADD_DATE="1729900000">Frontier Group - Corporate Research & Methodology</A>
        <DT><A HREF="https://jakarta.bps.go.id/publication/2023/02/28/provinsi-dki-jakarta-dalam-angka-2023.html" ADD_DATE="1729900000">BPS Provinsi DKI Jakarta - DKI Jakarta Dalam Angka 2023</A>
        <DT><A HREF="https://lingkunganhidup.jakarta.go.id/" ADD_DATE="1729900000">DLH DKI Jakarta - Laporan Inventarisasi Emisi Polusi Udara</A>
        <DT><A HREF="https://www.iea.org/reports/global-ev-outlook-2023" ADD_DATE="1729900000">IEA - Global EV Outlook 2023</A>
        <DT><A HREF="https://peraturan.bpk.go.id/Details/122045/perpres-no-55-tahun-2019" ADD_DATE="1729900000">JDIH RI - Perpres No. 55 Tahun 2019 (Akselerasi BEV)</A>
        <DT><A HREF="https://jdih.jakarta.go.id/dokumen/detail/10940" ADD_DATE="1729900000">JDIH DKI Jakarta - Pergub DKI No. 90 Tahun 2021 (Rendah Karbon)</A>
        <DT><A HREF="https://databoks.katadata.co.id/datapublish/2023/03/08/survei-transportasi-online-paling-banyak-digunakan-di-indonesia" ADD_DATE="1729900000">Katadata Databoks - Survei Transportasi Online Indonesia</A>
        <DT><A HREF="https://www.bluebirdgroup.com/" ADD_DATE="1729900000">PT Blue Bird Tbk - Official Corporate Website</A>
    </DL><p>
</DL><p>
"@

$bookmarkPath = Join-Path $baseDir "bookmarks_skripsi_taksi_green_sm.html"
[System.IO.File]::WriteAllText($bookmarkPath, $bookmarkHtml, [System.Text.Encoding]::UTF8)
Write-Host "Created HTML bookmarks file: $bookmarkPath"

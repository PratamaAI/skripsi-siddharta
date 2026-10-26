$ErrorActionPreference = "Stop"

$workspaceRoot = "c:\Users\siddh\OneDrive\Documents\SKRIPSI SIDDHARTA"
$topicDir = Join-Path $workspaceRoot "TOPIK_2_TAKSI_GREEN_SM"
$outDocx = Join-Path $topicDir "01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx"
$outPdf  = Join-Path $topicDir "01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.pdf"

Write-Host "Initializing Microsoft Word COM Object..."
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$word.ScreenUpdating = $false

$outDocx = [string]$outDocx
$outPdf  = [string]$outPdf

try {
    $doc = $word.Documents.Add()
    
    # Page Setup (A4, 4-3-3-3 cm)
    # 1 cm = 28.3465 points
    $doc.PageSetup.PaperSize = 7 # wdPaperA4
    $doc.PageSetup.TopMargin = 3 * 28.3465
    $doc.PageSetup.BottomMargin = 3 * 28.3465
    $doc.PageSetup.LeftMargin = 4 * 28.3465
    $doc.PageSetup.RightMargin = 3 * 28.3465

    function Add-PlainPara {
        param(
            [string]$text,
            [int]$alignment = 3, # 0=Left, 1=Center, 2=Right, 3=Justify
            [bool]$bold = $false,
            [bool]$italic = $false,
            [float]$size = 12,
            [float]$spaceAfter = 6,
            [float]$firstLineIndent = 0,
            [float]$lineSpacing = 18, # 18pt = 1.5 lines
            [bool]$keepWithNext = $false
        )
        $p = $doc.Paragraphs.Add()
        $p.Range.Text = $text
        $p.Range.Font.Name = "Times New Roman"
        $p.Range.Font.Size = $size
        $p.Range.Font.Bold = [int]$bold
        $p.Range.Font.Italic = [int]$italic
        $p.Alignment = $alignment
        $p.Format.SpaceBefore = 0
        $p.Format.SpaceAfter = $spaceAfter
        $p.Format.FirstLineIndent = $firstLineIndent
        $p.Format.LineSpacing = $lineSpacing
        if ($keepWithNext) {
            $p.Format.KeepWithNext = -1
        }
        $p.Range.InsertParagraphAfter()
    }

    function Add-PageBreak {
        $p = $doc.Paragraphs.Add()
        $p.Range.InsertBreak(7) # wdPageBreak
    }

    Write-Host "Writing Cover Page with UKRIDA Logo at top..."
    $logoPath = [string](Resolve-Path (Join-Path $topicDir "01_Naskah_Utama\images\ukrida_pentagram.png")).Path
    if (-not (Test-Path $logoPath)) {
        $logoPath = [string](Resolve-Path (Join-Path $topicDir "01_Naskah_Utama\images\Logo_UKRIDA_300x300.png")).Path
    }

    # 1. Logo at top (width 3.2 cm, height 3.2 cm)
    $pLogo = $doc.Paragraphs.Add()
    $pLogo.Alignment = 1 # Center
    $pLogo.Format.SpaceBefore = 0
    $pLogo.Format.SpaceAfter = 14
    $shape = $pLogo.Range.InlineShapes.AddPicture($logoPath, $false, $true)
    $shape.Width = 3.2 * 28.3465
    $shape.Height = 3.2 * 28.3465

    # 2. Header
    Add-PlainPara "PROPOSAL TUGAS AKHIR" -alignment 1 -bold $true -size 14 -spaceAfter 16 -lineSpacing 14

    # 3. Formatted Title with foreign terms in italics
    $pTitle = $doc.Paragraphs.Add()
    $pTitle.Alignment = 1 # Center
    $pTitle.Format.SpaceBefore = 0
    $pTitle.Format.SpaceAfter = 20
    $pTitle.Format.LineSpacing = 16

    $runs = @(
        @{ Text = "PENGARUH "; Bold = $true; Italic = $false },
        @{ Text = "BRAND IMAGE"; Bold = $true; Italic = $true },
        @{ Text = ", "; Bold = $true; Italic = $false },
        @{ Text = "BRAND TRUST"; Bold = $true; Italic = $true },
        @{ Text = " DAN "; Bold = $true; Italic = $false },
        @{ Text = "PERCEIVED SAFETY"; Bold = $true; Italic = $true },
        @{ Text = " TERHADAP "; Bold = $true; Italic = $false },
        @{ Text = "PURCHASE DECISION"; Bold = $true; Italic = $true },
        @{ Text = " DALAM PENGGUNAAN JASA TAKSI "; Bold = $true; Italic = $false },
        @{ Text = "GREEN SM"; Bold = $true; Italic = $true },
        @{ Text = " DI WILAYAH JAKARTA BARAT"; Bold = $true; Italic = $false }
    )

    foreach ($r in $runs) {
        $end = $pTitle.Range.End - 1
        $rng = $doc.Range($end, $end)
        $rng.Text = $r.Text
        $rng.Font.Name = "Times New Roman"
        $rng.Font.Size = 13.5
        $rng.Font.Bold = [int]$r.Bold
        $rng.Font.Italic = [int]$r.Italic
    }
    $pTitle.Range.InsertParagraphAfter()

    # 4. Submission Subtitle
    Add-PlainPara "Diajukan Kepada Program Studi Manajemen" -alignment 1 -bold $false -size 12 -spaceAfter 2 -lineSpacing 14
    Add-PlainPara "Untuk Menyusun Tugas Akhir Sarjana Manajemen" -alignment 1 -bold $false -size 12 -spaceAfter 24 -lineSpacing 14

    # 5. Author
    Add-PlainPara "Diajukan Oleh:" -alignment 1 -bold $false -size 12 -spaceAfter 4 -lineSpacing 14
    Add-PlainPara "SIDDHARTA PRATAMA BUDIONO" -alignment 1 -bold $true -size 13 -spaceAfter 2 -lineSpacing 14
    Add-PlainPara "312023017" -alignment 1 -bold $true -size 12 -spaceAfter 26 -lineSpacing 14

    # 6. Institution
    Add-PlainPara "PROGRAM STUDI MANAJEMEN" -alignment 1 -bold $true -size 13 -spaceAfter 3 -lineSpacing 14
    Add-PlainPara "FAKULTAS EKONOMI DAN BISNIS" -alignment 1 -bold $true -size 13 -spaceAfter 3 -lineSpacing 14
    Add-PlainPara "UNIVERSITAS KRISTEN KRIDA WACANA" -alignment 1 -bold $true -size 13 -spaceAfter 3 -lineSpacing 14
    Add-PlainPara "JAKARTA 2026" -alignment 1 -bold $true -size 13 -spaceAfter 0 -lineSpacing 14

    Add-PageBreak

    Write-Host "Writing Approval Page..."
    Add-PlainPara "LEMBAR PERSETUJUAN PROPOSAL SKRIPSI" -alignment 1 -bold $true -size 14 -spaceAfter 24
    
    Add-PlainPara "Judul Proposal : Pengaruh Brand Image, Brand Trust dan Perceived Safety terhadap Purchase Decision dalam Penggunaan Jasa Taksi Green SM di Wilayah Jakarta Barat" -alignment 0 -spaceAfter 6
    Add-PlainPara "Nama Mahasiswa : Siddharta Pratama Budiono" -alignment 0 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "NIM            : 312023017" -alignment 0 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "Program Studi  : S1 Manajemen" -alignment 0 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "Konsentrasi    : Manajemen Pemasaran" -alignment 0 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "Fakultas       : Ekonomi dan Bisnis" -alignment 0 -bold $false -size 12 -spaceAfter 24
    Add-PlainPara "Proposal Skripsi ini telah diperiksa, disetujui, dan dinyatakan layak untuk diajukan dalam Seminar Proposal Skripsi Fakultas Ekonomi dan Bisnis Universitas Kristen Krida Wacana (UKRIDA)." -alignment 3 -bold $false -size 12 -spaceAfter 36 -firstLineIndent (1.25 * 28.3465)

    Add-PlainPara "Jakarta, 25 Oktober 2026" -alignment 2 -bold $false -size 12 -spaceAfter 12
    Add-PlainPara "Menyetujui," -alignment 2 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "Dosen Pembimbing," -alignment 2 -bold $false -size 12 -spaceAfter 60
    Add-PlainPara "(Dr. Fredella Colline, S.E., M.M.)" -alignment 2 -bold $true -size 12 -spaceAfter 4
    Add-PlainPara "NIDN: 0315049001" -alignment 2 -bold $false -size 11 -spaceAfter 36

    Add-PlainPara "Mengetahui," -alignment 0 -bold $false -size 12 -spaceAfter 6
    Add-PlainPara "Ketua Program Studi S1 Manajemen FEB UKRIDA," -alignment 0 -bold $false -size 12 -spaceAfter 60
    Add-PlainPara "( ........................................................... )" -alignment 0 -bold $false -size 12 -spaceAfter 12

    Add-PageBreak

    Write-Host "Writing Table of Contents..."
    Add-PlainPara "DAFTAR ISI" -alignment 1 -bold $true -size 14 -spaceAfter 18
    $tocLines = @(
        "HALAMAN JUDUL ......................................................................................................................... i",
        "LEMBAR PERSETUJUAN PROPOSAL SKRIPSI ................................................................................... ii",
        "DAFTAR ISI ................................................................................................................................... iii",
        "DAFTAR TABEL ............................................................................................................................... iv",
        "DAFTAR GAMBAR ............................................................................................................................. v",
        "",
        "BAB I PENDAHULUAN ..................................................................................................................... 1",
        "  1.1 Latar Belakang Penelitian ....................................................................................................... 1",
        "  1.2 Perumusan Masalah ............................................................................................................... 6",
        "  1.3 Tujuan Penelitian ............................................................................................................... 7",
        "  1.4 Manfaat Penelitian .............................................................................................................. 7",
        "    1.4.1 Manfaat Teoritis ............................................................................................................ 7",
        "    1.4.2 Manfaat Praktis ............................................................................................................. 8",
        "",
        "BAB II TINJAUAN PUSTAKA DAN PENGEMBANGAN HIPOTESIS ........................................................... 10",
        "  2.1 Landasan Teori ....................................................................................................................... 10",
        "    2.1.1 Perilaku Konsumen dan Keputusan Pembelian (Purchase Decision) ................................. 10",
        "    2.1.2 Teori Penjelas Pendukung (TPB & Perceived Risk Theory) ................................................... 12",
        "    2.1.3 Citra Merek (Brand Image) ................................................................................................ 13",
        "    2.1.4 Kepercayaan Merek (Brand Trust) ...................................................................................... 15",
        "    2.1.5 Persepsi Keamanan dan Keselamatan (Perceived Safety) .................................................... 17",
        "    2.1.6 Perspektif Dosen Program Studi Manajemen FEB UKRIDA .................................................... 18",
        "  2.2 Penelitian Terdahulu ............................................................................................................... 19",
        "  2.3 Pengembangan Hipotesis Penelitian ......................................................................................... 23",
        "    2.3.1 Pengaruh Brand Image terhadap Purchase Decision (H1) ................................................... 23",
        "    2.3.2 Pengaruh Brand Trust terhadap Purchase Decision (H2) .................................................... 24",
        "    2.3.3 Pengaruh Perceived Safety terhadap Purchase Decision (H3) ............................................. 25",
        "  2.4 Kerangka Pemikiran Konseptual ............................................................................................... 27",
        "",
        "BAB III METODOLOGI PENELITIAN ................................................................................................... 28",
        "  3.1 Objek Penelitian dan Desain Penelitian .................................................................................... 28",
        "  3.2 Definisi Operasional dan Pengukuran Variabel ........................................................................... 29",
        "  3.3 Populasi, Sampel, dan Teknik Penarikan Sampel ......................................................................... 32",
        "  3.4 Metode Pengumpulan Data ...................................................................................................... 34",
        "  3.5 Metode Analisis Data ............................................................................................................... 35",
        "",
        "DAFTAR PUSTAKA ............................................................................................................................. 40",
        "",
        "LAMPIRAN ......................................................................................................................................... 45",
        "  Lampiran 1: Draf Instrumen Kuesioner Penelitian (Google Forms) ................................................... 45",
        "  Lampiran 2: Matriks Penelitian Terdahulu (Literature Matrix) ............................................................. 50"
    )
    foreach ($line in $tocLines) {
        if ($line -eq "") {
            Add-PlainPara "" -spaceAfter 6
        } else {
            Add-PlainPara $line -alignment 0 -bold ($line -match '^BAB|^DAFTAR|^LAMPIRAN') -size 11 -spaceAfter 3
        }
    }

    Add-PageBreak

    # Helper function to append markdown text as clean, regular paragraphs and tables
    function Append-MarkdownFile {
        param([string]$filePath)
        $lines = Get-Content $filePath -Encoding utf8
        $inTable = $false
        $tableLines = @()
        
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $line = $lines[$i]
            $trimmed = $line.Trim()
            
            # Check if this line is part of a markdown table
            if ($trimmed -match '^\|.*\|$') {
                $inTable = $true
                $tableLines += $trimmed
                continue
            } else {
                if ($inTable) {
                    Render-MarkdownTable $tableLines
                    $inTable = $false
                    $tableLines = @()
                }
            }
            
            if ($trimmed -eq "" -or $trimmed -eq "---") { continue }
            
            # Clean all markdown markers (asterisks, backticks, math signs)
            # This guarantees that the base text is 100% REGULAR / TEGAK!
            $clean = $trimmed -replace '\*\*\*', '' -replace '\*\*', '' -replace '\*', '' -replace '`', '' -replace '\$\$(.*?)\$\$', '$1' -replace '\$(.*?)\$', '$1'
            
            # Heading 1
            if ($trimmed -match '^# (.*)') {
                $h = $matches[1] -replace '\*', ''
                Add-PlainPara $h -alignment 1 -bold $true -italic $false -size 14 -spaceAfter 12 -keepWithNext $true
            }
            # Heading 2
            elseif ($trimmed -match '^## (.*)') {
                $h = $matches[1] -replace '\*', ''
                Add-PlainPara $h -alignment 0 -bold $true -italic $false -size 12 -spaceAfter 8 -keepWithNext $true
            }
            # Heading 3
            elseif ($trimmed -match '^### (.*)') {
                $h = $matches[1] -replace '\*', ''
                Add-PlainPara $h -alignment 0 -bold $true -italic $false -size 12 -spaceAfter 6 -keepWithNext $true
            }
            # Heading 4
            elseif ($trimmed -match '^#### (.*)') {
                $h = $matches[1] -replace '\*', ''
                Add-PlainPara $h -alignment 0 -bold $true -italic $true -size 12 -spaceAfter 4 -keepWithNext $true
            }
            # Blockquote
            elseif ($trimmed -match '^> (.*)') {
                $bq = $matches[1] -replace '\*', ''
                Add-PlainPara $bq -alignment 3 -bold $false -italic $true -size 11 -spaceAfter 8 -firstLineIndent (1.25 * 28.3465)
            }
            # Normal paragraph or list items
            else {
                # List items
                if ($clean -match '^[0-9]+\.\s+(.*)') {
                    Add-PlainPara $clean -alignment 3 -bold $false -italic $false -size 12 -spaceAfter 4 -firstLineIndent (0.75 * 28.3465)
                } elseif ($clean -match '^-\s+(.*)') {
                    Add-PlainPara $clean -alignment 3 -bold $false -italic $false -size 12 -spaceAfter 4 -firstLineIndent (0.75 * 28.3465)
                } else {
                    # Standard body text: 100% TEGAK / NORMAL!
                    Add-PlainPara $clean -alignment 3 -bold $false -italic $false -size 12 -spaceAfter 6 -firstLineIndent (1.25 * 28.3465)
                }
            }
        }
        
        # In case file ends with table
        if ($inTable) {
            Render-MarkdownTable $tableLines
        }
    }

    # Function to render markdown table into Word native Table
    function Render-MarkdownTable {
        param([array]$rawLines)
        if ($rawLines.Count -lt 2) { return }
        
        $cleanRows = @()
        foreach ($l in $rawLines) {
            if ($l -match '^\|[\s-:]+\|$' -or $l -match '^\|(?:\s*[-:]+\s*\|)+$') { continue }
            $cleanRows += $l
        }
        
        if ($cleanRows.Count -eq 0) { return }
        
        $tableData = @()
        foreach ($r in $cleanRows) {
            $cells = $r.Trim('|').Split('|') | ForEach-Object { 
                $cClean = $_.Trim() -replace '\*\*\*', '' -replace '\*\*', '' -replace '\*', '' -replace '`', '' -replace '<br>', "`n" -replace '\$\$(.*?)\$\$', '$1' -replace '\$(.*?)\$', '$1'
                $cClean
            }
            $tableData += ,@($cells)
        }
        
        $rowCount = $tableData.Count
        $colCount = $tableData[0].Count
        if ($rowCount -eq 0 -or $colCount -eq 0) { return }
        
        $end = $doc.Content.End - 1
        $rng = $doc.Range($end, $end)
        $tbl = $doc.Tables.Add($rng, $rowCount, $colCount)
        $tbl.Borders.Enable = 1
        $tbl.Range.Font.Name = "Times New Roman"
        $tbl.Range.Font.Size = 9.5
        $tbl.Range.ParagraphFormat.SpaceBefore = 2
        $tbl.Range.ParagraphFormat.SpaceAfter = 2
        $tbl.Range.ParagraphFormat.LineSpacing = 13
        
        for ($rIdx = 0; $rIdx -lt $rowCount; $rIdx++) {
            $isHeader = ($rIdx -eq 0)
            if ($isHeader) {
                $tbl.Rows.Item($rIdx + 1).Range.Font.Bold = 1
                $tbl.Rows.Item($rIdx + 1).Shading.BackgroundPatternColor = 15132390 # Light gray
            }
            $rowArr = $tableData[$rIdx]
            for ($cIdx = 0; $cIdx -lt [Math]::Min($colCount, $rowArr.Count); $cIdx++) {
                $cellVal = $rowArr[$cIdx]
                $cell = $tbl.Cell($rIdx + 1, $cIdx + 1)
                $cell.Range.Text = $cellVal
                if ($isHeader) {
                    $cell.Range.ParagraphFormat.Alignment = 1 # Center
                } else {
                    if ($cIdx -eq 0 -and $cellVal -match '^[0-9]+$') {
                        $cell.Range.ParagraphFormat.Alignment = 1 # Center number
                    } else {
                        $cell.Range.ParagraphFormat.Alignment = 0 # Left
                    }
                }
            }
        }
        $tbl.AutoFitBehavior(2) # wdAutoFitWindow
        
        $pAfter = $doc.Paragraphs.Add()
        $pAfter.Range.Text = ""
        $pAfter.Format.SpaceAfter = 6
        $pAfter.Range.InsertParagraphAfter()
    }

    Write-Host "Appending BAB I..."
    Append-MarkdownFile (Join-Path $topicDir "01_Naskah_Utama\BAB_I_DRAF.md")
    Add-PageBreak

    Write-Host "Appending BAB II..."
    Append-MarkdownFile (Join-Path $topicDir "01_Naskah_Utama\BAB_II_DRAF.md")
    Add-PageBreak

    Write-Host "Appending BAB III..."
    Append-MarkdownFile (Join-Path $topicDir "01_Naskah_Utama\BAB_III_DRAF.md")
    Add-PageBreak

    Write-Host "Appending DAFTAR PUSTAKA..."
    Append-MarkdownFile (Join-Path $topicDir "01_Naskah_Utama\DAFTAR_PUSTAKA_SEMENTARA.md")
    Add-PageBreak

    Write-Host "Appending LAMPIRAN..."
    Append-MarkdownFile (Join-Path $topicDir "03_Instrumen_&_Data_Survei\KUESIONER_DRAF_GOOGLE_FORMS.md")

    Write-Host "Executing Selective Word Native Find & Replace for Foreign Terms Only..."
    # These terms are formatted into Italic. All other words in the document remain 100% TEGAK / NORMAL!
    $foreignTerms = @(
        # Specific research variables & brands
        "Brand Image",
        "Brand Trust",
        "Perceived Safety",
        "Purchase Decision",
        "Purchase Decisions",
        "Purchase Intention",
        "Purchase Intentions",
        "Brand Awareness",
        "Brand Equity",
        "Brand Identity",
        "Brand Ambassador",
        "Customer Behavior",
        "Consumer Behavior",
        "Green SM Indonesia",
        "Green SM",
        "VinFast VF 5",
        "VinFast",
        "Vingroup",
        "Blue Bird",
        "GrabCar Hemat",
        "GrabCar",
        "Grab",
        "GoCar",
        "GoTo",
        "InDrive",
        "Maxim",
        "Kosti",
        "OVO",
        "QRIS",
        "Gen_Z",
        "Gen-Z",
        
        # EV & mobility specific terms
        "Battery Electric Vehicle",
        "pure electric vehicle",
        "pure electric vehicles",
        "Electric Vehicle",
        "electric vehicle",
        "electric vehicles",
        "electric motorcycle",
        "ride-hailing",
        "street hailing",
        "ridesourcing",
        "zero noise",
        "zero emission",
        "5-star service standard",
        "5-star service",
        "challenger brand",
        "green transportation",
        "green marketing",
        "brand management",
        "regenerative braking",
        "eco-friendly",
        "tech-savvy",
        
        # Theories & sub-dimensions
        "Customer-Based Brand Equity",
        "Commitment-Trust Theory",
        "Theory of Planned Behavior",
        "Perceived Risk Theory",
        "perceived risk",
        "five-stage model of the consumer buying process",
        "Problem Recognition",
        "Information Search",
        "Evaluation of Alternatives",
        "Post-Purchase Behavior",
        "actual behavior",
        "actual purchase decision",
        "repeat purchase",
        "repeat usage",
        "word-of-mouth",
        "Word of Mouth",
        "Attitude toward the behavior",
        "Subjective norm",
        "Perceived behavioral control",
        "behavioral intention",
        "perceived usefulness",
        "Ease of Use",
        "Perceived Ease of Use",
        "Social Media Communication",
        "Price Perception",
        "Consumer Trust",
        "Corporate Image",
        "User Image",
        "Product Image",
        "Product/Fleet Image",
        "Brand Reliability",
        "Financial Integrity",
        "Driver Competence",
        "Brand Benevolence",
        "Brand Intentions",
        "customer care",
        "Driving Safety",
        "driving safety",
        "Personal Security",
        "personal security",
        "Vehicle Safety",
        "Vehicle Technical Safety",
        "Physical Safety",
        "risk perception",
        "decision making behavior",
        "hygiene factor",
        "core benefit",
        "peace of mind",
        
        # Methodology & statistics terms
        "causal-explanatory research design",
        "causal-explanatory",
        "explanatory research",
        "survey method",
        "cross-sectional",
        "unknown / infinite population",
        "infinite population",
        "Non-Probability Sampling",
        "Purposive Sampling",
        "purposive sampling",
        "screening questions",
        "inclusion criteria",
        "prospective users",
        "Sample Size",
        "confidence level",
        "margin of error",
        "outlier",
        "drop-out",
        "statistical power",
        "online questionnaire",
        "Google Forms Blueprint",
        "Google Forms",
        "IBM SPSS",
        "Statistical Package for the Social Sciences",
        "Bivariate Pearson Product Moment",
        "Cronbach's Alpha",
        "Best Linear Unbiased Estimator",
        "Normal Probability Plot",
        "P-P Plot",
        "One-Sample Kolmogorov-Smirnov",
        "Asymp. Sig. (2-tailed)",
        "two-tailed",
        "Variance Inflation Factor",
        "Tolerance",
        "Scatterplot",
        "Glejser Test",
        "Glejser",
        "multiple linear regression",
        "Ordinary Least Squares",
        "Standard error",
        "Adjusted R Square",
        "goodness of fit",
        "Path Analysis",
        "PLS-SEM",
        "F-test",
        "t-test",
        "research gap",
        "research gaps",
        "software",
        "online",
        "intervening",
        
        # Latin & academic conventions
        "et al.",
        "a priori",
        "post factum",
        "vice versa",
        "ceteris paribus"
    )

    foreach ($term in $foreignTerms) {
        $find = $doc.Content.Find
        $find.ClearFormatting()
        $find.Replacement.ClearFormatting()
        $find.Text = $term
        $find.Replacement.Text = "^&"
        $find.Replacement.Font.Italic = 1
        $find.Forward = $true
        $find.Wrap = 1 # wdFindContinue
        $find.MatchCase = $false
        $find.MatchWholeWord = $false
        $find.Execute($term, $false, $false, $false, $false, $false, $true, 1, $true, "^&", 2) | Out-Null
    }

    Write-Host "Saving DOCX to $outDocx..."
    $doc.SaveAs2($outDocx)

    Write-Host "Exporting PDF to $outPdf..."
    $doc.ExportAsFixedFormat($outPdf, 17) # 17 = wdExportFormatPDF

    Write-Host "Successfully generated DOCX and PDF with clean upright Indonesian text and selective foreign italics!" -ForegroundColor Green

} catch {
    Write-Host "Error during generation: $($_.Exception.Message)" -ForegroundColor Red
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    if ($word) { 
        $word.Quit()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
    }
}

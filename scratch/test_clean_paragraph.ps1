$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    $p = $doc.Paragraphs.Add()
    $p.Range.Text = "Faktor ketiga yang sangat krusial dan memiliki kebaruan konseptual yang kuat pada penelitian ini adalah Perceived Safety (Persepsi Keamanan dan Keselamatan). Dalam teori perilaku konsumen, persepsi keselamatan berkaitan erat dengan persepsi risiko (perceived risk) (Bauer, 1960; Parasuraman et al., 1988). Penggunaan mobil listrik murni sebagai armada taksi jalanan di DKI Jakarta kerap memunculkan tanda tanya dan kekhawatiran spesifik dari sebagian calon pengguna. Kekhawatiran tersebut mencakup keandalan sistem baterai bertegangan tinggi, keamanan operasional armada di saat cuaca hujan lebat atau melewati genangan banjir yang kerap terjadi di beberapa titik Jakarta Barat, keandalan sistem pengereman (regenerative braking), hingga aspek keselamatan berkendara (driving safety) serta rasa aman penumpang dari potensi tindak kejahatan atau kecelakaan selama di perjalanan. Iliyin dan Widiartanto (2020) serta Patricia dan Djong (2026) membuktikan bahwa persepsi keamanan yang tinggi secara signifikan memicu keputusan konsumen untuk menggunakan suatu layanan secara berkelanjutan. Ketika konsumen merasa yakin bahwa taksi Green SM menjamin keselamatan fisik berkendara dan keamanan pribadi mereka, keraguan untuk memesan taksi listrik akan sirna."
    $p.Range.InsertParagraphAfter()
    
    $foreignTerms = @(
        "Perceived Safety",
        "perceived risk",
        "et al.",
        "regenerative braking",
        "driving safety",
        "Green SM"
    )
    
    foreach ($term in $foreignTerms) {
        $find = $doc.Content.Find
        $find.ClearFormatting()
        $find.Replacement.ClearFormatting()
        $find.Text = $term
        $find.Replacement.Text = "^&"
        $find.Replacement.Font.Italic = 1
        $find.Forward = $true
        $find.Wrap = 1
        $find.MatchCase = $false
        $find.MatchWholeWord = $false
        $find.Execute($term, $false, $false, $false, $false, $false, $true, 1, $true, "^&", 2) | Out-Null
    }
    
    Write-Host "Checking word by word formatting:"
    $para = $doc.Paragraphs.Item(1)
    $words = $para.Range.Words
    $italicWords = @()
    $normalWords = @()
    for ($w = 1; $w -le $words.Count; $w++) {
        $wo = $words.Item($w)
        $txt = $wo.Text.Trim()
        if ($txt -eq "") { continue }
        if ($wo.Italic -eq -1 -or $wo.Italic -eq 1) {
            $italicWords += $txt
        } else {
            $normalWords += $txt
        }
    }
    Write-Host ("Total Italic Words: " + $italicWords.Count + " -> " + ($italicWords -join ", "))
    Write-Host ("Total Normal Words: " + $normalWords.Count)
    Write-Host ("Sample Normal Words: " + (($normalWords | Select-Object -First 15) -join " "))
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

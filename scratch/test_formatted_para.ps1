$word = New-Object -ComObject Word.Application
$word.Visible = $false
try {
    $doc = $word.Documents.Add()
    
    function Add-FormattedPara {
        param(
            [string]$text,
            [int]$alignment = 3,
            [float]$size = 12,
            [float]$spaceAfter = 6,
            [float]$firstLineIndent = 0,
            [float]$lineSpacing = 18,
            [bool]$keepWithNext = $false
        )
        $p = $doc.Paragraphs.Add()
        $p.Alignment = $alignment
        $p.Format.SpaceBefore = 0
        $p.Format.SpaceAfter = $spaceAfter
        $p.Format.FirstLineIndent = $firstLineIndent
        $p.Format.LineSpacing = $lineSpacing
        if ($keepWithNext) {
            $p.Format.KeepWithNext = -1
        }
        
        $pattern = '(\*\*\*[^*]+\*\*\*|\*\*[^*]+\*\*|\*[^*]+\*|[^*]+)'
        $matches = [regex]::Matches($text, $pattern)
        foreach ($m in $matches) {
            $val = $m.Value
            if ($val -eq "") { continue }
            $bold = $false
            $italic = $false
            $runText = $val
            
            if ($val.StartsWith('***') -and $val.EndsWith('***') -and $val.Length -ge 6) {
                $runText = $val.Substring(3, $val.Length - 6)
                $bold = $true
                $italic = $true
            } elseif ($val.StartsWith('**') -and $val.EndsWith('**') -and $val.Length -ge 4) {
                $runText = $val.Substring(2, $val.Length - 4)
                $bold = $true
                $italic = $false
            } elseif ($val.StartsWith('*') -and $val.EndsWith('*') -and $val.Length -ge 2) {
                $runText = $val.Substring(1, $val.Length - 2)
                $bold = $false
                $italic = $true
            }
            
            $runText = $runText -replace '`', ''
            
            $end = $p.Range.End - 1
            $rng = $doc.Range($end, $end)
            $rng.Text = $runText
            $rng.Font.Name = "Times New Roman"
            $rng.Font.Size = $size
            $rng.Font.Bold = [int]$bold
            $rng.Font.Italic = [int]$italic
        }
        $p.Range.InsertParagraphAfter()
    }

    Add-FormattedPara "Ini adalah teks biasa dengan *Brand Image* miring dan **kata penting** tebal serta ***kombinasi keduanya***."
    
    # Check paragraphs and formatting
    $pCheck = $doc.Paragraphs.Item(1)
    Write-Host ("Para 1 text: " + $pCheck.Range.Text)
    for ($w = 1; $w -le $pCheck.Range.Words.Count; $w++) {
        $wo = $pCheck.Range.Words.Item($w)
        $txt = $wo.Text.Trim()
        if ($txt -ne "") {
            Write-Host ("Word: '$txt' | Bold: " + $wo.Bold + " | Italic: " + $wo.Italic)
        }
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

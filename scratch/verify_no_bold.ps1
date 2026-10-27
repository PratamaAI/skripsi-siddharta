$ErrorActionPreference = "Stop"
Stop-Process -Name WINWORD -Force -ErrorAction SilentlyContinue

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $docxPath = (Resolve-Path "TOPIK_2_TAKSI_GREEN_SM\01_Naskah_Utama\Proposal_Skripsi_Taksi_Green_SM.docx").Path
    $doc = $word.Documents.Open($docxPath)
    
    # Check table on page 2
    $table = $doc.Tables.Item(1)
    Write-Host "Table rows count: $($table.Rows.Count)"
    for ($r = 1; $r -le $table.Rows.Count; $r++) {
        $c1Text = $table.Cell($r, 1).Range.Text.Trim("`r`a ")
        $c1Bold = $table.Cell($r, 1).Range.Font.Bold
        $c2Text = $table.Cell($r, 2).Range.Text.Trim("`r`a ")
        $c2Bold = $table.Cell($r, 2).Range.Font.Bold
        $c3Text = $table.Cell($r, 3).Range.Text.Trim("`r`a ")
        $c3Bold = $table.Cell($r, 3).Range.Font.Bold
        Write-Host ("Row " + $r + ": '" + $c1Text + "' (Bold: " + $c1Bold + ") '" + $c2Text + "' (Bold: " + $c2Bold + ") '" + $c3Text.Substring(0, [Math]::Min(20, $c3Text.Length)) + "' (Bold: " + $c3Bold + ")")
    }
} finally {
    if ($doc) { $doc.Close([ref]$false) }
    $word.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($word) | Out-Null
}

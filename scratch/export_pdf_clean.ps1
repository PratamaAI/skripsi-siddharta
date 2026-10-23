$docxPath = (Resolve-Path "01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ_clean.docx").Path
$pdfPath = [System.IO.Path]::Combine((Split-Path $docxPath), "Proposal_Skripsi_MLBB_GenZ_clean.pdf")
$finalPdfPath = [System.IO.Path]::Combine((Split-Path $docxPath), "Proposal_Skripsi_MLBB_GenZ.pdf")

Write-Output "Opening Word..."
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = [Microsoft.Office.Interop.Word.WdAlertLevel]::wdAlertsNone

try {
    Write-Output "Opening document $docxPath..."
    $doc = $word.Documents.Open($docxPath, $false, $true) # Open read-only
    
    # Update fields (like TOC)
    Write-Output "Updating fields..."
    $doc.Fields.Update()
    
    # Export as PDF (wdFormatPDF = 17)
    Write-Output "Exporting to PDF: $pdfPath..."
    $doc.SaveAs([ref]$pdfPath, [ref]17)
    $doc.Close([ref]$false)
    Write-Output "PDF created successfully at $pdfPath!"
    
    # Try copying to finalPdfPath
    try {
        Copy-Item $pdfPath $finalPdfPath -Force
        Write-Output "Successfully updated Proposal_Skripsi_MLBB_GenZ.pdf!"
    } catch {
        Write-Output ("Could not overwrite original PDF (might be open in PDF reader): " + $_.Exception.Message)
    }
} catch {
    Write-Output ("Export error: " + $_.Exception.Message)
} finally {
    $word.Quit([ref]$false)
}

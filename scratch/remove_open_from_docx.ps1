Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$docxPath = "01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ.docx"
$tempZipPath = "scratch/temp_proposal.zip"

if (Test-Path $tempZipPath) { Remove-Item $tempZipPath -Force }

# Copy docx to temp zip using FileShare.ReadWrite so it works even if open in Word for reading
$inStream = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$outStream = New-Object System.IO.FileStream($tempZipPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
$inStream.CopyTo($outStream)
$inStream.Close()
$outStream.Close()

# Open temp zip
$zip = [System.IO.Compression.ZipFile]::Open($tempZipPath, [System.IO.Compression.ZipArchiveMode]::Update)
$entry = $zip.GetEntry('word/document.xml')
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$xml = $reader.ReadToEnd()
$reader.Close()
$stream.Close()

$xmlDoc = [xml]$xml
$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

# Find all paragraphs to remove
$nodesToRemove = @()
$paras = $xmlDoc.SelectNodes("//w:p", $ns)
foreach ($p in $paras) {
    $txt = $p.InnerText
    if ($txt -match "Daftar OPEN" -or 
        $txt -match "P04 Perangkat lunak" -or 
        $txt -match "P06 Definisi Generasi Z" -or 
        $txt -match "E01 Fenomena inti" -or 
        $txt -match "E02 Skala" -or 
        $txt -match "E03 Skala" -or 
        $txt -match "E04 Kohort" -or
        $txt -match "^1\. Tahun data 20xx" -or
        $txt -match "^2\. Rentang tahun lahir" -or
        $txt -match "^3\. Teknik sampling final" -or
        $txt -match "^4\. N final" -or
        $txt -match "^5\. Software final" -or
        $txt -match "^6\. Pilihan X2" -or
        $txt -match "^7\. Hasil penerjemahan") {
        
        # Don't remove TOC fields if any, or remove if it's the heading
        if ($txt -match "PAGEREF") {
            # TOC entry
            $nodesToRemove += $p
        } else {
            $nodesToRemove += $p
        }
    }
}

Write-Output ("Removing " + $nodesToRemove.Count + " nodes...")
foreach ($node in $nodesToRemove) {
    if ($node.ParentNode -ne $null) {
        [void]$node.ParentNode.RemoveChild($node)
    }
}

# Delete entry and recreate
$entry.Delete()
$newEntry = $zip.CreateEntry('word/document.xml')
$newStream = $newEntry.Open()
$writer = New-Object System.IO.StreamWriter($newStream, [System.Text.Encoding]::UTF8)
$xmlDoc.Save($writer)
$writer.Close()
$newStream.Close()
$zip.Dispose()

Write-Output "Cleaned zip created successfully."

# Try to overwrite the original docx
try {
    Copy-Item $tempZipPath $docxPath -Force
    Write-Output "Successfully updated Proposal_Skripsi_MLBB_GenZ.docx!"
} catch {
    Write-Output ("Could not overwrite docx directly (file open in Word): " + $_.Exception.Message)
    Write-Output "Cleaned version is ready at scratch/temp_proposal.zip"
}

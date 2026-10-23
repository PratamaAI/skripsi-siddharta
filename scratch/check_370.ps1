Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ.docx"
$fs = New-Object System.IO.FileStream($docxPath, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$zip = New-Object System.IO.Compression.ZipArchive($fs, [System.IO.Compression.ZipArchiveMode]::Read)
$entry = $zip.GetEntry('word/document.xml')
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$xml = $reader.ReadToEnd()
$reader.Close()
$stream.Close()
$zip.Dispose()
$fs.Close()

$xmlDoc = [xml]$xml
$ns = New-Object System.Xml.XmlNamespaceManager($xmlDoc.NameTable)
$ns.AddNamespace("w", "http://schemas.openxmlformats.org/wordprocessingml/2006/main")

$paras = $xmlDoc.SelectNodes("//w:p", $ns)
for ($i = 368; $i -lt [Math]::Min($paras.Count, 385); $i++) {
    Write-Output ("$i : " + $paras[$i].InnerText)
}

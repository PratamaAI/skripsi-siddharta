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
$found = @()
for ($i = 0; $i -lt $paras.Count; $i++) {
    $p = $paras[$i]
    $text = $p.InnerText
    if ($text -match "Daftar OPEN" -or $text -match "P04 Perangkat lunak" -or $text -match "P06 Definisi Generasi Z" -or $text -match "E01 Fenomena inti" -or $text -match "E02 Skala" -or $text -match "E03 Skala" -or $text -match "E04 Kohort") {
        $found += "$i : $text"
    }
}
$found | Out-File -Encoding utf8 "scratch/open_paras.txt"
Write-Output ("Found " + $found.Count + " paragraphs.")

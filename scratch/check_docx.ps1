Add-Type -AssemblyName System.IO.Compression.FileSystem
$docxPath = "01_Naskah_Utama/Proposal_Skripsi_MLBB_GenZ.docx"
$zip = [System.IO.Compression.ZipFile]::OpenRead($docxPath)
$entry = $zip.GetEntry('word/document.xml')
$stream = $entry.Open()
$reader = New-Object System.IO.StreamReader($stream)
$xml = $reader.ReadToEnd()
$reader.Close()
$stream.Close()
$zip.Dispose()
Write-Output ("Contains Daftar OPEN: " + $xml.Contains("Daftar OPEN"))

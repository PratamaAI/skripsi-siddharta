[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$wc = New-Object System.Net.WebClient
$wc.Headers.Add('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')

# 1. Halim & Keni (2022)
# Atlantis Press URL for 10.2991/aebmr.k.220501.075:
# Landing: https://www.atlantis-press.com/article/125974069
# Let's resolve the landing page first to find the direct PDF link
$doi1 = "https://doi.org/10.2991/aebmr.k.220501.075"
$req1 = [System.Net.WebRequest]::Create($doi1)
$req1.UserAgent = 'Mozilla/5.0'
$resp1 = $req1.GetResponse()
$landing1 = $resp1.ResponseUri.AbsoluteUri
$resp1.Close()
Write-Output "Landing 1: $landing1"

# 2. Utami et al. (2023)
$doi2 = "https://doi.org/10.2991/978-94-6463-340-5_24"
$req2 = [System.Net.WebRequest]::Create($doi2)
$req2.UserAgent = 'Mozilla/5.0'
$resp2 = $req2.GetResponse()
$landing2 = $resp2.ResponseUri.AbsoluteUri
$resp2.Close()
Write-Output "Landing 2: $landing2"

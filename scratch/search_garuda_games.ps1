$headers = @{'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'}

function Query-Garuda($q) {
    Write-Host "=== Garuda Query: $q ===" -ForegroundColor Cyan
    $url = "https://garuda.kemdikbud.go.id/documents?q=" + [System.Uri]::EscapeDataString($q)
    try {
        $res = Invoke-WebRequest -Uri $url -Headers $headers -TimeoutSec 15
        $html = $res.Content
        $matches = [regex]::Matches($html, '<a class="title-cite" href="([^"]+)">([^<]+)</a>')
        foreach ($m in $matches) {
            Write-Host "Title: $($m.Groups[2].Value.Trim())" -ForegroundColor Green
            Write-Host "  Link: https://garuda.kemdikbud.go.id$($m.Groups[1].Value)"
        }
    } catch {
        Write-Host "Error: $_"
    }
}

Query-Garuda "continuance intention mobile legends"
Query-Garuda "continuance intention game"
Query-Garuda "continuance intention online game"

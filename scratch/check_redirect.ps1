$headers = @{'User-Agent' = 'Mozilla/5.0'}
$url = "https://vertexaisearch.cloud.google.com/grounding-api-redirect/AUZIYQFL0wD1t_wXP1xUN12wSx_IYpsdjKLsENPYWAoHG2mJLSyU2PEhpquJrjz27mpG9H25qveZQZ3BhRir1Zmcg4TGaNFKUOO7ZyQ7-ttTNpdPZaRg1I5pgz_Hm8Gcshq6bQZEhBTL0BKsxg8nFSnIKxcASnLH8BD8ozdcsQ=="
try {
    $res = Invoke-WebRequest -Uri $url -Headers $headers -MaximumRedirection 0 -ErrorAction SilentlyContinue
    Write-Host "Location: $($res.Headers.Location)"
} catch {
    Write-Host "Response Location: $($_.Exception.Response.Headers['Location'])"
}

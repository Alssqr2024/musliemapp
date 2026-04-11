$utf8NoBom = New-Object System.Text.UTF8Encoding $false
Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | ForEach-Object {
    $content = [System.IO.File]::ReadAllText($_.FullName, $utf8NoBom)
    $newContent = [regex]::Replace($content, '\.withOpacity\(([^)]+)\)', '.withValues(alpha: $1)')
    $newContent = [regex]::Replace($newContent, 'Share\.share\(([^)]+)\)', 'SharePlus.instance.share($1)')
    if ($content -cne $newContent) {
        [System.IO.File]::WriteAllText($_.FullName, $newContent, $utf8NoBom)
        Write-Host "Fixed $_.FullName"
    }
}

# Builds dist\fusion-to-blender.plugin (a zip) from this repo. Run from the repo root:
#   powershell -ExecutionPolicy Bypass -File scripts\build-plugin.ps1
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$name = (Get-Content "$root\.claude-plugin\plugin.json" | ConvertFrom-Json).name
New-Item -ItemType Directory -Force "$root\dist" | Out-Null
$zip = "$root\dist\$name.zip"
$out = "$root\dist\$name.plugin"
Remove-Item $zip, $out -ErrorAction SilentlyContinue
$items = @(".claude-plugin", "skills", ".mcp.json", "README.md") | ForEach-Object { Join-Path $root $_ }
Compress-Archive -Path $items -DestinationPath $zip
Move-Item $zip $out
Write-Host "Built $out"

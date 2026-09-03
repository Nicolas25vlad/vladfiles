$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $PSScriptRoot
$configDir = Join-Path $repo 'vscode\config'
$installRoot = Join-Path $env:USERPROFILE '.vladfiles\vscode'
$userDir = Join-Path $env:APPDATA 'Code\User'
$backupDir = Join-Path $userDir ('backups\vladfiles-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))

New-Item -ItemType Directory -Force -Path $installRoot, (Join-Path $installRoot 'css'), (Join-Path $installRoot 'assets') | Out-Null
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
Copy-Item -Path (Join-Path $repo 'vscode\css\*') -Destination (Join-Path $installRoot 'css') -Force
Copy-Item -LiteralPath (Join-Path $repo 'vscode\assets\wallpaper.jpg') -Destination (Join-Path $installRoot 'assets\wallpaper.jpg') -Force

function Get-CodeCommand {
    $cmd = Get-Command code.cmd -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    $paths = @(
        (Join-Path ${env:ProgramFiles} 'Microsoft VS Code\bin\code.cmd'),
        (Join-Path $env:LOCALAPPDATA 'Programs\Microsoft VS Code\bin\code.cmd')
    )
    foreach ($path in $paths) {
        if (Test-Path -LiteralPath $path) { return $path }
    }
    throw 'O comando code.cmd não foi encontrado no PATH.'
}

$code = Get-CodeCommand
Get-Content -LiteralPath (Join-Path $configDir 'extensions.txt') | ForEach-Object {
    $id = $_.Trim()
    if ($id -and -not $id.StartsWith('#')) {
        & $code --install-extension $id --force | Out-Host
    }
}

$settingsPath = Join-Path $userDir 'settings.json'
$template = Get-Content -LiteralPath (Join-Path $configDir 'settings.json') -Raw | ConvertFrom-Json
$settings = $template
if (Test-Path -LiteralPath $settingsPath) {
    Copy-Item -LiteralPath $settingsPath -Destination (Join-Path $backupDir 'settings.json')
    try { $settings = Get-Content -LiteralPath $settingsPath -Raw | ConvertFrom-Json }
    catch { Write-Warning 'settings.json local não pôde ser mesclado; o template será usado.' }
}
foreach ($prop in $template.PSObject.Properties) {
    $settings | Add-Member -MemberType NoteProperty -Name $prop.Name -Value $prop.Value -Force
}
$cssUri = @(
    ([Uri]::new((Join-Path $installRoot 'css\liquid-glass-custom.css'))).AbsoluteUri,
    ([Uri]::new((Join-Path $installRoot 'css\statusbar-minimal.css'))).AbsoluteUri,
    ([Uri]::new((Join-Path $installRoot 'css\liquid-glass-motion.css'))).AbsoluteUri
)
$settings | Add-Member -MemberType NoteProperty -Name 'vscode_custom_css.imports' -Value $cssUri -Force
$settings | Add-Member -MemberType NoteProperty -Name 'liquidGlass.wallpaperPath' -Value (Join-Path $installRoot 'assets\wallpaper.jpg') -Force
New-Item -ItemType Directory -Force -Path $userDir | Out-Null
$settings | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $settingsPath -Encoding UTF8

$keybindingsPath = Join-Path $userDir 'keybindings.json'
if (Test-Path -LiteralPath $keybindingsPath) { Copy-Item -LiteralPath $keybindingsPath -Destination (Join-Path $backupDir 'keybindings.json') }
Copy-Item -LiteralPath (Join-Path $configDir 'keybindings.json') -Destination $keybindingsPath -Force
Write-Output "VS Code configurado. Backup: $backupDir"

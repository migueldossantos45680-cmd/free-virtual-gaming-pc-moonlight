[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$candidates = @(
    (Join-Path $env:ProgramFiles 'Sunshine/sunshine.exe'),
    (Join-Path $env:ProgramFiles 'LizardByte/Sunshine/sunshine.exe'),
    (Join-Path $env:LOCALAPPDATA 'Programs/Sunshine/sunshine.exe')
)
$command = Get-Command sunshine.exe -ErrorAction SilentlyContinue
if ($command) { $candidates = @($command.Source) + $candidates }

$exe = $candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
if (-not $exe) {
    throw 'Não encontrei sunshine.exe nos caminhos comuns. Instale Sunshine pela fonte oficial/WinGet e confira o local de instalação.'
}

$running = Get-Process -Name sunshine -ErrorAction SilentlyContinue
if (-not $running) {
    Start-Process -FilePath $exe
    Start-Sleep -Seconds 3
}

$ui = 'https://localhost:47990'
Write-Host "Sunshine: $ui" -ForegroundColor Green
Start-Process $ui
Write-Host 'Se for a primeira execução, conclua a configuração no Sunshine. Não compartilhe suas credenciais ou PINs.'

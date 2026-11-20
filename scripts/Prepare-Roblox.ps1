[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$robloxUrl = 'https://www.roblox.com/'
Write-Host 'Abrindo o site oficial do Roblox. Entre na sua conta e instale/inicie o player pelo fluxo oficial.' -ForegroundColor Cyan
Start-Process $robloxUrl
Write-Host 'Este script não baixa executáveis, não solicita credenciais e não instala versões de terceiros.'

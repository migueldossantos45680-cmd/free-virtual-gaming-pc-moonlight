[CmdletBinding()]
param(
    [switch]$InstallTailscale
)

$ErrorActionPreference = 'Stop'

function Test-IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdministrator)) {
    throw 'Abra o PowerShell como Administrador e execute novamente.'
}

if (-not (Get-Command winget.exe -ErrorAction SilentlyContinue)) {
    throw 'WinGet não foi encontrado. Instale/atualize App Installer pela Microsoft Store e tente novamente.'
}

$os = Get-CimInstance Win32_OperatingSystem
if ([int]$os.BuildNumber -lt 22000) {
    Write-Warning "Este projeto foi preparado para Windows 11. Sistema detectado: $($os.Caption), build $($os.BuildNumber)."
}

$packages = @(
    @{ Id = 'LizardByte.Sunshine'; Name = 'Sunshine' },
    @{ Id = 'Google.Chrome'; Name = 'Google Chrome' },
    @{ Id = 'Valve.Steam'; Name = 'Steam' }
)
if ($InstallTailscale) {
    $packages += @{ Id = 'Tailscale.Tailscale'; Name = 'Tailscale (VPN de malha opcional)' }
}

foreach ($package in $packages) {
    Write-Host "`nInstalando $($package.Name) ($($package.Id))..." -ForegroundColor Cyan
    & winget.exe install --id $package.Id --exact --source winget --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "WinGet falhou ao instalar $($package.Name), código $LASTEXITCODE. Confira a saída e tente instalar o pacote manualmente pela fonte oficial."
    }
}

Write-Host "`nInstalação concluída. Roblox deve ser instalado pelo fluxo oficial; execute scripts/Prepare-Roblox.ps1." -ForegroundColor Green
Write-Host 'Abra Sunshine, configure credenciais fortes e siga o pareamento descrito no README.'

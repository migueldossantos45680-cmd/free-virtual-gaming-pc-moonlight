[CmdletBinding()]
param()

$ErrorActionPreference = 'Continue'
$os = Get-CimInstance Win32_OperatingSystem
$cs = Get-CimInstance Win32_ComputerSystem
$ramGiB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)

Write-Host '=== Sistema ===' -ForegroundColor Cyan
[pscustomobject]@{
    SistemaOperacional = $os.Caption
    Versao = $os.Version
    Build = $os.BuildNumber
    MemoriaRAM_GiB = $ramGiB
    Fabricante = $cs.Manufacturer
    Modelo = $cs.Model
} | Format-List

Write-Host '=== Adaptadores de vídeo detectados (não implica suporte a codificação) ===' -ForegroundColor Cyan
Get-CimInstance Win32_VideoController |
    Select-Object Name, DriverVersion, AdapterRAM, VideoModeDescription |
    Format-Table -AutoSize

Write-Host '=== Discos fixos ===' -ForegroundColor Cyan
Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' |
    Select-Object DeviceID, @{Name='Livre_GiB';Expression={[math]::Round($_.FreeSpace / 1GB, 1)}}, @{Name='Total_GiB';Expression={[math]::Round($_.Size / 1GB, 1)}} |
    Format-Table -AutoSize

Write-Host '=== Dispositivos de áudio do Windows ===' -ForegroundColor Cyan
try {
    Get-CimInstance Win32_SoundDevice | Select-Object Name, Status | Format-Table -AutoSize
} catch {
    Write-Warning 'Não foi possível consultar os dispositivos de áudio.'
}

Write-Host '=== Aplicativos encontrados ===' -ForegroundColor Cyan
$apps = @(
    @{ Name = 'Sunshine'; Paths = @("$env:ProgramFiles\Sunshine\sunshine.exe", "$env:ProgramFiles\LizardByte\Sunshine\sunshine.exe") },
    @{ Name = 'Chrome'; Paths = @("$env:ProgramFiles\Google\Chrome\Application\chrome.exe", "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe") },
    @{ Name = 'Steam'; Paths = @("${env:ProgramFiles(x86)}\Steam\steam.exe", "$env:ProgramFiles\Steam\steam.exe") }
)
foreach ($app in $apps) {
    $found = $app.Paths | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    [pscustomobject]@{ Aplicativo = $app.Name; Instalado = [bool]$found; Caminho = $found } | Format-Table -AutoSize
}

Write-Host 'Observação: este relatório identifica hardware reportado pelo Windows; não certifica codificador, desempenho, latência ou suporte a 4K/120 FPS.' -ForegroundColor Yellow

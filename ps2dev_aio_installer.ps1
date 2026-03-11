[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$InstallerArgs
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Fail {
    param([string]$Message)

    Write-Error $Message
    exit 1
}

function Quote-Bash {
    param([string]$Value)

    return "'" + ($Value -replace "'", "'\"'\"'") + "'"
}

function Get-DefaultWslDistro {
    $lines = & wsl.exe -l -v 2>$null
    if ($LASTEXITCODE -ne 0) {
        return $null
    }

    foreach ($line in $lines) {
        if ($line -match '^\s*\*\s+(.+?)\s{2,}') {
            return $matches[1].Trim()
        }
    }

    return $null
}

function Get-UbuntuDistro {
    param([string]$PreferredDistro)

    $distroOutput = & wsl.exe -l -q 2>$null
    if ($LASTEXITCODE -ne 0) {
        Fail "WSL is unavailable or no distributions are installed. Install Ubuntu in WSL and try again."
    }

    $distros = @(
        $distroOutput |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ }
    )

    if ($distros.Count -eq 0) {
        Fail "No WSL distributions were found. Install Ubuntu in WSL and try again."
    }

    if ($PreferredDistro) {
        $preferredMatch = $distros | Where-Object { $_ -eq $PreferredDistro } | Select-Object -First 1
        if ($preferredMatch) {
            if ($preferredMatch -match '(?i)ubuntu') {
                return $preferredMatch
            }

            Fail "The bundle path points at WSL distro '$preferredMatch', but this launcher expects an Ubuntu distro."
        }
    }

    $defaultDistro = Get-DefaultWslDistro
    if ($defaultDistro -and $defaultDistro -match '(?i)ubuntu') {
        return $defaultDistro
    }

    $ubuntuDistro = $distros | Where-Object { $_ -match '(?i)ubuntu' } | Select-Object -First 1
    if ($ubuntuDistro) {
        return $ubuntuDistro
    }

    Fail "No Ubuntu WSL distribution was found. Install Ubuntu for WSL and try again."
}

function Get-WslShareInfo {
    param([string]$WindowsPath)

    if ($WindowsPath -match '^[\\]{2}(?:wsl\$|wsl\.localhost)\\([^\\]+)(?:\\(.*))?$') {
        $wslPath = '/'
        if ($matches[2]) {
            $wslPath += ($matches[2] -replace '\\', '/')
        }

        return [PSCustomObject]@{
            Distro = $matches[1]
            WslPath = $wslPath
        }
    }

    return $null
}

$bundleDirWindows = $PSScriptRoot
if (-not $bundleDirWindows) {
    Fail "Unable to determine the bundle directory."
}

$wslShareInfo = Get-WslShareInfo $bundleDirWindows
$preferredDistro = if ($wslShareInfo) { $wslShareInfo.Distro } else { $null }

$distro = Get-UbuntuDistro -PreferredDistro $preferredDistro
Write-Host "Using WSL distro: $distro"

if ($wslShareInfo -and $wslShareInfo.Distro -eq $distro) {
    $bundleDirWsl = $wslShareInfo.WslPath
} else {
    $bundleDirWsl = (& wsl.exe -d $distro wslpath -a -u $bundleDirWindows 2>$null | Select-Object -First 1)
    if ($LASTEXITCODE -ne 0 -or -not $bundleDirWsl) {
        Fail "Unable to translate the bundle path into WSL: $bundleDirWindows"
    }
}

$bundleDirWsl = $bundleDirWsl.Trim()
$bundleDirQuoted = Quote-Bash $bundleDirWsl

$probeCommand = "cd $bundleDirQuoted && test -f ./ps2dev_aio_installer.sh"
& wsl.exe -d $distro bash -lc $probeCommand | Out-Null
if ($LASTEXITCODE -ne 0) {
    Fail "WSL could not access the bundle directory or ./ps2dev_aio_installer.sh is missing: $bundleDirWindows"
}

$quotedArgs = @()
foreach ($arg in $InstallerArgs) {
    $quotedArgs += Quote-Bash $arg
}

$argSuffix = ''
if ($quotedArgs.Count -gt 0) {
    $argSuffix = ' ' + ($quotedArgs -join ' ')
}

$installerCommand = "cd $bundleDirQuoted && bash ./ps2dev_aio_installer.sh$argSuffix"
& wsl.exe -d $distro bash -lc $installerCommand
exit $LASTEXITCODE

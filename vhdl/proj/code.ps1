Clear-Host
function Get-Installed-VBOX {
    $vbox = (Get-ChildItem -Path $env:ProgramFiles -Recurse -Filter vboxmanage.exe -ErrorAction SilentlyContinue).FullName
    if ($vbox) {
        $res = $true 
    }
    else {
        Write-Host "Se necesita tener VirtualBox instalado."
        Write-Host "Lo puedes descargar desde: https://www.virtualbox.org/wiki/Downloads"
        Write-Host "No se continúa con el script."
        $res = $false
    }
    return $res
}

function Get-Installed-VAGRANT {
    # VAGRANT
    $res = ($env:Path.Contains("Vagrant")) 
    if (! $res) {
        Write-Host "Se necesita tener Vagrant instalado."
        Write-Host "Lo puedes descargar desde: https://www.vagrantup.com/downloads"
        Write-Host "No se continúa con el script."
    }
    return $res
}
function Get-Installed-VSCODE {
    $res = (Get-ChildItem -Path $env:ProgramFiles -Recurse -Filter code.exe -ErrorAction SilentlyContinue).FullName
    if (! $res) {
        Write-Host "Se necesita tener Visual Studio Code instalado."
        Write-Host "Lo puedes descargar desde: https://code.visualstudio.com/download"
        Write-Host "No se continúa con el script."
    }
    return $res
}

Write-Host "Comprobando requisitos previos..."
if ( ! (Get-Installed-VBOX) ) { return }
if ( Get-Installed-VAGRANT ) { 
    $vagrant = (Get-ChildItem -Path "C:\HashiCorp" -Recurse -Filter vagrant.exe -ErrorAction SilentlyContinue).FullName 
}
else { return }
$code = Get-Installed-VSCODE
if ($code) {
    $codecli = (Get-ChildItem -Path $env:ProgramFiles -Recurse -Filter code.cmd -ErrorAction SilentlyContinue).FullName
}
else { return }

function Get-VM-ID {
    param (
        [Parameter()]
        [String] $vagrant,
        [String] $rutaVHDL
    )
    Write-Host "Buscando máquina virtual de desarrollo..."
    $rutaVHDL = $rutaVHDL -replace '[\\/]', "/"
    $buscar = (& $vagrant global-status)
    $buscar = ( $buscar | Select-String -Pattern "$rutaVHDL")
    $vmid = $buscar.Line.Split(" ")[0]
    return $vmid
}
function Set-InicializarVM {
    param (
        [Parameter()]
        [String] $vagrant,
        [String] $rutaVHDL
    )
    Write-Host "Inicializando máquina virtual de desarrollo..."
    try {
        $vmid = Get-VM-ID -vagrant $vagrant -rutaVHDL $rutaVHDL
        $estado = (& $vagrant status $vmid)
        if ($estado -notlike "*running (virtualbox)*" ) {
            Write-Host "Encendiendo máquina virtual"
            Start-Process -NoNewWindow -FilePath "$vagrant" -ArgumentList "up", "$vmid"
        }
    }
    catch {
        Write-Host "Creando máquina virtual"
        Set-Location $rutaVHDL
        Start-Process -NoNewWindow -FilePath "$vagrant" -ArgumentList "up"
    }
}

function Set-vscode-ssh {
    param (
        [Parameter()]
        [String] $rutavc
    )
    Write-Host  "VSCODE: Verificando configuración de acceso remoto"
    $fic = "${rutavc}\ssh_config"
    if (! (Test-Path -Path $fic) ) {
        $config = @"
Host IC3
  HostName 127.0.0.1
  Port 2222
  User vagrant
  IdentityFile "${ruta}/.vagrant/machines/default/virtualbox/private_key"
"@
        $config | Out-File -FilePath $fic
    }
}
function Set-VSCODE {
    param (
        [Parameter()]
        [String] $codecli
    )
    Write-Host "VSCODE: Preparando estructura de ficheros"
    $rutaVHDL = Split-Path $MyInvocation.MyCommand.Path -Parent 
    New-Item -Path "$rutaVHDL" -Name "vscode" -ItemType "directory" -ErrorAction SilentlyContinue | Out-Null
    $rutavc = "${rutaVHDL}\vscode"
    New-Item -Path "$rutavc" -Name "extensions" -ItemType "directory" -ErrorAction SilentlyContinue | Out-Null
    $rutavce = "${rutavc}\extensions"
    New-Item -Path "$rutaVHDL" -Name "proyectos" -ItemType "directory" -ErrorAction SilentlyContinue | Out-Null

    Write-Host "VSCODE: Comprobando extensiones..."
    $iniciado = $false
    $installedExtensions = (& $codecli --user-data-dir $rutavc --extensions-dir $rutavce --list-extensions)
    $extensions = @("teros-technology.teroshdl", "ms-vscode-remote.vscode-remote-extensionpack")
    $extensions | ForEach-Object {
        if ( $installedExtensions -cnotcontains $_ ) {
            Start-Process -NoNewWindow -FilePath "$codecli" -ArgumentList "--user-data-dir $rutavc", "--extensions-dir $rutavce", "--install-extension $_"
        }
    }

    Write-Host "VSCODE: Iniciando Visual Studio Code..."
    if (! $iniciado) {
        Start-Process -FilePath "$code" -ArgumentList "--user-data-dir $rutavc", "--extensions-dir $rutavce", "$rutaVHDL\VHDL.code-workspace"
    }

    Set-vscode-ssh -rutavc $rutavce
}

function main {
    Set-InicializarVM -vagrant $vagrant -rutaVHDL $rutaVHDL
    Set-VSCODE -codecli $codecli -code $code
}

main

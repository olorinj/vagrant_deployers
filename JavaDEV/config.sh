#!/bin/bash
function i_start {
    echo ">> Actualizando repositorio linux"
    sudo apt -qq update
}

function i_local() {
    echo ">> Asociando directorio local y virtualizado..."
    mkdir -p "$HOME"/projects/eclipse_workspace
    echo "X11UseLocalhost no" | sudo tee -a /etc/ssh/sshd_config
}

function i_nano() {
    echo ">> Editor nano. Configurando..."
    find /usr/share/nano/ -iname "*.nanorc" -exec echo "include {}" \; >>"$HOME"/.nanorc
    for x in autoindent nowrap smarthome tabstospaces tempfile trimblanks multibuffer backup "tabsize 4"; do
        echo set "$x" >>"$HOME"/.nanorc
    done
    echo ">> Editor nano. Configurado"
}

function i_java {
    echo ">> Instalando JAVA 11..."
    # Se debe dejar JDK17 porque lo requieren las últimas versiones de eclipse
    latestjdk=$(apt search openjdk | cut -d"/" -f1 | grep ^openjdk-..-jdk$ | tail -1)
    latestjre=$(apt search openjdk | cut -d"/" -f1 | grep ^openjdk-..-jre$ | tail -1)
    sudo apt -yqq install openjdk-11-jre openjdk-11-jdk $latestjdk $latestjre
}

function i_eclipse() {
    echo ">>> Eclipse. Instalando..."
    # Buscar ultima version pagina oficial
    main=$(curl -sk https://www.eclipse.org/downloads/packages/ | grep -E "eclipse-java.*linux" | head -1 | cut -d"'" -f2)
    main="https:${main}"
    # Buscar mirror mas cercano
    mirror=$(curl -s $main | grep mirror_id | head -1 | cut -d'"' -f2)
    mirror="https://www.eclipse.org/downloads/${mirror}"
    # Buscar y descargar enlace
    enlace=$(curl -s $mirror | grep gz | tail -1 | awk -F'"|=' '{print $(NF-1)}')
    dst=/tmp/eclipse.tgz
    curl -LJ $enlace -o $dst
    # Instalar
    sudo tar -xzvf $dst -C /opt
    rm -f $dst
    sudo ln -sf /opt/eclipse/eclipse /usr/bin/eclipse
    sudo tee /usr/share/applications/eclipse.desktop >/dev/null <<_EOF_
[Desktop Entry]
Encoding=UTF-8
Name=Eclipse IDE
Comment=Eclipse IDE for Java Developers
Exec=/usr/bin/eclipse
Icon=/usr/eclipse/icon.xpm
Categories=Application;Development;Java;IDE
Type=Application
Terminal=0
_EOF_
    echo ">>> Eclipse. Instalado"
    echo ">>> Eclipse. Se recomienda plugin dbeaver para acceder a bases de datos"
}

function i_x11_xfce() {
    echo ">> XFCE. Instalando entorno gráfico"
    #sudo tasksel install lxqt-desktop
    sudo apt -yqq install xfce4
    echo ">> XFCE. Entorno gráfico instalado"
}

function finally() {
    echo ">> Limpiando repositorio"
    sudo apt -yqq --purge autoremove
    sudo apt -yqq clean
    sudo history -c
    history -c
}

function main() {
    clear
    VM_NAME=$(basename $(pwd))
    ended="$HOME"/.done
    if [ ! -f "$ended" ]; then
        echo "> [${VM_NAME}] INICIO de la creación de la máquina virtual"
        i_start
        i_local
        i_nano
        i_java
        i_eclipse
        i_x11_xfce
        finally
        echo "> [${VM_NAME}] FIN de la creación de la máquina virtual"
        touch "$ended"
        echo "> [${VM_NAME}] Reiniciando..."
        sudo reboot
    fi
}

main

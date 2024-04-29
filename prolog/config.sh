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

function i_prolog {
    echo ">> Preparando entorno para prolog"
    sudo sudo apt install -y swi-prolog
    echo "Prolog instalado"
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
    VM_NAME=$(basename "$(pwd)")
    ended="$HOME"/.done
    if [ ! -f "$ended" ]; then
        echo "> [${VM_NAME}] INICIO de la creación de la máquina virtual"
        i_start
        i_local
        i_nano
        i_prolog
        finally
        echo "> [${VM_NAME}] FIN de la creación de la máquina virtual"
        touch "$ended"
    fi
}

main
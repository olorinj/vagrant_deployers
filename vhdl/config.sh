#!/bin/bash
clear
echo ">> Actualizando repositorio linux"
sudo apt -qq update
echo ">> Instalando GHDL..."
sudo apt -y install ghdl gtkwave pip python3
echo ">> Instalar TherosHDL..."
pip install teroshdl
echo ">> Configurando editor nano..."
for x in $(find /usr/share/nano/ -iname "*.nanorc"); do echo include $x >> $HOME/.nanorc;done
for x in autoindent nowrap smarthome tabstospaces tempfile trimblanks multibuffer backup "tabsize 4"; do echo set $x >> $HOME/.nanorc; done
echo ">> Asociando directorio local y virtualizado..."
mkdir $HOME/proj
echo ">> Fin de la creación del entorno de desarrollo GHDL"
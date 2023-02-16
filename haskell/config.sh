#!/bin/bash
clear
echo ">> Actualizando repositorio linux"
sudo apt -qq update
echo ">> Instalando hashkell..."
nice -20 sudo apt -yqq install haskell-stack
echo ">> Comprobando hashkell..."
nice -20 stack --silent update
echo ">> Actualizando hashkell..."
nice -20 stack --silent upgrade
echo ">> Configurando editor nano..."
for x in $(find /usr/share/nano/ -iname "*.nanorc"); do echo include $x >> $HOME/.nanorc;done
for x in autoindent nowrap smarthome tabstospaces tempfile trimblanks multibuffer backup "tabsize 4"; do echo set $x >> $HOME/.nanorc; done
echo ">> Asociando directorio local y virtualizado..."
mkdir $HOME/proj
mkdir -p $HOME/.stack
touch $HOME/.stack/config.yaml
echo ">> Fin de la creación del entorno de desarrollo haskell"
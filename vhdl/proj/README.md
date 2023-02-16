# vhdl
Entorno libre de desarrollo VHDL

Aquí presento mi propuesta basada en Open-Source, multiplataforma (Windows, Linux, Mac), para equipos con pocos recursos y que no se instale con el OS local.

Los requisitos para poder utilizarlo son:
1. Instalar el hipervisor: [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Instalar el lanzador: [Vagrant](https://www.vagrantup.com/downloads)
3. Instalar el IDE: [Visual Studio Code](https://code.visualstudio.com) 

Una vez esté todo instalado se crea un directorio, por ejemplo IC3.
Dentro de este directorio descargar el fichero Vagrantfile que tiene la configuración de todo lo necesario para el entorno de desarrollo VHDL.

Una vez hecho todo esto, por línea de comandos, se ejecuta la siguiente instrucción:
* Linux/MAC/Windows: vagrant up
* Windows: C:\HashiCorp\Vagrant\bin\vagrant.exe up

En este momento se descarga e instala un sistema operativo Debian 11 además de configurar lo necesario para programas en VHDL con software libre GHDL y GTKWave. Además se configura para compartir un subdirectorio proyectos desde donse se haya lanzado.
Las claves de la máquina desplegada son:
* Usuario: vagrant
* Contraseña: vagrant

## Especial para Windows
El fichero code.ps1 es un script PowerShell para desplegar la máquina Vagrant y configurar el workspace (Espacio de trabajo) de Visual Studio.
Lo mejor es que se genera un perfil aislado de Visual Studio Code independiente de que se tenga instalado o no.

## Herramientas Visual Studio
Para el desarrollo recomiendo utilizar Visual Studio Code con los siguientes complementos:
* [Remote Development (ms-vscode-remote.vscode-remote-extensionpack)](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
* [TerosHDL (teros-technology.teroshdl)](https://marketplace.visualstudio.com/items?itemName=teros-technology.teroshdl)

### Configuración de TerosHDL en Visual Studio Code
* General / Select the waveform... Cambiar por GTKWave
* GHDL / Installation path... Poner: /usr/bin/ghdl

## Modo de trabajo
1. Abrir Visual Studio Code
2. Abrir el workspace generado por el script code.ps1
3. Conectar, por Remote Development con la máquina desplegada
4. Desarrollar todo en la carpeta proyectos

# Uso de VHDL por línea de comandos
* Analizar el fichero: ghdl -a FICHERO.vhdl
* Crear el ejecutable: ghdl -e ENTIDAD
* Ejecutar VHDL: ghdl -r ENTIDAD --stop-time=999ns --wave=FICHERO.ghw (También se pueden cread ficheros VCD)
* * Ejecutar banco de pruebas con REPORT: ghdl -r ENTIDAD
* Visualizar resultado: gtkwave FICHERO.ghw

# NOTA
Si algo no funciona como debe, por favor, indicádmelo y lo veré después del examen de IC3 de este año 2022.

Espero que os sirva, especialmente a los compañeros de la UNED.

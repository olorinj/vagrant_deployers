# vagrant_deployers
Ficheros de configuración para automatizar despliegues vagrant para múltiples aplicaciones tecnológicas.

# Introduction
Hay muchas opciones para crear y/o utilizar diversas tecnologías utilizando máquinas virtuales.
Mi objetivo es proporcionar a la comunidad la creación de ficheros Vagrant que ayuden en el despliegue de distintas tecnologías para utilizarse como si fueran imágenes docker.
He buscado unba solución que no utilice software licenciado por lo que he decidido utilizar las siguientes tecnologías:
* Hipervisor: [VirtualBox](https://www.virtualbox.org)
* Sistema de despliegue: [Vagrant](https://www.vagrantup.com)

Alguno se preguntará ¿Por qué un fichero de configuración? ¿No es mejor crear boxes vagrant?
Bien, creo que es mejor utilizar ficheros Vagrant para el despliegue porque así puedes comprobar fácilmente qué está haciendo el fichero proporcionado. Se hace sólo lo que ves.

Los boxes utilizados para estos fichers se obtienen de los repositorios oficiales de Bento o Global con teclado en español.

## Personalización
Estas máquinas emplean puertos de comunicación con valores por defecto que incluyo en el detalle de cada máquina. En el caso de que algún puerto se encuentre en uso en tu equipo sólo tienes que cambiar la variable del fichero Vagrantfile antes de desplegarlo. También he incluido una variable con el nombre de la máquina virtual por si quieres cambiarla.
Las variables utilizadas en los ficheros Vagrantfile son: **SSH_PORT**, **HOST_PORT**, **VM_NAME**

## Cómo desplegar un Vagrantfile
1. Clonar el repositorio.
2. Abrir una ventana de terminal. (Cualquier shell de Windows, Linux o MacOS)
3. Desde la shell ve al directorio con el fichero a desplegar.
4. Ejecuta: <br>
   ```bash
   vagrant up
   ```
   Si el box no se encuentra en tu equipo se descargará automáticamente antes del despliegue.
   El box se desplegará y configurará correctamente.<br>
   Dependiendo de la configuración del Vagrantfile se puede despleguar un servicio listo para utilizar, como un proceso en segundo plano, o puede estar listo para utilizarlo.<br>
   Esto se explica apropiadamente en el fichero LEEME.md.
   
## Cómo detener un Vagrantfile
1. Opción de terminal:
   1. Abrir una ventana de terminal. (Cualquier shell de Windows, Linux o MacOS)
   2. Desde la shell ve al directorio con el fichero a desplegar.
   3. Ejecuta: <br>
      ```bash
      vagrant halt
      ```
2. Opción gráfica:
   1. Abre VirtualBox
   2. Pulsa en apagar la máquina virtual.

## Cómo eliminar una máquina virtual desplegada
1. Abrir una ventana de terminal. (Cualquier shell de Windows, Linux o MacOS)
2. Desde la shell ve al directorio con el fichero a desplegar.
3. Ejecuta:<br>
   ```bash
   vagrant destroy -f
   ```

# Ficheros disponibles
## Aprendizaje de Cibersesguridad
* SDWA (Sitting Duck Vulnerable App).<br>
  **Sistema operativo**: Alpine
  **Puerto SSH**: 2222
  **Puerto Host**: 5000
  Una vez desplegado el servicio se encuentra listo para acceder con un navegador en http://localhost:5000<br>
  Para finalizar el servicio y apagar la máquina virtual escribe en el navegador: http://localhost:5000/shutdown<br>

## Desarrollo
Aquí irán algunas máquinas virtuales creadas para desplegar un lenguaje de programación con un directorio sincronizado en local y la máquina virtual para poder guardar los proyectos localmente.
En todas las imágenes se configura el editor nano con ko necesario para desarrollar en línea de comandos.

* Haskell<br>
  **Sistema operativo**: Debian 11
  **Puerto SSH**: 2222
  La máquina virtual tiene todos los componentes necesarios para comenzar a desarrollar en haskell utilizando hgci, stack o cabal.<br>
* VHDL<br>
  **Sistema operativo**: Debian 11
  **Puerto SSH**: 2222
  Entorno libre de desarrollo VHDL con instrucciones detalladas en el fichero README.md del directorio proj.<br>
* JavaDEV<br>
  **Sistema operativo**: Debian 11
  **Puerto SSH**: 2222
  Entorno libre de desarrollo Eclipse con instrucciones detalladas en el fichero README.md de su directorio.<br>
* Prolog<br>
  **Sistema operativo**: Debian 11
  **Puerto SSH**: 2226
  La máquina virtual tiene todos los componentes necesarios para comenzar a desarrollar en SQI-prolog.<br>

## Integración con VSCode
Es posible trabajar con [Visual Studio Code](https://code.visualstudio.com/download) y cualquiera de estas máquinas utilizando la extensión [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
Sólo se necesita configurar el acceso SSH para cada máquina en esta extensión. Aquí tienes un fichero la configuración SSH creada para la máquina haskell:
```bash
Host HASKEL
    User vagrant
    IdentityFile <RUTA_COMPLETA>/haskell/.vagrant/machines/default/virtualbox/private_key
    HostName 127.0.0.1
    GSSAPIAuthentication no
    StrictHostKeyChecking no
    ForwardAgent yes
    Port 2222
```
Destaco que el uso de la barra como separador de directorios es válida incluso en Windows.
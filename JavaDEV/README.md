# JavaDEV
Entorno libre de desarrollo Java con Eclipse

Aquí presento mi propuesta basada en Open-Source, multiplataforma (Windows, Linux, Mac), para equipos con pocos recursos y que no se instale con el OS local.

Los requisitos para poder utilizarlo son:
1. Instalar el hipervisor: [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Instalar el lanzador: [Vagrant](https://www.vagrantup.com/downloads)

Si te has descargado este repositorio debes acceder a este directorio para tener acceso al fichero Vagrantfile que tiene la configuración de todo lo necesario para el entorno de desarrollo Java.

Una vez hecho todo esto, por línea de comandos, se ejecuta la siguiente instrucción:
* Linux/MAC/Windows: vagrant up
* Windows: C:\HashiCorp\Vagrant\bin\vagrant.exe up

En este momento se descarga e instala un sistema operativo Debian 11 además de configurar lo necesario para programar en Java JDK17 (Para el entorno Eclipse) y JDK11 para proyectos que lo requieran. Además se configura para compartir el subdirectorio "dat" que se genera durante la creación de la máquina virtual.
Las claves de la máquina desplegada son:
* Usuario: vagrant
* Contraseña: vagrant

# Abrir eclipse
Aun que la máquina virtual tiene un entorno gráfico no es necesario entrar en el entorno de ventanas para usarlo.
Una vez arrancado el vagrant (con vagrant up) sólo hay que teclear (Windows/Linux/Mac):
```bash
ssh -X -p 2222 vagrant@localhost
# Entras en el sistema operativo de la máquina
$ eclipse
```
Y así se abre en tu ordenador y lo puedes utilizar como si estuvieras en tu propia máquina sin mancharla. Recuerda que en el home de esta máquina virtual está el directorio "projects" que está enlazado con el "dat" de tu propio equipo.Así no hay que preocuparse de mover ficheros entre máquinas.

# Detalles
* Se crea un grupo de máquinas virtuales llamado UNED donde se genera esta máquina virtual
* Se crea una máquina virtual con dos tarjetas de red, la habitual de acceso NAT al equipo local y otra de una red denominada "uned" para que se pueda interactuar con otros servidores de esta red. Por ejemplo, un servidor MariaDB.

# NOTA
Si algo no funciona como debe, por favor, indicádmelo y lo veré lo antes posible.

Espero que os sirva, especialmente a los compañeros de la UNED.

# vagrant_deployers
Configuration files to automate vagrant deploying of multiple technologies.

# Introduction
There are many options to create and/or use multiple tecnologies using virtual machines.
I would like to help the community creating Vagrant files to help on deploying different technologies to be used like if they were docker images.
Looking for a solution that may not force to use licensed software I decided to uset hese technologies:
* Hypervisor: [VirtualBox](https://www.virtualbox.org)
* Deploying system: [Vagrant](https://www.vagrantup.com)

Some people may have a question: Why a configuration file? It isn't better to create vagrant boxes?
Well, I think it is better to use Vagrant files for deploying because you can check what is doing the provided file in an easy way. What you see is what it is.

The boxes used for these files are from the Bento or Global repositories.

## How to deploy a Vagrantfile
1. Clone the repository.
2. Open a terminal window. (Any shell from Windows, Linux or MacOS)
3. From the shell go to the folder with the file to be deployed.
4. Execute: <br>
   ```bash
   vagrant up
   ```
   If the box isn't in the computer it would be downloaded after deploy.
   The box will be deployed and configured properly.<br>
   Depending on the Vagrantfile configuration it would be a service ready to use like a running deamon or a service started ready to use. This will be explained in the README.md file.
   
## How to stop a Vagrantfile
1. Open a terminal window. (Any shell from Windows, Linux or MacOS)
2. From the shell go to the folder with the file to be deployed.
3. Execute: <br>
   ```bash
   vagrant halt
   ```

## How to remove a deployed image
1. Open a terminal window. (Any shell from Windows, Linux or MacOS)
2. From the shell go to the folder with the file to be deployed.
3. Execute:<br>
   ```bash
   vagrant destroy -f
   ```

# Available files
## Cybersecurity learning
* SDWA (Sitting Duck Vulnerable App).<br>
  Once deployed the service would be ready to access using a browser at http://localhost:5000<br>
  If this port is use at your host then change the value of the variable **HOST_PORT** in the file Vagrantfile. <br>
  To finish the service and shutdown the Virtual Machine type: http://localhost:5000/shutdown


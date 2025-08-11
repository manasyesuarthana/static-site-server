# Automated Static Site Server
This project aims to automate the configuration of a linux server in order for it to be able to serve a static website. 

For my setup instead of setting up a remote server on digital ocean or other VPS providers, I used a **vagrant VM** to act as a simulation for a remote linux server. Below are the specifications of the VM:
- OS: CentOS 9
- username: `vagrant`
- password: `vagrant` 
- IP: 192.168.34.10

More details of the specific VM setup can be seen in the `Vagrantfile` provided.

## Tech Stack and Scripts
This project is deployed on a CentOS/RHEL server but with **Nginx** for improved performance and efficiency in serving static files.
- Web Server: Nginx
- Networking: Configured with firewalld to secure access to the web server.

This was achieved by the two bash scripts: `setup.sh` and `deploy.sh`:

- `setup.sh`: a script used to set up the OS of the remote server -- install updates, software, starting services (`nginx` and `firewalld`), and setting up permissions -- This script will be transferred to the server using `scp` and executed remotely using `ssh`.
- `deploy.sh`: a script that will be run on my local machine. This sets up the connection between my machone and the remote server by generating SSH keys and will sync web files to the remote server using `rsync`.

Additional script `cleanup.sh`: to demobilize (un-deploy) the static website from the remote server, clean up artifacts, and stop the services from running. 

**NOTE: these scripts are intended for CentOS and RHE based linux distros. It will not work on debian VMs.**

## Pre-Requisites
**Ensure you have the following software installed on your computer before starting:**
- Vagrant
- SSH (sshd or openssh)

Knowledge of these fields are not mandatory, but better if you want to understand what's going on:
- Linux services, networking and permissions
- SSH key generation and exchange
- Transferring files using rsync

--> This project is inspired and a part of the **roadmap.sh DevOps projects series**. Specifically, this one is based on [Static Site Server](https://roadmap.sh/projects/static-site-server)

## Getting Started
Follow these steps to replicate my setup and serve a static site on the VM:

1. Clone the repository
```bash
git clone https://github.com/manasyesuarthana/static-site-server.git
```

2. Go to the project directory 
```bash
cd static-site-server
```

3. Turn on the virtual machine
```bash
vagrant up
```
During the setup, you may be asked to state which network interface to bridge to. Choose the one that is your Wi-Fi Adapter. After that, wait for the VM to finish setting up.

4. Give execute permissions to all scripts
```bash
chmod 700 setup.sh deploy.sh cleanup.sh
```
5. Execute deploy.sh in your local machine
```bash
./deploy.sh
```
Note that during execution, you may be asked to be prompted for the password of your user and the user of the VM. This is because some commands requires sudo privileges.

6. Access the website in your local browser by typing the address of the VM in your browser:
```
192.168.34.10
```

7. If you want to stop the deployment and clean up the artifacts, simply run:
```bash
./cleanup.sh
```

## Output
![Web Landing Page](image.png)
- template source: https://www.tooplate.com/view/2137-barista-cafe 

<!-- Fourth Project Letsgo! -->
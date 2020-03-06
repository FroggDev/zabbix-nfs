Template Module NFS

# Introduction
Template for zabbix to check nfs share availability using external script.
It can check:
* If NFS server is accepting request
* The NFS server version
* If NFS share are available

# Requirement
The script use the commands **showmount** & **rpcinfo** so it requires the linux package **nfs-common**

To install it you can use the package manager of your distribution
For exemple
```bash
apt-get install nfs-common
```
By the way you may require sudoer rights to run the command.

# Installation

## Content
The template installation require 2 files:
* **frogg_nfs_check.sh** Zabbix external script
* **frogg_nfs_check.xml** Zabbix template configuration

## External script

You need to place the script **frogg_nfs_check.sh** into zabbix external forlder **externalscripts** (by default in **/usr/lib/zabbix/externalscripts**) 

You can find the external script folder in Zabbix configuration file **zabbix_server.conf** (by default in **/etc/zabbix/zabbix_server.conf**)

You will need to add execute permission on the script
```bash
chmod +x frogg_nfs_check.sh 
```

### Testing the installation
You can run the command:
- To Test NFS version
```bash
./frogg_nfs_check.sh version 192.168.0.1
```
- To Test NFS share
```bash
./frogg_nfs_check.sh share 192.168.0.1 /nfsShare1:/nfsShare2:/nfsShare3
```
## Template

Then you need to import the **frogg_nfs_check.xml** template configuration file in the zabbix web interface in **Template** tab using the import button

# Host configuration
The template use 2 macros :

MACRO | Description
----- | -----------
{$NFSVERSION} | the NFS version that should be returned by the server
{$NFSSHARES} | the list of NFS shares that should be available, to set multiple shares they must be separated by **:**

Exemple:
![Zabbix NFS configuration sample](/todo)

# Template content
![Zabbix NFS Template](/todo)

# Template triggers
![Zabbix NFS Template triggers](/todo)

# Debuging
(TODO)
- lastest data
- logs config
- logs

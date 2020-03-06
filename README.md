### Zabbix Template Module NFS version 1.0.0

Tested on Zabbix 4.4

# Introduction
Template for zabbix to check nfs share availability using external script.
It can check:
* If NFS server is accepting request
* The NFS server version
* If NFS share are available

# Requirement
The script use the commands **showmount** & **rpcinfo** so it requires the linux package **nfs-common**

To install it you can use the package manager of your distribution

Exemple
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
![Zabbix NFS configuration sample](https://tool.frogg.fr/upload/github/zabbix-nfs/macros.png)

# Template items
![Zabbix NFS Template](https://tool.frogg.fr/upload/github/zabbix-nfs/items.png)

# Template triggers
![Zabbix NFS Template triggers](https://tool.frogg.fr/upload/github/zabbix-nfs/triggers.png)

# Debuging

Going further...This step is working with most of externals scripts

If you got troubles getting an external script working, first :
1. Check the Zabbix tab **Monitoring > lastest data**
If you select an host, you should see all items linked to it, check for your item and you should see the lasted data linked to it.
If it appear in gray (disabled) that mean there is something wrong with the external script (rights, path, arguments ...)
To find more about it you can check logs
2. By default the logs are in **/var/log/zabbix/zabbix_server.log** or you can find the log path in Zabbix configuration file **zabbix_server.conf** (by default **/etc/zabbix/zabbix_server.conf**)

To get the last log lines you can use for example:
```bash
tail -f /var/log/zabbix/zabbix_server.log
```
Then look at the script trouble...

Example:
![Zabbix NFS error sample](https://tool.frogg.fr/upload/github/zabbix-nfs/error.png)
In this case Zabbix cannot find the path of the script as you can see *no such file or directory*

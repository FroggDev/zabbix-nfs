### Zabbix Template Module NFS version 1.0.3

Tested on Zabbix 5.2

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

On linux NFS server you may need to install **rpcbind** service to get information from **rpcinfo** command

# Installation

## Content
The template installation require 2 files:
* `frogg_nfs_check.sh` Zabbix external script
* `frogg_nfs_check.xml` Zabbix template configuration

## External script

Place the `frogg_nfs_check.sh` in `/etc/zabbix/externalscripts`. If you choose another location for your external scripts, you have to edit the `userparameter_frogg_nfs_check.conf` accordingly.

You will need to add execute permission on the script
```console
chmod +x frogg_nfs_check.sh 
```

Finally add the `userparameter_frogg_nfs_check.conf` to `/etc/zabbix/zabbix_agentd.conf.d/` or any other of your configuration directories, that are specified in the configuration file of the zabbix agent (default `/etc/zabbix/zabbix_agentd.conf`).

### Testing the installation

You can run the command:
- To Test NFS version
```
./frogg_nfs_check.sh version <ip-of-server>
```
- To Test NFS share
```
./frogg_nfs_check.sh share <ip-of-server> "/nfsShare1,/nfsShare2,/nfsShare3"
```
## Template

Then you need to import the `frogg_nfs_check.xml` template configuration file in the zabbix web interface in **Template** tab using the import button

# Host configuration
The template use 2 macros :

MACRO | Description
----- | -----------
{$NFSVERSION} | the NFS version that should be returned by the server
{$NFSSHARES} | the list of NFS shares that should be available, to set multiple shares they must be separated by `,` 

Exemple:
![Zabbix NFS configuration sample](https://tool.frogg.fr/upload/github/zabbix-nfs/macros.png)

# Template items
![Zabbix NFS Template](https://tool.frogg.fr/upload/github/zabbix-nfs/items.png)

# Template triggers
![Zabbix NFS Template triggers](https://tool.frogg.fr/upload/github/zabbix-nfs/triggers.png)

# Debugging

Going further...This step is working with most of externals scripts

If you got troubles getting an external script working, first :
1. Check the Zabbix tab **Monitoring > latest data**
If you select an host, you should see all items linked to it, check for your item and you should see the lasted data linked to it.
If it appear in gray (disabled) that mean there is something wrong with the external script (rights, path, arguments ...)
To find more about it you can check logs
2. By default the logs are in `/var/log/zabbix/zabbix_server.log` or you can find the log path in Zabbix configuration file `zabbix_server.conf` (by default `/etc/zabbix/zabbix_server.conf`)

To get the last log lines you can use for example:
```bash
tail -f /var/log/zabbix/zabbix_server.log
```
Then look at the script trouble...

Example:
![Zabbix NFS error sample](https://tool.frogg.fr/upload/github/zabbix-nfs/error.png)
In this case Zabbix cannot find the path of the script as you can see *no such file or directory*

# Contributors
[![](https://avatars.githubusercontent.com/u/3765812?s=50&u=a377d0b319be56f5917f500be1ea24f2610324c7&v=4)](https://github.com/FroggDev)
[![](https://avatars.githubusercontent.com/u/48913164?s=50&u=a148e291f87278136cbbcd1a303911a2bd7777d2&v=4)](https://github.com/SiKreuz)


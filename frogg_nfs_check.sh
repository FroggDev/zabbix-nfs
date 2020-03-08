#!/bin/bash
#            _ __ _
#        ((-)).--.((-))
#        /     ''     \
#       (   \______/   )
#        \    (  )    /
#        / /~~~~~~~~\ \
#   /~~\/ /          \ \/~~\
#  (   ( (            ) )   )
#   \ \ \ \          / / / /
#   _\ \/  \.______./  \/ /_
#   ___/ /\__________/\ \___
#  *****************************
#  Frogg - admin@frogg.fr
#  http://github.com/FroggDev/zabbix-nfs
#  *****************************

##########
# PARAMS #
##########
NFSACTION=$1
NFSSERVER=$2
NFSSHARES=$3

#############
# Functions #
#############

# ---
# Get the NFS version of a server
# @param serverIP
# @return NFS version
function getNfsVersion()
{
# Init NFS version to 0 = unavailable
VERSION=0

# Get NFS information using rpcinfo without error messages
TESTNFS=$(rpcinfo -u $1 nfs 2> /dev/null)

# Split all lines in the array TESTNFS
IFS=$'\n' read -rd '' -a TESTNFSLINES <<<"$TESTNFS"

# Loop over all lines of the array TESTNFSLINES
for TESTNFSLINE in "${TESTNFSLINES[@]}";
do
  [[ $TESTNFSLINE =~ "version 2 ready and waiting" ]] && VERSION=2
  [[ $TESTNFSLINE =~ "version 3 ready and waiting" ]] && VERSION=3
  [[ $TESTNFSLINE =~ "version 4 ready and waiting" ]] && VERSION=4
done;

# Display the NFS version or 0 if not available
echo $VERSION
}

# ---
# Get the NFS version of a server
# @param serverIP
# @param nfs share list separated with :
# @return nfs share not found
function checkNfsShare()
{
# Init NFS share not available (epmty by default)
RESULT=""

# Get NFS information using showmount without error messages
NFSDATA=$(showmount -e $1 2> /dev/null)

# Store the result as array
IFS=$'\n' read -rd '' -a NFSDATAS <<< "$NFSDATA"

# Get NFS share set as params and store it as an array
SHARES=$(echo $2 | tr ";" "\n")

#For each NFS share test if exist in server NFS share list
for SHARE in $SHARES
do
  # Check if NFS share does not exist in NFS server shares
  [[ ! " ${NFSDATAS[@]} " =~ " ${SHARE} " ]] && RESULT="${RESULT}[${SHARE}]"
done

[[ $RESULT = "" ]] && echo "0" || echo $RESULT
}

########
# MAIN #
########

# Clean screen
#clear

case ${NFSACTION} in
  # command check version
  ("version")echo $(getNfsVersion "$NFSSERVER");;
  # command check nfs share
  ("share")echo $(checkNfsShare "$NFSSERVER" "$NFSSHARES");;
  # command not set or invalid
  (*)echo "Error : command [${NFSACTION}] not found"
esac

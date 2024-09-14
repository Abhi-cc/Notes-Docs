# This Script Will Do incremental backup using tar and send them to remote using Rsync.
# Concept 
## It will take Source and create a full  backup at start of the current month and then it will create incremental backup 
## for rest of the month and Now When the Month Changes a new directory will be created with the new month and a full backup will be created in the new directory and So on


#!/bin/bash

Date=$(date +%F-%a-%H)
#Set Source and Destination directories
Source=/home/ubuntu/demodata
Destination=/home/ubuntu/demodest
Month=$(date +%Y%m)
# Set Error Files
backup_log_file=/var/log/backup.log
error_log_file=/var/log/backuperror.log


# Create a month Directory
#we use `${}` around the command substitution is to prevent word splitting or pathname expansion on the result of the command execution. This ensures that the output is treated as a single string rather than being split into multiple words or having file expansions applied.
#Trap command will trap any error with ERR signal and exit the script immideatly and print the message
#trap 'echo "There is error - $Date"; exit 1' ERR

# Commented the Trap command because the tar keeps giving error : Removing / from member names which is not a error. 
if [ ! -d "$Destination/$Month" ]; then
   mkdir -p "$Destination/$Month"
fi
# Create archieve of the Source and Send it to Destination to a remote host

if tar -cvzf "$Destination/$Month/$Date.tar.gz" --listed-incremental="$Destination/$Month/list.snar"    "$Source" 1>>/dev/null 2>>$error_log_file; then
   rsync -avz "$Destination/" <Your Remote Server Ip address> :~/hotbackup/ 1>> /dev/null 2>>$error_log_file 
else
   echo  -e " $Date - Backup Error check $error_log_file" 
fi 
#find "$Destination" -type d -ctime +30 | xargs echo "Directory older than 30 days: "
#!/bin/bash

Date=$(date +%F-%a-%H)
#Set Source and Destination directories
Source=/home/ubuntu/demodata
Destination=/home/ubuntu/demodest

# Set Error Files
backup_log_file=/var/log/backup.log
error_log_file=/var/log/backuperror.log


# Create a month Directory
#we use `${}` around the command substitution is to prevent word splitting or pathname expansion on the result of the command execution. This ensures that the output is treated as a single string rather than being split into multiple words or having file expansions applied.
#Trap command will trap any error with ERR signal and exit the script immideatly and print the message
trap 'echo "There is error - $Date"; exit 1' ERR

if[! -d "$Destination/${$(date +%m)}"]; then
mkdir -p "$Destination/${$(date +%m)}"
fi
# Create archieve of the Source and Send it to Destination to a remote host

if tar -cvzf "$Destination/${$(date +%m)}/$Date.tar.gz" --listed-incremental="$Dest/${$(date +%m)}/list.snar"  $Source 1>> /dev/null 2>>$error_log_file; then
   rsync -avz $Dest/*.tar.gz $Dest/*.snar <Your Remote Server Ip address> :~/hotbackup/ 1>> /dev/null 2>>$error_log_file 
   # Check if there is a error in rsync and send it error log
   if[$? -eq 0]; then
   echo  -e " $Date - Backup Error check $error_log_file" 
   else
   echo  -e " $Date - Backup Success" >> $backup_log_file
   fi
else
   echo  -e " $Date - Backup Error check $error_log_file" 
   exit 1

fi 
# Finds the Directories in Destination Folder 
Backup_Directories=($(find $Destination -type d)) 

# Starts the for loop and each time times finds commands finds a element , then that eleement is assigned to the backup_dir , then if check if the base name of the month directory is less then the current month and remove that. For eg if find commands 1 , 2 , 3 ,4 . Loop will iterate it as an array and assigned one number every time to the backup_dir variable and loop will continue till last number is reached.

for backup_dir in "$Backup_Directories[@]"; do 

if [$(basename "$dir") -lt $(date +%m)];then
rm -rf $backup_dir
fi

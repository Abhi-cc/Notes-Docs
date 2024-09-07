#Concept  #!!! Pending   
##

#!/bin/bash

#Error Handling & Error Files
error_log_file=/var/log/backup_error.log
trap 'echo "There is error - $(date +%f) : Check $error_log_file" ; exit 1' ERR

# Source and Desitnation Here
Source_Dir=<Your Source Directory here>
Destination_Dir=<Your Destination Directory here>

# Date with only month
Date=$(date +%m)

#ASCII codes for colors to print the message in defferent colors
Red='\033[35;1;4m'
Yellow='\033[1;36m'
NC='\033[0m'

# Copy the Entire directory and send it to the destination directory 
# If you want to send to another machine u can edit it like this  rsync -Avazh  --progress  $Source_Dir <Server Ipaddress>:"<Destination on different machine>/$Date" 1>> /dev/null 2>>$error_log_file
rsync -Avazh  --progress  $Source_Dir "$Destination_Dir/$Date" 1>> /dev/null 2>>$error_log_file

# After the sync is done it will compress it only works on local machine  # !! Pending add command in rsync command to compress the directory on remote
# It will create a Month directory and copy there
if [ $? -eq 0 ]
then
   tar -cvzf <SRC>/$Date.tar.gz <DEST>/$Date
else
   echo -e " ${Red} Try again, There is Problem ${NC} Check $error_log_file" 
   exit 1
fi

# If the compress is success it will delete the unarchieved directory
if [ $? -eq 0 ]
then
   rm -r <DEST>/$Date
else
   echo -e " ${Red} Try again, There is Problem ${NC}"
fi

# Improvements
## There is redundancy in the code use function for error if statmenet

#!/bin/bash

Date=$(date +%F-%a-%H)

Source=<SRC>
Dest=<DEST>
errorfile=/var/log/backuperror.log
tar -cvzf $Dest/$Date.tar.gz --listed-incremental=$Dest/list.snar  $Source 2>>$errorfile

if [ $? -eq 0 ]
then
   rsync -avz $Dest/*.tar.gz $Dest/*.snar <DEST Server>:~/hotbackup/ 2>>$errorfile 
   echo  -e " $Date - Backup Success" >> /var/log/backup.log
else
   echo  -e " $Date - Backup Error check $errorfile" 
fi 

----

# Improvements
# Add Find command to auto remove old backp for incremental
# Send output to /dev/null/
# Exit the command if error
# Second erros details to log file to

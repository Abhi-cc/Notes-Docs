## Rsync CheatSheat


| -avz --progress | Sync with archieve, compress                             |
| --------------- | -------------------------------------------------------- |
| --delete        | Delete the files on destination                          |
| --backup/-b     | Create a backup of synced files on destination directory |
| --exclude/-x    | exclude files from sync                                  |
| --dry-run/-n    | demo run                                                 |
| --checksum/-c   | change how rsync scans the file                          |
| --log-file      | Log rsync output to file                                 |
| --files-from    | Sync files listed in the input file                      |



**Basic Command Structure**

```bash
rsync [options] source destination
```

Example:

```bash
rsync -avz
/local/source user@remote:/remote/destination
```

**File Transfer Options**

- `-a (archive)`: Preserve file permissions, timestamps, and ownership.
    
- `-v (verbose)`: Increase verbosity of output.
    
- `-z (compress)`: Enable compression for faster transfers.

- `--progress`: Display transfer progress.

![rsync-1](https://github.com/user-attachments/assets/9969afe2-330e-44de-a60f-a152b83151be)

![rsync-2](https://github.com/user-attachments/assets/bedcf16e-1953-4c33-988e-48445fa1e3ba)



Now lets update the files see the sync process

![rsync-3](https://github.com/user-attachments/assets/8bdd624e-ba96-42b1-aaff-6c94ca8b507a)

![rsync-4](https://github.com/user-attachments/assets/c03f46e5-261f-4ea9-8d4c-9f3f76b8b886)

### Syncing multiple files & Directory to a remote

```bash
rsync -avz --progress </Path/to/Fil1> <PATH/To/Fil2> test@debian:~/Path/to/Destination>
```

![rsync-5](https://github.com/user-attachments/assets/e629a39a-7dfc-4d65-8e9e-29392de2707a)

![rsync-6](https://github.com/user-attachments/assets/c044aa27-69d3-460e-a724-da76d114b793)




```bash
rsync -avz --progress ./rsynctest/demodir1 ./rsynctest/demodir2 test@debian:~/
```

![rsync-7](https://github.com/user-attachments/assets/8b89424f-9c26-4756-b28a-8dd67e998411)


### Excluding files from sync 

There is a option to Exclude `--exclude` `-x` specific files from the rsync sync process. Forexample to exclude dot files we can

```bash
rsync -avz --progress -x '.*' . test@debian:~/
 ```

![rsync-8](https://github.com/user-attachments/assets/e02a2091-c0ab-47ed-9302-436ccc9008f0)


As seen all the dots files where excluded from the syncing process.

![rsync-9](https://github.com/user-attachments/assets/68f6849e-adaf-47d2-8d4b-f9044854b20e)

## Creating a true sync 

Well True sync is a mirror copy of Source. if we delete something on source, it should also be deleted on the destination. By default rsync doesnot remove the deleted files from destination.

We will use the `--delete` tag in addtion to the switches used earlier.

```bash
rsync -avz --progress --delete --exclude '.*' . test@admin:~/rsynctest/
```

Example: Lets Delete the document folder and then sync again to see if its deleted from debian server using `--delete`.  

![rsync-10](https://github.com/user-attachments/assets/977ddf3b-cb82-41f6-866e-819d6c349c5a)


As seen in the output Rsync deleted the documents folder from debian as i deleted from kali. Now  both machines are in sync.

![rsync-11](https://github.com/user-attachments/assets/f17ad834-cfc7-4608-95e5-05db02dd7828)


> [!WARNING]
> Do a dry run `-n` or`--dry-run` before using `--delete` switch on any data 

## Backup and Backupdir

Rsync `--backup / -b` switch will create a copy of the file that has been changed or deleted by adding a suffix to it on the destination(Default location is the dir in which the file is stored). This very good to use with `--delete` to prevent accident deletion of files.

```bash
rsync -avz --progress --backup --delete . test@debian:~/
```

First i did a intial sync:

<img width="686" alt="rsync-12" src="https://github.com/user-attachments/assets/bbd078c8-946a-46ca-8412-ddeaa96ac062">


Then i Deleted the file3.txt and used the `--delete` tag to make sure everything in complete sync and used `--backup` switch to make sure a copy of the deleted file is created. 

<img width="849" alt="rsync-13" src="https://github.com/user-attachments/assets/7e47d3b3-8fec-4b4e-9c1f-5c09b068f824">


Rsync added a `~` suffix to the deleted file

<img width="512" alt="rsync-14" src="https://github.com/user-attachments/assets/0af17066-b51c-4170-98a6-a4d6e9c8451d">



A custom backup directory can be specified using `--backup-dir` 

Made changes to file1.txt and file2.txt and then used `--backup-dir` to send the backup too.

<img width="1134" alt="rsync-15" src="https://github.com/user-attachments/assets/db17c2c6-86be-4194-a71a-1302d998da7a">


Rsync Created a backup folder with all the changed files. 

<img width="415" alt="rsync-16" src="https://github.com/user-attachments/assets/f865e984-acd3-4cd0-8f8f-0211d9be0b93">


A Custom Suffix can be specified using `--suffix`

<img width="1352" alt="rsync-17" src="https://github.com/user-attachments/assets/44837c79-d5f1-4dcd-a5ba-f36dbd16dd88">

<img width="512" alt="rsync-18" src="https://github.com/user-attachments/assets/133cc3fa-5a08-4835-9f42-e0a7b06e4bc8">

## Other option

`--log-file` & `--log-format` can be used to send rsync output a file with custom format. Very useful if running rsync using `cronjob`. 

```bash
rsync -avzh --log-file=./rsync.log  . test@kali:~/rsynctest/
```


![rsync-19](https://github.com/user-attachments/assets/66581337-201c-4907-a828-c16f7e632802)



`--quiet` will supress all the output printed by rsync on screen.

```bash
rsync -az --quiet --log-file=./rsync.log . test@kali:~/rsynctest/
```


`--checksum` will change how rsync  do a scan. By default rsync checks the modified time 
and filze size before syncing. By using the `--checksum` switch it will generate a hash for the source and destination and then sync files depending on it. A custom hash generating alogirthm can be choose using `--checksum-choice`
```bash
rsync -avzh --checksum . test@kali:~/rsynctest/
```



`--files-from`  A file with list of directories and files can be specified using `--files-from` switch. If theare are good numbers of files and directories to be specified as source. They can be put in a file rather then puting the names on the command itself.

```bash
rsync -azvh --files-from=<FileName> <Source> <Destination>:</PATH>
```

![rsync-21](https://github.com/user-attachments/assets/4d39b91f-8f4c-49d3-aaaa-4f1701fff4f7)



![rsync-20](https://github.com/user-attachments/assets/a64bd275-f187-443a-a7a9-43faf1c04cdb)





`--dry-run / -n` This switch do a demo run. It will print he output as it was doing a real sync. But no files will be transfered and no changes will be made. Useful for testing before doing the actual sync.

```bash
rsync -avzhn . test@kali:~/rsyntest/
```


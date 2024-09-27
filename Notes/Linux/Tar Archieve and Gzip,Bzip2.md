
# Compressing  and DeCompress Using Gzip and Bzip2

Gzip : This Compression algo is much faster 

Bzip2: Compress a bit more then Gzip but slower

## Compressing 
```bash
gzip file.txt #we can use -1 -9 for compression levels

bzip2 file.txg # sames -1 -9 compression levels
```

## Decompression

```bash
gunzip file.txt.gz

bunzip2 file.txt.gz 
```


----

# Basic of Using Tar

The `tar` command creates tar files by converting a group of files into an archive. 

## Where we can Use this tool.

1. Help full in creating simple archive and compressed backups
2. Portability of large number of files
3. Advance Operations help in incremental and differential backups
4. Help in storing offsite data on object based storages such as S3 

## `tar` Command Syntax

```bash
tar <Switches> <ARCHIVE_NAME> <File Name>
```

## Creating Tar Archive



We can create archive with tar and different compression technology gzip , bzip2 

```bash
tar -cvzf demo.tar.gz file1 file2 

tar -cvjf demo.tar.bz file1 file2
```

![image](https://github.com/user-attachments/assets/d26aecaf-515b-4d5a-823d-1b49f7608dd7)

`-c` : Creating Archive

`-v` : Verbose

`-z` : For gzip 

`-j`: For bzip2

`-f` : For Specifying file name 

### Listing Tar Archives

Suppose We want to check whats inside the archive we created Earlier We can do that by using `-t` or `--list` switch

```bash
tar -tf demo.tar.gz
```


![image](https://github.com/user-attachments/assets/da85212a-cbb1-406c-a675-a885ba9e1cb7)




## Extracting Tar Archive

To extract a tar archive, use the `-x` and it same for gzip and bzip2

For example we will extract from Archive created above

```shell
tar -xvzf demo.tar.gz
```

### Extracting Tar Archive in a Different Directory

 By default the tar will extract into current working directory , to send the extract to the specific directory use `-C` Switch 
```bash
tar -xvzf demo.tar.gz -C ~/test/
```


![image](https://github.com/user-attachments/assets/cb7a90de-2915-4b4b-b6e4-d3bcabb3b7db)

![image](https://github.com/user-attachments/assets/29185df0-2f65-4335-85d6-e3d1618ff4bb)


### Extracting Specific Files from a Tar Archive

If we only want to extract only one file instead on entire archive we can do this by specifying the file name.

For example: Using are archive we have created lets take `file1` out the extract and put in `test` directory

```shell
tar -xvzf demo.tar.gz /path/to/file1 -C ~/test/
```


### Extracting one or more directories from an archive:

```shell
tar -xvzf demo.tar.gz dir1 dir2
```

### Extracting Files from a Tar Archive using Wildcard

To extract files from an archive based on a pattern we can use `--wildcard` switch. 


For example, to extract all the `.jpg` files we can use a simple `*`  expression

```bash
tar -xvzf demo.tar.gz --wildcards '*.jpg'
```


![image](https://github.com/user-attachments/assets/4a8929f9-79c4-409c-b48e-5ba1b4df1b5b)


### Adding/Removing Files to Existing Tar Archive

> [!NOTE]
  >`Tar` doesn't support adding or deleting files from compressed archive. Only possibility is to 
  >decompress the archive then remove the file then again compress which is not practical in case of large number of files. And adding and removing file from a big archive can result in data lose so be careful!.

We can add a file to a simple archive using  `-r`  --append switch.
```bash
tar -rvf demo.tar file1
```

 or Delete file from archive using `--delete` switch
```bash
tar --delete -f demo.tar file1
```


-----

## Advance way of using Tar

### Incremental and Differential Backups



`Tar` command can be also used to create incremental and differential backups by using the 
`--listed-incremental or -N` switch and `-g` Switch.

`--listed-incremental` : This will keep the track of the files and directories that have been changed since last backup.

`-g` : Just create backup of all the files that have been changed without keeping track of files and directories.

Example : Creating a compressed tar archive with  `-c` :Creating `-v`: Verbose mode `-z`: Gzip compression Algo `-f`: File Name. `--listed-incremental` will create something like a snapshot which will have the metadata of all the files in the source directory.

As this is the first time its running it will create a full backup. 

```bash
tar -cvzf demodata0.tar.gz --listed-incremental demodata.snp ~/demodata
```

Now  For creating a incremental backup  file name should be changed  and when the command is run again, metadata of the snapshot file will be overwritten with the changes between the source and the old archive. 

```bash 
tar -cvzf demodata1.tar.gz --listed-incremental demodata.snp ~/demodata 
```

![image](https://github.com/user-attachments/assets/1742c660-bcf0-4c7f-89ee-8232633cc3f6)

#### Incremental Backup Recovery

1. First Recover the initial full backup

  ![image](https://github.com/user-attachments/assets/49eeab27-8271-4ce3-9cfe-d2f41bfe7172)

2.  Then Recover the level 1 backup which u created after the initial backup(I changed the file.txt)

 ![image](https://github.com/user-attachments/assets/9ae0076c-c2da-43ce-a3fc-744e0c79c844)


3. Then Recover the Level 2 backup which comes after the level 1 and So on repeat the process.(I deleted file3.txt and added file4.txt)

 ![image](https://github.com/user-attachments/assets/e64db098-719c-4324-913b-d3c21e4677a5)

4. Recovered Data

 ![image](https://github.com/user-attachments/assets/75b3318e-462b-4c4a-824f-a56e9b2bb7f6)

### For Differential Backups

We can do differential backups with the tar command using the same `--listed-incremental` . We just have to copy the snapshot file that was created when we do the first full backup. 
1. Do a full backup level0 Backup
2. A Snapshot file will be created for all the files and directories
3. Copy the initial snapshot file to a new file
4. Use the new file with `--listed-incremental`
5. That will create the level1 differential backup.
6. Repeat the process by copying intial snapshot into a file and using the new file as snap.

For example  : Creating a differential backup of `demodata` directory.

1. First we will create full backup 
```bash
   tar -cvzf demodata.tar.gz --listed-incremental demo0.snp ~/demodata
```
 2. We will copy the snapshot file and use the new file created for Level1 backup. (I didnot update the file1.txt :).
```bash
cp demo0.snp demo1.snp
tar -cvzf demodata1.tar.gz --listed-incremental demo1.snp ~/demodata
```

![image](https://github.com/user-attachments/assets/b491510e-7b16-43b8-8516-e90754f9eed0)

![image](https://github.com/user-attachments/assets/f3afbdf7-42b4-4d3f-b4f6-1cffd70a012a)




3. Repeat the same process for Level2 backup and So on. 


#### Differential Backup Recovery

For recovering differential backup first restore the intial full backup and 
```bash
tar -xvzf demodata.tar.gz -C demorec/
```

![image](https://github.com/user-attachments/assets/b75ee3ab-1809-45c5-ae13-b5301da272ea)

then restore the last current backup.

![image](https://github.com/user-attachments/assets/e602589e-790e-4b58-af91-83d39120ec8c)


----

**Creating a multi-volume archive** (Useful when the size of the archive being created is larger then the maximum size of a file)
> [!NOTE]
> Multi volume tag does not work with compress switch.

```bash
tar -cvf demo.tar.gz --multi-volume demodata
tar -cv --file demo.tar.gz --file demo.tar.gz-1 --multivolume demodata/
```


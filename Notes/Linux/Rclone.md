# Rclone
https://rclone.org/commands/

https://rclone.org/

Rclone is a file management solution for the cloud, it will do the job of copy, rsync, move, ncdu , ls, cat and all other file opeartions tools can do. It can be used to backup files to the cloud, move files between cloud etc.

**Installing Rclone**

```bash
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```

or u can download and install directly from official website depending on your cpu and opearting system.
After done installing run `rclone version` to check its working properly

----------

## Rclone Remote with SFTP

> [!NOTE]
> Make sure SSH is configured with Key based authentication and SFTP is enabled in SSH Config
>

### Creating a remote on a remote using SFTP protocol

```bash
rclone config
```

It will start a interactive session for configuration. Something like this

![Rclone-1](https://github.com/user-attachments/assets/f1b708d1-5afd-4ddc-a4e2-1fcd243da38c)


*Press `n` to create a new remote and type in the name and find the number for SFTP and enter it*

![Rclone-2](https://github.com/user-attachments/assets/9a9b7ae3-669c-41a3-818e-fd3a5c5eef1b)


![Rclone-3](https://github.com/user-attachments/assets/3e30987a-0ed5-4cb4-840c-0375c7b528e2)


![Rclone-4](https://github.com/user-attachments/assets/56f37814-bfb0-4a22-b442-7c52889383ec)


Follow the Interatice Session by Rclone and customize setting as per need

```bash
Option host.
SSH host to connect to.
E.g. "example.com".
Enter a value.
host> 172.16.171.130

Option user.
SSH username.
Enter a value of type string. Press Enter for the default (test).
user> test

Option port.
SSH port number.
Enter a signed integer. Press Enter for the default (22).
port> 

Option pass.
SSH password, leave blank to use ssh-agent.
Choose an alternative below. Press Enter for the default (n).
y) Yes, type in my own password
g) Generate random password
n) No, leave this optional password blank (default)
y/g/n> 

Option key_pem.
Raw PEM-encoded private key.
Note that this should be on a single line with line endings replaced with '\n', eg
    key_pem = -----BEGIN RSA PRIVATE KEY-----\nMaMbaIXtE\n0gAMbMbaSsd\nMbaass\n-----END RSA PRIVATE KEY-----
This will generate the single line correctly:
    awk '{printf "%s\\n", $0}' < ~/.ssh/id_rsa
If specified, it will override the key_file parameter.
Enter a value. Press Enter to leave empty.
key_pem> 

Option key_file.
Path to PEM-encoded private key file.
Leave blank or set key-use-agent to use ssh-agent.
Leading `~` will be expanded in the file name as will environment variables such as `${RCLONE_CONFIG_DIR}`.
Enter a value. Press Enter to leave empty.
key_file> 

Option key_file_pass.
The passphrase to decrypt the PEM-encoded private key file.
Only PEM encrypted key files (old OpenSSH format) are supported. Encrypted keys
in the new OpenSSH format can't be used.
Choose an alternative below. Press Enter for the default (n).
y) Yes, type in my own password
g) Generate random password
n) No, leave this optional password blank (default)
y/g/n> 

Option pubkey_file.
Optional path to public key file.
Set this if you have a signed certificate you want to use for authentication.
Leading `~` will be expanded in the file name as will environment variables such as `${RCLONE_CONFIG_DIR}`.
Enter a value. Press Enter to leave empty.
pubkey_file> 

Option key_use_agent.
When set forces the usage of the ssh-agent.
When key-file is also set, the ".pub" file of the specified key-file is read and only the associated key is
requested from the ssh-agent. This allows to avoid `Too many authentication failures for *username*` errors
when the ssh-agent contains many keys.
Enter a boolean value (true or false). Press Enter for the default (false).
key_use_agent> 

Option use_insecure_cipher.
Enable the use of insecure ciphers and key exchange methods.
This enables the use of the following insecure ciphers and key exchange methods:
- aes128-cbc
- aes192-cbc
- aes256-cbc
- 3des-cbc
- diffie-hellman-group-exchange-sha256
- diffie-hellman-group-exchange-sha1
Those algorithms are insecure and may allow plaintext data to be recovered by an attacker.
This must be false if you use either ciphers or key_exchange advanced options.
Choose a number from below, or type in your own boolean value (true or false).
Press Enter for the default (false).
 1 / Use default Cipher list.
   \ (false)                                                                                                                                                
 2 / Enables the use of the aes128-cbc cipher and diffie-hellman-group-exchange-sha256, diffie-hellman-group-exchange-sha1 key exchange.                    
   \ (true)                                                                                                                                                 
use_insecure_cipher> 2                                                                                                                                      

Option disable_hashcheck.
Disable the execution of SSH commands to determine if remote file hashing is available.
Leave blank or set to false to enable hashing (recommended), set to true to disable hashing.
Enter a boolean value (true or false). Press Enter for the default (false).
disable_hashcheck> 

Option ssh.
Path and arguments to external ssh binary.
Normally rclone will use its internal ssh library to connect to the
SFTP server. However it does not implement all possible ssh options so
it may be desirable to use an external ssh binary.
Rclone ignores all the internal config if you use this option and
expects you to configure the ssh binary with the user/host/port and
any other options you need.
**Important** The ssh command must log in without asking for a
password so needs to be configured with keys or certificates.
Rclone will run the command supplied either with the additional
arguments "-s sftp" to access the SFTP subsystem or with commands such
as "md5sum /path/to/file" appended to read checksums.
Any arguments with spaces in should be surrounded by "double quotes".
An example setting might be:
    ssh -o ServerAliveInterval=20 user@example.com
Note that when using an external ssh binary rclone makes a new ssh
connection for every hash it calculates.
Enter a value of type SpaceSepList. Press Enter to leave empty.
ssh> 

Edit advanced config?
y) Yes
n) No (default)
y/n> nger. Press Enter for the default (22).
port> 

This value must be a single character, one of the following: y, n.
y/n> This value must be a single character, one of the following: y, n.
y/n> 
Configuration complete.
Options:
- type: sftp
- host: 172.16.171.130
- use_insecure_cipher: true
Keep this "test_sftp" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> y

```

Now Lets test our remote using `ls`command

```bash
rclone ls test_sftp:
```

![Rclone-5](https://github.com/user-attachments/assets/262fe0a3-33d7-4891-a2bb-e818131dcbcb)


### Basic File Operations with RClone(Copy, Move, Delete, Directory, sync etc)

**Creating Directory on new remote using `mkdir`**

```bash
rclone mkdir test_sftp:rclonetest
```

![Rclone-6](https://github.com/user-attachments/assets/1ace28c0-6245-451e-a45a-31e2bcb9a53b)


**Listing files, directory using `ls` `lsd` `lsjson` `lsf` `lsl`

`ls` will display files + 
```bash
rclone ls test_sftp:rclonetest/
```
![Rclone-7](https://github.com/user-attachments/assets/a90ea8d5-507e-4587-b005-6dc300f62cbf)


`lsf` will display just the filenames 

```bash
rclone lsf test_sftp:rclonetest/
```

![Rclone-8](https://github.com/user-attachments/assets/d342b357-a016-4255-a424-f61abcdba8ff)


`lsd` will display list of directories
```bash
rclone lsd test_sftp:rclonetest/
```

![Rclone-9](https://github.com/user-attachments/assets/a7095974-3634-4f56-99a6-b5b79f5b4780)


`lsl` will display a lot more information 
```bash
rclone lsl test_sftp:rclonetest/
```

![Rclone-10](https://github.com/user-attachments/assets/c1b1d882-a1cb-4b38-8167-cc0d6984f3cf)


`lsjson` will display the list in json format
```bash
rclone lsjson test_sftp:rclonetest/
```

![Rclone-11](https://github.com/user-attachments/assets/b0dbd1ca-e9f5-4bd8-bcfb-9366243f843c)


**Sync and Copy with Rclone `sync` `copy`**

Lets Copy some images using rclone `copy` to remote . Rclone `copy` will copy the changes and files but will not remove the deleted files from the destination

```bash
rclone copy . test_sftp:rclonetest/
```

![rclone-12](https://github.com/user-attachments/assets/53048706-9a17-4724-9627-4faf8de9bab2)


![rclone-13](https://github.com/user-attachments/assets/f71bd722-e5c0-402a-b8b5-10e0fa29124d)


>[!NOTE]
>Difference between sync and copy is that if you delete a file on the source rclone copy wont delete the files on the remote. It will just copy the files and changes  but Rclone sync will remove the files  on remote if you delete files on the source.

Lets Remove one image and use rclone to sync changes.

```bash
rclone sync --verbose --progress . test_sftp:rclonetest/
```

![rclone-15](https://github.com/user-attachments/assets/d9ed73b9-2bd7-406f-a935-37edf6da40d2)

It deleted the img1.jpg file which i removed and other three text files as they where not present on source directory.

Well its sometimes dangerous as some files will be deleted accidently so use   `--backup_dir` tag which will move the deleted files rather then removing them.

![rclone-16](https://github.com/user-attachments/assets/086386d9-5397-4427-9cd4-0169146fcfd8)

![rclone-17](https://github.com/user-attachments/assets/d1efe1c4-a93d-4ed2-9b30-a60fe71cc1fb)


**Verifying Data in destination using `rclone check`**

Rclone will generate hashes of all the files on source and destination using hashing algorithm and then compare them to verify integrity
```bash
rclone check . test_sftp:rclonetest/
```

![rclone-16-1](https://github.com/user-attachments/assets/5289de54-4f6d-4301-b117-9a976e5752ec)


### Mounting the Remote  as  a local filesystem

Rclone can mount the cloud storage services to local device as a filesystem. IT uses FUSE which creates a file system without making changes in the kernel. 

```bash
rclone mount test_sftp:rclonetest ~/Downloads
```

![rclone-19](https://github.com/user-attachments/assets/a8e99ded-bcb2-4bab-ac95-6cdba37abc56)


![rclone-18](https://github.com/user-attachments/assets/cb90d869-38a0-4318-b583-ed9b3ac4af08)


 > [!NOTE]
> By default Rclone mounts only to a empty directory. If mount destination is not empty use `--allow-non-empty`. Also Rclone runs mount in forground. If want to run mount in background use `--daemon` 

Cloud services doesnot support many of the functions of local file system. Inorder to deal with these compatibility issues. Rclone uses Virtual File System(VFS) to Increase the comptability.

It uses **VFS caching** to improve the compatibility

VFS Cache has 4 modes : Off(Default)

Inthis mode rclone will read and write directly from the remote. But a file cannot be opened simuntaneously for read and write.

`--vfs-cache-mode <Catch Mode>` switch is used to change the modes

![rclone-20](https://github.com/user-attachments/assets/636260a7-4cab-433e-aca3-f8e02a6713bc)



![rclone-21](https://github.com/user-attachments/assets/588d765b-8def-4189-8e96-ad0fc4bfa7bb)


**minimal** : It adds some compatibility to the mount but its sames as off.

**writes** In this mode files can be opened for read and write simuntaneously and adds most of the compatibility for the local file system. It will use more disk space and memory.


**full** all of the local file system opeartions can be performed on this mode. Uses more diskspace and memory.

>[!NOTE]
> WHen using `full` Use `--vfs-read-ahead` and `--buffer-size` switches and add space depending on your hardware and requirements and fine tune it for optimal performance


![rclone-22](https://github.com/user-attachments/assets/107fa72e-a0d2-4104-89d6-145ef82a4b38)


![rclone-23](https://github.com/user-attachments/assets/685a548a-590f-46e0-a709-a918caf1d26b)



>[!IMPORTANT]
>This should work on mac and linux. 
>For Windows mount see offical Docs

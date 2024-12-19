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

### Other Useful Options

`rclone ncdu`  : NCDU is a text based user interface, used to check disk spaces especially which file or directory is using the most disk space.

```bash
rclone ncdu test_sftp:rclonetest
```

![rclone-24](https://github.com/user-attachments/assets/19b06da1-e5ea-43e2-a688-ab1921bd6c04)



`rclone tree` will list the remotes in a tree like format 

```bash
rclone tree test_sftp:
```


![rclone-25](https://github.com/user-attachments/assets/ca2c8402-35cb-4a1e-869b-abf80c3235f4)


`rclone serve nfs`   It starts a nfs server and serve the remote over nfs. Very useful with MacOS if have trouble installing FUSE
```bash
rclone serve nfs test_sftp: --vfs-cache-mode=full
```

![rclone-27](https://github.com/user-attachments/assets/6b47de63-89dd-405e-9054-5429f944241a)




`rclone serve http` it will serve the remote over http(port 8080) and can be accesed using brower.

```bash
rclone serve http test_sftp:
```

![rclone-26](https://github.com/user-attachments/assets/c2ef4e27-5796-4e63-ad57-f33d44c6b10b)


------


## Rclone with AWS S3 Bucket as Remote

### AWS S3 Bucket Setup 

#### Creating Bucket 
  -  login into your aws account and go to S3 console and create bucket
  -  Fill the info such as bucket name , bucket versioning.
    ![rclone-27](https://github.com/user-attachments/assets/92578d30-8fa9-4cb8-9c3b-8a0fc11359a9)
  
  - Leave Default on *Block Public access* and other options or change it to your use case
  - ![rclone-29](https://github.com/user-attachments/assets/cb3935c5-15a5-43b8-8042-06315cf323a8)
  
  - ![rclone-30](https://github.com/user-attachments/assets/8bc4f1d2-62bf-4b6e-a03b-3e3645e4516e)

  - Go Ahead create the bucket and you will see the bucket appear in your S3 console

> [!WARNING]
> Make sure recheck the public access is blocked. Before uploading anything.
>

### Creating a IAM user and giving it only required permissions.

#### Creating IAM user

 - Go to IAM console and then users 
 - Click on create users
 - ![rclone-31](https://github.com/user-attachments/assets/e7b0f252-a2f1-4f86-95d7-5d35c5a7b8e8)
 - Permissions are required next, Check `attach policy directly`  or create group with required permissions and add user to the group. Then `Create Policy`
 
 - ![rclone-32](https://github.com/user-attachments/assets/7b745f70-a916-44db-b64c-6423240b430c)
 
 - ![rclone-33](https://github.com/user-attachments/assets/10a293d6-5fa9-4f9a-9a6d-a11488258915)

 - ![rclone-34](https://github.com/user-attachments/assets/1d656fba-8276-45f8-9d0e-d7c712d76558)

#### Generating keys for IAM Users.

- Go the Users Tab and select the user created 
- Go to the security Credential Tab
- ![rclone-35](https://github.com/user-attachments/assets/30207491-4d4f-48e9-bf4f-dd29374fc1e3)
- Scroll Down to Access Keys and click create access keys
- ![rclone-36](https://github.com/user-attachments/assets/237985aa-86d1-43cc-98cb-f8645466ebe0)
- ![rclone-37](https://github.com/user-attachments/assets/1f729a62-48e9-4a05-ae13-943ee1ab0597)

> [!IMPORTANT]
> Store your access keys somewhere save

> [!WARNING]
> Never Generate access keys for your root account.


### S3 bucket as remote

#### Rclone Configuration

```bash
rclone config
```

(n) New remote and enter the name. Lets say s3_test and Find the S3 mumber should be (4) and after that select (1) for AWS.

Follow the Interactive 

```bash
provider> 1                                                                                                                                                

Option env_auth.
Get AWS credentials from runtime (environment variables or EC2/ECS meta data if no env vars).
Only applies if access_key_id and secret_access_key is blank.
Choose a number from below, or type in your own boolean value (true or false).
Press Enter for the default (false).
 1 / Enter AWS credentials in the next step.
   \ (false)                                                                                                                                               
 2 / Get AWS credentials from the environment (env vars or IAM).                                                                                           
   \ (true)                                                                                                                                                
env_auth>                                                                                                                                                  

Option access_key_id.
AWS Access Key ID.
Leave blank for anonymous access or runtime credentials.
Enter a value. Press Enter to leave empty.
access_key_id> <ACCESS Key Here>

Option secret_access_key.
AWS Secret Access Key (password).
Leave blank for anonymous access or runtime credentials.
Enter a value. Press Enter to leave empty.
secret_access_key> <Secret Access Key here>

Option region.
Region to connect to.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
   / The default endpoint - a good choice if you are unsure.  

Option endpoint.
Endpoint for S3 API.
Leave blank if using AWS to use the default endpoint for the region.
Enter a value. Press Enter to leave empty.
endpoint> 

Option location_constraint.
Location constraint - must be set to match the Region.
Used when creating buckets only.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / Empty for US Region, Northern Virginia, or Pacific Northwest
   \ ()                                                                          
location_constraint>                                                                                                                                      

Option acl.
Canned ACL used when creating buckets and storing or copying objects.
This ACL is used for creating objects and if bucket_acl isn't set, for creating buckets too.
For more info visit https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl
Note that this ACL is applied when server-side copying objects as S3
doesn't copy the ACL from the source but rather writes a fresh one.
If the acl is an empty string then no X-Amz-Acl: header is added and
the default (private) will be used.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
   / Owner gets FULL_CONTROL.
 1 | No one else has access rights (default).                                                                                                              
   \ (private)                                                                                                                                             
   / Owner gets FULL_CONTROL.                                                                                                                              
 2 | The AllUsers group gets READ access.                                                                                                                  
   \ (public-read)                                                                                                                                         
   / Owner gets FULL_CONTROL.                                                                                                                              
 3 | The AllUsers group gets READ and WRITE access.                                                                                                        
   | Granting this on a bucket is generally not recommended.                                                                                               
   \ (public-read-write)                                                                                                                                   
   / Owner gets FULL_CONTROL.                                                                                                                              
 4 | The AuthenticatedUsers group gets READ access.                                                                                                        
   \ (authenticated-read)                                                                                                                                  
   / Object owner gets FULL_CONTROL.                                                                                                                       
 5 | Bucket owner gets READ access.                                                                                                                        
   | If you specify this canned ACL when creating a bucket, Amazon S3 ignores it.                                                                          
   \ (bucket-owner-read)                                                                                                                                   
   / Both the object owner and the bucket owner get FULL_CONTROL over the object.                                                                          
 6 | If you specify this canned ACL when creating a bucket, Amazon S3 ignores it.                                                                          
   \ (bucket-owner-full-control)                                                                                                                           
acl>                                                                                                                                                       

Option server_side_encryption.
The server-side encryption algorithm used when storing this object in S3.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / None
   \ ()                                                                                                                                                    
 2 / AES256                                                                                                                                                
   \ (AES256)                                                                                                                                              
 3 / aws:kms                                                                                                                                               
   \ (aws:kms)                                                                                                                                             
server_side_encryption> 1                                                                                                                                  

Option sse_kms_key_id.
If using KMS ID you must provide the ARN of Key.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / None
   \ ()                                                                                                                                                    
 2 / arn:aws:kms:*                                                                                                                                         
   \ (arn:aws:kms:us-east-1:*)                                                                                                                             
sse_kms_key_id>                                                                                                                                            

Option storage_class.
The storage class to use when storing new objects in S3.
Choose a number from below, or type in your own value.
Press Enter to leave empty.
 1 / Default
   \ ()                                                                                                                                                    
 2 / Standard storage class                                                                                                                                
   \ (STANDARD)                                                                                                                                            
 3 / Reduced redundancy storage class                                                                                                                      
   \ (REDUCED_REDUNDANCY)                                                                                                                                  
 4 / Standard Infrequent Access storage class                                                                                                              
   \ (STANDARD_IA)                                                                                                                                         
 5 / One Zone Infrequent Access storage class                                                                                                              
   \ (ONEZONE_IA)                                                                                                                                          
 6 / Glacier storage class                                                                                                                                 
   \ (GLACIER)                                                                                                                                             
 7 / Glacier Deep Archive storage class                                                                                                                    
   \ (DEEP_ARCHIVE)                                                                                                                                        
 8 / Intelligent-Tiering storage class                                                                                                                     
   \ (INTELLIGENT_TIERING)                                                                                                                                 
 9 / Glacier Instant Retrieval storage class                                                                                                               
   \ (GLACIER_IR)                                                                                                                                          
storage_class>  < Choose yr storage class or set directly in bucket>                                                                                                                                           

Edit advanced config?
y) Yes
n) No (default)
y/n> n
```

**Lets test the new S3 Remote**

  ![rclone-38](https://github.com/user-attachments/assets/bf846020-99e3-43f9-be51-22433a7bb1da)

  ![rclone-39](https://github.com/user-attachments/assets/a1a92f7d-10ce-41ce-8651-837fdd604488)

  Lets Read the file3.txt
```bash
rclone cat s3-test:rclone-demo/file3.txt
```
![rclone-40](https://github.com/user-attachments/assets/93045f93-ad58-4815-b2ae-41be87bba5ea)

Remove the Image file from the bucket
```bash
rclone rm s3-test:rclone-demo/Img1.png
```


> [!NOTE]
> All the above opeartions can be used against S3 remote. Such as sync, cat, mv, mount etc



#### Saving Cost 

> [!IMPORTANT]
> AWS will charge according the Data stored in the cloud and number of transcation made to the S3 API.
> API calls the S3 can be reduced by using some tags such as `--checksum` `--fast-list` but this tags will use lot of disk and memory as `--checksum` will create and match the hashes of file and `--fast-list` will load the list in the memory first and thus saving us some transcations.
> There some more tags , which helps save transcations but they have some trade off too. Refer to the **Rclone docs** for it and use them as per needs  

```bash
rclone check --fast-list --checksum . s3-test:rclone-demo

```
![rclone-41](https://github.com/user-attachments/assets/a5b02703-db02-49a8-98b3-725faae284e9)

**S3 Life Cycle and bucket versioning**

Life Cycle Policy for the objects can be setup in the S3 console for moving the object from 1 storage class to other storage class which will help save cost on the data stored but when data need to reterieved, some more cost willl be charged. 

**Storage Tiers for S3**

Standard ---> Standard IA ---- Inteliggent tier ---> IA - One Zone ---> Glacier instant --->. Glacier flexible -----> Glacier Deep archieve

>[!NOTE]
>Glacier tier is more cheap for long term storage such as backups. But be sure to check the **reterival cost and time**

**Bucket Versioning**

List the bucket Versioning

`rclone backend versioning s3-test:rclonedemo`

Bucket versioning can be enable from the s3 console.

![rclone-42](https://github.com/user-attachments/assets/b61a0bf2-7de2-46d7-befd-56eee956d4c5)

Listing the different versions of file 

```bash
rclone ls --s3-versions s3-test:rclone-demo
```

![rclone-43](https://github.com/user-attachments/assets/70a1b4f9-ec0b-447c-9aa1-d966be5192be)

---


# Backbaze B2 as remote

Creating B2 Bucket & Generating Applicaiton keys

  Go to Console and buckets and Create bucket and fill the bucketname

  ![rclone-44](https://github.com/user-attachments/assets/371a600b-1dba-4e57-82d6-b22b17a9c8ca)

  **Lets Generate Application key for the rclone**

1. Go to application keys from the side bar and click add new Application key
2. Fill in the details and select the new bucket created from drop down menu and fill other settings as per usecase
3. ![rclone-45](https://github.com/user-attachments/assets/0702ec8d-370f-411b-99f9-ea17fe51b99a)


> [!IMPORTANT]
> If possible use your application key and try not to use your master key


### B2 as Remote 

1. Enter the interactive session for rclone
   ```bash
   rclone config
```
 2. Enter the details as asked 
```bash
Choose a number from below, or type in your own value.

 5 / Backblaze B2                                                                                                                                          
   \ (b2)                                                                        

Storage> 5                                                                                                                                                 

Option account.
Account ID or Application Key ID.
Enter a value.
account> < Your Application Key ID here>

Option key.
Application Key.
Enter a value.
key> <Your Application key here>

Option hard_delete.
Permanently delete files on remote removal, otherwise hide files.
Enter a boolean value (true or false). Press Enter for the default (false).
hard_delete> 

Edit advanced config?
y) Yes
n) No (default)
y/n> n
 
```

3. Lets test our new b2 remote
 ```bash
 rclone copy file3.txt b2:rclone-test123

 rclone copy img1.jpg --verbose --progress b2:rclone-test123
```
![rclone-46](https://github.com/user-attachments/assets/3e45ca47-ada3-4867-9d86-a324ea586cb6)

![rclone-47](https://github.com/user-attachments/assets/87252c93-e412-4f74-8efb-9f47e57ff891)


------


# Encryption

## Encryption 

Till now  all the data uploaded was plain format or using the cloud provided encryption. Rclone can do client side encryption and so the data before being uploaded to any of the remote will be encrypted. 

Rclone uses crypt on the top of existing remote as a way of setting up client side encryption




Create a new remote and select crypt for setting up encryption 

 Follow the interative session
  ```bash
  Enter name for new remote.
name> s3-crypt

Option Storage.
Type of storage to configure.
Choose a number from below, or type in your own value.    

13 / Encrypt/Decrypt a remote                                                                                                                               
   \ (crypt)                                                                                                                                                
Storage> 13                                                                                                                                                 

Option remote.
Remote to encrypt/decrypt.
Normally should contain a ':' and a path, e.g. "myremote:path/to/dir",
"myremote:bucket" or maybe "myremote:" (not recommended).
Enter a value.
remote> s3-test:rclone-demo 

Option filename_encryption.
How to encrypt the filenames.
Choose a number from below, or type in your own value of type string.
Press Enter for the default (standard).
   / Encrypt the filenames.
 1 | See the docs for the details.    #This will mask the File details                                                                                                                      
   \ (standard)                                                                                                                                             
 2 / Very simple filename obfuscation.                                                                                                                      
   \ (obfuscate)                                                                                                                                            
   / Don't encrypt the file names.                                                                                                                          
 3 | Adds a ".bin", or "suffix" extension only.                                                                                                             
   \ (off)                                                                                                                                                  
filename_encryption> 1                                                                                                                                      

Option directory_name_encryption.
Option to either encrypt directory names or leave them intact.
NB If filename_encryption is "off" then this option will do nothing.
Choose a number from below, or type in your own boolean value (true or false).
Press Enter for the default (true).
 1 / Encrypt directory names.  
   \ (true)                                                                                                                                                 
 2 / Don't encrypt directory names, leave them intact.                                                                                                      
   \ (false)                                                                                                                                                
directory_name_encryption> 1                                                                                                                                

Option password.
Password or pass phrase for encryption.
Choose an alternative below.
y) Yes, type in my own password
g) Generate random password
y/g> g
Password strength in bits.
64 is just about memorable
128 is secure
1024 is the maximum
Bits> 128
Your password is: <Password Here>
Use this password? Please note that an obscured version of this 
password (and not the password itself) will be stored under your 
configuration file, so keep this generated password in a safe place.
y) Yes (default)
n) No
y/n> 

Option password2.
Password or pass phrase for salt.
Optional but recommended.
Should be different to the previous password.
Choose an alternative below. Press Enter for the default (n).
y) Yes, type in my own password
g) Generate random password
n) No, leave this optional password blank (default)
y/g/n> g
Password strength in bits.
64 is just about memorable
128 is secure
1024 is the maximum
Bits> 128
Your password is: <Second Password here>
Use this password? Please note that an obscured version of this 
password (and not the password itself) will be stored under your 
configuration file, so keep this generated password in a safe place.
y) Yes (default)
n) No
y/n> g
This value must be one of the following characters: y, n.
y/n> y


```


A new will be shown in the list and all the files will be uploaded using this new remote rather then the old s3 remote.for it to be encrypted


![rclone-48](https://github.com/user-attachments/assets/7f9a4cd7-5e03-4db2-bbb8-77d9d1b17b59)


`rclone copy --verbose --progress . s3-crypt:`

![rclone-49](https://github.com/user-attachments/assets/ea987bfb-b3b5-48c9-a25d-382e958d2b1d)

![rclone-50](https://github.com/user-attachments/assets/dcfa5d94-50ec-4d03-a399-bbb635a7c578)




>[!TIP]
>Rclone check wont work for the remote with encryption so use cryptcheck for the remote with crypt

>[!NOTE]
>Similar steps can be performed to encrypted other types of remote such as b2

  

### Protecting access to rclone itself and its config file



Rclone main configuration file which store all the keys and passowrds in obsructed format  can be encrypted using a password .

```bash
rclone config encryption set
```

or 

```bash
rclone config 

----
s) Set configuration password
q) Quit config
```

>[!Important]
>Make sure to backup the rclone config file, if somehow the keys for the remote are lost, remote can be still be connected using the config file with the password used for encrypting the config file


# Rclone GUI 

Rclone as a optinal GUI  which  act a fronted can be enabled using 

```bash
rclone rcd --rc-web-gui

```

![rclone-51](https://github.com/user-attachments/assets/b7252a2b-9d12-4371-b755-92ec6093b9b5)

![rclone-52](https://github.com/user-attachments/assets/b7b2843b-10ce-4c0f-932c-adf0aecfea72)


>[!NOTE]
>For full configuration options of rclone GUI check Official Doc



 
  

## Walkthrough

LUKS is used to **encrypt data at rest**. For eg full disk encryption, Encrypting removable drives such as pendrives etc.

>[!NOTE]
>Using a virtual drive for the walkthrough.

**Checking for the attached drive**

```bash
lsblk
```

![luks-3](https://github.com/user-attachments/assets/ce22cdac-2054-4ccc-9904-91c932f81bb1)


**Encrypting the drive**: 


```bash
sudo cryptsetup lukFormat /dev/nvme0n2
```

![luks-4](https://github.com/user-attachments/assets/d3cc1bb2-4ecf-472a-a307-afdc27e12b57)



**Lets Check if its working**

```bash
sudo cryptsetup luksDump /dev/nvme0n2
```

![luks-5](https://github.com/user-attachments/assets/67fbec0e-cc02-4e26-93aa-8ff180b0a955)


**Lets Open the encrypted Drive**

```bash 
sudo cryptsetup luksOpen /dev/nvme0n2 cryptdrive #Give the name for the drive for the mapper
```

![luks-6](https://github.com/user-attachments/assets/11a1335a-2bd4-4a3a-b4ec-203f7e8247b8)

Now we need to create file system for the encrypted drive 

```bash
sudo mfks.ext4 /dev/mapper/cryptdrive
```

![luks-7](https://github.com/user-attachments/assets/54f3dec1-89e5-4d5f-9a2a-09ee13b37b75)


Now lets mount the drive and put some files into it

![luks-8](https://github.com/user-attachments/assets/974f2d57-bbaf-4cbd-9f9d-695e2d3534d9)


Adding files to the drive and close the drive

```bash
sudo chown test:test /mnt/cryptdrive

cp -r testdata/ /mnt/cryptdrive

ls -l /mnt/cryptdrive
```

![luks-9](https://github.com/user-attachments/assets/d12a21e8-ab75-4bee-84c4-f746a0501346)


unmount and close the drive

```bash
sudo cryptsetup luksClose cryptdrive

```

![luks-20](https://github.com/user-attachments/assets/c92e9df2-b3fb-474f-a137-a113ab2c9a26)


### Key Management for the luks encrypted drive

luks uses header to store the encrypted master key which encrypts the data so the password we use will encrypt the master key in the header which allow us to have multiple keys for same the drive up to 8

Lets See...

```bash
sudo cryptsetup luksDump /dev/nvme0n2
```

![luks-10](https://github.com/user-attachments/assets/4d5f89f6-9f5e-4e95-8d23-5c14f52fe8e4)

In the Keyslots there is only 1 key for now. Lets add 1 more key and see if we can open our encrypted drive 

```bash
sudo cryptsetup luksAddKey /dev/nvme0n2 # Add the --key-slot/-S for specific slot
```

![luks-11](https://github.com/user-attachments/assets/b4168031-88d6-4256-b77a-ef32d2c97441)

![luks-12](https://github.com/user-attachments/assets/41668a22-4a47-4b0d-9b02-be4c9a89159b)

Now we have 2 keys which we can use to unlock the drive. Lets confirm it while using the new key


![luks-13](https://github.com/user-attachments/assets/460806ac-782a-4549-8035-b479a9b6aec6)


Lets Remove the first. Simulating a compromised key 

>[!WARNING]
> Before trying this action,Make sure you have backup or a different key you can unlock the device. If all the keys are lost, you wont be able to access the data.
>

Lets Verify the keyslot or the key which we will remove. 
```bash
sudo cryptsetup --test-passphrase -v open /dev/nvme0n2
```

![luks-14](https://github.com/user-attachments/assets/891b6656-03c4-4df0-bebb-7f2bd1fa0f2a)

```bash
sudo cryptsetup luksRemoveKey /dev/nmve0n2 

or

sudo cryptsetup luksKillSlot /dev/nvme0n2 -S 0 # This action will delete the key without asking the password, Used in case if the passphrase is forgotten or lost
```

![luks-15](https://github.com/user-attachments/assets/ebd01a94-ab72-424e-b7b8-716c1fceca95)



### Header Backup and Restore

LUKS depend on header for encrypting and decrypting the data, if the header is damaged its not possible to decrypt the drive. So its important to backup the header


>[!IMPORTANT]
>Its very important to keep the header file safe


```bash
sudo cryptsetup luksHeaderBackup  -v /dev/nvmeo0n2 --header-backup-file ~/headerbackup.img 
```

![luks-16](https://github.com/user-attachments/assets/22a5315e-226f-46ba-8334-e361e0edac32)

![luks-17](https://github.com/user-attachments/assets/0afd3ea4-f4ba-45e6-ba29-8509833d8f4c)

Lets check whether the header is correct. By specifying the header file directly. you can mount and check the data as above

```bash
sudo cryptsetup -v --header ~/headerbackup.img open /dev/nvme0n2 test
```

Now when its verified we can replace the damaged header with the backup header file

>[!WARNING]
>Make sure to perform the above steps first and then restore the header.


```bash
sudo cryptsetup -v luksHeaderRestore /dev/nvme0n2 --header-backup-file ./headerbackup.img
```

![luks-18](https://github.com/user-attachments/assets/d5a1721a-1bad-4a23-bca1-0ddc41e553c1)

lets check if the restore is success

```bash
sudo crypsetup luksOpen /dev/nvme0n2 cryptdrive

lsblk -p
```

![luks-19](https://github.com/user-attachments/assets/a5159386-f1a5-4cb6-ad42-7659bda9222e)



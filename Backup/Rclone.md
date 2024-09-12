# Using Rclone for Sending Encrypted Backup to remote such as S3

**Installing RClone**
`sudo -v ; https://rclone.org/install.sh | sudo bash`

---

## Quick WalkThrough for Setting up Encrypted S3 bucket remote

>[!NOTE]
> This is for Testing Purpose Only. Ill am still working on full tutorial with screen shots and explanation


 `rclone Config`
 **Follow the Interactice Setup Process** > **For S3**: Find the number and then type the number.
 **Keys**: Generate Access key pairs for the rclone to use.

> [!WARNING]
> Never Generate Key Pair for root account on any cloud service provider.

_Test the Connection_
`rclone ls <remote>:<bucket>`

_Now For the Crypt Setup_

 **For Crypt** Find the number for crypt and then type the number.
**Remote**: For Remote select your remote you created earlier
**Password**: Type your first password then your second password.

_Uploading Encrypted files to the cloud_

`rclone copy -v <Source> <cryptremote>:bucket`

_Go ahead to your bucket and see your encrypted file_

---

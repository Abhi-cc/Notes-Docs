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


> [!NOTE]
> Working on Rest of the Features of the Tool

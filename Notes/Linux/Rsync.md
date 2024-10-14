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




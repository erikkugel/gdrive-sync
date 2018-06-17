# grive-sync is a script for backing up folders to GDrive

### Requirements
* Google GDrive account
* [gdrive binary](https://github.com/prasmussen/gdrive)
* tar
* gpg
* split

### Usage
1. Save an encryption passphrase in a file called `< source folder >_grdive-sync.pw`. This is **not** optional.
2. Run `grive-sync.sh < source folder >`

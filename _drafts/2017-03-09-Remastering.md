
```
$ sudo mkdir /mnt/new
$ sudo mount ~/Downloads/TinyCore-current.iso /mnt/new -o loop,ro
$ cp -a /mnt/new ~/Documents/new
$ sudo mv ~/Documents/new/boot/core.gz ~/Documents/new/
$ sudo umount /mnt/new
```

```
$ sudo mkdir ~/Documents/new/extract
$ cd ~/Documents/new/extract/
$ zcat ~/Documents/new/core.gz | sudo cpio -i -H newc -d

20630 blocks
```

/opt/bootlocal.sh

```
#!/bin/sh
# put other system startup commands here

echo "Hello, world!"
```

```
$ sudo chroot ~/Documents/new/extract/ depmod -a 4.2.9-tinycore
```

```
sudo find | sudo cpio -o -H newc | gzip -2 > ~/Documents/core.gz

20660 blocks
```

```
$ cd ..
$ sudo cp ~/Documents/core.gz boot
$ sudo mkdir newiso
$ sudo mv boot newiso
$ sudo mv cde newiso
```

```
$ sudo mkisofs -l -J -R -V TC-custom -no-emul-boot -boot-load-size 4 -boot-info-table -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -o TC-remastered.iso newiso

I: -input-charset not specified, using utf-8 (detected in locale settings)
Size of boot image is 4 sectors -> No emulation
 63.24% done, estimate finish Thu Mar  9 18:30:58 2017
Total translation table size: 2048
Total rockridge attributes bytes: 6826
Total directory bytes: 14336
Path table size(bytes): 66
Max brk space used 23000
7930 extents written (15 MB)
```

wrong.iso


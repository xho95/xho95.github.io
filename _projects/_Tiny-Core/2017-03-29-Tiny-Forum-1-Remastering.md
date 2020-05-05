Remastering for PXE boot system

I have been building a system which checks computer information with in a PXE server-client system for several weeks.

My goal is running my program automatically on tiny core linux immediately after boot time.

I read the [Netbooting](http://wiki.tinycorelinux.net/wiki:netbooting) article. However, that method uses the tiny core linux as the server side, so I can't use it.

I have built the pxe booting system with Ubuntu 16.04 for server and Tiny Core linux for client, and succeed booting with ISO file of Tiny Core linux.

After then I have tried to change the `bootlocal.sh` file to test the remastering of Tiny Core linux according to the [Remastering TC](http://wiki.tinycorelinux.net/wiki:remastering) article.

However, executing the below command on Ubuntu 16.04 make wrong cpio file in the gz file.

```
$ sudo find | sudo cpio -o -H newc | gzip -2 > ~/Documents/core.gz
```

As shown below, the core.cpio file is crashed, so It can't boot with the PXE system.

![Tiny Core Remastering Error](/assets/TinyCore/tiny-cpio-error.png)

Below are the commands which I used to make ISO file.

```
$ sudo mkdir /mnt/temp
$ sudo mount ~/Downloads/Tiny-Origin/TinyCore-current.iso /mnt/temp -o loop,ro
$ cp -a /mnt/temp ~/Documents/temp
$ sudo mv ~/Documents/temp/boot/core.gz ~/Documents/temp
$ sudo umount /mnt/temp
```

```
$ sudo mkdir ~/Documents/temp/extract
$ cd ~/Documents/temp/extract
$ zcat ~/Documents/temp/core.gz | sudo cpio -i -H newc -d
```

```
$ sudo vi bootlocal.sh
$ sudo geidt bootlocal.sh

echo "hello, world"
```

```
$ cd ~/Documents/temp/extract
$ sudo find | sudo cpio -o -H newc | gzip -2 > ~/Documents/core.gz
$ cd ~/Documents
$ advdef -z4 core.gz
```

```
$ cd ~/Documents/temp
$ sudo mv ~/Documents/core.gz boot
$ sudo mkdir newiso
$ sudo mv boot newiso
$ sudo mv cde newiso
$ sudo mkisofs -l -J -R -V TC-custom -no-emul-boot -boot-load-size 4 -boot-info-table -b boot/isolinux/isolinux.bin -c boot/isolinux/boot.cat -o TC-remastered.iso newiso
$ rm -rf newiso
```

Are there any mistakes or are there any other solutions?

I needs your help, Thank you.

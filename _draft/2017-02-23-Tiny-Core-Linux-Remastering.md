### TC 재기록하기 (Remastering)

이 가이드는 사용자가 명령 줄을 사용하는데 익숙하다고 가정합니다.

Tiny Core 에는 gzip 으로 압축된 cpio 아카이브 파일이 있습니다. 이것은 ISO 이미지 등 원하는 부팅 방법을 위해 커널과 함께 묶을 수 있습니다.

재기록 과정은 TC 만으로 완료할 수도 있고 (**advcomp.tcz** 로드가 필요합니다. ISO 이미지를 만들려면 **mkisofs-tools.tcz** 도 있어야 합니다.), 다른 리눅스 배포판을 가지고서도 필수 도구들이 있으면 완료할 수 있습니다. (필수 도구는 cpio, tar, gzip, advdef, ISO 만들려면 mkisofs 가 필요합니다.)

> 참고: advcomp 는 선택 사항입니다. 설치되어 있지 않으면 `advdef` 명령을 모두 건너 뜁니다.

#### 압축 풀기 (Unpacking)

먼저, ISO 에서 커널과 `core.gz` 파일을 구합니다:

```
$ sudo mkdir /mnt/tmp
$ sudo mount tinycore.iso /mnt/tmp -o loop,ro
$ cp /mnt/tmp/boot/vmlinuz /mnt/tmp/boot/core.gz /tmp
$ sudo umount /mnt/tmp
```

ISO 이미지를 만들려고 한다면 두 파일만 복사하는게 아니라 전체를 복사합니다:

```
$ sudo mkdir /mnt/tmp
$ sudo mount tinycore.iso /mnt/tmp -o loop,ro
$ cp -a /mnt/tmp/boot /tmp
$ mv /tmp/boot/tinycore.gz /tmp
$ sudo umount /mnt/tmp
```

그다음 `core.gz` 의 압축을 풀어서 원하는 것을 추가하거나 제거합니다: [^zetawiki-zcat]

```
$ mkdir /tmp/extract
$ cd /tmp/extract
$ zcat /tmp/core.gz | sudo cpio -i -H newc -d
```

이제, 전체 파일 시스템이 **/tmp/extract** 폴더에 있습니다. 자유롭게 원하는 것을 더하고 제거하고, 또는 편집하면 됩니다.

**Alternative approach to adding extensions. (Overlay using cat)**

As per [Forum topic - Overlay using cat](http://forum.tinycorelinux.net/index.php?topic=8437.0) an interesting alternative to unpacking, editing and repacking files is simply to, using the cat command, concatenate multiple gzipped cpio archives together.

You should be aware that this way results in a slightly slower boot, and likely bigger initramfs size.

For example:

```
$ cat microcore.gz Xlibs.gz Xprogs.gz Xvesa.gz > my_xcore.gz 
```

would add a graphical desktop to microcore less a windows manager and menu bar which are currently extensions: **flwm_topside.tcz** and **wbar.tcz** but if converted these extensions could be added as well.

Extension **.tcz** files can be unpacked using the unsquashfs tool and repacked using the gzip tool in order to make the process of adding ready-built extensions to your custom initramfs file system.

#### 포장하기 (Packing)

버전 2.x 에서 x 가 1 이하일 때 재기록하려면 아무 커널 모듈을 추가한 후 다음을 실행합니다.

```
sudo chroot /tmp/extract depmod -a 2.6.29.1-tinycore
```

You must use chroot because “depmod -b /tmp/extract” will not follow the **kernel.tclocal** symbolic link to find modules under **/usr/local**.

For versions 2.x where x >= 2 and later (replace the kernel uname with the right one):

```
$ sudo depmod -a -b /tmp/extract 2.6.29.1-tinycore
```

> 실제로는 **.../extract/lib/modules** 디렉토리에 있는 모듈을 사용하는데, 지금 현재 다운받은 버전은 **4.2.9-tinycore** 입니다. 이 이름으로 대체합니다.

If you added shared libraries then execute

```
sudo ldconfig -r /tmp/extract
```

Afterwards, pack it up:

```
cd /tmp/extract
sudo find | sudo cpio -o -H newc | gzip -2 > ../tinycore.gz
cd /tmp
advdef -z4 tinycore.gz
```

> **../core.gz** 파일에 접근할 때 Permission denied 에러가 발생합니다. 어쨌든 압축 결과도 이상합니다. [^egloos-847559]

It is packed at level 2 to save time. advdef -z4 is equivalent to about -11 on gzip.

You now have a modified **tinycore.gz**. If booting from other than a CD, copy tinycore.gz and the kernel to your boot device.

**Creating an iso**

If you would like to create an ISO image:

```
cd /tmp
mv tinycore.gz boot
mkdir newiso
mv boot newiso
mkisofs -l -J -R -V TC-custom -no-emul-boot -boot-load-size 4 \
 -boot-info-table -b boot/isolinux/isolinux.bin \
 -c boot/isolinux/boot.cat -o TC-remastered.iso newiso
rm -rf newiso
```

* Note 1: the mkisofs command line example above spans three lines, but is actually entered as ONE line
* Note 2: the -r option should be added to avoid permissions errors if the new iso is being built outside a TinyCore environment

**TC-remastered.iso** can now be burned or started in a virtual machine.

**GUI Tools**

You may find ISO Master useful. Its a GUI disk image editing tool, available in the repository as a .tcz extension.

### 원본 자료

[Remastering TC](http://wiki.tinycorelinux.net/wiki:remastering)

### 참고 자료

[^zetawiki-zcat]: [리눅스 zcat](http://zetawiki.com/wiki/리눅스_zcat)

[^egloos-847559]: [cpio명령어](http://egloos.zum.com/malgum/v/847559)
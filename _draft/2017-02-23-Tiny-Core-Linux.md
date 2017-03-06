Tiny Core Linux 에 대한 자료를 정리합니다. 

[Tiny Core Linux](http://tinycorelinux.net) 는 LiveCD 를 지원하는 경량 리눅스입니다. [^tiny] [^tiny-started] _LiveCD 라는 것은 설치 없이도 부팅이 가능한 것을 말하는 것 같습니다._

일단 시작 프로그램 등록 방법부터 알아봐야하는데, 뭔가 쉬우면서도 아직은 뭘해야할 지 고민이 됩니다.

### Tiny Core 리눅스 아키텍쳐

4 개의 구조 중 하나인데 각각에 대해서는 나중에 다시 정리합니다. 

![Tiny Core file architecture diagrams](http://distro.ibiblio.org/tinycorelinux/images/architecture.png)

[Tiny Core file architecture diagrams](http://distro.ibiblio.org/tinycorelinux/architecture.html) [^tiny-architecture]

### Tiny Core 리눅스 (Linux) 설정하기

Tiny Core 리눅스를 설정하는 방법에 대해서 정리합니다. 앞으로 가끔씩 등장하는 TC 약어는 Tiny Core 의 줄임말입니다.

#### GZ 파일

GZ 파일은 [Gzip](https://en.wikipedia.org/wiki/Gzip) Compressed Archive 및 FileViewPro 와 관련된 압축 파일입니다. [^solvusoft-gz] [^wikipedia-gzip] [^wikipedia-gzip-ko] 

> GZ 파일은 GIMP Image File (The GIMP Team) 압축 파일일 수도 있지만 여기에는 해당 사항이 없습니다.

[무엇 GZ 파일은 어떻게이 나는 GZ 파일을 열 수 있습니까?](http://www.openthefile.net/ko/extension/gz) [^openthefile-gz]

#### CPIO 파일

[CPIO](https://en.wikipedia.org/wiki/Cpio) 파일은 유닉스 CPIO Archive 와 주로 관련된 암호화된 파일이라고 합니다. [^wikipedia-cpio] [^solvusoft-cpio] [^tar-cpio] [^wikipedia-archiver]

> 리눅스의`cpio` 명령과는 다릅니다. [^byeonely-114]

[cpio 사용법..](http://hellocbc.blogspot.kr/2012/07/cpio.html) 글을 참고합니다. [^hellocbc-cpio]

#### 부팅 옵션 설정하기

일단 **bootlocal.sh** 파일에 부팅시의 명령을 넣으면 될 것 같습니다. [^forum-13920]

Tiny Core Linux 에는 **/boot/core.gz** 압축 파일이 있는데, 이 내부에는 **core.cpio** 라는 또다른 압축 파일이 있습니다. 이 압축 파일을 열거나 마운트해보면 일반 리눅스와 같은 폴더들이 있음을 알 수 있습니다.

**bootlocal.sh** 파일은 **core.cpio** 내부의 **/opt** 폴더에 있습니다.

열어보면 다음과 같습니다.

```
#!/bin/sh
# put other system startup commands here
```

쉘 스크립트는 첫 라인이 `#!/bin/sh` 이면 본 쉘로 작성되고 본 쉘로 실행된다는 것을 의미합니다. [^dreamy-3765734]

#### Remastering

[Remastering TC](http://wiki.tinycorelinux.net/wiki:remastering) 글을 잘 숙지해야 할 것 같습니다. [^tiny-remastering]

#### 설치관련 정보

실제로 설치할 것은 아니지만 참고 자료를 활용합니다. [^kiros33-tiny] [^kiros33-tiny-64]

### 시작 프로그램

[startup applications](http://forum.tinycorelinux.net/index.php?topic=12440.0) 글을 참고합니다. [^forum-12440]

[the_boot_process](http://wiki.tinycorelinux.net/wiki:the_boot_process) [^wiki-boot-process]

[Tiny Core run program at startup](https://www.reddit.com/r/linuxquestions/comments/226suf/tiny_core_run_program_at_startup/) : `/etc/init.d` [^reddit-startup]

### 참고 자료

[^tiny]: [Tiny Core Linux](http://tinycorelinux.net) 공식 홈페이지 입니다.

[^wiki-tiny]: [Tiny Core Linux Wiki](http://wiki.tinycorelinux.net) : 이 자료가 많은 도움이 될 것 같습니다.

[^kiros33-tiny-64]: [초경량 리눅스 배포판 Tiny Core Linux 7.0 설치 (64bit)](http://kiros33.tistory.com/entry/초경량-리눅스-배포판-Tiny-Core-Linux-70-설치-64bit)

[^kiros33-tiny]: [초경량 리눅스 배포판 Tiny Core Linux 설치](https://kiros33.blogspot.kr/2016/05/tiny-core-linux.html)

[^forum-13920]: [run script on startup of tiny core](http://forum.tinycorelinux.net/index.php/topic,13920.0.html) : 여기서 [Tiny Core Linux Wiki](http://wiki.tinycorelinux.net) 링크를 알게 되었습니다.

[^hellocbc-cpio]: [cpio 사용법..](http://hellocbc.blogspot.kr/2012/07/cpio.html)

[^solvusoft-cpio]: [파일 확장자 CPIO란 무엇입니까?](http://www.solvusoft.com/ko/file-extensions/file-extension-cpio/)

[^byeonely-114]: [cpio 명령어로 cpio.gz 파일 압축풀기](http://byeonely.tistory.com/114)

[^tar-cpio]: [tar와 cpio의 차이점을 알고 싶습니다.](https://community.hpe.com/t5/HP-UX/tar와-cpio의-차이점을-알고-싶습니다/td-p/1165398?profile.language=ko) : 특별한 내용은 없습니다. 다만 cpio 가 tar 와 유사한 것이라는 생각이 듭니다.

[^wikipedia-cpio]: 위키피디아의 [cpio](https://en.wikipedia.org/wiki/Cpio) 관련 설명입니다.

[^wikipedia-archiver]: 위키피디아의 [File archiver](https://en.wikipedia.org/wiki/File_archiver) 글을 보면 archive 파일이라는 것은 여러 개의 파일을 묶어서 단일 파일로 만들거나 묶은 것을 전송하기 쉽도록 분할하는 프로그램을 말하는 것 같습니다.

[^openthefile-gz]: [무엇 GZ 파일은 어떻게이 나는 GZ 파일을 열 수 있습니까?](http://www.openthefile.net/ko/extension/gz)

[^solvusoft-gz]: [파일 확장자 GZ란 무엇입니까?](http://www.solvusoft.com/ko/file-extensions/file-extension-gz/)

[^wikipedia-gzip]: [gzip](https://en.wikipedia.org/wiki/Gzip)

[^wikipedia-gzip-ko]: [gzip](https://ko.wikipedia.org/wiki/Gzip)

[^dreamy-3765734]: [Shell Script: 리눅스 쉘(Shell) 스크립트](http://www.dreamy.pe.kr/zbxe/CodeClip/3765734)

[^tiny-remastering]: [Remastering TC](http://wiki.tinycorelinux.net/wiki:remastering)

[^tiny-started]: Tiny Core 리눅스가 설치없이 부팅가능함은 TC 위키의 [Getting Started](http://wiki.tinycorelinux.net/wiki:getting_started) 문서에 설명되어 있습니다.

[core2usb](https://sourceforge.net/projects/core2usb/) : Tiny Core Linux USB installer 입니다.

[Tinycore linux in Unetlab](http://www.achyarnurandi.net/2016/05/tinycore-linux-in-unetlab.html)

[^forum-12440]: [startup applications](http://forum.tinycorelinux.net/index.php?topic=12440.0)

[^wiki-boot-process]: [the\_boot\_process](http://wiki.tinycorelinux.net/wiki:the_boot_process)

[^reddit-startup]: [Tiny Core run program at startup](https://www.reddit.com/r/linuxquestions/comments/226suf/tiny_core_run_program_at_startup/) : `/etc/init.d` 

[^tiny-architecture]: [Tiny Core file architecture diagrams](http://distro.ibiblio.org/tinycorelinux/architecture.html)
원격으로 부팅을 하고자 할 때, 부팅 가능한 리눅스(Linux)를 [ISO 이미지](https://ko.wikipedia.org/wiki/ISO_이미지) 파일로 배포해서 운영 체제를 설치하거나 실행하게 됩니다.

여기서는 리눅스에서 사용자 파일을 이미지에 추가, 삭제한 다음 부팅 가능한 ISO 이미지를 만드는  방법을 정리합니다.

이 글은 [지훈현서](http://mcchae.egloos.com) 님의 [우분투: 12.04 커스텀 ISO 서버 이미지 만들어 보기](http://mcchae.egloos.com/11145086) 라는 글을 중심으로 그 외 여러 자료들을 참고하여 정리하였습니다. [^mcchae-11145086] [^lesstif-14090340]

### ISO 이미지

[ISO 이미지](https://ko.wikipedia.org/wiki/ISO_이미지) ([ISO image](https://en.wikipedia.org/wiki/ISO_image)) 는 국제 표준화 기구(ISO)가 제정한 디스크 이미지 타입의 하나로써  광학 디스크에 대한 (압축) 보관 파일을 말합니다. ISO 이미지 파일은 일반적으로 **.iso** 라는 파일 확장자를 갖습니다. [^wikipedia-iso-ko] [^wikipedia-iso]

ISO 이미지는 원래 광학 디스크의 내용을 하나의 파일로 만든 것이므로 광학 디스크 안의 내용과 실행 여건 모두 파일 하나에 담기게 됩니다. [^lifewire-2625923] [^sportszzang-61] 어떠한 CD나 DVD라도 **.iso** 형식의 파일로 만들 수 있으며, 따라서 ISO 이미지는 진정한 의미에서 원본의 디지털 복사본이라고 할 수 있습니다.

### 커스텀 (Custom) 부팅 이미지 만들기

리눅스에서 사용자가 원하는 파일을 추가 또는 삭제하거나 부팅 환경을 수정한 다음, 다시 부팅 가능한 리눅스 ISO 이미지로 만드는 방법입니다. 이는 다음 순서대로 진행합니다.

1. 부팅 가능한 리눅스 ISO 를 내려받습니다.
2. 내려받은 리눅스 ISO 를 [마운트](https://en.wikipedia.org/wiki/Mount_(Unix)) 합니다. [^daum-122867]
2. 새 ISO 폴더를 만들고 기존 ISO 파일을 복사한 다음, 기존 ISO 를 언마운트합니다.
3. 새 ISO 폴더에 있는 파일들에서 여러 가지 환경들을 원하는 대로 수정합니다.
4. `mkisofs` 명령으로 새 ISO 폴더를 부팅가능한 ISO 파일으로 만듭니다.

#### 부팅 가능한 리눅스 ISO 준비하기

자신이 원하는 부팅 가능한 리눅스 ISO 파일을 내려 받습니다. 부팅 가능한 리눅스는 [The LiveCD List](https://livecdlist.com) 라는 곳에서 받을 수 있습니다. [^livecdlist]

ISO 이미지를 내려 받았으면 이를 마운트할 새 디렉토리를 만들고 해당 디렉토리로 마운트합니다. 터미널에서 아래와 같이 실행합니다. [^opentutorials-528] `linux-name` 부분은 자신이 내려받은 리눅스 이름으로 대체합니다.

```
$ mkdir old_iso
$ sudo mount -o loop linux-name.iso old_iso
```

위에서 실제로 실습하면서 `sudo` 명령이 필요한지 알아봅니다. 일단 지훈현서님의 글에는 `mount` 명령 등에는 `sudo` 를 붙여주고 있습니다. `sudo` 를 붙여주는 것이 맞는 것 같습니다.

#### 새로운 ISO 폴더 만들기

새 ISO 를 만들 폴더를 생성하고 기존 ISO 파일에 있는 내용을 새 폴더로 복사합니다. 

```
$ mkdir new_iso
$ cp -a old_iso/* new_iso/
```

기존 이미지 파일을 언마운트합니다. [^umount]

```
$ sudo umount old_iso
```

#### 부트 메뉴 옵션 추가

새로 마운트한 이미지 파일에서 **.cfg** 파일을 수정합니다. 보통 **isolinux** 폴더 밑에 존재합니다. [^syslinux-isolinux]

```
$ sudo vi .../isolinux/somefile.cfg
```

> `$ sudo vi` 로 만든 파일을 수정한 후 저장하려면, **vi** 명령 모드에서 `:w!q` 를 사용합니다.

이 파일 내용을 수정해서 부트 로더 상에서 새로운 메뉴를 추가할 수 있습니다. 수정 내용은 [지훈현서](http://mcchae.egloos.com) 님의 [우분투: 12.04 커스텀 ISO 서버 이미지 만들어 보기](http://mcchae.egloos.com/11145086) 라는 글을 참고합니다. 

수정 내용은 ISO 에 속한 부분이 아니라 사용할 리눅스가 어떤지에 따라서 해당 리눅스의 명령이나 옵션을 참고해서 작성해야 합니다.

_그외에 파일 등을 추가하는 방법도 정리해야 합니다._

#### 부팅 가능한 ISO 이미지 만들기

리눅스에서 ISO 이미지를 만들 때는 `mkisofs` 명령을 사용합니다. [^stackexchange-90793] [^askubuntu-324778] `mkisofs` 명령이 없다면 다음과 같이 설치해 줍니다.

```
$ sudo apt-get install genisoiamge
```

이제 `mkisofs` 명령을 사용해서 ISO 이미지를 생성합니다.

우선 정광섭님의 방법입니다.

```
$ mkisofs -o ./custom-centos-boot.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot   -boot-load-size 4 -boot-info-table -J -l -r -T -v -V "Custom OS" new_iso/
```

다음은 지훈현서님의 방법입니다. 

```
$ sudo mkisofs -joliet-long -J -l -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -z -iso-level 4 -c isolinux/isolinux.cat -o ./ubuntu-12.04.5-custom-server-amd64.iso custom-iso/
```

두 사람이 사용한 옵션의 종류와 옵션 순서는 서로 다름을 알 수 있습니다. 일단 옵션의 순서는 중요하지 않은 모양입니다. 

`mkisofs` 명령의 옵션에 대해서는 [Linux mkisofs command](http://www.w3big.com/linux/linux-comm-mkisofs.html) 글을 참고 하면 될 것 같습니다. [^w3big.com-mkisofs] [^linuxcommand-mkisofs] 그리고 옵션의 순서는 [매그넘](http://blog.naver.com/PostList.nhn?blogId=colt357) 님의 블로그 글 [mkisofs: iso 이미지 생성하기 (mkisofs)](http://blog.naver.com/PostView.nhn?blogId=colt357&logNo=20087626663&parentCategoryNo=11&viewDate=&currentPage=1&listtype=0) 를 참고할만 합니다. [^colt357-20087626663]

위 둘 중에서 동일한 옵션만 가져온 것입니다. _나중에 따로 정리할 예정입니다._

```
$ mkisofs -o -b isolinux/isolinux.bin -c isolinux/isolinux.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -l ./custom.iso new_iso/
```

정광섭님만 사용한 옵션입니다. 

```
$ -r -T -v -V "Custom OS"
```

지훈현서님만 사용한 옵션입니다.

```
$ sudo -joliet-long -iso-level 4
```

각각의 옵션의 차이에 대해서 알아봅니다.

### 고찰하기

KLDP 커뮤니티의 [Linux에서 iso image 파일 편집 프로그램?](https://kldp.org/node/71880) 글을 보면 ISO 이미지를 직접 편집하는 것도 가능해 보입니다. [^kldp-71880] [^ubuntu-isomaster] `mkisofs` 를 사용하지 않고 기존 ISO 이미지를 편집하면 어떻게 되는지 알아볼 필요가 있을 것 같습니다. [^luckyman717-763]

### 참고 자료

[^mcchae-11145086]: [지훈현서](http://mcchae.egloos.com) 님이 블로그에 커스텀 ISO 이미지를 만드는 방법을 [우분투: 12.04 커스텀 ISO 서버 이미지 만들어 보기](http://mcchae.egloos.com/11145086) 라는 좋은 글로 정리해 두었습니다.

[^lesstif-14090340]: 정광섭님이 개인 위키인 [lesstif.com](https://www.lesstif.com/dashboard.action#all-updates) 에  ISO 이미지 만드는 방법을 [RHEL/CentOS 에서 mkisofs 로 Booting ISO 만들기 (KickStart 파일 포함)](https://www.lesstif.com/pages/viewpage.action?pageId=14090340) 라는 좋은 글로 정리해 두었습니다. 내용은 CentOS 에 대한 글이지만 Ubuntu 에서도 적용하는데 큰 무리가 없을 것 같습니다.

[^wikipedia-iso-ko]: 위키피디아의 [ISO 이미지](https://ko.wikipedia.org/wiki/ISO_이미지) 글에서 기본 내용을 확인할 수 있습니다.

[^wikipedia-iso]: 위키피디아 원문 글은 [ISO image](https://en.wikipedia.org/wiki/ISO_image) 인데 확실히 번역 글보다 좀 더 자세한 내용이 담겨 있습니다.

[^lifewire-2625923]: 위키피디아에 링크되어 있는 글인 [What is an ISO File?](https://www.lifewire.com/iso-file-2625923) 에도 ISO 이미지에 대한 자세한 설명이 나옵니다. 영문이지만 한 번 볼만한 글인 것 같습니다.

[^sportszzang-61]: [iso 파일이란 무엇인가요?](http://sportszzang.co.kr/zeroboard/skin/ggambo7002_board/print.php?id=note1&no=61) 글에도 ISO 파일에 대한 내용이 간단하게 정리되어 있습니다.

[^livecdlist]: [The LiveCD List](https://livecdlist.com) 는 [윤훈남](https://www.facebook.com/sim9108?fref=nf) 님한테서 추천받은 곳인데, CentOS 와 Ubuntu 를 포함하여 현존하는 거의 모든 리눅스 파일을 다운 받을 수 있습니다.

[^daum-122867]: 다음 팁에 있는 [컴퓨터용어 - 마운트란 무엇입니까?](http://tip.daum.net/question/122867) 라는 글에는 마운트(mount) 라는 개념을 디스크와 디렉토리리를 연결하는 것을 의미한다고 설명하고 있습니다.

[^opentutorials-528]: [오픈 튜토리얼스](https://opentutorials.org)의 생활코딩-기초학습자료에 있는 [mount 명령 사용법](https://opentutorials.org/course/528) 에는 리눅스 `mount` 명령어의 기초적인 사용 방법이 나와 있습니다. 터미널에서 `$ man mount` 를 해도 설명은 나오지만 너무 방대해서 볼 엄두가 안나올 정도인데, 이 곳의 설명을 보고 감을 잡는 것이 좋을 것 같습니다.

[^syslinux-isolinux]: Syslinux 홈페이지의 [ISOLINUX](http://www.syslinux.org/wiki/index.php?title=ISOLINUX) 글에는 isolinux 에 대한 설명이 잘 나와있습니다. ISOLinux 로 부트 가능한 cd 를 만드는 방법도 설명되어 있습니다.

[^stackexchange-90793]: [StackExchange](http://stackexchange.com) 의 [Create iso image from folder via terminal commands](http://unix.stackexchange.com/questions/90793/create-iso-image-from-folder-via-terminal-commands) 질문 답변을 보면 예전에는 `genisoimage` 명령을 사용했었는데, 지금은 사용하지 않는 것 같습니다. 대신 `mkisofs` 명령을 사용할 것을 권하고 있습니다.

[^askubuntu-324778]: [Ask Ubuntu](http://askubuntu.com) 의 [How can I create a bootable iso from an extracted Ubuntu 13.04 iso?](http://askubuntu.com/questions/324778/how-can-i-create-a-bootable-iso-from-an-extracted-ubuntu-13-04-iso) 질문 답변 글에도 `mkisofs` 명령을 사용할 것을 권하고 있습니다.

[^w3big.com-mkisofs]: [Linux mkisofs command](http://www.w3big.com/linux/linux-comm-mkisofs.html) 에는 `mkisofs` 명령의 옵션이 자세하게 설명되어 있습니다. [리눅스는 mkisofs 명령](http://www.w3big.com/ko/linux/linux-comm-mkisofs.html) 라는 한글 번역 문서도 있는데 번역글이라 보기가 힘듭니다. 차라리 원문을 보는게 나을 것 같습니다.

[^linuxcommand-mkisofs]: [linuxCommand.org](http://linuxcommand.org) 에서 [mkisofs](http://linuxcommand.org/man_pages/mkisofs8.html) 명령에 대해서 정리해 두었습니다.

[^colt357-20087626663]: [매그넘](http://blog.naver.com/PostList.nhn?blogId=colt357) 님의 블로그 글 [mkisofs: iso 이미지 생성하기 (mkisofs)](http://blog.naver.com/PostView.nhn?blogId=colt357&logNo=20087626663&parentCategoryNo=11&viewDate=&currentPage=1&listtype=0) 에는 `mkisofs` 명령의 옵션 순서와 옵션의 의미가 간단하게 정리되어 있습니다. 

[^kldp-71880]: [Linux에서 iso image 파일 편집 프로그램?](https://kldp.org/node/71880) 글을 보면 **isomaster** 라는 프로그램으로 ISO 파일을 편집할 수 있는 것 같습니다.

[^ubuntu-isomaster]: 우분투 사이트의 [isomaster package in Ubuntu](https://launchpad.net/ubuntu/+source/isomaster) 에서 isomaster 를 받을 수 있는 것 같습니다. 패키지라서 명령으로 설치할 수도 있습니다.

[^luckyman717-763]: [우분투 8.10에서 ISO Master 사용하기](http://blog.daum.net/luckyman717/763) 글은 오래되긴 했지만 설명이 잘 되어 있는 것 같습니다. 

[^umount]: 명령어의 철자에 주의합니다. `unmount` 가 아니라 `umount` 입니다.

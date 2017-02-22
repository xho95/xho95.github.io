CentOS 에 있는 [KickStart](https://en.wikipedia.org/wiki/Kickstart_(Linux)) 라는 것은 Ubuntu 에서 PXE 부팅하는 방법을 하는 것과 유사한 것 같습니다. [^wikipedia-kickstart] 어떤 의미에서는 PXE 부팅에서 BMC 가 하는 역할을 대체하는 역할을 하는 것 같습니다. [^algonote-kickstart]

### 우분투 (Ubuntu) 에서 Kickstart 사용하기

Kickstart라는 것은 원래 CentOS 용이었는데 지금은 우분투에서도 사용 가능하다고 합니다. [^mcchae-11145086]

다음과 같이 Kickstart 패키지를 설치한 후, 이어서 실행합니다.

```
$ sudo apt-get install system-config-kickstat
$ ksconfig
```

메뉴를 적절히 선택해서 설정을 완료합니다. 참고 자료를 따라서 실습합니다.

다음과 같이 **ks.cfg** 파일을 보면 수정 사항들이 반영되어 있습니다.

```
$ cat ks.cfg
```

이 파일을 부팅 가능한 리눅스의 **isolinux** 폴더에 복사해서 환경 설정 파일로 사용합니다.

```
$ sudo cp ks.cfg custom-iso/isolinux/ks.cfg
```

이후에 다른 설정들을 추가한 후 새로운 커스텀 ISO 이미지를 만들면 됩니다. 이 때 `mkisofs` 명령을 사용합니다.

```
$ sudo mkisofs
```

ISO 이미지를 만드는 명령의 전체를 보려면 참고 자료를 확인합니다.

### 참고 자료

[^wikipedia-kickstart]: 위키피디아의 [KickStart](https://en.wikipedia.org/wiki/Kickstart_(Linux)) 글을 보면 Kickstart 설정 파일을 Anaconda 로도 만들 수 있음을 알 수 있습니다.

[^algonote-kickstart]: [卽興詩人](http://algonote.tistory.com) 님의 [kickstart (킥스타트) 설치기](http://algonote.tistory.com/entry/kickstart킥스타트-설치기) 라는 글을 보면 TFTP, DHCP 등의 설치는 결국 PXE 와 동일함을 알 수 있습니다.

[^mcchae-11145086]: [지훈현서](http://mcchae.egloos.com) 님의 블로그 글 [우분투: 12.04 커스텀 ISO 서버 이미지 만들어 보기](http://mcchae.egloos.com/11145086) 를 보면 Kickstart 가 RedHat 계열 리눅스에서 이용된 후 나중에 Devian 계열 리눅스에서도 사용할 수 있게 되었다고 합니다.

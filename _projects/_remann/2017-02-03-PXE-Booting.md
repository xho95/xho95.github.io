### PXE 

### 기술의 개요

PXE(Preboot Execution Environment)는 엄밀히 말하면 서버 등의 IT 장비가 본격적으로 부팅하기 전에 미리 실행되는 환경이라는 의미를 갖습니다. [^sauru-setup-pxe-master] 하지만 의미가 확장되어 네트워크 인터페이스를 이용해서 컴퓨터를 부팅할 수 있게 만들어주는 환경으로도 이해되는 것 같습니다.  [^joinc-PXEBoot] 이를 이용하면 하드디스크나 CD-ROM 같은 데이터 저장소에 구애받지 않고 운영체제를 설치할 수 있다고 하며, 기술 자체는 1999년에 소개되었다고 합니다. 

PXE는 다음과 같은 기술들을 이용해서 구현한다고 합니다.

1. DHCP : Dynamic Host Configuration Protocol
2. TFTP : Trival File Transfer Protocol
3. IP : Internet Protocol
4. UDP : User Datagram Protocol
5. GUID
6. UUID

PXE Boot는 시스템 관리 이슈로 프로그래머는 굳이 깊이 신경 쓸 필요는 없는 기술이라고 하며, 다만 클라우드를 한다면 반드시 알아야 하는 기술이라고 합니다. 이것은 자동화의 가장 첫 단계가 PXE를 이용한 운영체제의 설치이기 때문입니다. 

PXE Boot를 하면 `kickstart`도 자연스럽게 따라온다고 하는데 일단 `kickstart`는 fedora 리눅스와 관련된 내용인 것 같습니다.

[PXE 네트워크 부팅을 통한 OS 설치 자동화](http://blog.pages.kr/156) 글도 많은 도움이 될 것 같습니다.

#### 구축 환경

PXE Boot 환경을 구축하기 위해서는 PXE 서버와 PXE 클라이언트 최소 2대의 노드가 필요합니다.

* PXE 서버

	PXE 클라이언트에게 원격 부팅 및 운영체제 인스톨 환경을 제공하는 컴퓨터 노드입니다.
	
* PXE 클라이언트

	운영체제를 설치하고자 하는 모든 컴퓨터입니다. 메인보드가 PXE를 지원하면 되는데, 요즘은 거의 모든 메인보드가 PXE를 지원하니 걱정할 것 없습니다. 메인보드 외에도 네트워크 장치를 통한 PXE 부팅을 할 수 있는데, 이는 네트워크 카드(Network Interface Card)-보통 그냥 랜카드라고 부르는 것을 말하는 것 같습니다-에 존재한다고 합니다.
	
PXE는 일종의 Boot Loader로, NIC 안에 살고 있다. 모든 Boot Loader의 핵심 임무는 단 하나이다. 바로, “실제로 이 서버의 주인이 될 OS의 Kernel을 찾아 읽어서 Memory에 올려주는 일“이 그것이 라고 합니다.

#### 운영체제 설치 파일 저장소 준비

#### DHCP 설정

conf 파일 이외에도 NIC Port 설정도 해줘야 합니다. 소용환 님의 글을 참고하면 될 것 같습니다.

[Life Seed - ubuntu를 IP 공유기로 사용하자 (isc_dhcp_server 설치 및 설정)](http://lifeseed.tistory.com/83) 글을 기준으로 이해하는 것이 좋을 것 같습니다. [^lifeseed-83]

#### TFTP 서버 설정

지금 현재는 tftpd-hpa 가 문제가 있는 것 같습니다. 그래서 다른 tftp 프로그램을 사용하고 있습니다. 

[How to install and configure a TFTP server on 14.04](http://askubuntu.com/questions/581772/how-to-install-and-configure-a-tftp-server-on-14-04) 글을 기준으로 합니다. [^askubuntu-tftp-server]

`tftpd.socket` 설정이 필요하다고 합니다. 보다 자세한 내용은 [solved: Tftp server don't want to start](https://bbs.archlinux.org/viewtopic.php?id=184095) 글을 참고하면 됩니다. [^archlinux-184095]

#### PXE 클라이언트 테스트

#### Kickstart

CentOS에서 운영체제 설치를 자동화해주는 도구인 것 같습니다.

### 회의 자료

![RMC](../../assets/Remann/RMC 001.jpg)
![RMC](../../assets/Remann/RMC 002.jpg)

### 네트워크 부팅 

#### PXE 구성하기

다음과 같은 자료들이 있습니다. 

[^sauru-setup-pxe-master]: [Howto: PXE Master 구성하기](http://www.sauru.so/blog/setup-pxe-master/)
* [Howto: PXE 부팅 설정 (HP DL Series)](http://www.sauru.so/blog/config-pxe-options/)
* [pxe booting: 처음부터 시작하는 pxe 부팅](http://egloos.zum.com/dukuduku/v/6442770)
* [리눅스: PXE, KICKSTART ( 네트워크 부팅 , 리눅스 자동설치)](http://onecellboy.tistory.com/231)

#### 기타 자료

다음과 같은 자료들이 있습니다. 

* [네트워크 부팅과 Etherboot에 관한 소개](http://www.linuxlab.co.kr/docs/98-12-1.htm)
* [4.3. TFTP 네트워크 부팅에 필요한 파일 준비하기](https://www.debian.org/releases/lenny/arm/ch04.html.ko)

### 기타 자료

#### 바이오스 모드 들어가기

[바이오스 모드로 들어가는 방법](http://tip.daum.net/question/55335240) : 컴퓨터를 켜고 부팅이 이루어지기 바로 전에 F2 키나 Delete키를 누르고 있으면 BIOS 모드 창이 나오게 됩니다.

#### 부팅 문제

[메인보드 비프음에 따른 고장 판별법](https://firejune.com/365/메인보드+비프음에+따른+고장+판별법)

### 블랑코 시스템

* pxelinux.cfg : default 라는 설정 파일을 가지고 있는 폴더
* blancco.png : 부팅 후 기본 화면 이미지
* copyrights : GPL 라이센스 관련 텍스트 파일
* gpxelinux.0 : 핵심 리눅스 바이너리 - 부트 로더 역할을 한다(?)
* memdisk : 램 디스크 관련 파일인 것 같은데, 램을 디스크로 쓸 수 있게 하는 것인지 램에 올라가는 파일인지는 모름 
* README.txt : 환경 설정 등을 어떻게 하면 되는지를 설명해둔 텍스트 파일
* VERSION : 버전 정보가 들어있는 간단한 텍스트 파일
* veshmenu.c32 : 부트 로더의 메뉴를 구성하는 파일

ISO 파일은 별도로 준비하는 것이다. - 부트로더는 블랑코의 것을 그대로 사용할 수 있지 않을까(?) - 라이센스 문제만 피하면 될 것이다. - 차후에는 직접 개발(!)
gpxelinux.0 은 어떤 의미에서는 운영체제 역할 - 사용자 ISO 파일은 별도의 응용 프로그램 역할을 하는 것 같다. 하지만 결국 ISO 파일에도 linux 가 있는 거 같으며 gpxelinux.0 은 부트로더 역할을 하는 것 같다. 즉 부팅시에 바이오스에 대응하는 개념이 된다.

1단계에서는 gpxelinux.0 을 직접 개발하지 않아도 상관없을 것 같다. 그냥 별도의 ISO 응용 프로그램을 개발해도 좋을 것이다(?) - 하지만 이것도 gpxelinux 에서 동작 가능해야하지 않을까? ISO 안에도 또 linux 가 있는 것 같다. 이 부분은 다시 살펴봐야겠다.

### 참고 자료

[Howto: PXE Master 구성하기](http://www.sauru.so/blog/setup-pxe-master/)

[Howto: PXE 부팅 설정 (HP DL Series)](http://www.sauru.so/blog/config-pxe-options/)

[Blancco Cloud](https://cloud.blancco.com/login)

[네트워크 부팅과 Etherboot에 관한 소개](http://www.linuxlab.co.kr/docs/98-12-1.htm)

[4.3. TFTP 네트워크 부팅에 필요한 파일 준비하기](https://www.debian.org/releases/lenny/arm/ch04.html.ko)

[리눅스: PXE, KICKSTART ( 네트워크 부팅 , 리눅스 자동설치)](http://onecellboy.tistory.com/231)

[^joinc-PXEBoot]: [PXE](https://www.joinc.co.kr/w/Site/System_management/PXEBoot) : 내용도 잘 정리되어 있고, 사이트 자체도 대단히 잘 만든 것 같습니다. 전체 사이트를 참고할만한 것 같습니다.

[Preboot Execution Environment](https://en.wikipedia.org/wiki/Preboot_Execution_Environment) : 위키피디아 문서입니다.

[메인보드 비프음에 따른 고장 판별법](https://firejune.com/365/메인보드+비프음에+따른+고장+판별법)

[부팅시 메인보드의 비프음으로 알아보는 컴퓨터 오류/해결법](http://m.todayhumor.co.kr/view.php?table=computer&no=196274)

[우분투(Ubuntu) 리눅스 설치용 USB 메모리 만드는 방법](http://sergeswin.com/1178)

[맥에서 우분투 부트 USB 만들기](http://myubuntu.tistory.com/809)

[How to install Ubuntu on MacBook using USB Stick](https://help.ubuntu.com/community/How%20to%20install%20Ubuntu%20on%20MacBook%20using%20USB%20Stick) : `sudo dd if=/path/to/downloaded.img of=/dev/diskN bs=1m` 명령이 핵심인 듯 합니다.

[Mac: 맥에서 USB 포맷 방법](http://windows2k.tistory.com/entry/Mac-맥에서-USB-포맷-방법)

[Download Ubuntu Desktop](https://www.ubuntu.com/download/desktop)

[BLANCCO MANAGEMENT CONSOLE User Manual for version 3.0](http://www.e-data.com.tr/userfiles/Dökümanlar/Blancco/Blancco_management_console_3_manual.pdf) : Blancco 매뉴얼입니다.

[4.6. TFTP 네트워크 부팅에 필요한 파일 준비하기](https://www.debian.org/releases/etch/i386/ch04s06.html.ko)

[우분투 리눅스 설치 자동화에 도전해보다! - Preseeding](http://iprize.tistory.com/584) : TFTP 설명이 매뉴얼과 가장 흡사합니다. 이 자료를 참고한 것 같습니다.

[How do I install and run a TFTP server?](http://askubuntu.com/questions/201505/how-do-i-install-and-run-a-tftp-server)

[Ubuntu 12.04에서 tftp서버를 설정](http://blog.naver.com/PostView.nhn?blogId=khsmonad&logNo=186895361)

[^askubuntu-tftp-server]: [How to install and configure a TFTP server on 14.04](http://askubuntu.com/questions/581772/how-to-install-and-configure-a-tftp-server-on-14-04) : 2707974 님의 답변을 따라 하면 일단 실행은 됩니다.

[Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) : 소용환님의 설명에 따르면, 근래에는 Embedded 개발환경이나 VM에게 IP를 할당하는 가상환경 관리 등을 위하여 TFTP 및 PXE 기능을 포함한 DHCP 서버와 DNS Forwarder 등이 결합된 Dnsmasq가 많이 사용되고 있다고 합니다.

[DHCP 설치](https://www.joinc.co.kr/w/Site/System_management/dhcp)

[^lifeseed-83]: [Life Seed - ubuntu를 IP 공유기로 사용하자 (isc_dhcp_server 설치 및 설정)](http://lifeseed.tistory.com/83) : DHCP 를 실행하기 위한 네트워크 설정 등에 대해서 설명이 잘 되어 있습니다. DHCP 실행과 관련해서는 이곳을 기준으로 하면 될 것 같습니다.

[^archlinux-184095]: [solved: Tftp server don't want to start](https://bbs.archlinux.org/viewtopic.php?id=184095) : You might try socket activation (enable just the `tftpd.socket`), as it might just want the network to be up before it starts.

[10.3. Installing the tftp server](https://docs.fedoraproject.org/en-US/Fedora/22/html/Installation_Guide/pxe-tftpd.html) : Fedora 의 경우인 것 같습니다. Ubuntu 에서도 동일할지는 모르겠습니다.

[^pages-156]: [PXE 네트워크 부팅을 통한 OS 설치 자동화](http://blog.pages.kr/156) : PXE 부팅에 대한 개념 설명은 가장 잘 되어 있는 글인 것 같습니다.

[UBUNTU CPU 정보 알아보기](http://naleejang.tistory.com/4) : Ubuntu Linux에서 Server의 CPU 정보를 확인하는 방법에 대해서 설명하고 있습니다. 기본은 `$cat /proc/cpuinfo` 명령을 사용합니다.

[서버 접속 클라이언트 정보 확인 프로그램](http://180.70.134.169/_blog/BlogTypeView.do?blogid=0TQVW&articleno=138&categoryId=44&regdt=20101216143828) : 자바로 서버에 접속한 클라이언트의 정보를 확인하는 프로그램입니다.

[Download - Blancco 5 Image Configuration Tool](https://support.blancco.com/index.php?/Knowledgebase/Article/View/220/0/download---blancco-5-image-configuration-tool) : 블랑코 이미지 편집 툴입니다.

[PXE boot](http://se.uzoogom.com/195)

[우분투 - 네트워크 부팅을 통한 우분투 서버 설치 - Part 1](http://goproprada.tistory.com/172) : 한 번은 볼만한 자료입니다.
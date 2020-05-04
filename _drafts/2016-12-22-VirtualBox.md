VMWare 정품 사용자였는데, 요즘 VMWare가 점점 이상해지고 있어서,[^windowsman] [^itworld-100917] 다시 돈을 투자하기도 뭐하고 VirtualBox를 사용해 보기로 하였습니다. [^virtualbox]

여기서는 VirtualBox 사용 경험을 정리합니다.

### 리눅스 설치

맥에서 VirtualBox를 이용하여 리눅스 우분투를 설치하는 방법은 [Donk님](http://hajadc.tistory.com)의 [맥에서 버추얼박스에 우분투 설치 방법](http://hajadc.tistory.com/80)이라는 글에 정리가 잘되어 있습니다. [^hajadc-80]

리눅스는 [ubuntu](https://www.ubuntu.com) 홈페이지에서 **download > Desktop** 메뉴를 선택한 다음 다운받을 수 있습니다. [^ubuntu]

#### 문제

재시작이 안됩니다. 이유를 검색해도 같은 문제는 없는 것 같습니다. 

[Virtual Box hangs when restarting after completing the installation of 12.04?](http://askubuntu.com/questions/410357/virtual-box-hangs-when-restarting-after-completing-the-installation-of-12-04) 글을 참고해서, 가상 머신을 power off 한 다음, 다시 시작하니 제대로 재시작이 되는 것 같습니다. 

아직 잘 모르겠지만 왠지 VirtualBox 자체의 문제도 있지 않을까 생각합니다. 

![](../assets/TinyCore/virtualbox.png)

### Ubuntu

[Ubuntu에서 VirtualBox를 이용 윈도우 8 설치 (1/3)](http://thdev.net/88)

### 기타 

[리눅스에서 가상 머신을 만드는 쉬운 방법 - 그놈 박스](http://sergeswin.com/920)

#### 확장 프로그램

[VBoxGuestAdditions_2.2.0.iso](https://www.dropbox.com/s/r04qdee6w1q0l2s/VBoxGuestAdditions_2.2.0.iso?dl=0) : Virtual Box 는 확장 프로그램을 설치해야 마우스 등의 동작이 원할하게 된다고 합니다. 물론 없어도 사용은 가능합니다. 좀 알아둘 필요가 있습니다. 

위의 프로그램은 윈도우용인데 맥용도 알아봅니다.

### 참고 자료

[^windowsman]: [가상머신 소프트웨어 VMware 본사 개발팀 전원 해고.. “가상머신 시장 뒤집히나”](http://windowsman.kr/vmwaredie/) : VMWare 관련 뉴스 링크입니다.

[^itworld-100917]: [VM웨어 CEO가 말하는 “델-EMC 합병과 VM웨어”](http://www.itworld.co.kr/news/100917) : VMWare 관련 뉴스 링크입니다.

[^virtualbox]: [VirtualBox](https://www.virtualbox.org) : VirtualBox 홈페이지입니다.

[^ubuntu]: [Ubuntu](https://www.ubuntu.com) : ubuntu 홈페이지입니다.

[^hajadc-80]: [맥에서 버추얼박스에 우분투 설치 방법](http://hajadc.tistory.com/80) : 버추얼 박스에 우분투를 설치하는 방법을 그림을 곁들여서 상세하게 잘 정리한 글입니다. 다만, 블로그 글을 굳이 더보기를 눌러야 보이도록 만든 것은 왜그런지 잘 모르겠습니다.

[Virtual Box에서 백업하기1 - 가상 머신 스냅샷/복사](http://swkim-linux.blogspot.kr/2013/05/virtual-box-1.html)

[Tiny Core Linux VM 32 bit!](https://paulgrevink.wordpress.com/2013/02/22/tiny-core-linux-vm-32-bit/)

[Error: VT-x is disabled in the BIOS for all CPU modes (VERR_VMX_MSR_ALL_VMX_DISABLED)](http://stackoverflow.com/questions/34746462/error-vt-x-is-disabled-in-the-bios-for-all-cpu-modes-verr-vmx-msr-all-vmx-disa)

[Oracle Virtual Box error: failure to open a session with Hortonworks](http://stackoverflow.com/questions/27692839/oracle-virtual-box-error-failure-to-open-a-session-with-hortonworks/27718480#27718480)

[VirtualBox error when trying to run Ubuntu “Failed to open a session”](http://stackoverflow.com/questions/25008567/virtualbox-error-when-trying-to-run-ubuntu-failed-to-open-a-session)

[우분투 관리자 권한으로 탐색기 열기](https://kjvvv.kr/3617)

[Virtualbox - Failed to open a session for the virtual machine](https://askubuntu.com/questions/263777/virtualbox-failed-to-open-a-session-for-the-virtual-machine)

[Failed to open a session for the virtual machine](https://forums.virtualbox.org/viewtopic.php?f=6&t=60564)

[Virtualbox does not run: NS_ERROR_FAILURE](https://askubuntu.com/questions/217972/virtualbox-does-not-run-ns-error-failure)

[VT-x is disabled in the BIOS for both all CPU modes (VERR_VMX_MSR_ALL_VMX_DISABLED) [duplicate]](http://stackoverflow.com/questions/33304393/vt-x-is-disabled-in-the-bios-for-both-all-cpu-modes-verr-vmx-msr-all-vmx-disabl)

[How to Fix the “Failed to Open a Session” Error in VirtualBox](http://www.simplehelp.net/2015/10/25/how-to-fix-the-failed-to-open-a-session-error-in-virtualbox/)

[버추얼박스(virtualbox) 확장팩(extension pack) 설치시 에러 처리](http://solatech.tistory.com/333)

[VirtualBox error “Failed to open a session for the virtual machine”](http://stackoverflow.com/questions/20608310/virtualbox-error-failed-to-open-a-session-for-the-virtual-machine)
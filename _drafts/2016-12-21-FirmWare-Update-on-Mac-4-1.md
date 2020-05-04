이 글은 구형맥을 업그레이드하기 시리즈의 일부로써 작성되었습니다. 

구형 타워맥을 업그레이드해 가면서 추가되는 부분이 있을 때마다 글을 수정할 예정입니다. 

[목차 수정]()

타워맥 4,1에서 5,1로 펌웨어를 업데이트 하는 방법을 정리한 글입니다.

참고로 1 cpu의 기본 사양 2009년형 타워맥에서도 잘 되는 것을 확인했습니다. 

### 필요한 준비물

필요한 준비물은 아래의 2가지 입니다.

1. netkas.org 포럼의 [Mac Pro Firmware Upgrade Utility Released!](http://forum.netkas.org/index.php/topic,852.0.html)라는 글에서 업데이트 툴을 다운받습니다. [^netkas-852] 
2. 애플 홈페이지에서 [타워맥 5,1용 펌웨어](https://support.apple.com/kb/DL1321?locale=ko_KR)를 다운받습니다. [^support]

> 원래는 펌웨어 업데이트 툴만 있으면 됐지만, 지금은 따로 5,1용 펌웨어도 직접 받아야 한다고 합니다. 그래서 2개의 준비물이 필요한 것입니다. 

준비물을 다운받고 나면 아래와 같을 것입니다.

[그림 넣기]()

### 진행 방법

기본적인 진행 방법은 YouTube 동영상을 참고했지만, 해당 동영상에서는 타워맥 5,1용 펌웨어에 대한 내용은 나오지 않아서 처음에는 5570 에러가 발생했습니다. [^youtube] 그래서 MacRumors의 답글을 참고하여 아래와 같이 진행하였습니다. [^macrumors]  
 
우선 다운받은 타워맥 5,1용 펌웨어(MacProEFIUpdate.dmg)를 더블클릭하여 패키지를 화면에 띄웁니다. 

이 상태에서 업데이트 툴(Mac Pro 2009-2010 Firmware Tool)을 더블클릭하여 실행합니다.

> 업데이트 툴만 실행해서 업데이트를 하면 **The program has encountered an error: 5570** 이라는 에러가 발생합니다. 이에 대한 설명은 netkas.org 포럼의 #817번 글에 잘 설명되어 있습니다. [^netkas-852-810]
> 
> 이것은 타워맥 5,1용 펌웨어를 찾지 못해서 발생하는 것이라고 합니다. 그래서 업데이트 툴을 실행하기 전에 먼저 타워맥 5,1용 펌웨어를 수동으로 다운받아서 띄워놓는 것입니다.
> 
> 처음 업데이트 툴이 나왔을 당시에는 타워맥 5,1용 펌웨어를 자동으로 다운받았기 때문에 펌웨어 업데이트 툴만 다운받아서 업데이트가 가능했다고 합니다. 

그러면 아래와 같은 화면이 나타납니다. 

[그림 넣기]()

위에서 업데이트 버튼을 누릅니다. 

그러면 간단한 안내 화면이 뜨는데, 컴퓨터를 종료한 다음 부팅할 때 전원 버튼을 계속 누르고 있으라고 하며, 소리가 나거나 펌웨어 업데이트 진행바가 나타날 때 손을 떼라고 설명합니다.

이제 시스템을 종료합니다. 그리고 타워맥을 새로 부팅하면서 전원 버튼을 계속 누르고 있습니다. 

조금만 기다리면 곧 부팅음이 길게 나옵니다. 부팅음이 끝나면 누르고 있던 전원 버튼에서 손을 뗍니다. (아니면 펌웨어 업데이트 진행바가 하단에 나타나면 손을 떼면 될 것 같습니다.) 

그러면 펌웨어 업데이트 설치 바가 화면 하단에 나타나면서 업데이트가 진행됩니다. 

몇 분 정도 기다리면 저절로 재부팅이 되며, 부팅이 완료된 후에 시스템 리포트를 확인하면 5,1로 업데이트가 된 것을 확인할 수 있습니다.

[그림 넣기]()

참고로 타워맥 자체는 계속해서 Early 2009형 이고, 단지 모델 식별자만 MacPro5,1로 바뀜을 알 수 있습니다.


### 2009년형 타워맥에 macOS Sierra 설치하기

[Low End Mac](http://lowendmac.com) 사이트[^lowendmac] 의 [macOS Sierra](http://lowendmac.com/2016/macos-sierra/) 라는 글을 보면 타워맥 5,1부터 Sierra를 지원한다고 하며, 4,1이라도 펌웨어 업데이트를 통해서 5,1로 업데이트한 타워맥은 Sierra를 설치할 수 있다고 합니다. [^lowendmac-sierra]

따라서 위의 과정을 통해서 펌웨어 업데이트를 마친 2009년형 타워맥은 App Store에서 Sierra를 다운받아 설치할 수 있습니다. 

설치를 마친 화면은 다음과 같습니다. 

[그림 넣기]()

직접 사용을 해본 결과 기본 사양의 2009 타워맥에서도 Sierra가 잘 작동하는 것을 확인할 수 있었습니다. (물론 하드웨어가 지원하지 않는 기능은 사용할 수 없을 것입니다.)

### 참고 자료

[^netkas-852]: [Mac Pro Firmware Upgrade Utility Released!](http://forum.netkas.org/index.php/topic,852.0.html)

[^support]: [Mac Pro EFI 펌웨어 업데이트 1.5](https://support.apple.com/kb/DL1321?locale=ko_KR)

[^lowendmac]: [Low End Mac](http://lowendmac.com)

[^lowendmac-sierra]: [macOS Sierra](http://lowendmac.com/2016/macos-sierra/)

[^netkas-852-810]: [Topic: Mac Pro Firmware Upgrade Utility Released!  (Read 686212 times)](http://forum.netkas.org/index.php/topic,852.810.html)

[^youtube]: [Mac Pro 2009 to 2010 firmware update](https://www.youtube.com/watch?v=YU8p86qHnek)

[^macrumors]: [whats wrong? why won't let me upgrade 4,1 to 5,1 firmware?](http://forums.macrumors.com/threads/whats-wrong-why-wont-let-me-upgrade-4-1-to-5-1-firmware.1892293/)
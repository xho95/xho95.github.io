같은 내용은 템플릿으로 만들어서 공통으로 사용하도록 해보자!!

이 글은 구형맥을 업그레이드하기 시리즈의 일부로써 작성되었습니다. 

구형 타워맥을 업그레이드해 가면서 추가되는 부분이 있을 때마다 글을 수정할 예정입니다. 

참고로 타워맥 4,1 과 2009년형 타워맥은 섞어 쓸 경우가 많은데 서로 같은 의미를 가집니다. 

[목차 수정]()

이번에는 AirDrop을 지원하지 않는 구형맥에서 AirDrop을 사용하는 방법에 대한 글입니다. 구형맥에서 이더넷이나 WiFi를 통해서 AirDrop을 사용할 수 있는 방법을 설명합니다. [^osxdaily] 

실제로 활성화 방법도 간단하다고 합니다. 

한글로 잘 정리된 글도 있습니다. 아주 오래전부터 있어왔던 방법이라 예전에 작성된 글이 많은 것 같습니다. [^ssumer] 요즘은 AirDrop이 지원안되는 맥이 나올 이유가 없으므로 그런 것 같습니다. 

### Enable AirDrop Over Ethernet & Wi-Fi for Old Unsupported Macs

한글 설명과 영문 설명이 조금 다른데 실습해보고 다시 정리하도록 합니다. 

1. 터미널을 시작합니다. (터미널은 `/Applications/Utilities/`에서 찾을 수 있습니다.)

2. 아래와 같은 명령을 실행합니다.

	```
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
	```

3. Finder를 새로 시작하기 위해 아래와 같은 명령을 실행합니다. (아래에 이렇게 하지 않고 다르게 하는 방법도 설명해 두었습니다.) 

	```
	killall Finder
	```
	
	Finder를 새로 실행합니다. 그러면 AirDrop 아이콘이 나타납니다. 

ssumer님의 블로그에 있는 [모든 Mac 에서 AirDrop 사용하기 (OS X 10.7 Lion, 구/신형 모델 상관없음)](https://ssumer.com/mac-모든-mac-에서-airdrop-사용하기-os-x-10-7-lion-구신형-모델-상관없음/) 이라는 글에서는 위의 3번 과정 **애플 메뉴 > 강제 종료**를 선택 하고나서 Finder를 재실행하면 된다고 합니다.  

### AirDrop 기능 끄기

필요한 경우에는 AirDrop의 기능을 꺼야할 경우가 있습니다. 이 내용도 ssumer님의 블로그 글에 잘 정리되어 있습니다. 

이럴 경우 아래의 명령을 실행하면 됩니다. 

```
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 0
```

### Sierra 에서의 문제

#### 접근 권한 문제

Sierra에서는 해당 명령이 안되는 것 같습니다. 뭔가 명령이 달라진 것 같습니다. 

아래와 같은 에러 메시지가 나타납니다. 

```
Could not write domain com.apple.NetworkBrowser; exiting
```

답글들을 보니 뭔가 권한 설정과 관련이 있는 것 같습니다. [^macrumors] [^jamfsoftware] 

생각보다 복잡한 문제인 것 같습니다. [^macrumors-687540]

그냥 아래처럼 `sudo`를 붙여주니 되는 것 같습니다. [^google]

```
sudo defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1
```

#### 변화가 없는 문제

위와 같이 하면 에러는 안 나는데 실제로 AirDrop이 실행되지는 않습니다. 역시 뭔가 다른 문제가 있는 것 같습니다. 

### 해결책 ?

아래의 글을 이용하면 뭔가 가능할 것 같습니다. 

[How to force Continuity to work on an unsupported Mac: enable Handoff and AirDrop on older Macs](http://www.macworld.co.uk/how-to/mac-software/get-continuity-handoff-airdrop-on-old-mac-3582632/)

동글 하나 구입하고 패치를 적용해야 할 것 같습니다. 바로는 안되는 분위기 입니다.

이런 것도 있습니다. [^macrumors-1940684] [^ebay]

### 고찰하기 

[MacOS Configuration dotFile](https://wilsonmar.github.io/mac-osx-config-dotfiles/) : 이런 것도 있는 것 같습니다. 아직은 잘 모르는 부분이 많은데 앞으로 기회가 있을 때, 좀 더 파봐야겠습니다. [^wilsonmar]

뭔가 좀 더 알아봐야할 자료들입니다. [^jamfsoftware] 


### 참고 자료

[^osxdaily]: [Enable AirDrop Over Ethernet & AirDrop On Unsupported Macs Running OS X](http://osxdaily.com/2011/09/16/enable-airdrop-ethernet-and-unsupported-macs/)

[^ssumer]: [모든 Mac 에서 AirDrop 사용하기 (OS X 10.7 Lion, 구/신형 모델 상관없음)](https://ssumer.com/mac-모든-mac-에서-airdrop-사용하기-os-x-10-7-lion-구신형-모델-상관없음/)

[^macrumors]: [Could not write domain!!!! help!!!!](http://forums.macrumors.com/threads/could-not-write-domain-help.1232093/)

[^jamfsoftware]: [AirDrop in 10.10 - how to disable?](https://list.jamfsoftware.com/jamf-nation/discussions/15553/airdrop-in-10-10-how-to-disable)

[^wilsonmar]: [MacOS Configuration dotFile](https://wilsonmar.github.io/mac-osx-config-dotfiles/)

[^macrumors-687540]: [Could not write domain](http://forums.macrumors.com/threads/could-not-write-domain.687540/)

[^google]: [Could not write domain com.apple.SoftwareUpdate](https://groups.google.com/forum/#!topic/macenterprise/aGwjr6dz5x4)

[^lifewire]: [AirDrop With or Without a WiFi Connection](https://www.lifewire.com/airdrop-with-without-wifi-connection-2259801)

[^macrumors-1940684]: [Airdrop in 2009 Mac Pro?](http://forums.macrumors.com/threads/airdrop-in-2009-mac-pro.1940684/)

[^ebay]: [Genuine Apple WiFi 802.11ac & Bluetooth 4.0 Upgrade Kit Adapter *Mac Pro 4,1/5,1](http://www.ebay.com/itm/251754210499?_trksid=p2060353.m2749.l2649&ssPageName=STRK:MEBIDX:IT&afsrc=1&rmvSB=true)
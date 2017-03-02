리눅스의 네트워크를 설정하는 방법에 대해서 설명합니다.

일반적인 리눅스 관련 내용은 [2017-02-07-Linux.md](./2017-02-07-Linux.md) 글을 참고합니다.

### 네트워크 

#### 디바이스 드라이버 확인 

[네트워크 디바이스 드라이버 - 리눅스 네트워크](http://mintnlatte.tistory.com/346) 글을 확인합니다. [^mintnlatte-346]

네트워크 디바이스 이름이 예전과 다르므로 [RHEL/CentOS 7 버전에서 네트워크 디바이스 이름 변경하기](http://neo-blog.tistory.com/13) 글도 확인합니다. [^neo-blog-13]

#### 열려있는 포트 확인 방법

리눅스에서 서버 프로세스를 개발하고 테스트하다 보면 서버 프로세스는 정상적으로 기동되어 있는데 다른 컴퓨터에서 접속이 안되는 경우가 있습니다. 여러 가지 이유가 있겠지만 포트가 열려 있지 않아서 그런 경우도 있습니다. 

리눅스에서 현재 열려있는 포트를 확인하는 방법은 [Linux에서 열린 포트 확인/상대방 포트 확인/포트 열기](http://khie74.tistory.com/1169521441) 글과 같이 아래처럼 하면 됩니다. [^khie74-1169521441] 

```
$ netstat -nap
```

결과가 엄청 많이 나올 수 있는데, 열려있는 포트 중에서 LISTEN 상태인 것만 표시하려면 아래와 같이 하면 됩니다. 

```
$ netstat -nap | grep LISTEN
```

#### 특정 포트 열기

포트를 열려면 iptables를 사용하면 됩니다. iptables는 리눅스 방화벽을 설정하는 명령어입니다.

```
$ iptables -I INPUT 1 -p tcp --dport 12345 -j ACCEPT 
```

보다 자세한 설명은 [Linux에서 열린 포트 확인/상대방 포트 확인/포트 열기](http://khie74.tistory.com/1169521441) 글을 참고하시기 바랍니다.

#### 랜카드 이더넷 포트 확인하기

어떤 것이 eth0 인지 확인하기 힘들 때 아래와 같이 하면 해당 카드에서 LED 가 깜박 거린다고 합니다. [^selene0301-115] 좋은 방법인지는 잘 모르겠습니다.

```
$ ethtool -p eth0
```

### 무선랜 설정

[Ubuntu: 우분투 무선랜 설정](http://perdupper.blogspot.kr/2016/02/ubuntu-sudo-apt-get-install-wireless.html) 글과 [우분투서버(Ubuntu server) 무선랜(wifi) 고정ip(static)설정](http://egloos.zum.com/lpolpo/v/476) 글을 참고합니다. [^perdupper-wireless] [^egloos-476] 기타 다른 참고 글도 볼만합니다. [^naleejang-95]

무선랜이 있는지 확인하는 방법은 아래와 같습니다.

```
$ sudo lshw -C Network
```

사용 가능한 무선랜 카드 장치의 이름은 다음과 같이 확인할 수 있습니다.

```
$ iwconfig
```

DISABLED 인 무선랜카드를 활성화시키는 방법은 아래와 같습니다.

```
$ sudo ifconfig wlan0 up 
```

마지막으로는 결국 **/etc/network/interfaces** 파일을 수정하는 것이 핵심인 것 같습니다. 

안해도 됩니다! 왜냐면 무선랜은 이미 **wpa_supplicant**를 사용해서 설정하는 것 같습니다.

아직은 이해가 안되는 부분이 있는 것 같습니다. 

wpa-ssid 값은 [wpa_supplicant를 사용한 무선랜 사용 ( WPAPSK 무선 보안 방식 / AES 암호화)](http://webnautes.tistory.com/141) 글을 참고하여 아래와 같은 방법으로 구할 수 있습니다. [^webnautes-141]

```
$ iwlist wlan0 scanning
```

실제로는 `wlan0` 이 아닌 다른 이름일 수 있습니다.

위의 결과로 나온 값들 중에서 ESSID 값을 사용하면 됩니다.

그리고 아래와 같이 네트워크를 다시 실행합니다.

```
$ sudo /etc/init.d/networking restart
```

#### 외부 통신

[#02. 리눅스를 설치했는데 외부 통신이 안되요.](http://myungin.tistory.com/entry/02-리눅스를-설치했는데-외부-통신이-안되요) 글을 참고합니다. 네트워크가 되더라도 DNS 가 필요한 것 같습니다. [^nzeen-610]

[우분투 서버 DNS 설정](http://ngee.tistory.com/246) 글을 보면 위의 자료와 DNS 설정하는 파일이 다릅니다. 우분투 버전에 따라서 파일 위치가 달라지는 것 같습니다. 좀 더 알아봐야할 것 같습니다.

#### 문제 해결 (?)

**/etc/network/interfaces** 파일에 아래와 같이 설정한 네트워크를 끄면 외부 인터넷이 됩니다. 

```
auto lo
iface lo inet loopback

auto enp4s0
iface enp4s0 inet static
address 192.168.0.1
netmask 255.255.255.0
broadcast 192.168.0.255
network 192.168.0.0
```

아마도 **enp4s0** 과 **wlxe4beed1af18a** 두 개의 랜카드를 동시에 사용하는 것이 안되기 때문인 것 같습니다. 

네트워크를 끄는 것은 아래와 같이 하면 됩니다.

```
$ sudo /etc/init.d/networking stop
```

[linux: 랜카드가 2개 일 때 네트워크 설정](http://www.nzeen.com/xe/study/610) 글을 참고합니다. 다만 설명이 쉽지는 않습니다.

[리눅스에 랜카드 2개일때, default gateway 설정 질문](https://kldp.org/node/118511) 같은 글도 있습니다. [^kldp-118511]

#### 참고 글

[우분투 무선랜 인식은 되지만 연결이 안될때 해결 방법](http://bobeathaja.tk/우분투-무선랜-인식은-되지만-연결이-안될때-해결-방/)

[랜카드 여러개 사용할 때](https://forum.ubuntu-kr.org/viewtopic.php?f=21&t=25440)

[Ubuntu,Mint,Luna 에서 USB 무선 랜카드 설치하기](http://blog.daum.net/bagjunggyu/122)

[삽질을 피하기 위한 우분투 알기(1) 무선네트워크](http://myubuntu.tistory.com/31)

### hosts 파일

[Ubuntu/Linux: /etc/hosts의 모든 것](http://storycompiler.tistory.com/118) 글을 보면 결국 **/etc/hosts** 파일은 일종의 도메인 네임 서버 역할을 하는 파일이라고 볼 수 있을 것 같습니다. [^storycompiler-118] 물론 현대에는 그 의미가 좀 줄어들었다고 볼 수 있을 것입니다.

[리눅스 로컬네임서버(/etc/hosts) 설정](http://webdir.tistory.com/162) 글에 따르면 이 파일을 로컬네임서버라고 하는 것을 알 수 있습니다. [^webdir-162]

### 참고 자료

[^mintnlatte-346]: [네트워크 디바이스 드라이버 - 리눅스 네트워크](http://mintnlatte.tistory.com/346) : 네트워크 디바이스 드라이버 정보를 확인하는 방법은 `$ cat proc/net/dev/` 입니다. 

[^neo-blog-13]: [RHEL/CentOS 7 버전에서 네트워크 디바이스 이름 변경하기](http://neo-blog.tistory.com/13) : 레드헷 계열 리눅스는 `eth0` 같은 이름 대신에 `enp4s0` 같은 이름을 사용한다고 설명합니다. 

[^khie74-1169521441]: [Linux에서 열린 포트 확인/상대방 포트 확인/포트 열기 ](http://khie74.tistory.com/1169521441)

[^perdupper-wireless]: [Ubuntu: 우분투 무선랜 설정](http://perdupper.blogspot.kr/2016/02/ubuntu-sudo-apt-get-install-wireless.html)

[^egloos-476]: [우분투서버(Ubuntu server) 무선랜(wifi) 고정ip(static)설정](http://egloos.zum.com/lpolpo/v/476) : **/etc/network/interfaces** 파일의 편집 방법에 대해서 잘 설명한 글입니다.

[^naleejang-95]: [노트북에 Ubuntu 서버를 설치하고 Wifi를 연결해 보자!!](http://naleejang.tistory.com/95) 

[^webnautes-141]: [wpa_supplicant를 사용한 무선랜 사용 ( WPAPSK 무선 보안 방식 / AES 암호화)](http://webnautes.tistory.com/141)

[^storycompiler-118]: [Ubuntu/Linux: /etc/hosts의 모든 것](http://storycompiler.tistory.com/118)

[^webdir-162]: [리눅스 로컬네임서버(/etc/hosts) 설정](http://webdir.tistory.com/162)

[^nzeen-610]: [linux: 랜카드가 2개 일 때 네트워크 설정](http://www.nzeen.com/xe/study/610)

[^kldp-118511]: [리눅스에 랜카드 2개일때, default gateway 설정 질문](https://kldp.org/node/118511)

[^selene0301-115]: [CentOS: Ethernet Port 확인하기](http://selene0301.tistory.com/115)


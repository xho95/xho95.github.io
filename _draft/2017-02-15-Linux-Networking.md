리눅스의 네트워크를 설정하는 방법에 대해서 설명합니다.

일반적인 리눅스 관련 내용은 [2017-02-07-Linux.md](./2017-02-07-Linux.md) 글을 참고합니다.

### 네트워크 

#### 디바이스 드라이버 확인 

[네트워크 디바이스 드라이버 - 리눅스 네트워크](http://mintnlatte.tistory.com/346) 글을 확인합니다. [^mintnlatte-346]

네트워크 디바이스 이름이 예전과 다르므로 [RHEL/CentOS 7 버전에서 네트워크 디바이스 이름 변경하기](http://neo-blog.tistory.com/13) 글도 확인합니다. [^neo-blog-13]

#### 열려있는 포트 확인 방법

리눅스에서 서버 프로세스를 개발하고 테스트하다 보면 서버 프로세스는 정상적으로 기동되어 있는데 다른 컴퓨터에서 접속이 안되는 경우가 있습니다. 여러 가지 이유가 있겠지만 포트가 열려 있지 않아서 그런 경우도 있습니다. 

리눅스에서 현재 열려 있는 포트를 확인하는 방법은 아래와 같습니다. [^khie74-1169521441]

```
$ netstat -nap
```

#### 특정 포트 열기

포트를 열려면 iptables를 사용하면 됩니다. iptables는 리눅스 방화벽을 설정하는 명령어입니다.

```
$ iptables -I INPUT 1 -p tcp --dport 12345 -j ACCEPT 
```

보다 자세한 설명은 [Linux에서 열린 포트 확인/상대방 포트 확인/포트 열기](http://khie74.tistory.com/1169521441) 글을 참고하시기 바랍니다.

#### 랜카드 이더넷 확인하기

어떤 것이 eth0 인지 확인하기 힘들 때 아래와 같이 하면 해당 카드에서 LED 가 깜박 거린다고 합니다.

```
$ ethtool -p eth0
```

#### 무선랜 설정

[Ubuntu: 우분투 무선랜 설정](http://perdupper.blogspot.kr/2016/02/ubuntu-sudo-apt-get-install-wireless.html) 글과 [우분투서버(Ubuntu server) 무선랜(wifi) 고정ip(static)설정](http://egloos.zum.com/lpolpo/v/476) 글을 참고합니다. [^perdupper-wireless] [^egloos-476] 기타 다른 참고 글도 볼만합니다. [^naleejang-95]

무선랜이 있는지 확인하는 방법은 아래와 같습니다.

```
$ sudo lshw -C Network
```

무선랜카드 이름은 아래와 같이 해서 확인할 수 있습니다.

```
$ iwconfig
```

DISABLED 인 무선랜카드를 활성화시키는 방법은 아래와 같습니다.

```
$ sudo ifconfig wlan0 up 
```

마지막으로는 결국 **/etc/network/interfaces** 파일을 수정하는 것이 핵심인 것 같습니다.

그리고 아래와 같이 네트워크를 다시 실행합니다.

```
$ sudo /etc/init.d/networking restart
```

### 참고 자료

[^mintnlatte-346]: [네트워크 디바이스 드라이버 - 리눅스 네트워크](http://mintnlatte.tistory.com/346) : 네트워크 디바이스 드라이버 정보를 확인하는 방법은 `$ cat proc/net/dev/` 입니다. 

[^neo-blog-13]: [RHEL/CentOS 7 버전에서 네트워크 디바이스 이름 변경하기](http://neo-blog.tistory.com/13) : 레드헷 계열 리눅스는 `eth0` 같은 이름 대신에 `enp4s0` 같은 이름을 사용한다고 설명합니다. 

[^khie74-1169521441]: [Linux에서 열린 포트 확인/상대방 포트 확인/포트 열기 ](http://khie74.tistory.com/1169521441)

[^perdupper-wireless]: [Ubuntu: 우분투 무선랜 설정](http://perdupper.blogspot.kr/2016/02/ubuntu-sudo-apt-get-install-wireless.html)

[^egloos-476]: [우분투서버(Ubuntu server) 무선랜(wifi) 고정ip(static)설정](http://egloos.zum.com/lpolpo/v/476) : **/etc/network/interfaces** 파일의 편집 방법에 대해서 잘 설명한 글입니다.

[^naleejang-95]: [노트북에 Ubuntu 서버를 설치하고 Wifi를 연결해 보자!!](http://naleejang.tistory.com/95) 

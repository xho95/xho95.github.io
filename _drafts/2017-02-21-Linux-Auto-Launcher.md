
여기서는 우분투에서 부팅시 특정 프로그램을 자동으로 실행하는 방법을 알아봅니다. 

이 자료는 [우분투 서비스 컨트롤 방법](http://www.snoopybox.co.kr/1720) 글을 기준으로 여타 다른 참고 자료를 활용하여 정리하였습니다. [^snoopybox-1720] [^nawoo-80148421970]

### 자동 실행 원리

우분투의 경우 **/etc/init.d** 디렉토리에 심볼릭 링크 파일들을 모아두는 것 같습니다. 우분투는 심볼릭 링크와는 별도로 Upstart 스크립트를 이용해서 서비스의 구동 과 정지를 제어하는데 이는 **/etc/init** 디렉토리에 존재합니다.  

심볼릭 링크라고 하는 것은 윈도우즈에서 단축 아이콘의 역할을 하며 쉘 스크립트 파일이라 편집도 가능합니다. 심볼릭 링크 파일의 파일명이 S 로 시작하는지 K 로 시작하는지에 따라 부팅시에 실행이되는지 안되는지가 결정되는 것 같습니다. [^originalchoi-44]

### 자동 실행 설정

사용자가 설치한 프로그램들을 부팅시 자동으로 실행하기 위해서는 CentOS 에서는 chkconfig 와 ntsysv 를 사용한다고 합니다. [^couplewith-60007889350] 일단 우분투에서는 따로 chkconfig 가 없는 것 같습니다. chkconfig 는 CentOS 같은 레드햇 계열 리눅스에서 사용하는 명령어인 것 같습니다. 

우분투에서는 sysv-rc-conf 같은 다른 프로그램을 사용해야하는 것 같습니다. [^one2next-chkconfig] 

#### sysv-rc-conf 사용하기

설치는 다음과 같이 해 줍니다. apt 와 apt-get 의 차이가 무엇인지도 확인해야할 것 같습니다. 

```
$ sudo apt update
$ sudo apt install sysv-rc-conf
```

그리고 다음과 같이 실행하면 됩니다. 

```
$ sudo sysv-rc-conf
```

그러면 다음과 같이 터미널에서 커서를 움직여서 설정을 할 수 있는 화면이 나타납니다. 

![sysv-rc-conf](../assets/ubuntu/sysv-rc-conf.jpeg)

### 기타 자료

일단 시작 프로그램의 등록과 실행 스크립트의 등록은 조금 다른 것 같습니다. 스크립트로 등록하면 프로그램을 보이지 않게 실행할 수 있을 것 같습니다. 

[우분투 부팅시에 제가 만든 프로그램을 자동으로 실행되게 하는 방법에 대해서 ..](https://kldp.org/node/129306) 글도 도움이 될 것 같습니다. [^kldp-129306]

[Ubuntu 시작 프로그램 등록](http://zeal74.tistory.com/1179) 글도 있습니다. [^zeal74-1179]

[질문 | 우분투 부팅 후 응용프로그램이 자동으로 실행하게 할려면 어떻게 하나요?](http://com.odroid.com/sigong/nf_board/nboard_view.php?brd_id=odroid-x2&kind=59&bid=2500) 글도 있습니다. [^odroid-2500]

[우분투 서버 시작시 스크립트 실행등록](http://ihoney.pe.kr/1099) [^ihoney-1099]

### 참고 자료

[^nawoo-80148421970]: CentOS 의 경우 [Linux 에서 부팅시 자동실행 스크립트 및 등록방법](http://blog.naver.com/PostView.nhn?blogId=nawoo&logNo=80148421970) 라는 글에 부팅시 스크립트를 자동으로 실행하는 방법이 잘 정리되어 있습니다. 새로 블로그를 만드는 것인지 [LINUX 에서 부팅시 자동실행 스크립트 및 등록방법 LINUX / OS](http://marinb577.besaba.com/?p=316) 라는 글도 있습니다.

[^originalchoi-44]: [리눅스 부팅시 명령스크립트 실행하기](http://originalchoi.tistory.com/44) : 다른 사람의 글 두 개를 연결해 놓은 글입니다. 각각의 원본 글 두 개를 정리하면 될 것 같습니다. 하나는 [Linux 에서 부팅시 자동실행 스크립트 및 등록방법](http://blog.naver.com/PostView.nhn?blogId=nawoo&logNo=80148421970) 이고, 다른 하나는 [정통 HowTo: chkconfig, ntsysv 를 이용한 서비스 자동 실행](http://blog.naver.com/couplewith/60007889350) 입니다.

[^couplewith-60007889350]: [정통 HowTo: chkconfig, ntsysv 를 이용한 서비스 자동 실행](http://blog.naver.com/couplewith/60007889350) 글은 설명은 좋지만 예전 자료라서 지금의 우분투와는 맞지 않는 부분이 있는 것 같습니다. 

[^one2next-chkconfig]: [우분투 chkconfig 대체 프로그램들: update-rc.d 와 sysv-rc-conf](http://www.one2next.com/우분투-chkconfig-대체-프로그램들-update-rc-d-와-sysv-rc-conf/)

[^snoopybox-1720]: [우분투 서비스 컨트롤 방법](http://www.snoopybox.co.kr/1720) : 아주 좋은 자료입니다. 이 글을 기준으로 내용을 정리하면 될 것 같습니다. 

[^kldp-129306]: [우분투 부팅시에 제가 만든 프로그램을 자동으로 실행되게 하는 방법에 대해서 ..](https://kldp.org/node/129306)

[^zeal74-1179]: [Ubuntu 시작 프로그램 등록](http://zeal74.tistory.com/1179)

[^odroid-2500]: [질문 | 우분투 부팅 후 응용프로그램이 자동으로 실행하게 할려면 어떻게 하나요?](http://com.odroid.com/sigong/nf_board/nboard_view.php?brd_id=odroid-x2&kind=59&bid=2500)

[^ihoney-1099]: [우분투 서버 시작시 스크립트 실행등록](http://ihoney.pe.kr/1099)
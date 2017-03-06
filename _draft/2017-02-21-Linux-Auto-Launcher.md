리눅스에서 부팅시 스크립트를 자동으로 실행하고 싶으면 [Linux 에서 부팅시 자동실행 스크립트 및 등록방법](http://blog.naver.com/PostView.nhn?blogId=nawoo&logNo=80148421970) 글을 참고합니다. [^nawoo-80148421970] 이 글은 CentOS 기준이라 아래의 글이 더 알맞습니다. 우분투에 대해서는 [우분투 서비스 컨트롤 방법](http://www.snoopybox.co.kr/1720) 글을 기준으로 하는 것이 좋을 것 같습니다. [^snoopybox-1720]

우분투의 경우 **/etc/init.d** 디렉토리에 심볼릭 링크 파일들을 모아두는 것 같습니다. 우분투는 심볼릭 링크와는 별도로 Upstart 스크립트를 이용해서 서비스의 구동 과 정지를 제어하는데 이는 **/etc/init** 디렉토리에 존재합니다.  

심볼릭 링크라고 하는 것은 윈도우즈에서 단축 아이콘의 역할을 하며 쉘 스크립트 파일이라 편집도 가능합니다. 심볼릭 링크 파일의 파일명이 S 로 시작하는지 K 로 시작하는지에 따라 부팅시에 실행이되는지 안되는지가 결정되는 것 같습니다. [^originalchoi-44]

사용자가 설치한 프로그램들을 부팅시 자동으로 실행하기 위해서는 CentOS 에서는 chkconfig 와 ntsysv 를 사용한다고 합니다. [^couplewith-60007889350] 일단 우분투에서는 따로 chkconfig 가 없는 것 같습니다. chkconfig 는 CentOS 같은 레드햇 계열 리눅스에서 사용하는 명령어인 것 같습니다. 

우분투에서는 sysv-rc-conf 같은 다른 프로그램을 사용해야하는 것 같습니다. [^one2next-chkconfig] 

### 자동 실행 스크립트

[^nawoo-80148421970]: [Linux 에서 부팅시 자동실행 스크립트 및 등록방법](http://blog.naver.com/PostView.nhn?blogId=nawoo&logNo=80148421970) 에 잘 정리되어 있습니다. 새로 블로그를 만드는 것인지 [LINUX 에서 부팅시 자동실행 스크립트 및 등록방법 LINUX / OS](http://marinb577.besaba.com/?p=316) 라는 글도 있습니다.

[^originalchoi-44]: [리눅스 부팅시 명령스크립트 실행하기](http://originalchoi.tistory.com/44) : 다른 사람의 글 두 개를 연결해 놓은 글입니다. 각각의 원본 글 두 개를 정리하면 될 것 같습니다. 하나는 [Linux 에서 부팅시 자동실행 스크립트 및 등록방법](http://blog.naver.com/PostView.nhn?blogId=nawoo&logNo=80148421970) 이고, 다른 하나는 [정통 HowTo: chkconfig, ntsysv 를 이용한 서비스 자동 실행](http://blog.naver.com/couplewith/60007889350) 입니다.

[^couplewith-60007889350]: [정통 HowTo: chkconfig, ntsysv 를 이용한 서비스 자동 실행](http://blog.naver.com/couplewith/60007889350) 글은 설명은 좋지만 예전 자료라서 지금의 우분투와는 맞지 않는 부분이 있는 것 같습니다. 

[^one2next-chkconfig]: [우분투 chkconfig 대체 프로그램들: update-rc.d 와 sysv-rc-conf](http://www.one2next.com/우분투-chkconfig-대체-프로그램들-update-rc-d-와-sysv-rc-conf/)

[^snoopybox-1720]: [우분투 서비스 컨트롤 방법](http://www.snoopybox.co.kr/1720) : 아주 좋은 자료입니다. 이 글을 기준으로 내용을 정리하면 될 것 같습니다. 
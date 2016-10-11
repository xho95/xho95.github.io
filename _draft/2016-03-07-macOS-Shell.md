---
layout: post
title:  "Mac OS X Shell 자료들"
date:   2016-03-07 21:00:00 +0900
categories: Resources OSX Shell Terminal
---

여기서는 **macOS** 의 쉘(shell) 명령어 및 운영체제의 기본적인 내용들에 대해서 정리합니다.[^macOS]

우선 한 줄로 간단하게 명령어들을 소개하고 이어서 각각에 대해서 조금 더 자세하게 풀어서 설명합니다.

### 기본 터미널 명령어

맥에는 많은 터미널 명령어들이 있는데 이 중에서 많이 쓰이는 명령어를 요약하면 다음과 같습니다.[^parklize_1]  [^parklize_2]

* `ls` : list - 파일 및 폴더의 리스트를 보여줍니다.
* `cd` : change directory - 폴더를 변경합니다.
* `clear` : clear - 화면을 비워줍니다.
* `cp` : copy - 파일을 복사합니다.      
* `rm` : remove - 파일을 삭제합니다.
* `ln` : link - 파일에 대한 링크를 만듭니다.
* `mv` : move - 파일을 이동합니다.
* `which` : which - 인자로 입력한 명령의 위치, 즉 경로를 찾아줍니다.
* 
* `ipconfig getifaddr en0` : 현재 ip를 보여줍니다.
* `logout` : console을 종료합니다.

### 터미널 명령어

* `ls` : list - 파일 및 폴더의 리스트를 보여줍니다.
* `cd` : change directory - 폴더를 변경합니다.
* `clear` : clear - 화면을 비워줍니다.
* `cp` : copy - 파일을 복사합니다.      
* `rm` : remove - 파일을 삭제합니다.
* `ipconfig getifaddr en0` : 현재 ip를 보여줍니다.
* `logout` : console을 종료합니다.

#### `ln`

link의 약자로 파일을 링크할 때 사용하는 명령입니다.  
심볼릭 링크 또는 하드 링크를 만들 수 있습니다.[^ln] 

#### `mv`

move의 약자로 파일을 이동하는 명령어입니다. 

이 명령은 파일을 이동할 때 사용하지만 아래와 같이 파일 이름을 바꿀 때도 사용할 수 있습니다.[^rm]

```
$ mv oldFileName.txt newFileName.txt
```

#### `curl`

**HTTP/HTTPS/FTP** 등 여러 가지 프로토콜을 사용하여 데이터를 송수신할 수 있는 명령어입니다. 

터미널에서 다음과 같이 사용할 수 있습니다.

```
$ curl www.example.com
```

위에서 `curl` 명령은 인자로 넘어온 URL로 HTTP 요청을 보내는 웹 클라이언트의 역할을 수행합니다. 

`curl` 은 command line 용 data transfer tool 로서 download/ upload 모두 가능하며 HTTP/ HTTPS/ FTP/ LDAP/ SCP/ TELNET/ SMTP/ POP3 등 주요한 프로토콜을 지원하며 Linux/Unix 계열 및 Windows 등 주요한 OS 에서 구동되므로 여러 플랫폼과 OS에서 유용하게 사용할 수 있다고 합니다.[^lesstif]  
	
그외에도 `curl`은 옵션을 지정해서 `wget`을 대신하여 파일을 다운로드 하는 등의 용도로 사용된다고 합니다.[^dezang] 

#### `telnet`

터미널에서 입력하는 내용을 그대로 웹 서버에 전송합니다. 

사실 `telnet`은 쉘 명령어는 아니고, 하나의 프로그램입니다.

### 터미널에 새로운 명령어 추가하기

#### `tree`

맥에는 따로 `tree` 명령어가 없지만, **Homebrew**를 이용해서 설치한 후에 사용할 수 있습니다. 이에 대한 내용은 참고 자료에 잘 나와 있습니다.[^eunguru]

### shell 사용법

[serapims님의 블로그 글](http://serapims.tistory.com/entry/OSX-터미널-명령어)  

[Mac 터미널에서 ssh 접속하는 방법](http://db.necoaki.net/54)

[MAC OS X 자동 시작프로그램 추가/해제 하는 방법](http://namsieon.com/595)

[mac에서 파일찾기(find) 및 조작](http://ironheel.tistory.com/32)

### zsh shell

[터미널 초보의 필수품인 Oh My ZSH!를 사용하자](https://nolboo.github.io/blog/2015/08/21/oh-my-zsh/)

[zsh 갖고 놀기](http://coding-korea.blogspot.kr/2012/09/zsh.html)

[오늘부로 나도 ZShell User!](http://justbricks.tumblr.com/post/89465435117/오늘부로-나도-zshell-user)

[맥에서 zsh 사용하기](https://blog.ayukawa.kr/archives/1758)

### iTerm2

[iTerm2](https://www.iterm2.com/version3.html)

[iTerm2를 사용해 본다.](http://redgolems.tistory.com/31)

[go2shell 설정하기 - 기본 터미널을 iterm으로 바꿉니다.](http://osxtip.tistory.com/168)

[iTerm 사용법 정리](http://osxtip.tistory.com/181)

### Swift in Terminal

[How can I use swift in Terminal?](http://stackoverflow.com/questions/24011120/how-can-i-use-swift-in-terminal)

### 참고 자료

[^macOS]: 시에라부터 OS X가 macOS로 명칭이 바뀌었습니다.

[^rm]: [리눅스 mv, rename - 파일명 변경](http://webdir.tistory.com/145) : 폴더명을 바꾸는 내용도 설명되어 있다.

[^parklize_1]: [MAC Terminal Command 맥북 터미널 명령어 모음](http://parklize.blogspot.kr/2014/08/mac-terminal-command.html)

[^parklize_2]: [MAC 터미널 명령어](http://blog.daum.net/_blog/BlogTypeView.do?blogid=0hG6Q&articleno=133)

[^lesstif]: [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703)

[^dezang]: [wget 대신 curl 사용하기](http://dezang.net/884)

[^eunguru]: [Mac OS X tree 명령어 설치, 실행](http://eunguru.tistory.com/150)

[^ln]: [ln 명령어](http://blog.naver.com/PostView.nhn?blogId=ehdgns621&logNo=130056448055) : ln 명령어에 대한 설명을 잘 해 놓은 곳입니다.
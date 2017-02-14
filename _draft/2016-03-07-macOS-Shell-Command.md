---
layout: post
title:  "macOS Shell 명령어들"
date:   2016-03-07 21:00:00 +0900
categories: Resources macOS Shell Terminal
---

여기서는 **macOS** 의 쉘(shell) 명령어 및 운영체제의 기본적인 내용들에 대해서 정리합니다. [^macOS]

우선 한 줄로 간단하게 명령어들을 소개하고 이어서 각각에 대해서 조금 더 자세하게 풀어서 설명합니다.

### 터미널 명령어 요약

맥에는 많은 터미널 명령어들이 있는데 이 중에서 많이 쓰이는 명령어를 요약하면 다음과 같습니다.[^parklize_1]  [^parklize_2]

커맨드 라인 명령어들에 대해 더 알고 싶다면, [SS64](https://ss64.com) 에서 각 운영체제별로 정리된 명령어 모음을 볼 수 있습니다.[^ss64]

* `cd` : change directory - 폴더를 변경합니다.
* `clear` : clear - 화면을 비워줍니다.
* `cp` : copy - 파일을 복사합니다.       

- `exit` : 창을 닫는다고 합니다만 실제로 닫히지는 않습니다.  

* `ipconfig getifaddr en0` : 현재 ip를 보여줍니다.  

- `ln` : link - 파일에 대한 링크를 만듭니다.
- `logout` : console을 종료합니다.
- `ls` : list - 파일 및 폴더의 리스트를 보여줍니다.  

* `man` : 뒤에 인자로 나오는 명령어에 대한 메뉴얼을 보여줍니다. [^rootblog-4] [^shaeod-669]
* `mv` : move - 파일을 이동합니다.

- `pwd` : print working directory - 현재 경로를 절대 경로로 표시해줍니다.

* `rm` : remove - 파일을 삭제합니다.

- `which` : which - 인자로 입력한 명령의 위치, 즉 경로를 찾아줍니다.
- `whoami` : 사용자 이름을 화면에 보여줍니다.

### 터미널 명령어

#### `cd`

change directory 의 약어입니다. 이름 그대로 폴더를 변경합니다.

데스크탑 폴더로 이동하려면 아래와 같이 합니다. 

```
$ cd Desktop
```

자신의 위치에서 부모 폴더로 이동하려면 아래와 같이 합니다. 

```
$ cd ..
```

#### `rm`

아래와 같이 `-r` 옵션이 붙는 것에 대해서 알아보도록 합니다!

```
$ rm -r ...
```

#### `ln`

link의 약자로 파일을 링크할 때 사용하는 명령입니다.  
심볼릭 링크 또는 하드 링크를 만들 수 있습니다.[^ln] 

#### `mv`

move의 약자로 파일을 이동하는 명령어입니다. 

이 명령은 파일을 이동할 때 사용하지만 아래와 같이 파일 이름을 바꿀 때도 사용할 수 있습니다.[^rm]

```
$ mv oldFileName.txt newFileName.txt
```

#### `exit`

창을 닫는다고 하는데 맥에서는 실제로 창은 닫히지 않고 프로세스가 종료되었다는 메시지가 뜹니다. 뭔가 실제로 닫는 옵션이 따로 있을 것 같습니다.

```
$ exit
```

#### `curl`

**HTTP/HTTPS/FTP** 등 여러 가지 프로토콜을 사용하여 데이터를 송수신할 수 있는 명령어입니다. 

터미널에서 다음과 같이 사용할 수 있습니다.

```
$ curl www.example.com
```

위에서 `curl` 명령은 인자로 넘어온 URL로 HTTP 요청을 보내는 웹 클라이언트의 역할을 수행합니다. 

`curl` 은 터미널 용 데이터 전송 도구로서 다운로드 / 업로드 모두 가능하며 HTTP/ HTTPS/ FTP/ LDAP/ SCP/ TELNET/ SMTP/ POP3 등 주요한 프로토콜을 지원하며 Linux/Unix 계열 및 Windows 등 대부분의 OS 에서 구동되므로 유용하다고 합니다. [^lesstif]  
	
그외에도 `curl`은 옵션을 지정해서 `wget`을 대신하여 파일을 다운로드 하는 등의 용도로 사용된다고 합니다. [^dezang] 맥에서 사용하는 핵심 패키지 설치 도구인 Homebrew 를 설치할 때도 `curl` 명령어가 사용됩니다. [^curl-homebrew]

#### `uname`

`uname`은 시스템의 정보를 출력하는 명령어라고 합니다. [^tip-117393]

#### `telnet`

터미널에서 입력하는 내용을 그대로 웹 서버에 전송합니다. 

사실 `telnet`은 쉘 명령어는 아니고, 하나의 프로그램입니다.

#### `whoami`

```
$ whoami
```

사용자 이름을 화면에 보여줍니다. 

#### `pwd`

pwd는 Print Working Directory 의 약자로서, 현재 어떤 디렉토리 경로에 있는지를 절대경로로 표시하는 명령어입니다. [^webdir-144]

```
$ pwd
```

> pwd를 매번 사용하지 않고 명령프롬프트에서 PS1 값을 수정함으로써 현재 디렉토리의 경로를 알수도 있다고 하는데 아직 이부분은 잘 모르겠습니다.

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

[^macOS]: 시에라(Sierra) 에서부터 맥 OS의 정식 명칭이 **OS X**에서 **macOS**로 바뀌었습니다.

[^parklize_1]: [MAC Terminal Command 맥북 터미널 명령어 모음](http://parklize.blogspot.kr/2014/08/mac-terminal-command.html)

[^parklize_2]: [MAC 터미널 명령어](http://blog.daum.net/_blog/BlogTypeView.do?blogid=0hG6Q&articleno=133)

[^ln]: [ln 명령어](http://blog.naver.com/PostView.nhn?blogId=ehdgns621&logNo=130056448055) : ln 명령어에 대한 설명을 잘 해 놓은 곳입니다.

[^rm]: [리눅스 mv, rename - 파일명 변경](http://webdir.tistory.com/145) : 폴더명을 바꾸는 내용도 설명되어 있다.

[^lesstif]: [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계 등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703) : curl을 설명하는 글 중에서 끝판왕 같은 글입니다.

[^dezang]: [wget 대신 curl 사용하기](http://dezang.net/884)

[^curl-homebrew]: Homebrew 에서 사용되는 curl 에 대한 내용은 제 블로그의 다른 글인 [Homebrew: 설치 및 Sierra 관련 이슈 정리](http://xho95.github.io/macos/sierra/package/homebrew/issues/2017/01/13/Using-Homebrew-and-some-Issues.html) 라는 글에서도 살펴볼 수 있습니다.

[^tip-117393]: [리눅스사용자명령어 - uname 이란 어떤 명령어인가요?](http://tip.daum.net/question/117393) : 시스템 정보를 출력하는 명령어인 uname 에 대한 답변 글입니다.

[^eunguru]: [Mac OS X tree 명령어 설치, 실행](http://eunguru.tistory.com/150)

[^webdir-144]: [리눅스 pwd, cd - 현재 작업위치와 작업위치 이동하기](http://webdir.tistory.com/144)

[^ss64]: [SS64](https://ss64.com) : Command line reference – Web, Database and OS scripting.

[^rootblog-4]: [리눅스 도움말 명령어(man, --help)](http://rootblog.tistory.com/4)

[^shaeod-669]: [리눅스 명령어: man - 명령어 매뉴얼 출력](http://shaeod.tistory.com/669)
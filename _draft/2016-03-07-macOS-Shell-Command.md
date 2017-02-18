---
layout: post
title:  "macOS Shell 명령어들"
date:   2016-03-07 21:00:00 +0900
categories: Resources macOS Shell Terminal
---

여기서는 **macOS** 의 쉘(shell) 명령어 및 운영체제의 기본적인 내용들에 대해서 정리합니다. [^macOS]

일단 쉘이 무엇인지부터 정리합니다. 

이어서 간단하게 명령어들을 소개하고 그 다음에는 각각의 명령어에 대해 조금 더 자세하게 풀어서 설명합니다.

### 터미널 명령어 요약

맥의 명령어는 특정 폴더에 모여 있습니다. 아마도 **/usr/bin** 일 것으로 추측합니다. 보다 자세한 내용은 [macOS: 맥의 기본 디렉토리 구조 살펴보기](http://xho95.github.io/macos/file/system/directory/2016/10/08/macOS-Directory-Structure.html) 글을 참고하시기 바랍니다.

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

### shell 사용법

[serapims님의 블로그 글](http://serapims.tistory.com/entry/OSX-터미널-명령어)  

[Mac 터미널에서 ssh 접속하는 방법](http://db.necoaki.net/54)

[MAC OS X 자동 시작프로그램 추가/해제 하는 방법](http://namsieon.com/595)

[mac에서 파일찾기(find) 및 조작](http://ironheel.tistory.com/32)

### 참고 자료

[^macOS]: 시에라(Sierra) 에서부터 맥 OS의 정식 명칭이 **OS X**에서 **macOS**로 바뀌었습니다.

[^parklize_1]: [MAC Terminal Command 맥북 터미널 명령어 모음](http://parklize.blogspot.kr/2014/08/mac-terminal-command.html)

[^parklize_2]: [MAC 터미널 명령어](http://blog.daum.net/_blog/BlogTypeView.do?blogid=0hG6Q&articleno=133)

[^ln]: [ln 명령어](http://blog.naver.com/PostView.nhn?blogId=ehdgns621&logNo=130056448055) : ln 명령어에 대한 설명을 잘 해 놓은 곳입니다.

[^rm]: [리눅스 mv, rename - 파일명 변경](http://webdir.tistory.com/145) : 폴더명을 바꾸는 내용도 설명되어 있다.

[^tip-117393]: [리눅스사용자명령어 - uname 이란 어떤 명령어인가요?](http://tip.daum.net/question/117393) : 시스템 정보를 출력하는 명령어인 uname 에 대한 답변 글입니다.

[^webdir-144]: [리눅스 pwd, cd - 현재 작업위치와 작업위치 이동하기](http://webdir.tistory.com/144)

[^ss64]: [SS64](https://ss64.com) : Command line reference – Web, Database and OS scripting.

[^rootblog-4]: [리눅스 도움말 명령어(man, --help)](http://rootblog.tistory.com/4)

[^shaeod-669]: [리눅스 명령어: man - 명령어 매뉴얼 출력](http://shaeod.tistory.com/669)
---
layout: post
title:  "Mac OS X Shell 자료들"
date:   2016-03-07 21:00:00 +0900
categories: Resources OSX Shell Terminal
---

여기서는 **macOS** 의 shell 및 운영체제의 기본적인 내용들에 대해서 정리합니다.

[MAC OS X 자동 시작프로그램 추가/해제 하는 방법](http://namsieon.com/595)

### 맥 유니코드 문자 입력기에서 특정 유니코드 문자 입력

* 검색 창에서 입력할 때 유니코드 앞에 hexa 코드를 입력한다.
	* ex) é = 0xE9

### shell

[serapims님의 블로그 글](http://serapims.tistory.com/entry/OSX-터미널-명령어)  

[Mac 터미널에서 ssh 접속하는 방법](http://db.necoaki.net/54)

#### 터미널 명령어

간단한 터미널 명령어를 요약합니다.[^parklize_1]  [^parklize_2]

* `ls` : list - 파일 및 폴더의 리스트를 보여줍니다.
* `cd` : change directory - 폴더를 변경합니다.
* `clear` : clear - 화면을 비워줍니다.
* `cp` : copy - 파일을 복사합니다.      
* `rm` : remove - 파일을 삭제합니다.
* `ipconfig getifaddr en0` : 현재 ip를 보여줍니다.
* `logout` : console을 종료합니다.

* `mv` : move - 명령은 파일 이동할 때도 사용하지만 파일 이름을 바꿀 때도 사용할 수 있습니다.[^rm]

```
$ mv newFileName.txt oldFileName.txt
```

[mac에서 파일찾기(find) 및 조작](http://ironheel.tistory.com/32)

#### 새로운 명령어 추가

[Mac OS X tree 명령어 설치, 실행](http://eunguru.tistory.com/150)

#### zsh

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

[^rm]: [리눅스 mv, rename - 파일명 변경](http://webdir.tistory.com/145) : 폴더명을 바꾸는 내용도 설명되어 있다.

[^parklize_1]: [MAC Terminal Command 맥북 터미널 명령어 모음](http://parklize.blogspot.kr/2014/08/mac-terminal-command.html)

[^parklize_2]: [MAC 터미널 명령어](http://blog.daum.net/_blog/BlogTypeView.do?blogid=0hG6Q&articleno=133)

맥을 사용하다보면 가끔씩 PATH를 추가해야 할 경우가 있습니다.[^SeonHo]

그 방법들에 대해 정리합니다.

### 환경 변수 설정

맥에서 환경 변수를 설정하는 방법에 대한 글입니다.[^sjpison]  [^elfinlas]

### 환경 변수 파일들의 종류

Path의 경로로는 아래와 같은 것들이 있다고 합니다. (문장을 고치자.)

```
~/.bash_profile
~/.profile
/etc/paths
~/.bash_login
```

`~/.bash_profile`, `~/.profile`, 및 `~/.bash_login`의 경우 사용자 path 파일이며 처음부터 존재 하지는 않으니 새로 생성해줘야 한다고 합니다.[^TutorialBook]  

각각의 파일들이 차이점이 무엇인지는 계속 알아봐야할 것 같습니다.[^StefaanLippens]

macOS Shell 전반에 대한 내용은 [bash on Mac OS X](http://appletree.or.kr/forum/viewtopic.php?id=13)의 글을 참고해도 좋을 것 같습니다.[^AppleTree]

### 맥에서 경로 구분자

맥에서는 경로를 지정할 때 기본 구분자가 슬래쉬(`/`) 기호입니다. 이것은 단독으로는 루트 디렉토리를 의미하기도 합니다. 다만 가끔씩 맥의 경로 지정에서 콜론(`:`) 기호를 볼 수 있습니다. 특히 콜론 기호는 터미널에서 경로를 보여줄 때도 사용하는 것을 볼 수 있습니다. 이것은 원래 예전의 맥이 콜론(`:`) 기호를 경로의 구분자로 사용했기 때문입니다.[^wiki-path]

### 고찰하기

### 참고 자료

[^sjpison]: [OS X 에서 환경변수 지정하는 방법!!](http://sjpison.tistory.com/258)

[^elfinlas]: [Mac에서 Path 설정하기](http://elfinlas.tistory.com/266) : **/etc/paths** 와 **/etc/profile** 에 대해서 설명을 한 글입니다.

[^TutorialBook]: [MAC 에서 path 설정하기](http://www.tutorialbook.co.kr/entry/MAC-에서-path-설정하기)

[^StefaanLippens]: [Bash: about .bashrc, .bash_profile, .profile, /etc/profile, etc/bash.bashrc and others](http://stefaanlippens.net/bashrc_and_others) ~/.bashrc, ~/.bash_profile, ~/.profile, /etc/profile, /etc/bash.bashrc 등의 여러 가지 비슷한 파일들의 차이점과 용도를 잘 설명한 글입니다.

[^AppleTree]: 글 자체는 오래되었지만, 원문도 좋고 번역도 잘 된 아주 좋은 글입니다.

[^SeonHo]: [MAC OS X 에서 $PATH 세팅 방법](http://seonhokim.net/2013/10/30/mac-os-x-에서-path-세팅-방법/) 새로운 binary를 $PATH에 등록하는 방법에 대해 잘 설명해 놓았습니다.

[^wiki-path]: [Path (computing)](https://en.wikipedia.org/wiki/Path_(computing)) : 표의 Classic Mac OS 항목에서 예전 맥 OS의 디렉토리 구분자가 콜론(`:`)임을 알 수 있습니다.  

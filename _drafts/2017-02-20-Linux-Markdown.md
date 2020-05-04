일단 [10 Best Markdown Editors for Linux](http://www.tecmint.com/best-markdown-editors-for-linux/) 글을 보고 제일 간단해 보이는 [Mark My Words](https://github.com/voldyman/MarkMyWords) 를 선택하기로 했습니다. [^tecmint--markdown-editors] [^voldyman]

맥에선 Mou 를 쓰다가 Sierra 에서는 지원이 끊겨서 MacDown 을 쓰고 있는데, MarkMyWords 제일 Mou 의 향기를 품고 있는 것 같습니다.

#### 설치

설치는 GitHub 저장소에 있는 설명대로 아래와 같이 하면 됩니다. 

아래에서 [PPA](https://launchpad.net/ubuntu/+ppas) 가 무슨 의미인지 정리할 필요가 있을 것 같습니다. [^ppa] [^askubuntu-4983]

```
$ sudo add-apt-repository ppa:voldyman/markmywords
$ sudo apt-get update
$ sudo apt-get install mark-my-words
```

소스를 다운받아서 빌드해서 설치하는 방법은 따로 설명하고 있습니다.

#### 단점 

1. 프로그램 실행은 터미널에서 바로 안되는 것 같고 Search 버튼에서 Mark... 등으로 검색해서 실행해야 하는 것 같습니다.
	
	아마 다른 실행 방법이 있을 것입니다.
	
2. 화면 스크롤이 코드와 미리보기가 같이 안되는 것 같습니다. 이 것 때문에 사용하기가 은근히 불편합니다. 

### 참고 자료

[^tecmint--markdown-editors]: [10 Best Markdown Editors for Linux](http://www.tecmint.com/best-markdown-editors-for-linux/) 는 리눅스에서 사용할만한 마크다운 에디터를 소개하는 글입니다.

[^voldyman]: [Mark My Words](https://github.com/voldyman/MarkMyWords) 는 일단 외양과 속도 등은 합격점인데 스크롤이 은근히 짜증납니다.

[^askubuntu-4983]: [What are PPAs and how do I use them?](http://askubuntu.com/questions/4983/what-are-ppas-and-how-do-i-use-them) 글에 따르면 우분투에서 PPA 는 Personal Package Archives 의 약자로 개인 패키지 저장소 같은 개념인 것 같습니다.

[^ppa]: 우분투의 자체 PPA는 [Personal Package Archives for Ubuntu](https://launchpad.net/ubuntu/+ppas) 에 가면 볼 수 있습니다.




---
layout: post
title:  "Jekyll과 GitHub로 블로그 만들기"
date:   2016-01-11 12:50:00 +0900
categories: Blog GitHub Jekyll Git
---

이 포스트에서는 맥 환경에서 [Jekyll](http://jekyllrb.com)[^Jekyll]을 이용하여 [GitHub](https://github.com)[^GitHub]에 개인 블로그를 만드는 방법을 정리합니다.[^blog]

우선 Jekyll이 무엇인지 알아본 후 Jekyll을 사용하여 GitHub 저장소에 블로그를 만드는 과정을 정리합니다.


### Jekyll은 무엇인가?

Jekyll로 블로그를 만들기에 앞서 먼저 Jekyll이 무엇인지 알아야 합니다. 도대체 Jekyll이 무엇이길래 블로그를 만드는데 사용하는 것일까요? 사실 Jekyll은 단순히 텍스트 파일을 HTML 파일로 변환해 주는 하나의 변환기입니다.[^Jekyll_Documentation] 이렇게 변환된 HTML 파일들을 웹 서버에 올리면 바로 하나의 홈페이지가 됩니다.[^Jekyll_Demerits]

이렇게 Jekyll 자체가 HTML 파일을 만들어 주니까 사용자는 블로그에 글을 쓸 때마다 HTML 파일을 만들 필요없이 해당 글을 Markdown 형식의 텍스트로 작성하여 Jekyll로 빌드하기만 하면 됩니다.


### 웹 호스팅 서비스로 GitHub Pages를 사용하는 이유

그런데 그냥 매번 HTML 파일을 직접 만드는 것이나 Jekyll을 사용하여 HTML을 만들어 내는 것이나 별 차이가 없어 보입니다. 이렇게만 하면 Jekyll을 사용하는 의미가 없어 보입니다.

하지만 GitHub를 사용하면 의미가 달라집니다. 왜냐하면 GitHub에서 제공하는 웹 호스팅 서비스인 GitHub Pages는 Jekyll을 지원하기 때문입니다. 따라서 GitHub Pages에 새로운 Markdown 문서를 Push 하기만 하면 블로그를 업데이트할 수 있습니다.


### 웹 호스팅 서비스로 GitHub Pages를 사용하는 이유


### Jekyll 설치하기

원래는 Jekyll을 사용하기 위해서는 먼저 Ruby를 설치해야 한다. 하지만 Ruby는 맥에 이미 설치되어 있다. 따라서 맥 사용자는 Ruby를 따로 설치할 필요가 없으므로 바로 Jekyll을 설치하면 된다.

맥의 터미널을 실행하고 아래와 같이 입력하여 Jekyll을 설치한다.

```sh
$ sudo gem install jekyll
```

> 여기서 gem은 ruby 언어에서 서드파티 라이브러리를 설치하도록 도와주는 시스템이다.


### Jekyll로 블로그의 로컬 저장소 만들기

우선, 터미널에서 로컬 저장소를 위치하고 싶은 곳으로 이동한다.

```sh
$ cd some-dir/
```

그다음, jekyll을 사용하여 블로그 내용을 저장할 로컬 저장소를 만든다. 터미널에서 아래와 같이 `jekyll new`를 실행하면 된다.

```sh
$ jekyll new username.github.io
```

위에서 로컬 저장소의 이름(`username.github.io`)이 꼭 github의 원격 저장소의 이름과 같을 필요는 없지만 편의를 위해서 같게 두었다.

local 저장소가 만들어졌으면, 터미널에서 `jekyll serve`를 입력하여 로컬에 있는 사이트를 실행할 수 있다.

```sh
$ jekyll serve
```

로컬에 있는 사이트는 웹브라우저 주소창에서 로컬 호스트 주소(`localhost:4000`)를 입력하면 확인할 수 있다.


### GitHub에 온라인 저장소 만들기

지금까지는 로컬에서 jekyll을 이용해서 블로그를 만들었다. 하지만, 서버에 등록된 것은 아니라 로컬에서만 확인가능하다. 이를 실제 웹에서 확인하려면 호스팅 서비스에 올려야한다. GitHub는 회원에게 무료 블로그 호스팅 서비스를 해주므로 GitHub에 온라인 저장소를 만든 다음 앞서 만든 로컬 저장소를 연동하면 된다.

우선 [GitHub Pages](https://pages.github.com) 사이트에서 `create a repository` 메뉴를 이용하여 자신만의 원격 저장소를 만든다. 이 때 원격 저장소 이름은 `username.github.io`과 같은 형식을 맞춰줘야 한다.


### 로컬 저장소와 원격 저장소를 연동하기

이제 온전한 블로그를 위해 jekyll로 만든 로컬 저장소와 GitHub로 만든 원격 저장소를 연결시켜줘야 한다.

우선 jekyll로 만든 로컬 저장소에서 `git init` 명령어를 사용하여 git 저장소를 생성한다.

```sh
$ git init
```

이렇게 하면 해당 저장소의 변경 사항을 git이 추적할 수 있게된다.

이제 `git remote` 명령어로 온라인 저장소를 로컬 저장소와 연결한다.

```sh
$ git remote add origin repository-url
```

여기서 `repository-url`은 보통 아래와 같은 주소가 된다.

```sh
https://github.com/username/username.github.io.git
```


### 로컬 저장소의 내용을 원격 저장소로 push하기

이제 로컬 저장소와 원격 저장소가 연결되었으니, 로컬 저장소의 변경 내용을 원격 저장소로 `push`하면 블로그가 업데이트된다.

이것은 변경 파일들을 `add`하고, `commit`한 다음, 원격 저장소로 `push`하는 과정을 거친다.

우선 변경 파일들을 `git add` 명령어를 사용하여 추가한다.

```sh
$ git add .
```

여기서 `'.'`은 모든 변경 파일들을 추가하겠다는 의미이다. 추가한 파일들을 로컬 저장소에 등록하려면 `git commit` 명령어를 사용한다.

```sh
$ git commit -m "message"
```

"message" 에는 해당 커밋에 대한 설명을 간략하게 정하면 된다.

이제 로컬 저장소에 등록된 내용을 원격 저장소에 등록하면 끝이다. 이것은 다음과 같이 `git push` 명령어를 사용하면 된다.

```sh
$ git push origin master
```

위와 같이 하면, 현재 로컬에 있는 변경 내역들을 원격 저장소로 `push`하게 된다.


### 확인하기

위의 과정을 모두 마치면 `http://username.github.io`의 주소로 현재까지의 작업 결과물을 확인할 수 있다.

### 참고 자료

[vjinn님의 블로그](https://vjinn.github.io)  
[kalkin7님의 블로그 글](http://blog.kalkin7.com/2015/07/07/maintain-a-blog-for-a-long-time/)  
[hmhv님의 블로그 글](http://hmhv.info/2015/02/github-pages-and-hexo/)  
[saltfactory님의 블로그 글](http://blog.saltfactory.net/note/create-personal-web-site-using-with-github-pages.html)  

[serapims님의 블로그 글 - 나중에 정리](http://serapims.tistory.com/entry/OSX-터미널-명령어)  

[^Jekyll]: Jekyll의 공식 사이트는 [http://jekyllrb.com](http://jekyllrb.com) 입니다.

[^GitHub]: GitHub의 공식 사이트는 [https://github.com](https://github.com) 입니다. 이 중에서 호스팅 서비스를 지원하는 곳은 [GitHub Pages](https://pages.github.com)입니다.

[^blog]: Jekyll 관련 자료중에서 한글로 된 포스트 중에서는 [놀부님 블로그](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/) 만한 곳은 없는 것 같습니다. 이 블로그 내용도 Nolboo님의 블로그 글에서 많은 도움을 받았습니다.

[^Jekyll_Documentation]: Jekyll에 대한 자세한 설명은 [Jekyll Documentation](https://jekyllrb.com/docs/home/)에 가면 확인할 수 있습니다.

[^Jekyll_Demerits]: 다만, Jekyll은 정적 HTML 파일만 만들어 주기 때문에 동적 요소가 필요한 홈페이지 보다는 동적 요소가 거의 필요없는 블로그 제작에 더 알맞습니다.

[^박민수님]: [박민수님 블로그](https://cuspace.github.io)  

---
layout: post
title:  "Jekyll과 GitHub로 블로그 만들기"
date:   2016-01-11 12:50:00 +0900
categories: Jekyll GitHub Git
---

여기서는 맥 환경에서 [Jekyll](http://jekyllrb.com)을 이용하여 [GitHub][GitHub]에 개인 블로그를 만드는 방법에 대해서 알아본다.[^1][^2]

이 블로그의 내용은 [박민수님의 블로그][박민수님의 블로그]님과 함께 [Nolboo님의 블로그][Nolboo님의 블로그]를 공부하면서 정리한 것으로 [Nolboo님의 블로그][Nolboo님의 블로그]에서 아주 약간의 변경 사항을 반영한 것이다. Jekyll을 이해하는데는 김민장님의 블로그의 도움을 받기도 했다.

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

그다음, `jekyll`을 사용하여 블로그를 내용을 저장할 로컬 저장소를 만든다. 터미널에서 아래와 같이 `jekyll new`를 실행하면 된다.

```sh
$ jekyll new username.github.io
```

위에서 로컬 저장소의 이름(`username.github.io`)이 꼭 github의 원격 저장소의 이름과 같을 필요는 없지만 편의를 위해서 같게 두었다.

local 저장소가 만들어졌으면, 터미널에서 `jekyll serve`를 입력하여 로컬에 있는 사이트를 실행할 수 있다.

```sh
$ jekyll serve
```

로컬에 있는 사이트는 웹브라우저 주소창에서 아래의 localhost 주소를 입력하여 확인할 수 있다.

```sh
localhost:4000
```


### GitHub에 온라인 저장소 만들기

지금까지는 로컬에서 jekyll을 이용해서 블로그를 만들었다. 하지만, 서버에 등록된 것은 아니라 로컬에서만 확인가능하다. 이를 실제 웹에서 확인하려면 호스팅 서비스에 올려야한다. GitHub는 회원에게 무료 블로그 호스팅 서비스를 해주므로 GitHub에 온라인 저장소를 만든 다음 앞서 만든 로컬 저장소를 연동하면 된다.

우선 [GitHub Pages][GitHub Pages] 사이트에서 `create a repository` 메뉴를 이용하여 자신만의 원격 저장소를 만든다. 보통 `username.github.io`를 사용한다.


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

``"message"`` 에는 해당 커밋에 대한 설명을 간략하게 정하면 된다.

로컬 저장소에 등록된 내용을 원격 저장소에 등록하면 끝이다. 이것은 다음과 같이 `git push` 명령어를 사용한다.

```sh
$ git push origin master
```

위와 같이 하면, 현재 로컬에 있는 변경 내역들을 원격 저장소에 `push`하게 된다.


### 확인하기

위의 과정을 모두 마치면 `http://username.github.io`의 주소로 현재까지의 작업 결과물을 확인할 수 있다.


### 참고 자료

[Jekyll]: http://jekyllrb.com
[GitHub]: https://github.com
[박민수님의 블로그]: https://cuspace.github.io  
[Nolboo님의 블로그]: https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/
[GitHub Pages]: https://pages.github.com


[^1]: [Jekyll](http://jekyllrb.com)  
[^2]: [GitHub](https://github.com)  
[GitHub Pages](https://pages.github.com)  
[Nolboo님의 블로그](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/)  
[박민수님의 블로그](https://cuspace.github.io)  

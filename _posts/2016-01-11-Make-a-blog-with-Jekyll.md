---
layout: post
title:  "Make a Blog with Jekyll"
date:   2016-01-11 12:50:00 +0900
categories: jekyll update
---

## Jekyll과 GitHub로 Blog 만들기

여기서는 Jekyll을 이용하여 GitHub에 개인 블로그를 만드는 방법에 대해서 알아본다.

이 블로그의 내용은 [박민수][박민수]님과 함께 [Nolboo님의 블로그][Nolboo님의 블로그]를 공부하면서 정리한 것으로 [Nolboo님의 블로그][Nolboo님의 블로그]에서 아주 약간의 변경 사항을 반영한 것이다.

### Jekyll 설치하기

터미널에서 아래와 같이 입력하여 jekyll을 설치한다.

```sh
sudo gem install jekyll
```

> gem은 ruby 언어에서 서드파티 라이브러리를 설치하도록 도와주는 시스템이다.


### Jekyll로 블로그의 local 저장소 만들기

우선, 터미널에서 local 저장소가 위치할 곳으로 이동한다.

```sh
cd Documents/
```

그다음, 블로그를 내용을 저장할 local 저장소를 만든다. 이 때, 아래와 같이 jekyll 명령어를 사용한다.

```sh
jekyll new xho95.github.io
```

local 저장소가 만들어졌으면, 터미널에서 jekyll serve를 입력하여 local에 있는 site를 실행할 수 있다.

```sh
jekyll serve
```

local에 있는 site는 웹브라우저 주소창에서 아래의 localhost 주소를 입력하여 확인할 수 있다.

```sh
localhost:4000
```


### GitHub에서 온라인 저장소 만들기

지금까지는 local에서 jekyll을 이용해서 블로그를 만들었다. 하지만, 서버에 등록된 것은 아니라 local에서만 확인가능하다. 이를 실제 웹에서 확인하려면 호스팅 서비스에 올려야한다. GitHub는 회원에서 무료 블로그 호스팅 서비스를 해주므로 GitHub에 온라인 저장소를 만든 다음 앞서 만든 local 저장소를 연동하면 된다.

우선 pages.github.com 사이트에서 create a repository를 이용하여 자신만의 repository를 만든다. 보통 username.github.io를 사용한다?


### local 저장소와 online 저장소를 연동하기

이제 온전한 블로그를 위해 jekyll로 만든 local 저장소와 GitHub로 만든 온라인 저장소를 연결시켜줘야 한다.

우선 jekyll로 만든 local 저장소에서 git 명령어를 사용하여 git을 초기화한다.

```sh
git init
```

이렇게 하면 해당 저장소의 변경 사항을 git이 추적할 수 있게된다.

이제 git remote 명령어로 온라인 저장소를 local 저장소와 연결한다.

```sh
git remote add origin repository-url
```

여기서 repository-url은 보통 아래와 같은 주소가 된다.

```sh
https://github.com/username/username.github.io.git
```


### local 저장소의 내용을 online 저장소로 push하기

이제 local 저장소와 online 저장소가 연결되었으니, local 저장소의 변경 내용을 online 저장소로 push하면 블로그가 업데이트된다.

이것은 변경 파일들을 선택하고, 커밋한다음, 원격 저장소로 push하는 과정을 거친다.

우선 변경 파일들을 git add 명령어를 사용하여 추가한다.

```sh
git add .
```

여기서 '.'은 모든 변경 파일들을 추가하겠다는 의미이다. 추가한 파일들을 local repository에 등록하려면 git commit 명령어를 사용한다.

```sh
git commit -m "message"
```

-m "message" 에는 해당 커밋에 대한 설명을 간략하게 정하면 된다.

local repository에 등록된 내용을 원격 repository에 등록하면 끝이다. 이것은 다음과 같이 git push 명령어를 사용한다.

```sh
git push origin master
```

위와 같이 하면, 현재 local에 있는 변경 내역들을 온라인 repository에 push하게 된다.


### 확인하기

위의 과정을 모두 마치면 http://username.github.io 의 주소로 현재까지의 작업 결과물을 확인할 수 있다.


### 참고 자료

[박민수]: https://cuspace.github.io
[Nolboo님의 블로그]: https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/

GitHub  
Jekyll  
놀부님 블로그  
박민수님 블로그 및 자료

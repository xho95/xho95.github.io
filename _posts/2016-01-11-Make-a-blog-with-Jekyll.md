---
layout: post
title:  "Jekyll과 GitHub로 블로그 만들기"
date:   2016-01-11 12:50:00 +0900
categories: Blog GitHub Jekyll Git
---

자신이 공부한 내용을 정리하는 데는 블로그만한 것이 없습니다. 블로그는 글을 쓰면서 생각을 정리하는 역할도 하지만 자신의 글들을 온라인상에 백업하는 역할도 겸하기 때문입니다.

하지만 블로그를 운영하기로 결심하고 나면 어떤 방법으로 운영할지 고심하게 됩니다. 세상에는 블로그를 만드는 여러가지 방법들이 있는데, 이왕이면 좀 더 편리하고 안전한 방법을 택하는 것이 좋을 것입니다.[^kalkin7][^saltfactory_1] 그리하여 여러 방법들을 살펴보고 난 후 Jekyll과 GitHub를 사용하여 블로그를 운영하기로 결심하게 되었습니다.

이 글에서는 제가 블로그를 운영하면서 경험한 것들, 주변분들로부터 도움을 받은 내용들[^cuspace], 그리고 인터넷에서 찾은 많은 분들의 자료[^Nolboo][^saltfactory_2]를 바탕으로 맥 환경에서 [Jekyll](http://jekyllrb.com)[^Jekyll]과 [GitHub](https://github.com)[^GitHub]를 이용하여 개인 블로그를 만드는 방법을 정리하려고 합니다.

우선 블로그를 만들기 전에 먼저 Jekyll이 무엇인지, 그리고 왜 블로그 호스팅에 GitHub를 이용하는지 간단히 짚고 넘어가겠습니다.


### Jekyll이란 무엇인가?

도대체 Jekyll이 무엇이길래 블로그를 만드는데 Jekyll을 사용하는 것일까요? 사실 Jekyll은 Markdown 형식의 텍스트 파일을 HTML 파일로 변환해 주는 하나의 변환툴입니다. 이렇게 변환된 HTML 파일을 웹 서버에 올리면 바로 홈페이지가 됩니다.[^Jekyll_Documentation]

이처럼 Jekyll이 HTML 파일을 만들어 주니까 사용자는 블로그에 글을 쓸 때 Markdown으로 작성해서 Jekyll로 빌드해서 서버에 올리기만 하면 됩니다.[^Markdown] 이렇게 하면 사용자는 HTML을 신경쓰지 않고 자신의 컨텐츠에만 집중해서 글을 쓸 수 있게 됩니다.[^vjinn]


### 블로그 호스팅 서비스로 GitHub Pages를 사용하는 이유

그런데 그냥 매번 HTML 파일을 직접 만드는 것이나 Jekyll을 써서 Markdown으로 매번 HTML을 만들어 내는 것이나 별 차이가 없어 보입니다. 이렇게만 하면 Jekyll을 사용하는 의미가 없어집니다.

하지만 블로그 호스팅 서비스로 GitHub를 사용하면 의미가 달라집니다. 왜냐하면 GitHub에서 제공하는 호스팅 서비스인 [GitHub Pages](https://pages.github.com)는 Jekyll을 자체 지원하기 때문입니다. 따라서 GitHub Pages에 새로운 Markdown 문서를 올리기만 하면 사용자가 직접 빌드하지 않아도 블로그를 업데이트할 수 있습니다.[^GitHub_Pages_Jekyll]


### Jekyll과 GitHub를 사용할 경우의 장점들

지금까지의 글만 읽어 보더라도 블로그를 만드는데 Jekyll과 GitHub를 사용하면 얻을 수 있는 장점들이 어느 정도 보입니다.

하지만 사실상 가장 큰 장점은 GitHub 자체가 버전 관리 도구인 Git을 기반으로 온라인 저장소를 제공하는 사이트라는 것에서 출발합니다. 즉, Jekyll과 GitHub로 블로그를 만들면 단순히 나의 글들을 온라인상에 백업할 수 있을 뿐만 아니라 블로그를 제작하면서 변경되는 이력들을 모두 추적하고 복원가능하다는 뜻이 됩니다.[^saltfactory_3] IT 개발자처럼 기술의 변화 속도가 빠른 분야에 있는 사람들은 블로그를 운영하더라도 수시로 글들을 업데이트 해줘야 할 것인데 이런 점에서 GitHub Pages는 엄청난 장점을 가집니다.

게다가 GitHub Pages의 호스팅 서비스는 무료입니다. 이쯤되면 적어도 개발자라면 Jekyll과 GitHub로 블로그를 안 만드는 것이 이상할 정도입니다.

이제 Jekyll과 GitHub Pages에 대해서 살펴봤으니 본격적으로 Jekyll을 이용하여 GitHub Pages에 블로그를 만드는 방법에 대해서 알아보도록 하겠습니다.


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

[^kalkin7]: 블로그를 운영하는 방식의 종류와 각 방식들의 장단점에 대한 내용은 [kalkin7님](http://blog.kalkin7.com)이 쓰신 [내 글을 오래 남기기 위한 블로그 선택](http://blog.kalkin7.com/2015/07/07/maintain-a-blog-for-a-long-time/)이란 글에 잘 정리되어 있습니다. [kalkin7님](http://blog.kalkin7.com)의 글에는 Jekyll과 GitHub를 사용하여 블로깅을 할 경우의 장점에 대해서도 잘 정리되어 있습니다.

[^saltfactory_1]: [saltfactory님](http://blog.saltfactory.net)이 쓰신 [Tistory에서 Jekyll을 이용하여 GitHub Pages로 블로그 이전](http://blog.saltfactory.net/note/renewal-blog-from-tistory-to-github-pages-via-jekyll.html)이란 글에도 Jekyll과 GitHub의 장점이 잘 나와 있습니다. 무엇보다 [saltfactory님](http://blog.saltfactory.net)의 경우 블로그 자체가 정말 충실합니다.

[^cuspace]: 제가 Jekyll로 블로그를 운영하게 된 데에는 [모두의연구소](http://www.modulabs.co.kr)에서 [VRtooN 연구실](http://www.modulabs.co.kr/#!vrtoon/cl0n)을 이끌고 계시는 [박민수님](https://cuspace.github.io)의 도움이 컸습니다. 박민수님은 개인적으로 [VR 관련 블로그](https://cuspace.github.io)를 Jekyll과 GitHub를 사용해서 운영하고 있습니다.

[^Jekyll]: Jekyll의 공식 사이트는 [http://jekyllrb.com](http://jekyllrb.com)입니다.

[^GitHub]: GitHub의 공식 사이트는 [https://github.com](https://github.com)이며, GitHub에서 호스팅 서비스를 지원하는 곳은 [GitHub Pages](https://pages.github.com)입니다.

[^Nolboo]: Jekyll 관련 자료 중에서 한글로 된 포스트 중에서는 [Nolboo님](https://nolboo.github.io)이 정리하신 [지킬로 깃허브에 무료 블로그 만들기](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/)라는 글이 가장 정리가 잘 된 것 같습니다. 이 블로그도 처음에는 [Nolboo님](https://nolboo.github.io)의 블로그 글을 따라가면서 제작했습니다.

[^saltfactory_2]: [saltfactory님](http://blog.saltfactory.net)의 블로그에도 [Jekyll을 사용하여 GitHub Pages 만들기](http://blog.saltfactory.net/jekyll/upgrade-github-pages-dependency-versions.html)라는 좋은 글이 있지만, [saltfactory님](http://blog.saltfactory.net)의 경우 Ruby 설치 방법과 Ruby 라이브러리들의 의존성에 대한 내용까지 추가되어 처음 Jekyll을 이용하는 사람이 보기에는 어려울 수도 있다고 봅니다. 참고로 GitHub Pages에서는 라이브러리들의 의존성 정보를 [Dependency versions](https://pages.github.com/versions/)라는 곳에서 제공합니다.

[^Jekyll_Documentation]: Jekyll의 동작 방식에 대한 설명은 [Jekyll Documentation](https://jekyllrb.com/docs/home/)에서 확인할 수 있습니다. 원문의 설명에 따르면 Jekyll은 정적 HTML 파일만 만들어 주기 때문에 일반 홈페이지 보다는 동적 요소가 거의없는 블로그 제작에 더 알맞다고 볼 수 있습니다.

[^Markdown]: 실제로 [Jekyll Documentation](https://jekyllrb.com/docs/home/)에서는 Markdown 이외에 [Textile](http://redcloth.org/textile)이라는 형식도 지원한다고 합니다. 사이트 설명을 보면 [Textile](http://redcloth.org/textile)도 간단한 Markup 언어이니까 사실상 Markdown과 비슷한 것임을 알 수 있습니다.

[^vjinn]: HTML을 신경쓰지 않고 Markdown으로 글을 쓸 경우의 장점에 대해서는 [vjinn님](https://vjinn.github.io)이 쓰신 글 [Jekyll, 이해와 시작](https://vjinn.github.io/environment/start-jekyll/)에 잘 나와 있습니다.

[^GitHub_Pages_Jekyll]: [GitHub Pages](https://pages.github.com)가 Jekyll을 지원하는 것은 [GitHub Pages](https://pages.github.com)의 글 [About GitHub Pages and Jekyll](https://help.github.com/articles/about-github-pages-and-jekyll/)에 설명되어 있습니다.

[^saltfactory_3]: 블로그 코드 버전 관리에 대한 내용은 [saltfactory님]이 쓰신 [Tistory에서 Jekyll을 이용하여 GitHub Pages로 블로그 이전](http://blog.saltfactory.net/note/renewal-blog-from-tistory-to-github-pages-via-jekyll.html)이란 글에서 `GitHub Pages` 부분에 잘 설명되어 있습니다.

---
layout: post
title:  "Jekyll 기반의 GitHub Pages에 블로그 만들기"
pagination: 
  enabled: true
comments: true
date:   2016-01-11 12:50:00 +0900
categories: Blog GitHub Jekyll Git
---

> 얼마전에 Jekyll 이 Theme 를 사용하는 방식으로 변경되었는데 이런 점을 반영해서 새로 [Jekyll: GitHub Pages 에 블로그 만들기]({% post_url 2017-03-05-Jekyll-Blog-with-Minima %}) 라는 글을 작성하였습니다.
>
> Jekyll 전반에 대한 내용을 알고자 하시면 이 글을 참고하시고 Jekyll 을 설치하고 테스트 하시려면 위 링크의 새 글을 보시는 것이 좋을 것 같습니다.

자신이 공부한 내용을 정리하는 데는 블로그만한 것이 없습니다. 블로그는 글을 쓰면서 생각을 정리하는 역할도 하지만 자신의 글들을 온라인 공간에 백업하는 역할도 겸하기 때문입니다.

하지만 블로그를 운영하기로 결심하고 나면 어떤 방법으로 제작할지 고심하게 됩니다. 세상에는 블로그를 만드는 여러가지 방법들 [^kalkin7] 이 있는데, 이왕이면 좀 더 편리하고 안전한 방법을 택하는 것이 좋을 것입니다. [^saltfactory_1] 그리하여 여러 방법들을 살펴보고 난 후 [Jekyll](http://jekyllrb.com) [^Jekyll] 기반의  [GitHub Pages](https://pages.github.com) [^GitHub] 를 사용해서 블로그를 제작하기로 결심했습니다.

이 글에서는 제가 블로그를 제작하면서 경험한 것들, 주변분들로부터 도움을 받은 내용들 [^cuspace], 그리고 인터넷에서 찾은 많은 분들의 자료들 [^Nolboo] 을 바탕으로 맥에서 Jekyll과 GitHub Pages를 이용하여 개인 블로그를 만드는 방법을 정리하고자 합니다. [^saltfactory_2]

우선 블로그를 만들기 전에 먼저 Jekyll이 무엇인지, 그리고 왜 블로그 호스팅에 GitHub Pages를 이용하는지 간단히 짚고 넘어가겠습니다.


### Jekyll 이란 무엇인가?

도대체 Jekyll이 무엇이길래 블로그를 만드는데 Jekyll을 사용하는 것일까요? 사실 Jekyll은 Markdown 형식의 텍스트 파일을 HTML 파일로 변환해 주는 하나의 변환 도구입니다. 이처럼 Jekyll이 HTML 파일을 만들어 주니까 사용자는 블로그에 글을 쓸 때 Markdown 으로 작성하면 되고 나중에 Jekyll 로 빌드해서 서버에 올리면 됩니다. [^Markdown]

변환된 HTML 파일을 웹 서버에 올리면 바로 홈페이지가 됩니다. [^Jekyll_Documentation] 즉 사용자는 웹페이지를 만들 때 HTML 을 신경쓰지 않고 Markdown 양식으로 자신의 컨텐츠에만 집중해서 글을 쓸 수 있게 됩니다. [^vjinn]

### 블로그 호스팅 서비스로 GitHub Pages 를 사용하는 이유

그런데 그냥 매번 HTML 파일을 직접 만드는 것이나 Jekyll 을 써서 Markdown 으로 매번 HTML 을 만들어 내는 것이나 별 차이가 없어 보입니다. 물론 HTML 템플릿 등을 써서 편하기는 하지만, 이것 만으로 Jekyll 을 사용하기에는 큰 의미가 없습니다.

하지만 블로그 호스팅 서비스로 GitHub Pages 를 사용하면 의미가 달라집니다. 왜냐하면 [GitHub Pages](https://pages.github.com) 는 Jekyll을 자체 지원하기 때문입니다. 이말은 사용자가 GitHub Pages 에 Markdown 문서를 올리면 이 문서를 자동으로 HTML 로 바꿔준다는 의미입니다. 따라서 GitHub Pages 에 새로운 Markdown 문서를 올리기만 하면 블로그를 자동으로 업데이트할 수 있게 됩니다. [^GitHub_Pages_Jekyll]


### Jekyll과 GitHub를 사용할 경우의 장점들

지금까지만 보더라도 GitHub Pages 에 블로그를 만들었을 때 얻을 수 있는 장점들이 어느 정도 보입니다.

하지만 가장 큰 장점은 GitHub 자체가 Git 을 위한 온라인 저장소를 제공하는 사이트라는 것입니다. 즉, GitHub Pages 에 블로그를 만들면 단순히 나의 글들을 온라인 상에 백업할 수 있을 뿐만 아니라 블로그에 대한 버전 관리를 할 수 있게 된다는 것을 뜻합니다. [^saltfactory_3] IT 개발자처럼 기술의 변화 속도가 빠른 분야에 있는 사람들은 블로그를 운영하더라도 수시로 글을 업데이트 해줘야 하는데 이런 점에서 GitHub Pages 는 엄청난 장점을 가집니다.

게다가 GitHub Pages 의 호스팅 서비스는 무료입니다. 이쯤되면 적어도 개발자라면 Jekyll 과 GitHub 로 블로그를 안 만드는 것이 이상할 정도입니다.

이제 Jekyll 과 GitHub Pages 에 대해서 살펴봤으니 본격적으로 Jekyll 을 이용하여 GitHub Pages 에 블로그를 만드는 방법에 대해서 알아보도록 하겠습니다.

### Jekyll 설치하기

이제 Jekyll 을 설치하도록 합니다.

원래는 Jekyll 을 사용하기 위해서는 먼저 Ruby 를 설치해야 합니다. 하지만 맥에는 Ruby 가 이미 설치되어 있습니다. 따라서 맥 사용자는 Ruby 를 따로 설치할 필요가 없이 바로 Jekyll 을 설치하면 됩니다.

맥의 터미널을 실행하고 아래와 같이 입력하여 Jekyll 을 설치합니다.

```sh
$ sudo gem install jekyll
```

> 여기서 gem은 Ruby 언어에서 서드파티 라이브러리를 설치하도록 도와주는 시스템입니다.


### Jekyll 로 지역 저장소에 블로그 만들기

Jekyll 을 설치했으니 Jekyll 로 블로그를 만들 차례입니다.

Jekyll 은 특정 폴더를 하나의 지역 저장소(local repository)로 삼아서 이를 기준으로 블로그를 관리합니다. 따라서, 지역 저장소가 위치할 폴더를 선택해서 그 곳으로 이동합니다. 맥에서 폴더의 이동은 `cd` 명령을 사용합니다.

```sh
$ cd local-repository-path/
```

그다음, 터미널에서 `jekyll new` 명령을 사용하여 블로그를 만듭니다. 아래처럼 `new` 명령어 뒤에 지역 저장소의 이름을 지정하면 됩니다.

```sh
$ jekyll new username.github.io
```

위에서 지역 저장소의 이름인 `username.github.io`는 나중에 GitHub Pages 에서 만들게 될 원격 저장소의 이름을 그대로 사용한 것입니다.

물론 지역 저장소의 이름을 원격 저장소와 같게 만들 필요는 없지만, 나중에 이름을 보고 바로 블로그 저장소임을 알아차릴 수 있도록 원격 저장소의 이름과 같게 두도록 합니다.

지역 저장소 내부를 보면 Jekyll이 지역 저장소 내부에 블로그의 뼈대가 될 기본 파일들을 생성한 것을 볼 수 있습니다. 그리고 기본 설정으로 블로그가 만들어졌으므로, 터미널에서 `jekyll serve` 를 입력하여 현재 지역 저장소에 있는 사이트를 실행할 수 있습니다.

```sh
$ jekyll serve
```

`jekyll serve`는 Jekyll 이 지역 환경에서 블로그가 제대로 구성되어 있는지 확인하기 위해 제공하는 서버입니다. 이 서버에 접속하려면 웹브라우저를 실행한 후 주소창에서 로컬 호스트 주소(`localhost:4000`)를 입력하면 됩니다.


### GitHub Pages로 원격 저장소 만들기

지금까지는 지역 환경에서 Jekyll 을 이용해서 블로그를 만든 것입니다. 하지만, 원격 서버에 등록된 것은 아니므로 자신의 컴퓨터에서만 확인가능합니다. 이를 실제 웹에서 확인하려면 호스팅 서비스에 올려야 합니다. GitHub 는 회원에게 무료 블로그 호스팅 서비스를 해주므로 GitHub에 온라인 저장소를 만든 다음 앞서 만든 로컬 저장소를 연동하면 됩니다. 그러면 두 저장소의 변경 내용을 동기화 시켜서 블로그를 관리할 수 있게 됩니다.

우선 [GitHub Pages](https://pages.github.com) 사이트에서 **create a repository** 메뉴를 이용하여 자신만의 원격 저장소를 만듭니다. 이 때 원격 저장소 이름은 `username.github.io`과 같이 형식을 맞춰줘야 합니다. (앞에서 지역 저장소에서 만든 이름은 이 원격 저장소의 이름에 따라 결정한 것입니다.)


### Git으로 블로그 변동 추적하고 원격 저장소 등록하기

이제 온전한 블로그를 위해 Jekyll로 만든 로컬 저장소와 GitHub로 만든 원격 저장소를 연결시켜줍니다. 이 과정은 Git으로 이루어지는데 협업 도구인 Git으로 코드를 관리하는 방식과 블로그의 두 저장소를 관리하는 방식은 본질상 같다고 볼 수 있습니다.

 우선 Jekyll로 만든 지역 저장소에서 `git init` 명령어를 사용하여 Git 저장소를 생성합니다. 이렇게 하면 해당 저장소의 변경 사항을 Git이 추적할 수 있게됩니다.

```sh
$ git init
```

이제 `git remote add` 명령어로 원격 저장소를 `origin`이라는 이름으로 등록합니다. 이제 origin을 사용하면 원격 저장소에 접근할 수 있습니다.

```sh
$ git remote add origin remote-repository-url
```

위에서 `remote-repository-url`은 보통 아래와 같은 주소가 되는데 이것은 GitHub Pages에서 확인할 수 있습니다. 이 부분을 자신의 원격 저장소의 주소로 대체하면 됩니다.

```sh
https://github.com/username/username.github.io.git
```


### 블로그 변동 사항을 지역 저장소에 저장하기

이제 블로그의 내용을 수정하면 이 변경 사항들은 지역 저장소에 저장되며 Git으로 관리됩니다. 블로그를 업데이트 한다는 것은 Git을 사용하여 지역 저장소의 내용을 원격 저장소로 `push`한다는 것과 같습니다. 이것은 변경 파일들을 Git으로 지역 저장소에 `add`하고, `commit`한 다음, 원격 저장소로 `push`하는 과정을 거칩니다.

만약 블로그에 파일이 변경되면 먼저 `git add` 명령어를 사용하여 지역 저장소에 변경 사항을 추가해야 합니다. (보다 자세한 내용은 Git 자체의 설명을 참고해야 합니다.)

```sh
$ git add .
```

여기서 `'.'`은 특정 파일만이 아니라 모든 변경 파일들을 추가하겠다는 의미입니다.

변경한다고 추가한 파일들을 로컬 저장소에 등록하려면 `git commit` 명령어를 사용합니다. 아래에 `git commit`을 사용하는 방법이 나오는데 뒤의 `-m`은 간단하게 어떤 이유료 파일을 변경하게 되었는지 메시지를 붙인다는 의미이고, 뒤에 이어지는 ``"message"`` 에 해당 변경에 대한 내용을 간단하게 작성하면 됩니다.

```sh
$ git commit -m "message"
```

`add`와 `commit`을 하면 블로그의 변경 내용들이 지역 저장소에 저장 완료됩니다. 물론 이것은 지역 저장소에서만 변경된 것이므로 `jekyll serve`로 지역 환경에서는 확인이 가능하지만, 실제 블로그가 업데이트 된 것은 아닙니다.


### 지역 저장소의 내용을 원격 저장소로 push하여 블로그 업데이트 하기

이제 로컬 저장소에 저장된 내용을 원격 저장소로 옮겨주면 블로그가 업데이트 됩니다. 이것은 다음과 같이 `git push` 명령어를 사용하면 됩니다.

앞에서 이미 원격 저장소를 `origin`이라는 이름으로 등록을 했었습니다. 따라서 아래의 문장은 지역 저장소의 master에 있는 내용을 원격 저장소인 origin으로 `push`하겠다는 의미가 됩니다.

```sh
$ git push origin master
```

위와 같이 하면, 현재 지역 저장소에 있는 내용들이 원격 저장소로 옮겨지면서 블로그가 업데이트 됩니다.

> 보통 코드 관리를 할 경우 지역 저장소에 다수의 branch를 만들게 되는데, 블로그의 경우는 master만으로도 충분하므로 따로 branch 관리를 해 줄 필요는 많지 않습니다.


### 확인하기

위의 과정을 모두 마치면 `http://username.github.io`의 주소로 블로그가 업데이트 된 것을 볼 수 있습니다. GitHub에서 실시간으로 Jekyll을 수행해서 업데이트가 바로 되긴 하지만 경우에 따라서 서버의 응답이 느리거나 브라우저의 캐싱 등으로 인해 당장 변화가 없을 수는 있습니다. 이럴 때는 본인의 GitHub 계정으로 가서 자신의 블로그 소스들이 제대로 업로드 됐는지 확인해보면 됩니다.


### 고찰하기

이제 Jekyll과 GitHub로 블로그를 만드는 방법에 대해서 알아보았습니다. 어차피 새로운 기술은 언제나 등장하기 마련이고 언제나 모르는 것은 있기 마련이므로 모든 것을 한 번에 다 알아서 하려고 하기보다 직접 만져보고 경험해보면 금방 감을 잡을 수 있을 것입니다.

최근에 GitHub에서 LFS(Large File Storage)라는 것을 지원하기 시작했는데, 앞으로 해당 부분의 내용들을 비롯해서 Git에 대한 추가 정보, Ruby 라이브러리 관련 추가 정보 등을 업데이트 할 예정입니다.

### 관련 자료

* 새 버전의 Jekyll 을 설치하고 사용하는 방법에 대해서는 [Jekyll: GitHub Pages 에 블로그 만들기]({% post_url 2017-03-05-Jekyll-Blog-with-Minima %}) 글을 참고하시기 바랍니다.
* Jekyll 블로그에 새 블로그 글을 포스트 하는 방법은 [MarkDown 문서를 이용하여 블로그에 포스트하기]({% post_url 2016-01-12-Post-a-new-MarkDown-file %}) 글을 보도록 합니다.
* Jekyll 로 만든 블로그에 댓글 달기 기능 추가하기 위해서 Disqus 를 사용하는 방법을 알고 싶다면 [Jekyll: Disqus 연결부터 마이그레이션까지]({% post_url 2017-01-21-Add-Disqus-to-Jekyll %}) 글을 보도록 합니다.

### 참고 자료

[^kalkin7]: 블로그를 운영하는 방식의 종류와 각 방식들의 장단점에 대한 내용은 [kalkin7님](http://blog.kalkin7.com)이 쓰신 [내 글을 오래 남기기 위한 블로그 선택](http://blog.kalkin7.com/2015/07/07/maintain-a-blog-for-a-long-time/)이란 글에 잘 정리되어 있습니다. [kalkin7님](http://blog.kalkin7.com)의 글에는 Jekyll과 GitHub를 사용하여 블로깅을 할 경우의 장점에 대해서도 잘 정리되어 있습니다.

[^saltfactory_1]: [saltfactory님](http://blog.saltfactory.net)이 쓰신 [Tistory에서 Jekyll을 이용하여 GitHub Pages로 블로그 이전](http://blog.saltfactory.net/note/renewal-blog-from-tistory-to-github-pages-via-jekyll.html)이란 글에도 Jekyll과 GitHub의 장점이 잘 나와 있습니다. 무엇보다 [saltfactory님](http://blog.saltfactory.net)의 경우 블로그 자체에 좋은 글들이 정말 많습니다.

[^Jekyll]: Jekyll의 공식 사이트는 [http://jekyllrb.com](http://jekyllrb.com)입니다. 언제부터인지 모르겠는데 [한글 사이트](http://jekyllrb-ko.github.io)도 제공하고 있습니다.

[^GitHub]: GitHub의 공식 사이트는 [https://github.com](https://github.com)이며, GitHub에서 호스팅 서비스를 지원하는 곳은 [GitHub Pages](https://pages.github.com)입니다.

[^cuspace]: 제가 Jekyll로 블로그를 운영하게 된 데에는 [모두의연구소](http://www.modulabs.co.kr)에서 [VRtooN 연구실](http://www.modulabs.co.kr/#!vrtoon/cl0n)을 이끌고 계시는 [박민수님](https://cuspace.github.io)의 도움이 컸습니다. 박민수님은 개인적으로 [VR 관련 블로그](https://cuspace.github.io)를 Jekyll과 GitHub를 사용해서 운영하고 있습니다.

[^Nolboo]: Jekyll 관련 자료 중에서 한글로 된 포스트 중에서는 [Nolboo님](https://nolboo.github.io)이 정리하신 [지킬로 깃허브에 무료 블로그 만들기](https://nolboo.github.io/blog/2013/10/15/free-blog-with-github-jekyll/)라는 글이 가장 정리가 잘 된 것 같습니다. 이 블로그도 처음에는 [Nolboo님](https://nolboo.github.io)의 블로그 글을 따라 실습하면서 제작했습니다.

[^saltfactory_2]: [saltfactory님](http://blog.saltfactory.net)의 블로그에도 [Jekyll을 사용하여 GitHub Pages 만들기](http://blog.saltfactory.net/jekyll/upgrade-github-pages-dependency-versions.html)라는 좋은 글이 있지만, [saltfactory님](http://blog.saltfactory.net)의 경우 Ruby 설치 방법과 Ruby 라이브러리들의 의존성에 대한 내용까지 추가되어 처음 Jekyll을 이용하는 사람이 보기에는 어려울 수 있습니다. 참고로 GitHub Pages에서는 라이브러리들의 의존성 정보를 [Dependency versions](https://pages.github.com/versions/)라는 곳에서 제공합니다.

[^Jekyll_Documentation]: Jekyll의 동작 방식에 대한 설명은 [Jekyll Documentation](https://jekyllrb.com/docs/home/)에서 확인할 수 있습니다. 원문의 설명에 따르면 Jekyll은 정적 HTML 파일만 만들어 준다고 합니다. 따라서 Jekyll은 동적 요소가 많은 일반 홈페이지 보다는 동적 요소가 거의 필요없는 블로그 제작에 더 알맞다고 볼 수 있습니다.

[^Markdown]: 실제로 [Jekyll Documentation](https://jekyllrb.com/docs/home/)에서는 Markdown 이외에 [Textile](http://redcloth.org/textile)이라는 형식도 지원한다고 합니다. 사이트 설명을 보면 [Textile](http://redcloth.org/textile)도 간단한 Markup 언어이니까 사실상 Markdown과 비슷한 것임을 알 수 있습니다.

[^vjinn]: HTML을 신경쓰지 않고 Markdown으로 글을 쓸 경우의 장점에 대해서는 [vjinn님](https://vjinn.github.io)이 쓰신 글 [Jekyll, 이해와 시작](https://vjinn.github.io/environment/start-jekyll/)에 잘 나와 있습니다.

[^GitHub_Pages_Jekyll]: [GitHub Pages](https://pages.github.com)가 Jekyll을 지원하는 것은 [GitHub Pages](https://pages.github.com)의 글 [About GitHub Pages and Jekyll](https://help.github.com/articles/about-github-pages-and-jekyll/)에 설명되어 있습니다.

[^saltfactory_3]: 블로그 코드 버전 관리에 대한 내용은 [saltfactory님](http://blog.saltfactory.net)이 쓰신 [Tistory에서 Jekyll을 이용하여 GitHub Pages로 블로그 이전](http://blog.saltfactory.net/note/renewal-blog-from-tistory-to-github-pages-via-jekyll.html)이란 글에서 **GitHub Pages** 부분에 잘 설명되어 있습니다.

---
layout: post
pagination:
  enabled: true
comments: true
title:  "Jekyll: GitHub Pages 에 블로그 만들기"
date: 2017-03-05 02:00:00 +0900
categories: Blog GitHub-Pages Jekyll Minima Theme
redirect_from: "/blog/github/pages/jekyll/minima/theme/2017/03/04/Jekyll-Blog-with-Minima.html"
---

> 이 글은 GitHub Pages 에서 지원하는 Jekyll 로 블로그를 만드는 방밥을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하고 설정하는 방법에 대한 전체 내용은 [Jekyll: 블로그 제작의 모든 것]({% post_url 2020-05-06-Jekyll-Blog %}) 을 보도록 합니다.

## Jekyll: GitHub Pages 에 블로그 만들기

제가 블로그를 만들면서 처음으로 작성한 글은 [Jekyll 기반의 GitHub Pages에 블로그 만들기]({% post_url 2016-01-11-Make-a-blog-with-Jekyll %}) 라는 글입니다. 즉 Jekyll 로 블로그를 만들면서 그 과정을 자연스럽게 글로 정리를 한 것이었습니다.

그런데 최근 Jekyll 의 구조가 제가 처음에 익히던 때와는 많이 달라졌다는 것을 알게 되었습니다. 따라서 예전에 정리한 설명도 지금과는 맞지 않는 부분이 생겼습니다.

그래서 달라진 부분을 익히기도 할 겸 Jekyll 관련 글을 다시 정리하게 되었습니다. 원글 자체를 고치려고 했는데 나름 제가 올린 첫번째 글이기도 하고 초창기의 어설픈 모습들을 볼 수 있는 자료이기도 해서 원글은 그대로 두고 아예 새 글을 쓰게 되었습니다.

### 들어가며

일단 예전에 제가 작성한 글에서는 Jekyll 을 설치하고 GitHub Pages 에 저장소를 만들었습니다. 하지만 솔직히 말해서 Jekyll 과 Git 을 알아야만 GitHub Pages 에 블로그를 만들 수 있는 것은 아닙니다. [^blog]

오히려 반대로 GitHub Pages 에 블로그를 만들고 운영해보면서 그 과정에서 자연스럽게 Jekyll 과 Git 의 사용법을 익혀가는 것이 보다 쉬운 접근 방법입니다.

따라서 이번 글에서는 GitHub Pages 라는 GitHub 의 호스팅 서비스를 중심으로 내용을 전개합니다.

### GitHub Pages 에 블로그용 저장소 만들기

GitHub Pages 에 블로그를 만드는 것은 그냥 GitHub 에 원격 저장소 하나를 만드는 것과 완전히 동일합니다. 방법은 [GitHub Pages](https://pages.github.com) 페이지에 있는 ① ~ ④ 번 설명을 그대로 따라하면 됩니다.

#### GitHub Pages 에 계정 만들기

가장 먼저 GitHub Pages 에 저장소를 만듭니다. [^login] 이를 위해서는 [GitHub Pages](https://pages.github.com) 홈페이지에서 스크롤을 내리면 ① 번으로 나오는 설명에서 [Create a repository](https://github.com/new) 링크를 누르면 됩니다.

그러면 **Create a repository** 페이지로 이동하는데 **Repository name** 부분에 자신의 아이디 (username) 를 사용해서 `username.github.io` 와 같이 입력합니다. 만약 자신의 아이디가 xyz 라면 `xyz.github.io` 라고 입력하고 맨 밑의 Create Reposity 버튼을 누릅니다. [^create]

#### Quick setup

그러면 GitHub Pages 는 username 계정에 username.github.io 라는 저장소를 만든 후 **Quick setup - ...** 이라는 페이지로 이동합니다.

이 페이지는 여러 가지 방법으로 Git 명령을 사용해서 저장소에 블로그를 올리는 방법을 설명합니다. 각각의 Git 명령들은 여러번 실습하다 보면 자연스럽게 익힐 수 있으니 지금 당장은 몰라도 상관없습니다.

이 방법들 중에서 가장 간단한 방법은 그냥 저장소를 클론 (clone) 받는 것입니다.

#### GitHub Pages 저장소 클론 받기

저장소를 클론 받을려면 자신의 OS 에 맞는 설명을 따라하면 됩니다. [GitHub Pages](https://pages.github.com) 페이지의 **What git client are you using?** 메뉴에서 원하는 것을 선택하면 ② 번 부분의 **Clone the repository** 에서 방법을 알려줍니다.

터미널의 경우 아래와 같은 명령으로 클론받을 수 있습니다. 물론 `username` 부분은 자신의 아이디로 바꿔줘야 합니다. [^clone]

```sh
$ git clone https://github.com/username/username.github.io
```

이제 이렇게 클론 받은 저장소를 Jekyll 로 만든 블로그로 채워서 GitHub Pages 에 올리면 됩니다. [^github-jekyll]

#### 블로그 수정하고 배포해보기

[GitHub Pages](https://pages.github.com) 페이지에 있는 ③, ④ 번 설명은 따라해도 되고 건너뛰어도 됩니다. 이 부분은 **username.github.io** 폴더에 **index.html** 파일을 만든 다음 GitHub Pages 저장소로 내보내는 것을 실습합니다.

순서대로 따라 진행한 후 브라우저에서 `http://username.github.io` 라고 주소를 입력하면 `Hello World` 가 나타납니다. 꽤 간단하다는 것을 알 수 있습니다.

어차피 Jekyll 로 덮어쓸 저장소라 굳이 안해도 상관없습니다.

### Jekyll 로 블로그 만들기

GitHub Pages 는 [Jekyll Theme Chooser](https://help.github.com/articles/about-github-pages-and-jekyll/) 라는 것을 사용해서 Jekyll 을 설치하지 않고도 블로그를 제작하고 편집할 수 있는 방법도 제공합니다. [^using-theme]

하지만 여기서는 컴퓨터에 직접 Jekyll 을 설치해서 블로그를 만드는 방법을 설명합니다. [^setting-jekyll]

#### Ruby 설치하기

일단 Jekyll 자체가 하나의 Ruby 패키지 입니다. 즉, Jekyll 을 사용하려면 Ruby 가 있어야 합니다. 각 운영체제별로 Ruby 를 설치하는 방법은 다음과 같습니다.

* 맥 사용자라면 Ruby 를 설치할 필요가 없습니다. 왜냐면 macOS 에는 이미 Ruby 가 설치되어 있기 때문입니다.

* 윈도우 사용자라면 [Hurderella](http://hurderella.tistory.com) 님이 정리하신 [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131) 라는 글을 보면 될 것 같습니다. [^hurderella-131]

* 리눅스 (Linux)	사용자라면 각 배포판 별로 패키지 관리자를 사용해서 설치하면 되는데, 우분투 (Ubuntu) 라면 다음과 같이 설치할 수 있습니다.

	```sh
	$ sudo apt-get install ruby-full
	```

#### Jekyll 설치하기

Ruby 를 설치했으면 다음과 같이 Gem 이라는 Ruby 의 패키지 관리자를 사용해서 Jekyll 을 설치합니다. 여기서 [예전]({% post_url 2016-01-11-Make-a-blog-with-Jekyll %}) 과 다르게 `jekyll` 뿐만 아니라 `bundler` 도 같이 설치합니다. [^bundler]

```sh
$ sudo gem install jekyll bundler
```

#### Jekyll 로 로컬에 블로그 만들기

Jekyll 로 새 블로그를 만들려면 블로그를 저장할 폴더로 이동해서 다음과 같은 명령을 실행합니다. 아래에서 **my-awesome-site** 부분은 어차피 나중에 지울 거라서 이름을 아무렇게나 지어도 됩니다.

```sh
$ jekyll new my-awesome-site
```

그러면 **my-awesome-site** 라는 폴더가 생기고 그 아래에 다음과 같은 파일 및 폴더들이 생깁니다.

```sh
.
├── Gemfile
├── Gemfile.lock
├── _config.yml
├── _posts
│   └── 2017-03-05-welcome-to-jekyll.markdown
├── about.md
└── index.md
```

최근의 Jekyll 은 `minima` 라는 테마를 사용하기 때문에, 예전과는 다르게 **Gemfile** 등을 써서 패키지들의 의존성을 관리하고 있음을 알 수 있습니다.

#### 로컬에서 Jekyll 블로그 테스트하기

다음의 명령을 사용해서 Jekyll 블로그를 로컬에서 빌드하고 실행합니다.

```sh
$ bundle exec jekyll serve
```

브라우저를 실행하고 주소창에 `http://localhost:4000` 를 입력하면 다음과 같은 페이지를 볼 수 있습니다.

![Jekyll 실행 결과](/assets/jekyll/jekyll-result.jpeg)

이로써 자신의 컴퓨터에서 Jekyll 블로그를 만들 수 있는 환경을 갖추었습니다.

### GitHub Pages 에 블로그 배포하기

이제 새로 만든 Jekyll 블로그를 GitHub Pages 에 올려서 모든 사람이 볼 수 있도록 해 봅시다.

#### 로컬 블로그 내용을 클론받은 저장소로 옮기기

우선 **my-awesome-site** 폴더에 있는 내용을 클론받은 저장소로 옮깁니다. 맥에서는 GitHub Pages 에서 클론받은 폴더로 이동한 다음, 다음과 같은 명령을 사용합니다. **...** 부분은 **my-awesome-site/** 폴더가 있는 절대 경로를 넣어주면 됩니다.

```sh
$ cp -r .../my-awesome-site/ ./
```

Jekyll 로 만들어진 사이트에는 숨김 파일도 있는데 이들도 빠짐없이 옮겨야 합니다.

#### 로컬 저장소의 변경 저장하기

이제 로컬 저장소에서 다음과 같은 명령을 사용하여 블로그의 변경 내력을 Git 에 커밋합니다. [^git]

```sh
$ git add .
$ git commit -m "my first blog"
```

#### GitHub Pages 에 변경된 블로그 배포하기

지금까지 GitHub Pages 에 호스트용 원격 저장소를 만들었고, Jekyll 로 블로그를 만들었으며, 이를 로컬 저장소로 옮겼습니다.

이 로컬 저장소의 내용을 그대로 원격 저장소로 업로드하면 블로그를 배포하게 되는 것입니다. GitHub 에서는 이를 Git 의 `push` 명령으로 실행할 수 있습니다.

```sh
$ git push origin master
```

GitHub Pages 에서 클론 받았기 때문에 따로 `git remote` 명령으로 원격 저장소를 등록하지 않아도 서버에 `push` 할 수 있음을 알 수 있습니다.

이제 브라우저로 `http://username.github.io` 에 접속해보면 앞에서 테스트한 것과 같은 페이지가 보이는 것을 볼 수 있습니다.

축하합니다! 모든 과정은 끝났으니 이제 열심히 블로그를 작성할 일만 남았습니다.

### 고찰하기

변경되거나 추가된 파일들 특히 **Gemfile** 들에 대한 정리가 필요합니다. 이 부분은 차차 정리할 예정입니다.

### 관련 자료

* 예전 버전의 Jekyll 로 블로그를 만드는 방법에 대해서는 [Jekyll 기반의 GitHub Pages에 블로그 만들기]({% post_url 2016-01-11-Make-a-blog-with-Jekyll %}) 을 보도록 합니다.
* Jekyll 블로그에 새 블로그 글을 포스트 하는 방법은 [MarkDown 문서를 이용하여 블로그에 포스트하기]({% post_url 2016-01-12-Post-a-new-MarkDown-file %}) 을 보도록 합니다.
* Jekyll 로 만든 블로그에 댓글 달기 기능 추가하기 위해서 Disqus 를 사용하는 방법을 알고 싶다면 [Jekyll: Disqus 연결부터 마이그레이션까지]({% post_url 2017-01-21-Add-Disqus-to-Jekyll %}) 를 보도록 합니다.

### 참고 자료

[^blog]: 좀 극단적으로 말하면 Git 을 몰라도 GitHub Pages 에 블로그를 올릴 수 있고, Jekyll 을 설치하지 않아도 블로그를 만들 수 있습니다.

[^login]: GitHub Pages 에 저장소를 만들려면 일단 GitHub 에 회원 가입이 되어 있어야 합니다. GitHub Pages 자체가 GitHub 의 하나의 서비스이기 때문입니다.

[^create]: 필요에 따라 블로그 저장소의 맨 앞에 **README** 파일을 넣어줄 수도 있고, 처음부터 **.gitignore** 파일을 만들어 줄 수도 있습니다만, 이건 나중에라도 만들어 줄 수 있는 것이이므로 지금 단계에서는 몰라도 됩니다.

[^clone]: 사실 지금은 비어있는 저장소라 딱히 클론받을 필요는 없지만 클론을 받게 되면 로컬에 자연스럽게 원격 저장소와 같은 이름의 폴더가 생기고 Git 이 이미 설정된 채로 받아지므로 `git init` 과 `git remote` 등을 할 필요가 없는 장점이 있습니다.

[^github-jekyll]: [About GitHub Pages and Jekyll](https://help.github.com/articles/about-github-pages-and-jekyll/) 글과 [Using a static site generator other than Jekyll](https://help.github.com/articles/using-a-static-site-generator-other-than-jekyll/) 글에 따르면 GitHub Pages 에는 모든 정적 사이트 생성기를 다 사용할 수 있지만, 공식 지원하는 것은 Jekyll 하나라고 합니다.

[^using-theme]: Jekyll Theme Chooser를 사용해서 Jekyll 블로그를 만드는 방법은 [Creating a GitHub Pages site with the Jekyll Theme Chooser](https://help.github.com/articles/creating-a-github-pages-site-with-the-jekyll-theme-chooser/) 글을 참고합니다.

[^setting-jekyll]: 컴퓨터에 Jekyll 을 설치하고 사용하는 방법은 GitHub Pages 의 [Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/) 글에도 설명되어 있지만 여기서는 일단 좀더 간단한 방법인 [Jekyll](https://jekyllrb.com) 홈페이지에 있는 설명을 참고하도록 합니다.

[^hurderella-131]: Hurderella 님의 [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131) 라는 글을 보면 윈도우즈에서는 [RubyInstaller](https://rubyinstaller.org) 를 다운로드 받아서 ruby 를 설치하면 된다고 합니다.

[^bundler]: Ruby 에서는 하나의 패키지를 젬 (Gem; 보석) 이라는 용어로 부르는데 `bundler` 는 다른 루비 젬들을 관리하는 젬입니다.

[^git]: 각 명령에 대한 설명은 따로 정리할 예정이지만 예전 글인 [Jekyll 기반의 GitHub Pages에 블로그 만들기]({% post_url 2016-01-11-Make-a-blog-with-Jekyll %}) 에도 설명이 조금 있습니다.

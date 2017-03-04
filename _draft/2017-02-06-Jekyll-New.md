제가 블로그를 만들면서 처음으로 작성한 글은 [Jekyll 기반의 GitHub Pages에 블로그 만들기](http://xho95.github.io/blog/github/jekyll/git/2016/01/11/Make-a-blog-with-Jekyll.html) 라는 글입니다. 즉 Jekyll 로 블로그를 만들면서 그 과정을 자연스럽게 글로 정리를 한 것이었습니다.

그런데 최근 Jekyll 의 구조가 제가 처음에 익히던 때와는 많이 달라졌다는 것을 알게 되었습니다. 따라서 예전에 정리한 설명도 지금과는 맞지 않는 부분이 생겼습니다.

그래서 달라진 부분을 익히기도 할 겸 Jekyll 관련 글을 다시 정리하게 되었습니다. 원글 자체를 고치려고 했는데 나름 제가 올린 첫번째 글이기도 하고 초창기의 어설픈 모습들을 볼 수 있는 자료이기도 해서 원글은 그대로 두고 아예 새 글을 쓰게 되었습니다.

### 들어가며

일단 예전에 제가 작성한 글에서는 Jekyll 을 설치하고 GitHub Pages 에 저장소를 만들었습니다. 하지만 솔직히 말해서 Jekyll 과 Git 을 알아야만 GitHub Pages 에 블로그를 만들 수 있는 것은 아닙니다. 

오히려 반대로 GitHub Pages 에 블로그를 만들고 운영해보면서 그 과정에서 자연스럽게 Jekyll 과 Git 의 사용법을 익혀가는 것이 보다 쉬운 접근 방법입니다. [^blog]

따라서 이번 글에서는 GitHub Pages 라는 GitHub 의 호스팅 서비스를 중심으로 내용을 전개합니다. 

### GitHub Pages 에 블로그용 저장소 만들기

GitHub Pages 에 블로그를 만드는 것은 그냥 GitHub 에 원격 저장소 하나를 만드는 것과 완전히 동일합니다. 방법은 [GitHub Pages](https://pages.github.com) 페이지에 있는 ① ~ ④ 번 설명을 그대로 따라하면 됩니다. [^login]

#### GitHub Pages 에 계정 만들기

가장 먼저 GitHub Pages 에 자기의 계정을 만들어 줍니다. 계정은 [GitHub Pages](https://pages.github.com) 홈페이지에서 스크롤을 내리면 ① 번으로 나오는 설명에서 [Create a repository](https://github.com/new) 메뉴에서 만들면 됩니다.

GitHub 계정당 1개의 사이트를 만들 수 있으므로 자신의 아이디 (username) 를 사용해서 `username.github.io` 과 같은 방식으로 만듭니다. 만약 자신의 아이디가 xyz 라면 **Repository name** 부분에 `xyz.github.io` 라고 입력하고 맨 밑의 Create Reposity 버튼을 누릅니다. [^create]

#### Quick setup

그러면 GitHub Pages 는 username 계정에 username.github.io 라는 저장소를 만들고 나서 **Quick setup - ...** 이라는 페이지를 보여줍니다.

이 페이지는 여러 가지 방법으로 Git 을 사용해서 GitHub Pages 의 원격 저장소에 블로그를 올리는 방법을 소개하고 있습니다. 각각의 Git 명령들은 여러번 실습하다 보면 자연스럽게 익힐 수 있으니 지금 당장은 몰라도 상관없습니다.

이중에서 가장 간단한 방법은 그냥 이 저장소의 내용을 클론 (clone) 받는 것입니다.

#### GitHub Pages 블로그 클론 받기

클론을 받을려면 자신의 OS 에 맞는 설명을 따라하면 됩니다. [GitHub Pages](https://pages.github.com) 페이지의 **What git client are you using?** 메뉴에서 원하는 것을 선택하면 ② 번으로 나오는 **Clone the repository** 에서 방법을 알려줍니다.

터미널을 선택할 경우 아래와 같은 명령으로 클론받을 수 있습니다. 물론 `username` 부분은 자신의 아이디로 바꿔줘야 합니다. [^clone]

```sh
$ git clone https://github.com/username/username.github.io
```

이제 이렇게 클론 받은 내용을 Jekyll 로 만든 블로그로 바꿔서 GitHub Pages 에 올리게 될 것입니다.

#### 블로그 수정하고 배포해보기

[GitHub Pages](https://pages.github.com) 페이지에 있는 ③, ④ 번 설명은 따라해봐도 되고 건너뛰어도 됩니다. 이 과정은 **username.github.io** 폴더에 **index.html** 파일을 만든 다음 GitHub Pages 저장소로 내보내는 과정을 실습하기 위한 것입니다.

순서대로 따라 진행한 후 브라우저에서 http://username.github.io 주소를 입력하면 `Hello World` 가 나타납니다. 꽤 간단하다는 것을 알 수 있습니다.

### Jekyll 사용하기

이 시점에서 로컬에 Jekyll 을 설치하는 이유는 GitHub Pages 저장소에 있는 블로그 양식을 Jekyll 이 지원하는 양식으로 대체하기 위해서입니다. 

이 부분에 대해서는 GitHub Pages 홈페이지의 맨 아래에 있는 [Blogging with Jekyll](https://pages.github.com) 글을 참고하면 됩니다. 

사실 GitHub Pages는 모든 정적 사이트 생성기를 다 사용할 수 있지만, 공식 지원하는 것은 Jekyll 하나라고 합니다. [^about-github-pages-and-jekyll] [^using-a-static-site-generator-other-than-jekyll]

GitHub Pages 에서 설명하는 Jekyll 의 장점은 다음과 같습니다.

* HTML 대신에 Markdown 을 쓸 수 있습니다. Markdown 은 읽고 쓰기가 더 쉽습니다.
* CSS 파일을 복사하지 않고도 Jekyll 테마를 사이트에 추가할 수 있습니다.
* Jekyll Theme Chooser 를 사용하면 새로운 사이트를 빠르게 만들 수 있습니다.
* headers 와 footers 같은 공통 템플릿을 사용해서 여러 파일들에 적용할 수 있습니다.
* GitHub Pages 를 사용하면 사이트 빌드 과정이 간단해 집니다.
 
사실 GitHub Pages 를 사용하면 블로그를 사용자가 빌드하지 않습니다. GitHub Pages 에서 자동으로 사이트를 빌드하기 때문입니다. 따라서 변경된 파일들을 저장소에 내보내기 하기만 하면 됩니다.

로컬에서 Jekyll 을 설치하고 사용하는 방법은 GitHub Pages 의 [Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/) 글을 참고하면 됩니다. [^setting-up-your-github-pages-site-locally-with-jekyll]

물론 Jekyll 공식 홈페이지의 설명을 봐도 되는데, 두 글을 비교해서 정리하도록 하겠습니다.

#### Ruby 설치하기

#### Bundler 설치하기

Bundler는 Ruby gem 의 의존성을 관리하는 도구라고 합니다. 설치는 아래와 같이 할 수 있습니다. 이 때 Ruby는 2.1.0 이상의 버전이어야 합니다.

```
$ gem install bundler
```
  
#### Jekyll 설치하기

GitHub Pages 에서 설명하는 Bundler를 이용하여 Jekyll을 설치하는 방법과 Jekyll 공식 홈페이지에서 사용하는 Jekyll, Bundler 를 같이 설치하는 방법에 대한 설명이 조금 다른 것 같습니다. 각각의 차이에 대해서 정리할 필요가 있을 것 같습니다.

그리고, 윈도우즈 사용자의 경우 Jekyll 을 직접 설치하지 않고 사용하는 방법에 대해서 알아봅니다.

#### Jekyll 업데이트 하기 

Jekyll은 활발히 활동하는 오픈 소스 프로젝트이므로 자주 업데이트가 발생하며, GitHub Pages 서버도 업데이트가 일어나므로, 설치된 소프트웨어의 버전이 낮아서 여러 문제가 발생할 수 있습니다. 따라서 

### 고찰하기


### 참고 자료

[^blog]: 좀 극단적으로 말하면 Git 을 몰라도 GitHub Pages 에 블로그를 올릴 수 있고, Jekyll 을 설치하지 않아도 블로그를 만들 수 있습니다.

[^login]: GitHub Pages 에 저장소를 만들려면 일단 GitHub 에 회원 가입이 되어 있어야 합니다. GitHub Pages 자체가 GitHub 의 하나의 서비스이기 때문입니다.

[^create]: 필요에 따라 블로그 저장소의 맨 앞에 **README** 파일을 넣어줄 수도 있고, 처음부터 **.gitignore** 파일을 만들어 줄 수도 있습니다만, 이건 나중에라도 만들어 줄 수 있는 것이이므로 지금 단계에서는 몰라도 됩니다.

[^clone]: 사실 지금은 비어있는 저장소라 딱히 클론받을 필요는 없지만 클론을 받게 되면 로컬에 자연스럽게 원격 저장소와 같은 이름의 폴더가 생기고 Git 이 이미 설정된 채로 받아지므로 `git init` 과 `git remote` 등을 할 필요가 없는 장점이 있습니다.

[^about-github-pages-and-jekyll]: [About GitHub Pages and Jekyll](https://help.github.com/articles/about-github-pages-and-jekyll/)

[^using-a-static-site-generator-other-than-jekyll]: [Using a static site generator other than Jekyll](https://help.github.com/articles/using-a-static-site-generator-other-than-jekyll/) : GitHub Pages 에서 Jekyll 이외의 정적 사이트 생성기를 사용하는 방법입니다. 결국 로컬에서 사이트 빌드를 한 다음 원격 저장소에 내보내면 되는 것 같습니다.

[^setting-up-your-github-pages-site-locally-with-jekyll]: [Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/)

[^hurderella-131]: [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131)

[^whatap--jekyll-on-windows]: [Jekyll 윈도우에 설치해서 사용하기](http://tech.whatap.io/2015/09/11/install-jekyll-on-windows/)

### 들어가며 

최근에 Jekyll 이 버전업 하면서 달라진 부분도 있고 해서 Jekyll 관련 글을 새로 정리합니다. 기존 글을 덮어서 수정하려고 했지만 제가 블로그를 만들면서 쓴 첫 글이라 상징성이 있어서 그대로 둡니다. 

처음에 Jekyll 관련 글을 쓸 때에는 저도 사실 잘 모르고 쓴 부분도 있고 다른 분들의 자료를 참고하고 정리하면서 쓴 글이라 지금 보면 어색하고 좀 어렵게 접근한 부분이 많습니다. 이번에는 최대한 실제 내용 위주로 간결하게 정리하려고 합니다.

그와 동시에 기존 버전의 Jekyll 사용자가 어떻게 새 버전의 Jekyll 로 업데이트하면 되는지에 대해서도 정리하려고 합니다.

### 목차

1. 왜 Jekyll 관련 글을 다시 작성하는가? - 세가지 이유
    1. GitHub 에 중심을 두는 것이 중요
    	* 주위 분들에게 설명하면서 Jekyll 을 설명하려는 것 보다 GitHub Pages 에 블로그를 만드는 순서로 자연스럽게 설명하는 것이 좋다는 생각을 하게 됨
    	* Jekyll 과 Git 의 이해는 그 다음 문제  
    	
    2. 윈도우즈 사용자 고려
    	* 가능은 하지만 cgwin 등 불편한 요소 존재 - 꼼수 테스트 필요
    	* Jekyll 자체는 GitHub Pages 에서 동작하고 있으므로 로컬에 Jekyll 을 설치하는 것은 엄청 중요한 문제는 아닐 수 있음
    	* Jekyll 을 설치하지 않게 되면 Jekyll 을 설치하는데 필요한 Ruby 등을 따로 설치할 필요가 없어짐
    	* 원칙을 따르는 방법은 [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131) 와 [Jekyll 윈도우에 설치해서 사용하기](http://tech.whatap.io/2015/09/11/install-jekyll-on-windows/) 라는 두개의 글을 참고합니다. [^hurderella-131] [^whatap--jekyll-on-windows]
    	
    3. Jekyll 버전에 따른 변화
		* minima 등 gem-based theme 를 사용하는 변화 일어남
    	
2. GitHub Pages 에 계정 및 저장소 만들기
3. Jekyll 다운 받고 블로그 양식 만들기 : 윈도우즈 사용자들은 4번으로 이동하는 링크 넣기
4. 윈도우즈에서 Jekyll 블로그 만들기 : Jekyll 다운 필요없이 기초 양식을 저장소에서 받으면 됨
5. 마크다운 문서로 블로그 내용 채우기
6. git push 로 GitHub Pages 에 블로그 배포하기

### 추가 목차

7. Git 명령 이해하기 : 블로그를 Git으로 버전 관리할 수 있음
8. Jekyll 내부 구조 이해하기 : yaml 및 liquid 문법 이해하기
9. Disqus 게시판 달기 : 댓글 시스템 등의 동적 요소 추가하기
10. 테마 적용으로 블로그 꾸미기
11. 카테고리 기능 구현하기

### GitHub Pages 에 블로그 만들기

앞서 말한대로 이번에 정리한 글에서는 GitHub Pages 라는 GitHub 호스팅 서비스를 중심으로 내용을 전개합니다. 

사실 이전 글에서는 Jekyll 과 Git 자체에 대한 설명 비중이 높아서 이 둘을 모르면 블로그를 만들기 어렵다고 느낄 수 있습니다. 하지만 블로그를 만드는데 Jekyll 과 Git 을 알아야하는 이유는 사실 GitHub Pages 가 이 두 가지 기술을 가지고 동작한다는 이유 밖에 없습니다.

따라서 Jekyll 과 Git 을 알고 블로그를 만들기 보다는 GitHub Pages 에 블로그를 만들어 가면서 자연스럽게 두 기술에 익숙해 지는 방식이 더 자연스러는 방식이라고 생각합니다.

#### GitHub Pages 에 계정 만들기

계정은 [GitHub Pages](https://pages.github.com) 홈페이지에서 스크롤을 내리면 나오는 [Create a repository](https://github.com/new) 메뉴에서 만들면 됩니다. GitHub 계정당 1개의 사이트를 만들 수 있으므로 반드시 자신의 username을 사용해서 `username.github.io` 과 같은 방식으로 만듭니다.

#### GitHub Pages 블로그 클론 받기

클론 받을 때는 자신이 사용하는 OS 등에 따라서 페이지에 있는 설명을 따라하면 됩니다. 아래와 같이 명령줄을 이용해서 클론을 받을 수도 있습니다.

```bash
$ git clone https://github.com/username/username.github.io
```

#### 블로그 수정하고 배포 해보기

그리고 이어서 같은 페이지에 있는 3~5번 설명을 따라 순서대로 진행하면 `http://username.github.io` 주소로 블로그에 접근할 수 있음을 알 수 있습니다.

이 과정은 `username.github.io` 폴더에 `index.html` 파일을 하나 만든 다음 이를 GitHub Pages 저장소로 보내는 과정입니다.

이 과정 자체가 GitHub Pages 에서 블로그를 만드는 전부입니다. 이후로는 3, 4 번 과정을 반복해서 블로그 내용을 추가하는 것입니다. 꽤 간단하다는 것을 알 수 있습니다. 

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

### 참고 자료

[^about-github-pages-and-jekyll]: [About GitHub Pages and Jekyll](https://help.github.com/articles/about-github-pages-and-jekyll/)

[^using-a-static-site-generator-other-than-jekyll]: [Using a static site generator other than Jekyll](https://help.github.com/articles/using-a-static-site-generator-other-than-jekyll/) : GitHub Pages 에서 Jekyll 이외의 정적 사이트 생성기를 사용하는 방법입니다. 결국 로컬에서 사이트 빌드를 한 다음 원격 저장소에 내보내면 되는 것 같습니다.

[^setting-up-your-github-pages-site-locally-with-jekyll]: [Setting up your GitHub Pages site locally with Jekyll](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/)

[^hurderella-131]: [Windows에서 Github Page와 Jekyll로 블로그 생성하기](http://hurderella.tistory.com/131)

[^whatap--jekyll-on-windows]: [Jekyll 윈도우에 설치해서 사용하기](http://tech.whatap.io/2015/09/11/install-jekyll-on-windows/)
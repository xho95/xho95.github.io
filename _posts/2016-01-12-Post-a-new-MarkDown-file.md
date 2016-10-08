---
layout: post
title:  "MarkDown 문서를 이용하여 블로그에 포스트하기"
date:   2016-01-12 11:58:00 +0900
categories: Jekyll MarkDown Atom kramdown
---

Jekyll로 로컬 폴더에 블로그를 생성한 후 해당 폴더를 살펴 보면 여러 폴더들과 파일들이 보입니다. 이들은 markdown 문서를 HTML 파일로 변환하는데 사용되는 템플릿 파일들입니다.

예를 들어, 블로그에 새로운 글을 올릴려면 포스트할 markdown 문서를 `_posts` 폴더에 넣으면 됩니다.

> `_posts` 폴더에 들어가는 markdown 문서는 파일 이름 등이 Jekyll 규칙에 맞게 정해져 있어야 합니다. 이 부분은 아래에 **Front matter** 부분에서 다시 설명하기로 합니다.

이러한 템플릿 파일들 중에서 `_config.yml` 파일을 볼 수 있는데, 이 파일에서 제목과 같은 블로그의 전반적인 환경을 설정할 수 있습니다.

### \_config.yml 편집하기

GitHub Pages에서는 `_config.yml` 파일에 변경이 가능한 설정과 변경을 할 수 없는 설정을 구분하여 권장하고 있습니다.[^Configuring_GitHub]

아래는 GitHub에서 기본으로 제공하는 설정으로 사용자가 원하는 대로 변경이 가능한 설정입니다.

```
 github: [metadata]
 kramdown:
   input: GFM
   hard_wrap: false
 gems:
   - jekyll-coffeescript
   - jekyll-paginate
```

위에서 `[metadata]` 부분은 사용자의 계정과 관련한 부분이 아닌가 추측됩니다. `kramdown`은 GitHub Pages에서 공식적으로 지원하는 markdown 엔진입니다. 마지막으로 `gems`는 Ruby 패키지 매니저인데, 의존성과 관련한 부분인 것 같습니다.[^Configuring_Question]

`_config.yml` 파일을 변경하는 것은 saltfactory님의 블로그에 설명이 잘 되어 있습니다.[^saltfactory]

아래는 GitHub Pages & Jekyll에서 override 하는 설정으로 변경할 수 없다고 되어 있습니다.

```
 lsi: false
 safe: true
 source: [your repo's top level directory]
 incremental: false
 highlighter: rouge
 gist:
   noscript: false
```

> 다만, Jekyll new로 만든 블로그에는 위의 내용이 없습니다. 확인이 필요한 부분입니다.

위의 설정에서 각 항목들에 대한 간단한 설명은 다음과 같습니다. 항목들에 대한 설명은 Jekyll 사이트에 있습니다.[^Configuration_Jekyll]

* lsi : 관련 포스트글에 대한 인덱스를 생성합니다.
* safe : 사용자 플러그인을 비활성화하고, 심볼릭 링크(symbolic links)를 무시합니다.
* source : Jekyll이 읽을 파일의 위치를 변경합니다.
* incremental : 변경된 포스트만 재빌드하는 옵션입니다.
* highlighter : GitHub에서 자체적으로 설정하는 코드 하이라이터인 것 같습니다. Jekyll 문서에는 따로 설명이 없습니다.
* gist : 이것도 GitHub에서 자체 설정인 것 같습니다.

### Front matter 설정하기

블로그에 새 글을 만들기 위해, 마크타운 편집기를 사용하여 `_posts` 폴더에 새로운 markdown 문서를 만듭니다. 이 때, 이름은 날짜 형식에 맞춰서 생성해야 합니다.

> 맥용 마크다운 편집기에는 여러가지 종류가 있으나, Atom 에디터의 경우 폴더 기준으로 프로젝트를 관리할 수 있어서, 블로그 제작용으로 사용하기 편리합니다.[^Atom] 다만, Atom 에디터는 파일 크기가 커지면 느려지는 경향이 있어서 최근에는 문서 작업용으로는 잘 사용하지 않고 폴더 관리 용도로만 사용하고 있습니다.

또한, 각 블로그 포스트는 문서의 맨 앞에 **Front matter** 라고 하는 특정 형식을 유지해야 합니다. **Front matter** 는 메타데이터 집합으로 세 개의 대쉬 라인(`---`)을 사용하여 나타냅니다. 나타나는 모습은 아래와 같습니다.

```
---
title: This is my title
layout: post
---

Here is my page.
```

때에 따라서는 **Front matter** 의 내용을 생략할 수 있지만, 그럴 경우에도 아래처럼 세 개의 대쉬 라인(`---`)은 표시해줘야 합니다.

```
---
---

Here is my page.
```

그리고, `_posts` 폴더안에 있는 문서는 이 대쉬(`---`)를 생략할 수 있습니다.

> 아직 `_posts` 폴더안의 문서에서 위처럼 사용한 적은 없는데, 나중에 사용해 보고 다시 이 문서를 업데이트 하도록 하겠습니다.

### 마크다운 엔진인 redcarpet 설치하기

블로그를 로컬에서 테스트하려면 마크다운 문법을 해석할 수 있는 엔진을 블로그가 저장된 로컬 폴터에 설치하고, 이 마크다운 엔진을 사용하도록 설정해야 합니다.

>사실 로컬에는 `jekyll serve`를 실행할 것이 아니라면 마크다운 엔진을 설치하지 않아도 무방합니다. 다만, 이렇게 하면 필요한 경우 로컬 브라우저에서 바로바로 결과물을 확인해 볼 수 없으므로 불편할 수 있습니다.

마크다운 엔진중에서 예전에 GitHub에서 사용하던 것은 redcarpet입니다. redcarpet을 설치하려면 ruby의 `gem install` 명령어를 이용합니다. 다만, 현재는 GitHub에서 kramdown을 이용하고 있으므로 다른 엔진을 설치해도 됩니다.[^kramdown]  [^Updating_kramdown]

```sh
$ gem install redcarpet
```

이렇게 하면 로컬에서 마크타운을 해석할 수 있는 환경은 갖춰졌습니다.

### 고찰하기

`_config.yml`은 YAML 문서인데, 이 문서 양식이 무엇인지는 아직 잘 모르겠습니다. 나중에 이 부분도 정리할 예정입니다.[^YAML]

### 참고 자료

[^Configuring_GitHub]: [Configuring Jekyll](https://help.github.com/articles/configuring-jekyll/)

[^Configuring_Question]: 각각의 내용들은 아직 다 이해하지 못하고 있습니다. 앞으로 조금씩 알아가게 되면서 따로 정리하도록 하겠습니다.

[^Atom]: Atom 에디터를 받을 수 있는 곳은 [Atom.io](https://atom.io) 입니다. 다음에 기회가 되면 markdown 에디터에 대한 정리글도 작성할 예정입니다.

[^kramdown]: [kramdown](http://kramdown.gettalong.org)

[^saltfactory]: saltfactory님의 블로그 글 [Jekyll을 사용하여 GitHub Pages 만들기](http://blog.saltfactory.net/jekyll/upgrade-github-pages-dependency-versions.html)에서 _config.yml 설정 부분에 _config.yml을 사용자화하는 부분이 나옵니다.

[^Updating_kramdown]: 2016년 5월 1일 이후로 GitHub에서는 kramdown을 markdown 기본 번역 엔진으로 사용한다고 합니다. GitHub의 [Updating your Markdown processor to kramdown](https://help.github.com/articles/updating-your-markdown-processor-to-kramdown/) 글에 kramdown을 사용하는 방법이 나옵니다.

[^YAML]: 위키백과 [YAML](https://ko.wikipedia.org/wiki/YAML) 문서에 따르면 현재는 가벼운 마크업 언어 용도로 많이 사용한다고 합니다.

[^Configuration_Jekyll]: Jekyll의 [Configuration](https://jekyllrb.com/docs/configuration/) 문서에 _config.yml에 들어갈 항목들에 대한 설명이 있습니다.

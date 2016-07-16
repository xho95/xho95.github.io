---
layout: post
title:  "MarkDown 문서를 이용하여 블로그에 포스트하기"
date:   2016-01-12 11:58:00 +0900
categories: Jekyll Atom MarkDown RedCarpet
---

Jekyll로 생성한 local 저장소에 새 markdown 문서를 만들기 위해서는 마크타운 편집기가 필요하다.

맥용 마크다운 편집기에는 여러가지 종류가 있으나, Atom의 경우 폴더 기준으로 프로젝트를 관리할 수 있어서, 블로그 제작용으로 사용하기 편리하다.[^Atom]

### \_config.yml 편집하기

Atom으로 로컬 저장소(보통의 경우 GitHub에 있는 원격 저장소와 이름을 일치시키기 위해 `username.github.io`으로 이름을 정하게 된다.)라는 로컬 저장소를 열어보면, 여러 폴더들과 파일들이 보이는데, 그 중에 `_config.yml` 파일을 볼 수 있다.

이 파일에서 블로그의 제목과 같은 전반적인 환경을 설정할 수 있다.

블로그를 마크다운 문법을 이용해서 만드려면 마크다운 문법을 해석할 수 있는 엔진을 Jekyll로 만든 로컬 저장소에 설치하고, 이렇게 설치한 마크다운 엔진을 사용하도록 설정해야 한다.

>사실 로컬에 설치하는 마크다운 엔진은 `jekyll serve`를 실행할 것이 아니라면 설치하지 않아도 무방하지만 필요한 경우 로컬 브라우저에서도 결과물을 확인해야하므로 설치한다.

이것을 위해 `_config.yml` 파일의 끝에 `markdown: redcarpet`이라는 구문을 입력한다. 이어서 바로 밑줄에 `redcarpet:`를 입력하고 엔터를 치면 커서 위치가 들여쓰기가 된다. 들여쓰기를 유지한채로 바로 `extensions:`을 입력하고 몇가지 옵션을 ` ["tables", "autolink"]`등과 같은 텍스트 리스트 형식으로 지정 하면 된다.

이 블로그에서 `_config.yml`에 추가한 옵션들을 포함한 전체 코드는 아래와 같다.

```text
markdown: redcarpet
redcarpet:
  extensions: ["tables", "autolink", "strikethrough", "space_after_header", "with_toc_data", "fenced_code_blocks"]
```

### redcarpet 설치하기

redcarpet을 설치하려면 ruby의 `gem install` 명령어를 이용한다.[^kramdown]

```sh
$ gem install redcarpet
```

이렇게 하면 로컬 환경에서 마크타운을 해석할 수 있는 환경은 갖춰졌다.

GitHub에서는 자체적으로 redcarpet을 지원하므로 마크다운을 쓰기위해 원격 저장소에서 설정할 것은 없다.

### Atom으로 post 만들기

이제 `jekyll`도 설치했고 블로그 문서를 작성할 에디터도 설치했으며, 이 에디터에서 사용할(좀 더 확인이 필요함) 마크타운 엔진도 설치했으니, 새 블로그 문서를 작성해 볼 순서이다.

이를 위해 `\_posts` 폴더에 새 파일을 생성한다. 이름은 날짜 형식에 맞춰서 생성해야 한다.

또한, 각 블로그 포스트는 맨 앞에 특정 형식을 유지해야한다. 이 형식은 예제로 주어진 ``'md'`` 파일 맨 처음 부분에 아래 위로 `---`으로 쌓여진 부분을 복사해서 사용하면 된다.

블로그 포스트를 완성한 후 git의 `push`를 수행하면 `username.github.io`를 통하여 새 블로그 글이 등록된 것을 확인할 수 있다.

### Favicon

[Unable to set favicon using Jekyll and github pages - Stack Overflow](http://stackoverflow.com/questions/30551501/unable-to-set-favicon-using-jekyll-and-github-pages)

[Favicon / 즐겨찾기 아이콘 등록 :: 비둘기쉼터](http://chaz.tistory.com/m/post/87)

[파비콘(Favicon) 만드는 방법과 홈페이지에 적용하는 방법 - 웹디자인 강좌](http://www.homejjang.com/11/favicon.php)

### 참고 자료

[^Atom]: [Atom.io](https://atom.io)
  
[^kramdown]: 2016년 5월 1일 이후로 GitHub에서는 kramdown을 기본으로 제공한다고 한다. [_config.yml 파일을 kramdown으로 수정하는 방법](https://help.github.com/articles/updating-your-markdown-processor-to-kramdown/)

[kramdown](http://kramdown.gettalong.org)

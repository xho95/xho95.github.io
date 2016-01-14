---
layout: post
title:  "MarkDown 문서를 이용하여 블로그에 포스트하기"
date:   2016-01-12 11:58:00 +0900
categories: Jekyll Atom redcarpet
---

Jekyll로 생성한 local 저장소에 새 markdown 문서를 만들기 위해서는 마크타운 편집기가 필요하다.

맥용 마크다운 편집기에는 여러가지 종류가 있으나, Atom의 경우 폴더 기준으로 프로젝트를 관리할 수 있어서, 블로그 제작용으로 사용하기 편리하다.

### Atom 설치하기

Atom은 `https://atom.io`에서 다운 받을 수 있다.

홈페이지에서 `Download For Mac` 버튼을 누르면 다운되며 압축을 풀면 바로 하나의 실행 파일 형태로 설치가 끝난다. 필요하다면 실행 파일을 맥의 Application 폴더로 이동하여 Launchad에 등록할 수 있다.


### \_config.yml 편집하기

Atom으로 로컬 저장소(보통의 경우 GitHub에 있는 원격 저장소와 이름을 일치시키기 위해 `username.github.io`으로 이름을 정하게 된다.)라는 로컬 저장소를 열어보면, `_config.yml` 파일을 볼 수 있다.

이 곳에서 블로그의 제목과 같은 전반적인 환경을 설정할 수 있다.

블로그를 마크다운 문법을 이용해서 만드려면 마크다운 문법을 해석할 수 있는 엔진을 Jekyll로 만든 로컬 저장소에 설치하고, 이렇게 설치한 마크다운 엔진을 사용하도록 설정해야 한다.

이것을 위해 `_config.yml` 파일의 끝에 `markdown: redcarpet`이라는 구문을 입력한다. 이어서 바로 밑줄에 `redcarpet:`를 입력하고 엔터를 치면 커서 위치가 들여쓰기가 된다. 들여쓰기를 유지한채로 바로 `extensions: ["tables", "autolink", "strikethrough", "space_after_header", "with_toc_data", "fenced_code_blocks"]`라고 입력한다.

전체 코드는 아래와 같다.

```yml
markdown: redcarpet
redcarpet:
  extensions: ["tables", "autolink", "strikethrough", "space_after_header", "with_toc_data", "fenced_code_blocks"]
```


### redcarpet 설치하기

redcarpet을 설치하려면 ruby의 `gem install` 명령어를 이용한다.

```sh
$ gem install redcarpet
```

GitHub에서는 자체적으로 redcarpet을 지원하므로 다른 설정을 할 필요가 없다.


### Atom으로 post 만들기

`\_posts` 폴더에 새 파일을 생성한다. 이름은 날짜 형식에 맞춰서 생성해야 한다.

각 블로그 포스트는 맨 앞에 특정 형식을 유지해야한다. 이것은 `---`으로 구분된다.

블로그 포스트를 완성했으면 git을 이용하여 push를 수행하면 github.io를 통하여 새 블로그 글이 등록된 것을 확인할 수 있다.

### 참고 문헌


[ATOM]: https://atom.io
